//
//  ProjectModel.h
//  PowerStationCheck
//
//  Created by 孙锐 on 2017/12/20.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "SRObjectRuntime.h"

@interface ProjectModel : SRObjectRuntime
@property (nonatomic, strong) NSString *proj_id;
@property (nonatomic, strong) NSString *proj_name;
@property (nonatomic, strong) NSString *proj_type;
@property (nonatomic, assign) BOOL is_open;
@property (nonatomic, strong) NSArray *proj_work_order;

-(void)setModelWithDataPile:(NSDictionary *)dict;

@end
