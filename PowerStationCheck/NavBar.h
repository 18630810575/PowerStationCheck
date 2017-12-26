//
//  NavBar.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavBar : UIView

-(void)setBackgroundImage;
-(void)setNavTitle:(NSString *)title;
-(void)setBackBtnWithBlock:(void(^)(void))back;
@end
