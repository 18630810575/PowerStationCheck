//
//  NavBar.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "NavBar.h"

typedef void(^backBlock)(void);

@implementation NavBar{
    backBlock backClocker;
}

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
-(void)setBackBtnWithBlock:(void(^)(void))back{
    float statusBarHeight = kStatusBarHeight;
    UIImageView *backImg = [[UIImageView alloc]initWithImage:image(@"white_back")];
    [self  addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statusBarHeight + 12);
        make.left.equalTo(12);
        make.width.equalTo(16);
        make.height.equalTo(20);
    }];
    backClocker = back;
    UIButton *hudBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hudBtn.backgroundColor = [UIColor clearColor];
    [hudBtn addTarget:self action:@selector(PopVC) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hudBtn];
    [hudBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statusBarHeight);
        make.left.equalTo(0);
        make.width.equalTo(44);
        make.height.equalTo(44);
    }];
}

-(void)PopVC{
    backClocker();
}


@end
