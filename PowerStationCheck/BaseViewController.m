//
//  BaseViewController.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "BaseViewController.h"

int const kBaseTabBarHeight = 49;
int const kBaseTabBarMaxHeight = 63;



#define kTabBarShadowColor UIColorFromRGB(0x58B4FF)

@interface BaseViewController ()

@end

@implementation BaseViewController{

    BOOL needShowBack;
}

#pragma mark -----Life Cycle-----


- (instancetype)initWithTitle:(NSString *)title AndNeedBack:(BOOL)needBack
{
    self = [super init];
    if (self) {
        self.title = title;
        needShowBack = needBack;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tabBar];
    [self.view addSubview:self.navBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self doBaseSettings];
    [self doTabBarSettings];
    [self doNavBarSettings];
}


#pragma mark -----do settings-----
-(void)doNavBarSettings{
    float statusBarHeight = kStatusBarHeight;
    float navBarHeight = 44+statusBarHeight;
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(navBarHeight);
    }];
    [self.navBar setBackgroundImage];
    [self.navBar setNavTitle:self.title];
    if (needShowBack) {
        
    }
    
}

-(void)doTabBarSettings{
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(73);
    }];
    self.tabBar.layer.shadowColor = kTabBarShadowColor.CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -6);
    self.tabBar.layer.shadowOpacity = 0.1;
    
    [self.tabBar creatFiveTabButton];
    [self.tabBar changeViewWithViewTitle:self.title];
}

-(void)doBaseSettings{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 返回你所需要的状态栏样式
    return UIStatusBarStyleLightContent;
}


#pragma mark -----getters-----

-(TabBar *)tabBar{
    if (!_tabBar) {
        _tabBar = [[TabBar alloc]init];
    }
    return _tabBar;
}

-(NavBar *)navBar{
    if (!_navBar) {
        _navBar = [[NavBar alloc]init];
    }
    return _navBar;
}

@end
