//
//  TabBar.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const TabBarNotificationChangeViewController;

//@protocol TabBarDelegate <NSObject>
//
//@required
//
//-(void)tabButtonClickToShowControllerWithTag:(int)tag;
//
//@end

@interface TabBar : UIView

//@property (weak, nonatomic) id <TabBarDelegate> delegate;

-(void)creatFiveTabButton;

-(void)changeViewWithViewTitle:(NSString *)title;

-(void)addNeedBackButton;


@end
