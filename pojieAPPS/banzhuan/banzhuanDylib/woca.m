//
//  woca.m
//  banzhuanDylib
//
//  Created by 梁泽 on 2019/7/15.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "woca.h"

@implementation woca
+ (NSString *)woca{
    NSDictionary *testInfo = @{
                               @"timeStamp" : @"1563196109",
                               @"isVPNOn": @"false",
                               @"battery":@"93%-Charging",
                               @"registeredDate":@"1563195983",
                               @"ctCarrier":@"02-460-cn",
                               @"HMotion": @[@[@1,@0,@1],@[@1,@0,@1],@[@1,@0,@1],@[@1,@0,@1],@[@1,@0,@0]],
                               @"purchaserDSID":@0,
                               @"resetDate":@"1551227884",
                               @"systemPlistDate":@"1549347287",
                               @"isJailBroken": @"false",
                               @"RegionInfo": @"CH\/A",
                               @"iphoneType":@"iPhone8,2",
                               @"brightness":@"33583",
                               @"screenSize":@"1242*2208"
                               };
    NSData *data = [NSJSONSerialization dataWithJSONObject:testInfo options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *orig_dic = @{
                               @"timeap" : @"1563196108",
                               @"app_version" : @"1.4",
                               @"bundle_id" : @"com.recycle.easy",
                               @"taskId" : @"36",
                               @"testInfo" : testInfo,
                               @"sysVersion" : @"12.10",
                               @"device_type" : @"iPhone 6s Plus",
                               @"packageName" : @"com.cv.bfs",
                               @"idfa" : @"B7C76C82-CB78-48F2-897A-FA72D844FA56"
                               };
    NSArray *keys = [orig_dic allKeys];
    NSMutableString *mstr = @"".mutableCopy;
    for (NSString *key in keys){
        NSObject *value = orig_dic[key];
        [mstr appendFormat:@"%@", value];
    }
    // 我想要这种
    //    NSLog(@"%@",[mstr stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
    /*
     1.4com.recycle.easyiPhone 6s PlusB7C76C82-CB78-48F2-897A-FA72D844FA56com.cv.bfs12.1036{"timeStamp":"1563196109","isVPNOn":false,"battery":"93%-Charging","registeredDate":"1563195983","ctCarrier":"02-460-cn","HMotion":[[1,0,1],[1,0,1],[1,0,1],[1,0,1],[1,0,0]],"purchaserDSID":0,"resetDate":"1551227884","systemPlistDate":"1549347287","isJailBroken":false,"RegionInfo":"CH\/A","iphoneType":"iPhone8,2","brightness":"33583","screenSize":"1242*2208"}1563196108
     
     */
    return @"";
}
@end
