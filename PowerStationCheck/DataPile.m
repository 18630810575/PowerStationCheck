//
//  DataPile.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/20.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "DataPile.h"

@implementation DataPile

+(NSArray *)getDataPile{
    NSArray *arr = @[
                     @{@"proj_id":@"1",
                       @"proj_name":@"山东平原",
                       @"proj_type":@"1",
                       @"proj_work_order":@[
                               @{@"order_id":@"1",
                                 @"order_name":@"1#风机半月检",
                                 @"order_type":@"1",
                                 @"is_urgency":@"0",
                                 @"begin_time":@"12/18 7:30",
                                 @"end_time":@"12/19 9:30",
                                 @"mission":@[
                                         @{@"mission_id":@"1",
                                           @"mission_name":@"定期巡检-整机外观检查",
                                           @"assign_target":@"1",
                                           @"is_download":@"1",
                                           @"is_update":@"0",
                                           @"update_time":@"",
                                           @"need_handle":@"",
                                           },
                                         @{@"mission_id":@"1",
                                           @"mission_name":@"定期巡检-整机外观检查",
                                           @"assign_target":@"",
                                           @"is_download":@"1",
                                           @"is_update":@"1",
                                           @"update_time":@"",
                                           @"need_handle":@"",
                                           },
                                         @{@"mission_id":@"1",
                                           @"mission_name":@"定期巡检-整机外观检查",
                                           @"assign_target":@"1",
                                           @"is_download":@"1",
                                           @"is_update":@"0",
                                           @"update_time":@"",
                                           @"need_handle":@"",
                                           },
                                         @{@"mission_id":@"1",
                                           @"mission_name":@"定期巡检-整机外观检查",
                                           @"assign_target":@"1",
                                           @"is_download":@"1",
                                           @"is_update":@"0",
                                           @"update_time":@"",
                                           @"need_handle":@"",
                                           },
                                         @{@"mission_id":@"1",
                                           @"mission_name":@"定期巡检-整机外观检查",
                                           @"assign_target":@"1",
                                           @"is_download":@"1",
                                           @"is_update":@"0",
                                           @"update_time":@"",
                                           @"need_handle":@"",
                                           },
                                         @{@"mission_id":@"1",
                                           @"mission_name":@"定期巡检-整机外观检查",
                                           @"assign_target":@"1",
                                           @"is_download":@"1",
                                           @"is_update":@"0",
                                           @"update_time":@"",
                                           @"need_handle":@"",
                                           }
                                         ]
                                 },
                               ]
                       
                       },
                     @{
                         
                         },
                     ];
    return arr;
}

@end
