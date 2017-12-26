//
//  BaseViewController.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBar.h"
#import "TabBar.h"

extern const int kBaseTabBarHeight;
extern const int kBaseTabBarMaxHeight;


@interface BaseViewController : UIViewController{
    
}

- (instancetype)initWithTitle:(NSString *)title AndNeedBack:(BOOL)needBack;
@property (nonatomic, strong) TabBar *tabBar;
@property (nonatomic, strong) NavBar *navBar;
-(void)doNavBarSettings;
-(void)doBaseSettings;
@end
