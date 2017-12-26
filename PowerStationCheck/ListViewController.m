//
//  ListViewController.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "ListViewController.h"
#import "DataPile.h"
#import "ProjectModel.h"
#import "OrderModel.h"
#import "MissionModel.h"
#import "ProjectCell.h"
#import "HeaderView.h"

//static const int kleftSmallImageIconTag =500;
static const float kUnselectedButtonAlpha = 0.6;
static const float kAnimatedDuration = 0.3;
static const int kBaseNavHeight = 44;
static NSString *kSelectedRoundImageName = @"select-image";
//static const int kHeaderBaseTag = 500;
#define kTitleColor UIColorFromRGB(0x333333)
#define kFooterColor UIColorFromRGB(0xE5EDF1)
@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topSelectContent;
@property (nonatomic, strong) UIView *allMissionSelect;
@property (nonatomic, strong) UIView *overtimeMissionSelect;
@property (nonatomic, strong) UIView *urgencyMissionSelect;
@property (nonatomic, strong) UIView *normalMissionSelct;
@property (nonatomic, strong) UIImageView *selectedRoundImage;
@property (nonatomic, strong) UITableView *projectTableView;


@end

@implementation ListViewController{
    NSArray *selectTitleArr;
    NSArray *selectImageArr;
    NSMutableArray *returnDataArr;
    NSMutableArray *tableDataSource;
    NSArray *dataSource;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    selectTitleArr = @[@"人员",@"分配情况",@"工单类型",@"日期"];
    returnDataArr = [NSMutableArray array];
    NSArray *pileArr =[DataPile getDataPile];
    for (int i=0; i<pileArr.count; i++) {
        ProjectModel *projModel = [[ProjectModel alloc]init];
        [projModel setModelWithDataPile:pileArr[i]];
        [returnDataArr addObject:projModel];
    }
    tableDataSource = [NSMutableArray array];
    tableDataSource = [self tableviewSetData];
    dataSource = [NSArray arrayWithArray:tableDataSource];
    [self.view addSubview:self.topSelectContent];
    [self doTopSelectViewSettings];
    self.view.backgroundColor = kFooterColor;
    [self doProjectScrollViewSettings];
    [self.view bringSubviewToFront:self.tabBar];
    
}




-(void)doTopSelectViewSettings{
    
    [self.topSelectContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.bottom);
        make.left.equalTo(0);
        make.width.equalTo(self.view);
        make.height.equalTo(173*ScreenScale);
    }];
    UIImageView *topSelectBackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kNavBackgroundImageName]];
    [self.topSelectContent addSubview:topSelectBackImageView];
    [topSelectBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.width.and.height.equalTo(self.topSelectContent);
    }];
}




-(void)tapToChooseMissionType:(UIButton *)sender{
    UIView *currentView = sender.superview;
    if (currentView == self.allMissionSelect) {
        NSLog(@"choose all mission!");
        self.overtimeMissionSelect.alpha = kUnselectedButtonAlpha;
        self.urgencyMissionSelect.alpha = kUnselectedButtonAlpha;
        self.normalMissionSelct.alpha = kUnselectedButtonAlpha;
        self.allMissionSelect.alpha = 1;
        [self doAnimatedToView:self.allMissionSelect];
    }else if (currentView == self.overtimeMissionSelect){
        NSLog(@"choose overtime mission!");
        self.overtimeMissionSelect.alpha = 1;
        self.urgencyMissionSelect.alpha = kUnselectedButtonAlpha;
        self.normalMissionSelct.alpha = kUnselectedButtonAlpha;
        self.allMissionSelect.alpha = kUnselectedButtonAlpha;
        [self doAnimatedToView:self.overtimeMissionSelect];
    }else if (currentView == self.urgencyMissionSelect){
        NSLog(@"choose urgency mission!");
        self.overtimeMissionSelect.alpha = kUnselectedButtonAlpha;
        self.urgencyMissionSelect.alpha = 1;
        self.normalMissionSelct.alpha = kUnselectedButtonAlpha;
        self.allMissionSelect.alpha = kUnselectedButtonAlpha;
        [self doAnimatedToView:self.urgencyMissionSelect];
    }else if (currentView == self.normalMissionSelct){
        NSLog(@"choose normal mission!");
        self.overtimeMissionSelect.alpha = kUnselectedButtonAlpha;
        self.urgencyMissionSelect.alpha = kUnselectedButtonAlpha;
        self.normalMissionSelct.alpha = 1;
        self.allMissionSelect.alpha = kUnselectedButtonAlpha;
        [self doAnimatedToView:self.normalMissionSelct];
    }
}

-(void)doAnimatedToView:(UIView *)view{
    CGFloat nowCenterX = self.selectedRoundImage.center.x;
    CGFloat viewCenterX = view.center.x;
    CGFloat distance = viewCenterX - nowCenterX;
    [UIView animateWithDuration:kAnimatedDuration animations:^{
        self.selectedRoundImage.transform = CGAffineTransformMakeTranslation(distance, 0);
    }];
}

-(UIView *)topSelectContent{
    
    if (!_topSelectContent) {
        _topSelectContent = [[UIView alloc]init];
    }
    return _topSelectContent;
}

-(UIImageView *)selectedRoundImage{
    
    if (!_selectedRoundImage) {
        _selectedRoundImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kSelectedRoundImageName]];
    }
    return _selectedRoundImage;
}

//项目scrollview
-(void)doProjectScrollViewSettings{
    [self.view addSubview:self.projectTableView];
    CGFloat height = kScreenHeight-163*ScreenScale-kBaseTabBarHeight-kBaseNavHeight-kStatusBarHeight;
    [self.projectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topSelectContent.bottom).offset(0);
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(height);
    }];
}

-(UITableView *)projectTableView{
    
    if (!_projectTableView) {
        _projectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _projectTableView.backgroundColor = [UIColor clearColor];
        _projectTableView.contentSize = CGSizeMake(0, kScreenHeight);
        _projectTableView.layer.cornerRadius = 10*ScreenScale;
        _projectTableView.layer.masksToBounds = YES;
        _projectTableView.bounces = NO;
        _projectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _projectTableView.delegate = self;
        _projectTableView.dataSource = self;
        _projectTableView.showsHorizontalScrollIndicator = NO; // 水平方向
        _projectTableView.showsVerticalScrollIndicator = YES; // 垂直方向
        _projectTableView.showsVerticalScrollIndicator = FALSE;
        _projectTableView.showsHorizontalScrollIndicator = TRUE;
        BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
        if (is7Version) {
            self.edgesForExtendedLayout=UIRectEdgeNone;
        }
    }
    return _projectTableView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int section = (int)indexPath.section;
    //    ProjectModel *model = returnDataArr[section];
    NSArray *sourceArr = tableDataSource[section];
    NSObject *obj = sourceArr[indexPath.row][@"model"];
    NSString *level = sourceArr[indexPath.row][@"level"];
    ProjectCell *cell = [[ProjectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"obj%d%d",section,(int)indexPath.row] AndModel:obj AndLevel:level];
    if (indexPath.row == sourceArr.count-1) {
        [cell setBorder];
    }else{
        if ([sourceArr[indexPath.row+1][@"level"]isEqualToString:@"0"]){
            [cell setBorder];
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ProjectModel *model =returnDataArr[section];
    NSArray *sourceArr = tableDataSource[section];
    if (model.is_open) {
        return sourceArr.count;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int section = (int)indexPath.section;
    //    ProjectModel *model = returnDataArr[section];
    NSArray *sourceArr = tableDataSource[section];
    if (indexPath.row == sourceArr.count-1 && [sourceArr[indexPath.row][@"level"]isEqualToString:@"1"]) {
        
        return 165*ScreenScale;
    }else if (indexPath.row == sourceArr.count-1 && [sourceArr[indexPath.row][@"level"]isEqualToString:@"0"]){
        return 170*ScreenScale;
    }else{
        if ([sourceArr[indexPath.row][@"level"]isEqualToString:@"0"]&&![sourceArr[indexPath.row+1][@"level"]isEqualToString:@"0"]) {
            return 130*ScreenScale;
        }else {
            if (([sourceArr[indexPath.row][@"level"]isEqualToString:@"0"]&&[sourceArr[indexPath.row+1][@"level"]isEqualToString:@"0"])){
                return 170*ScreenScale;
            }else if(([sourceArr[indexPath.row][@"level"]isEqualToString:@"1"]&&[sourceArr[indexPath.row+1][@"level"]isEqualToString:@"0"])){
                return 165*ScreenScale;
            }{
                return 165*ScreenScale;
            }
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 146*ScreenScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40*ScreenScale;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return returnDataArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ProjectModel *model =returnDataArr[section];
    HeaderView *headerView = [[HeaderView alloc]initWithIsOpen:model.is_open AndModel:model];
    headerView.section = section;
    __weak typeof(self) weakself = self;
    headerView.openblock =^(NSInteger secion){
        [weakself openSection:section];
    };
    headerView.closeblock = ^(NSInteger section){
        [weakself closeSection:section];
    };
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = kFooterColor;
    footerView.frame = CGRectMake(0, 0, kScreenWidth, 40*ScreenScale);
    return footerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    NSMutableArray *data = [NSMutableArray arrayWithArray:tableDataSource[section]];
    NSDictionary *dictionary = data[row];
    
    if ([dictionary[@"level"]isEqualToString:@"0"]) {
        NSLog(@"收起/打开");
        OrderModel *model =(OrderModel *)dictionary[@"model"];
        if (model.is_open) {
            [self closeMissionWithIndexPath:indexPath];
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:.3];
        }else{
            [self openMissionWithIndexPath:indexPath];
        }
        model.is_open = !model.is_open;
    }else{
        //turn to details;;
    }
}


- (void)openSection:(NSInteger)section{
    ProjectModel *model =returnDataArr[section];
    model.is_open = !model.is_open;
    NSMutableArray *indexArray = [NSMutableArray array];
    NSArray *sourceArr = tableDataSource[section];
    for (int i = 0; i < sourceArr.count; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:section];
        [indexArray addObject:indexpath];
    }
    [self.projectTableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationLeft];
    //    returnDataArr[section] = model;
}

- (void)closeSection:(NSInteger)section{
    ProjectModel *model =returnDataArr[section];
    model.is_open = !model.is_open;
    NSMutableArray *indexArray = [NSMutableArray array];
    NSArray *sourceArr = tableDataSource[section];
    for (int i = 0; i < sourceArr.count; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:section];
        [indexArray addObject:indexpath];
    }
    [self.projectTableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationLeft];
    //    returnDataArr[section] = model;
}

-(void)openMissionWithIndexPath:(NSIndexPath *)indexPath{
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    NSMutableArray *indexArray = [NSMutableArray array];
    NSMutableArray *nowData = [NSMutableArray arrayWithArray:tableDataSource[section]];
    NSMutableArray *data = [NSMutableArray arrayWithArray:dataSource[section]];
    NSDictionary *dictionary = nowData[row];
    OrderModel *order =(OrderModel *)dictionary[@"model"];
    int k=0;
    for (int i=(int)data.count-1; i>=0; i--) {
        NSDictionary *dict = data[i];
        NSObject *obj = dict[@"model"];
        if ([obj isKindOfClass:[MissionModel class]]) {
            MissionModel *mission = (MissionModel *)obj;
            if ([mission.order_id isEqualToString:order.order_id]) {
                [nowData insertObject:dict atIndex:row+1];
                k++;
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row+k inSection:section];
                //                [indexSet addIndex:i];
                [indexArray addObject:indexpath];
            }
        }
    }
    tableDataSource[section] = nowData;
    [self.projectTableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationLeft];
    ProjectCell *cell =  [self.projectTableView cellForRowAtIndexPath:indexPath];
    UIImageView *isOpenImageView = cell.isOpenImageView;
    [UIView animateWithDuration:0.3 animations:^{
        isOpenImageView.transform = CGAffineTransformRotate(isOpenImageView.transform, -M_PI);
    }completion:^(BOOL finished) {
    }];
}

-(void)closeMissionWithIndexPath:(NSIndexPath *)indexPath{
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    NSMutableArray *data = [NSMutableArray arrayWithArray:tableDataSource[section]];
    NSMutableArray *indexArray = [NSMutableArray array];
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    OrderModel *order =(OrderModel *)data[row][@"model"];
    for (int i=row+1; i<data.count; i++) {
        NSDictionary *dict = data[i];
        NSObject *obj = dict[@"model"];
        if ([obj isKindOfClass:[MissionModel class]]) {
            MissionModel *mission = (MissionModel *)obj;
            if ([mission.order_id isEqualToString:order.order_id]) {
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:section];
                [indexSet addIndex:i];
                [indexArray addObject:indexpath];
            }
        }
    }
    [data removeObjectsAtIndexes:indexSet];
    tableDataSource[section] = data;
    ProjectCell *cell =  [self.projectTableView cellForRowAtIndexPath:indexPath];
    UIImageView *isOpenImageView = cell.isOpenImageView;
    [UIView animateWithDuration:0.3 animations:^{
        isOpenImageView.transform = CGAffineTransformRotate(isOpenImageView.transform, -M_PI);
    }completion:^(BOOL finished) {
    }];
    //        [self.projectTableView reloadData];
    [self.projectTableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationLeft];
}

-(void)delayMethod{
    [self.projectTableView reloadData];
}

-(NSMutableArray *)tableviewSetData{
    NSMutableArray *dataArr = [NSMutableArray array];
    for (int i=0; i<returnDataArr.count; i++) {
        ProjectModel *model = returnDataArr[i];
        NSArray *array = model.proj_work_order;
        NSMutableArray *data = [NSMutableArray array];
        for (int j=0; j<array.count; j++) {
            OrderModel *orderModel = array[j];
            NSArray *missionArr = orderModel.mission;
            [data addObject:@{@"model":orderModel,@"level":@"0"}];
            for (int k=0; k<missionArr.count; k++) {
                MissionModel *missionModel = missionArr[k];
                [data addObject:@{@"model":missionModel,@"level":@"1"}];
            }
        }
        [dataArr addObject:data];
    }
    
    return dataArr;
}


@end

