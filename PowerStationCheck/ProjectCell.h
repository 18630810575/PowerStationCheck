//
//  ProjectCell.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/22.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderModel;

@interface ProjectCell : UITableViewCell

@property (nonatomic, strong) UIImageView *isOpenImageView;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndModel:(NSObject *)model AndLevel:(NSString *)level;
-(void)addFooter;
-(void)setBorder;
@end
