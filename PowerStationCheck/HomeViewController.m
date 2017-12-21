//
//  HomeViewController.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "HomeViewController.h"
#import "DataPile.h"
//static const int kleftSmallImageIconTag =500;
static const float kUnselectedButtonAlpha = 0.6;
static const float kAnimatedDuration = 0.3;
static const int kBaseNavHeight = 44;
static NSString *kSelectedRoundImageName = @"select-image";

@interface HomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *topSelectContent;
@property (nonatomic, strong) UIView *allMissionSelect;
@property (nonatomic, strong) UIView *overtimeMissionSelect;
@property (nonatomic, strong) UIView *urgencyMissionSelect;
@property (nonatomic, strong) UIView *normalMissionSelct;
@property (nonatomic, strong) UIImageView *selectedRoundImage;
@property (nonatomic, strong) UIScrollView *projectScrollView;
@end

@implementation HomeViewController{
    NSArray *selectTitleArr;
    NSArray *selectImageArr;
    NSArray *returnDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selectTitleArr = @[@"全部",@"超期",@"紧急",@"普通"];
    selectImageArr = @[@"all",@"overtime",@"urgency",@"normal"];
    returnDataArr = [DataPile getDataPile];
    
    [self.view addSubview:self.topSelectContent];
    [self.view addSubview:self.projectScrollView];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self doTopSelectViewSettings];
    [self doProjectScrollViewSettings];
    [self.view bringSubviewToFront:self.tabBar];
    [self setSelectedImagePosition];
    
}


//顶部选择。
-(void)setSelectedImagePosition{
    [self.view addSubview:self.selectedRoundImage];
    [self.selectedRoundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.allMissionSelect);
        make.bottom.equalTo(self.allMissionSelect.bottom).offset(5*ScreenScale);
        make.width.equalTo(201*ScreenScale);
        make.height.equalTo(77*ScreenScale);
    }];
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
    [self getFourSelectButton];

}

-(void)getFourSelectButton{

    self.allMissionSelect = [self creatSelectButtonWithIndex:0 AndMissionNumber:14];
    self.allMissionSelect.alpha = 1; 
    self.overtimeMissionSelect = [self creatSelectButtonWithIndex:1 AndMissionNumber:2];
    self.urgencyMissionSelect = [self creatSelectButtonWithIndex:2 AndMissionNumber:8];
    self.normalMissionSelct = [self creatSelectButtonWithIndex:3 AndMissionNumber:4];

}


-(UIView *)creatSelectButtonWithIndex:(int)i AndMissionNumber:(int)number{

    UIView *selectContent = [[UIView alloc]init];
    selectContent.backgroundColor = [UIColor clearColor];
    selectContent.alpha = kUnselectedButtonAlpha;
    [self.topSelectContent addSubview:selectContent];
    [selectContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(i*kScreenWidth/4);
        make.top.equalTo(0);
        make.width.equalTo(kScreenWidth/4);
        make.height.equalTo(self.topSelectContent);
    }];
    
    UIImageView *leftSmallImageIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:selectImageArr[i]]];
    [selectContent addSubview:leftSmallImageIcon];
    [leftSmallImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(70*ScreenScale);
        make.top.equalTo(22*ScreenScale);
        make.width.and.height.equalTo(52*ScreenScale);
    }];
    
    UILabel *rightSelectTitle = [[UILabel alloc]init];
    rightSelectTitle.text = selectTitleArr[i];
    rightSelectTitle.textAlignment = NSTextAlignmentLeft;
    rightSelectTitle.font = [UIFont systemFontOfSize:55*ScreenScale weight:bold];
    rightSelectTitle.textColor = [UIColor whiteColor];
    [selectContent addSubview:rightSelectTitle];
    [rightSelectTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftSmallImageIcon.right).offset(10*ScreenScale);
        make.top.equalTo(leftSmallImageIcon.top);
        make.width.equalTo(130*ScreenScale);
        make.height.equalTo(55*ScreenScale);
    }];
    
    UILabel *bottomNumberLabel = [[UILabel alloc]init];
    bottomNumberLabel.text = [NSString stringWithFormat:@"(%d)",number];
    bottomNumberLabel.textAlignment = NSTextAlignmentCenter;
    bottomNumberLabel.font = [UIFont systemFontOfSize:45*ScreenScale];
    bottomNumberLabel.textColor = [UIColor whiteColor];
    [selectContent addSubview:bottomNumberLabel];
    [bottomNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(rightSelectTitle.bottom).offset(5*ScreenScale);
        make.width.equalTo(selectContent);
        make.height.equalTo(45*ScreenScale);
    }];
    
    UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tapButton.backgroundColor = [UIColor clearColor];
    [tapButton addTarget:self action:@selector(tapToChooseMissionType:) forControlEvents:UIControlEventTouchUpInside];
    [selectContent addSubview:tapButton];
    [tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.width.and.height.equalTo(selectContent);
    }];
    
    return selectContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    CGFloat height = kScreenHeight-163*ScreenScale-kBaseTabBarHeight-kBaseNavHeight-kStatusBarHeight;
    [self.projectScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topSelectContent.bottom).offset(-10*ScreenScale);
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(height);
    }];
}

-(UIScrollView *)projectScrollView{
    
    if (!_projectScrollView) {
        _projectScrollView = [[UIScrollView alloc]init];
        _projectScrollView.backgroundColor = [UIColor whiteColor];
        _projectScrollView.contentSize = CGSizeMake(0, kScreenHeight);
        _projectScrollView.bounces = NO;
        _projectScrollView.layer.cornerRadius = 10*ScreenScale;
        _projectScrollView.layer.masksToBounds = YES;
        _projectScrollView.pagingEnabled = NO;
        _projectScrollView.delegate = self;
        _projectScrollView.showsHorizontalScrollIndicator = NO; // 水平方向
        _projectScrollView.showsVerticalScrollIndicator = YES; // 垂直方向
        _projectScrollView.showsVerticalScrollIndicator = FALSE;
        _projectScrollView.showsHorizontalScrollIndicator = TRUE;
        BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
        if (is7Version) {
            self.edgesForExtendedLayout=UIRectEdgeNone;
        }
    }
    return _projectScrollView;
}

@end
