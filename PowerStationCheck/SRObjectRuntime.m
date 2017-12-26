
//
//  SRObjectRuntime.m
//  PartTimeJob
//
//  Created by 孙锐 on 2017/8/10.
//  Copyright © 2017年 孙锐. All rights reserved.
//

#import "SRObjectRuntime.h"

@implementation SRObjectRuntime


- (void)containsNilObject:(id)model {
    unsigned count = 0;
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t propertyValue = properties[i];
        const char *propertyName = property_getName(propertyValue);
        const char * attributes = property_getAttributes(propertyValue);//获取属性类型
        NSString *str = [NSString stringWithUTF8String:attributes];
        NSArray *subArr = [str componentsSeparatedByString:@"\""];
        if (subArr.count >1) {
            NSString *classString = subArr[1];
            NSString *proName = [NSString stringWithUTF8String:propertyName];
            
            SEL getSeletor = NSSelectorFromString([NSString stringWithUTF8String:propertyName]);
            
            if ([[model class] respondsToSelector:getSeletor]) {
                NSMethodSignature *signature = [[model class] methodSignatureForSelector:getSeletor];//方法签名
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];//调用对象
                
                [invocation setTarget:[model class]];//设置target
                [invocation setSelector:getSeletor];//设置selector
                NSObject *__unsafe_unretained returnValue = nil;//设置返回值
                [invocation invoke];//开始调用
                [invocation getReturnValue:&returnValue];//接收返回值
                NSLog(@"property value is:%@", returnValue);
                if (returnValue == nil) {
                    //                return YES;
                    if ([classString isEqualToString:@"NSString"]) {
                        NSString *data  = @"";
                        [self setValue:data forKey:proName];
                    }else if ([classString isEqualToString:@"NSDictionary"]){
                        NSDictionary *data  = [NSDictionary dictionary];
                        [self setValue:data forKey:proName];
                    }else if ([classString isEqualToString:@"NSArray"]){
                        NSArray *data = [NSArray array];
                        [self setValue:data forKey:proName];
                    }else if ([classString isEqualToString:@"NSData"]){
                        NSData *data  = [[NSData alloc]init];
                        [self setValue:data forKey:proName];
                    }else if ([classString isEqualToString:@"NSDate"]){
                        NSDate *data  = [NSDate date];
                        [self setValue:data forKey:proName];
                    }
                }
            }else{
                id propertyValue = [self valueForKey:proName];
                if (propertyValue == nil) {
                    if ([classString isEqualToString:@"NSString"]) {
                        NSString *data  = @"";
                        [self setValue:data forKey:proName];
                    }else if ([classString isEqualToString:@"NSDictionary"]){
                        NSDictionary *data  = [NSDictionary dictionary];
                        [self setValue:data forKey:proName];
                    }else if ([classString isEqualToString:@"NSArray"]){
                        NSArray *data = [NSArray array];
                        [self setValue:data forKey:proName];
                    }else if ([classString isEqualToString:@"NSData"]){
                        NSData *data  = [[NSData alloc]init];
                        [self setValue:data forKey:proName];
                    }else if ([classString isEqualToString:@"NSDate"]){
                        NSDate *data  = [NSDate date];
                        [self setValue:data forKey:proName];
                    }

                }
             
            }
        }
    }
}







@end
