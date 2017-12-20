//
//  NavBar.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "NavBar.h"


@implementation NavBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

-(void)setBackgroundImage{
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kNavBackgroundImageName]];
    [self addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.width.and.height.equalTo(self);
    }];
    
}

-(void)setNavTitle:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18 weight:bold];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [self addSubview:titleLabel];
    float statusBarHeight = kStatusBarHeight;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(statusBarHeight);
        make.height.equalTo(44);
    }];
}

@end
