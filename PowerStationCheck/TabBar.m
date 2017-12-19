//
//  TabBar.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/19.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "TabBar.h"

NSString *const TabBarNotificationChangeViewController = @"TabBarNotificationChangeViewController";

static const int kTabImageTag = 200;
static const int kTabLabelTag = 201;
static const int kTabButtonTag = 202;
static const int kTabContentBaseTag = 400;

static const int kTabLabelFont = 11;
static const int kTabImageSize = 18;
static const int kTabLabelOffset = -6;
static const int kMiddleImageSize = 45;




#define kUITabTextColor UIColorFromRGB(0xA0A0A0)
#define kSelectedFontColor UIColorFromRGB(0x5AB5FF)

@interface TabBar ()

@end

@implementation TabBar{
    NSArray *tabArr;
    NSArray *tabImageArr;
    UIView *backContent;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        tabArr = @[@"待办任务",@"待领任务",@"扫一扫",@"任务列表",@"我的"];
        tabImageArr = @[@"wait_doing",@"wait_getting",@"scan_qr_code_selected",@"mission_list",@"mine"];
        self.backgroundColor = [UIColor clearColor];
        backContent = [[UIView alloc]init];
        backContent.backgroundColor = [UIColor whiteColor];
        [self addSubview:backContent];
        [backContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.height.equalTo(kBaseTabBarHeight);
            make.width.equalTo(kScreenWidth);
        }];
    }
    return self;
}


-(void)creatFiveTabButton{
    
    for (int i=0; i<5; i++) {
        if (i != 2) {
            UIView *tabContent = [[UIView alloc]init];
            tabContent.backgroundColor = [UIColor clearColor];
            tabContent.tag = kTabContentBaseTag+i;
            [backContent addSubview:tabContent];
            
            UIImageView *tabImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:tabImageArr[i]]];
            tabImage.tag = kTabImageTag;
            [tabContent addSubview:tabImage];
            
            UILabel *tabLabel = [[UILabel alloc]init];
            tabLabel.text = tabArr[i];
            tabLabel.textColor = kUITabTextColor;
            tabLabel.font = [UIFont systemFontOfSize:kTabLabelFont];
            tabLabel.textAlignment = NSTextAlignmentCenter;
            tabLabel.tag = kTabLabelTag;
            [tabContent addSubview:tabLabel];
            
            UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tabButton.backgroundColor = [UIColor clearColor];
            [tabButton addTarget:self action:@selector(clickToShowViewWithTag:) forControlEvents:UIControlEventTouchUpInside];
            tabButton.tag = kTabButtonTag;
            [tabContent addSubview:tabButton];
            
            //设置尺寸
            [tabContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(i*kScreenWidth/5);
                make.bottom.equalTo(0);
                make.height.equalTo(kBaseTabBarHeight);
                make.width.equalTo(kScreenWidth/5);
            }];
            [tabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(tabContent.bottom).offset(kTabLabelOffset);
                make.left.equalTo(0);
                make.width.equalTo(tabContent);
                make.height.equalTo(kTabLabelFont);
            }];
            [tabImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(tabContent);
                make.bottom.equalTo(tabLabel.top).offset(kTabLabelOffset);
                make.width.equalTo(kTabImageSize);
                make.height.equalTo(kTabImageSize);
            }];
            [tabButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(tabContent);
                make.left.and.top.equalTo(0);
            }];
        }
    }
    [self creatMiddleTabButton];
}

-(void)creatMiddleTabButton{
    UIView *middleTabContent = [[UIView alloc]init];
    middleTabContent.backgroundColor = [UIColor clearColor];
    middleTabContent.tag = kTabContentBaseTag +2;
    [self addSubview:middleTabContent];
    
    [middleTabContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(kScreenWidth/5);
        make.height.equalTo(kBaseTabBarMaxHeight);
        make.bottom.equalTo(0);
        make.centerX.equalTo(self);
    }];
    UILabel *tabLabel = [[UILabel alloc]init];
    tabLabel.text = tabArr[2];
    tabLabel.textColor = kUITabTextColor;
    tabLabel.font = [UIFont systemFontOfSize:kTabLabelFont];
    tabLabel.textAlignment = NSTextAlignmentCenter;
    tabLabel.tag = kTabLabelTag;
    [middleTabContent addSubview:tabLabel];
    
    [tabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(middleTabContent.bottom).offset(kTabLabelOffset);
        make.left.equalTo(0);
        make.width.equalTo(middleTabContent);
        make.height.equalTo(kTabLabelFont);
    }];
    
    UIImageView *tabImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:tabImageArr[2]]];
    tabImage.layer.cornerRadius = kMiddleImageSize/2;
    [middleTabContent addSubview:tabImage];
    
    [tabImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(0);
        make.width.and.height.equalTo(kMiddleImageSize);
    }];
    
    UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tabButton.backgroundColor = [UIColor clearColor];
    [tabButton addTarget:self action:@selector(clickToShowViewWithTag:) forControlEvents:UIControlEventTouchUpInside];
    tabButton.tag = kTabButtonTag;
    [middleTabContent addSubview:tabButton];
    
    [tabButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(middleTabContent);
        make.left.and.top.equalTo(0);
    }];
}



-(void)clickToShowViewWithTag:(UIButton *)sender{
    
//    [_delegate tabButtonClickToShowControllerWithTag:(int)sender.tag];
    [[NSNotificationCenter defaultCenter]postNotificationName:TabBarNotificationChangeViewController  object:sender.superview];
    
}

-(void)changeViewWithViewTitle:(NSString *)title{
    
    for (int i=0; i<tabArr.count; i++) {
        if ([title isEqualToString:tabArr[i]]) {
            int tag = i;
            UIImageView *imageView;
            UILabel *label;
            if (tag != 2) {
                UIView *view = [backContent viewWithTag:kTabContentBaseTag+tag];
                imageView = [view viewWithTag:kTabImageTag];
                label = [view viewWithTag:kTabLabelTag];
                imageView.image = [UIImage imageNamed:[tabImageArr[tag] stringByAppendingString:@"_selected"]];
                label.textColor = kSelectedFontColor;
            }
            
        }
    }
}

@end
