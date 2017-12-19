//
//  BaseViewController.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "BaseViewController.h"
#import "TabBar.h"

int const kBaseTabBarHeight = 49;
int const kBaseTabBarMaxHeight = 63;


#define kTabBarShadowColor UIColorFromRGB(0x58B4FF)

@interface BaseViewController ()

@end

@implementation BaseViewController{

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tabBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self doBaseSettings];
    
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

-(TabBar *)tabBar{
    if (!_tabBar) {
        _tabBar = [[TabBar alloc]init];
    }
    return _tabBar;
}

@end
