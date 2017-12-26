//
//  HeaderView.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/22.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectModel;

typedef void(^openBlock)(NSInteger section);
typedef void(^closeBlock)(NSInteger section);

@interface HeaderView : UIView
@property (copy, nonatomic) openBlock openblock;
@property (copy, nonatomic) closeBlock closeblock;

@property (assign, nonatomic) BOOL isOpen;
@property (assign, nonatomic) NSInteger section;
- (instancetype)initWithIsOpen:(BOOL)is_open AndModel:(ProjectModel *)pmodel;
@end
