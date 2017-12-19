//
//  BaseViewController.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBar;

extern const int kBaseTabBarHeight;
extern const int kBaseTabBarMaxHeight;


@interface BaseViewController : UIViewController
@property (nonatomic, strong) TabBar *tabBar;
@end
