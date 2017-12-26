//
//  GettingCell.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/25.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderModel;
@class MissionModel;

typedef void(^orderBlock)(NSObject *model);
typedef void(^missionBlock)(NSObject *model);

@interface GettingCell : UITableViewCell
@property (nonatomic, strong) UIImageView *isOpenImageView;
@property (copy, nonatomic) orderBlock orderBlock;
@property (copy, nonatomic) missionBlock missionBlock;
@property (nonatomic, assign) BOOL selectedState;
@property (nonatomic, strong) UIButton *chosenButton;
@property (nonatomic , strong) OrderModel *model;
@property (nonatomic , strong) MissionModel *mission;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndModel:(NSObject *)model AndLevel:(NSString *)level;
-(void)addFooter;
-(void)setBorder;
@end
