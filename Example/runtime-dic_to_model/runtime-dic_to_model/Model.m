//
//  Model.m
//  runtime-dic_to_model
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "Model.h"
#import <objc/message.h>
@implementation Model

//key - value
//遍历 ，消息发送
//set 方法
//函数指针的格式
//返回类型 (*函数名)(arg1, arg2, ...)
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        for (NSString *key in dic) {
            id value = dic[key];
            //objc_msgSend(id, sel, value) 方法赋值 缺SEL
            NSString *methodName = [NSString stringWithFormat:@"set%@:", key.capitalizedString];
            SEL sel = NSSelectorFromString(methodName);
            if (sel) {
                ((void(*)(id, SEL, id))objc_msgSend)(self, sel, value);
            }
        }
    }
    return self;
}

// key - value
// key: class_getProperyList()
// value: get方法 (objc_msgSend)
- (NSDictionary *)convertModelToDic{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    if (count != 0) {
        NSMutableDictionary *tempDic = @{}.mutableCopy;
        
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            SEL sel = sel_registerName(propertyName);
            
            if (sel) {
                id value = ((id(*)(id, SEL))objc_msgSend)(self, sel);
                if (value) {
                    tempDic[name] = value;
                } else {
                    tempDic[name] = @"";
                }
            }
        }
        free(properties);
        return tempDic;
    }
    free(properties);
    
    return nil;
}

@end
