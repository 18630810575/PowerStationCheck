//
//  GettingCell.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/25.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GettingCell : UITableViewCell
@property (nonatomic, strong) UIImageView *isOpenImageView;

@property (nonatomic, assign) BOOL selectedState;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndModel:(NSObject *)model AndLevel:(NSString *)level;
-(void)addFooter;
-(void)setBorder;
@end
