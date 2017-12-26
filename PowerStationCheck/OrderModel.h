//
//  OrderModel.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/22.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "SRObjectRuntime.h"

@interface OrderModel : SRObjectRuntime
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *order_name;
@property (nonatomic, strong) NSString *order_type;
@property (nonatomic, strong) NSString *is_urgency;
@property (nonatomic, strong) NSString *begin_time;
@property (nonatomic, strong) NSString *end_time;
@property (nonatomic, assign) BOOL is_open;
@property (nonatomic, strong) NSArray *mission;

-(void)setModelWithDataPile:(NSDictionary *)dict;

@end
