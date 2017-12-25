//
//  ProjectModel.m
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/20.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "ProjectModel.h"
#import "OrderModel.h"
#import "MissionModel.h"
@implementation ProjectModel

-(void)setModelWithDataPile:(NSDictionary *)dict{
    
    self.proj_id = dict[@"proj_id"];
    self.proj_name = dict[@"proj_name"];
    self.proj_type = dict[@"proj_type"];
    self.is_open = YES;
    NSArray *orderArr = dict[@"proj_work_order"];
    NSMutableArray *orderMuArr = [NSMutableArray array];
    if (orderArr.count != 0 && orderArr != nil) {
        for (int i=0; i<orderArr.count; i++) {
            NSDictionary *dict = orderArr[i];
            OrderModel *model = [[OrderModel alloc]init];
            model.order_id = dict[@"order_id"];
            model.order_name = dict[@"order_name"];
            model.order_type = dict[@"order_type"];
            model.is_urgency = dict[@"is_urgency"];
            model.begin_time = dict[@"begin_time"];
            model.end_time = dict[@"end_time"];
            model.is_open = YES;
            NSArray *missionArr = dict[@"mission"];
            NSMutableArray *missionMuArr = [NSMutableArray array];
            if (missionArr.count != 0 && missionArr != nil) {
                missionMuArr = [MissionModel mj_objectArrayWithKeyValuesArray:missionArr];
            }
            model.mission = missionMuArr;
            [orderMuArr addObject:model];
        }
    }
    self.proj_work_order = orderMuArr;
    NSLog(@"finish!");
}

@end
