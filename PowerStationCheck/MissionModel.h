//
//  MissionModel.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/22.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "SRObjectRuntime.h"

@interface MissionModel : SRObjectRuntime
@property (nonatomic, assign) BOOL is_chosen;
@property (nonatomic, strong) NSString *mission_id;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *mission_name;
@property (nonatomic, strong) NSString *assign_target;
@property (nonatomic, strong) NSString *is_download;
@property (nonatomic, strong) NSString *has_saved;
@property (nonatomic, strong) NSString *is_update;
@property (nonatomic, strong) NSString *is_urgency;
@property (nonatomic, strong) NSString *update_time;
@property (nonatomic, strong) NSString *need_handle;

-(void)setModelWithDataPile:(NSDictionary *)dict;

@end
