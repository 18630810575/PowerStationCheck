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
    BOOL needShowBottom;
    
}

#pragma mark -----Life Cycle-----


- (instancetype)initWithTitle:(NSString *)title AndNeedBack:(BOOL)needBack AndShowBottom:(BOOL)showBottom
{
    self = [super init];
    if (self) {
        self.title = title;
        needShowBack = needBack;
        needShowBottom = showBottom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tabBar];
    [self.view addSubview:self.navBar];
    [self doBaseSettings];
    if (needShowBottom) {
        [self doTabBarSettings];
    }
    [self doNavBarSettings];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

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
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"white_back"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(50*ScreenScale);
            make.centerY.equalTo(self.navBar).offset(statusBarHeight/2);
            make.width.equalTo(31*ScreenScale);
            make.height.equalTo(56*ScreenScale);
        }];
        
        UIButton *hudBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hudBtn.backgroundColor = [UIColor clearColor];
        [hudBtn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:hudBtn];
        [hudBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(statusBarHeight);
            make.left.equalTo(0);
            make.width.equalTo(44);
            make.height.equalTo(44);
        }];
    }
    
}
-(void)pushBack{
    [self.navigationController popViewControllerAnimated:YES];
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
