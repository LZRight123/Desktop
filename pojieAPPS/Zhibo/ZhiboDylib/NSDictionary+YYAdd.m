//
//  NSDictionary+YYAdd.m
//  ZhiboDylib
//
//  Created by 周光 on 2019/7/14.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "NSDictionary+YYAdd.h"

@implementation NSDictionary (YYAdd)


- (NSString *)jsonPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData
                                                   encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}



- (NSString *)jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

@end
