//
//  MineViewController.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIImageView *headerView;
@property (nonatomic,strong)UIButton *headerBtn;
@property (nonatomic,strong)UITableView *tabelView;
@property (nonatomic,strong)UIButton *registoutBtn;
@end

@implementation MineViewController{
    NSArray *cellTitleArr;
    UIView *switchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    cellTitleArr = @[@"历史任务",@"反馈",@"更改密码",@"流量上传",@"消息通知",@"清除缓存",@"关于"];
    [self.view addSubview:self.tabelView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.headerBtn];
    [self.view addSubview:self.registoutBtn];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(576 * ScreenScale);
        make.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(1222 * ScreenScale);
    }];
    [self.headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(576 * ScreenScale);
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(576 * ScreenScale);
    }];
    [self.registoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-210 * ScreenScale);
        make.left.equalTo(60 * ScreenScale);
        make.width.equalTo(kScreenWidth - 120 * ScreenScale);
        make.height.equalTo(150 * ScreenScale);
    }];
}
-(void)doNavBarSettings{
}


#pragma mark - 私有方法 -
-(void)changeAvater{
    #ifdef IS_OPEN_NSLOG
       NSLog(@"点击了头像");
    #endif
}
-(void)switchBtnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (btn.selected == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            switchView.transform = CGAffineTransformMakeTranslation(50 * ScreenScale - 2, 0);
        }];
        
        btn.selected = YES;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            switchView.transform = CGAffineTransformIdentity;
        }];
        btn.selected = NO;
    }
}
-(void)registout{
    #ifdef IS_OPEN_NSLOG
        NSLog(@"点击了注销账号");
    #endif
}
#pragma mark - tabview -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = cellTitleArr[indexPath.row];
    if(indexPath.row == 3){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = UIColorFromRGB(0xD2D2D2);
        [cell addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo((58 - 50 * ScreenScale)/2);
            make.left.equalTo(kScreenWidth - 155 * ScreenScale);
            make.width.equalTo(100 * ScreenScale);
            make.height.equalTo(50 * ScreenScale);
        }];
        view.layer.cornerRadius = 25 * ScreenScale;
        switchView = [[UIView alloc]init];
        [view addSubview:switchView];
        [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(1);
            make.top.equalTo(0);
            make.width.and.height.equalTo(50 * ScreenScale);
        }];
        switchView.layer.cornerRadius = 25 * ScreenScale;
        switchView.backgroundColor = [UIColor whiteColor];
        UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cell addSubview:switchBtn];
        [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo((58 - 50 * ScreenScale)/2);
            make.left.equalTo(kScreenWidth - 155 * ScreenScale);
            make.width.equalTo(100 * ScreenScale);
            make.height.equalTo(50 * ScreenScale);
        }];
        [switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 5){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",21.5];
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  58;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - getters -
-(UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [[UIImageView alloc]init];
        _headerView.image = image(@"theme_background");
        UIImageView *avaterImg = [[UIImageView alloc]init];
        //avaterImg.image = image(@"");
         [_headerView addSubview:avaterImg];
        [avaterImg makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(160 * ScreenScale);
            make.left.equalTo((kScreenWidth - 232 * ScreenScale)/2);
            make.width.equalTo(232 * ScreenScale);
            make.height.equalTo(232 * ScreenScale);
        }];
        avaterImg.image = image(@"");
        avaterImg.layer.cornerRadius = 232 / 2 * ScreenScale;
        avaterImg.layer.borderColor = [[UIColor whiteColor]CGColor];
        avaterImg.layer.borderWidth = 2;
     }
    return _headerView;
}
-(UIButton *)headerBtn{
    if (!_headerBtn) {
        _headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headerBtn setBackgroundColor:[UIColor clearColor]];
        [_headerBtn setBackgroundImage:image(@"") forState:UIControlStateNormal];
        [_headerBtn addTarget:self action:@selector(changeAvater) forControlEvents:UIControlEventTouchUpInside];
     }
    return _headerBtn;
}

-(UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc]init];
        _tabelView.backgroundColor = [UIColor clearColor];
        //_tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tabelView.delegate =self;
        _tabelView.dataSource =self;
        _tabelView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _tabelView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = FALSE;
        }
        _tabelView.showsVerticalScrollIndicator = YES;
    }
    return _tabelView;
}

-(UIButton *)registoutBtn{
    if (!_registoutBtn) {
        _registoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registoutBtn setBackgroundColor:[UIColor redColor]];
        [_registoutBtn setTitle:@"注销账号" forState:UIControlStateNormal];
        _registoutBtn.titleLabel.textColor = UIColorFromRGB(0xD35E58);
        [_registoutBtn addTarget:self action:@selector(registout) forControlEvents:UIControlEventTouchUpInside];
        _registoutBtn.layer.cornerRadius = 8 * ScreenScale;
        _registoutBtn.alpha = 0.5;
        
    }
    return _registoutBtn;
}







@end
