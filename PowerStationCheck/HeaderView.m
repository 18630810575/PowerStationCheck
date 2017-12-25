//
//  HeaderView.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/22.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "HeaderView.h"
#import "ProjectModel.h"
#define kTitleColor UIColorFromRGB(0x333333)



@implementation HeaderView{
    ProjectModel *model;
    UIImageView *isOpenImageView;
}

- (instancetype)initWithIsOpen:(BOOL)is_open AndModel:(ProjectModel *)pmodel
{
    self = [super init];
    if (self) {
        model = pmodel;
        self.isOpen = is_open;
        [self addItems];
    }
    return self;
}

-(void)addItems{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 146*ScreenScale);
    NSString *kPicName = @"";
    if ([model.proj_type isEqualToString:@"1"]) {
        kPicName = @"wind_ene";
    }else{
        kPicName = @"sun_ene";
    }
    UIImageView *projectType = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kPicName]];
    [headerView addSubview:projectType];
    [projectType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(45*ScreenScale);
        make.width.equalTo(59*ScreenScale);
        make.height.equalTo(52*ScreenScale);
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = model.proj_name;
    title.textColor = kTitleColor;
    title.font = [UIFont systemFontOfSize:46*ScreenScale weight:bold];
    title.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(projectType.right).offset(25*ScreenScale);
        make.centerY.equalTo(projectType);
        make.width.equalTo(500*ScreenScale);
        make.height.equalTo(46*ScreenScale);
    }];
    
    NSString *kOpenImageName = @"";
    if(model.is_open) {
        kOpenImageName = @"proj_up";
    }else{
        kOpenImageName = @"proj_down";
    }
    
    isOpenImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:kOpenImageName]];
    [headerView addSubview:isOpenImageView];
    [isOpenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-65*ScreenScale);
        make.centerY.equalTo(projectType);
        make.width.equalTo(35*ScreenScale);
        make.height.equalTo(15*ScreenScale);
    }];
    
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOpen)]];
    [self addSubview:headerView];
}

- (void)tapOpen{
    
    if (self.isOpen) {
        [UIView animateWithDuration:0.3 animations:^{
            isOpenImageView.transform = CGAffineTransformRotate(isOpenImageView.transform, -M_PI);
        }completion:^(BOOL finished) {
        }];
        self.closeblock(self.section);
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            isOpenImageView.transform = CGAffineTransformRotate(isOpenImageView.transform, M_PI);
        }completion:^(BOOL finished) {
        }];
        self.openblock(self.section);
    }
    self.isOpen = !self.isOpen;
}

@end
