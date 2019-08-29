//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  banzhuanDylib.m
//  banzhuanDylib
//
//  Created by 梁泽 on 2019/7/15.
//  Copyright (c) 2019 梁泽. All rights reserved.
//

#import "banzhuanDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>
#import <FLEX/FLEXManager.h>

CHConstructor{
    printf(INSERT_SUCCESS_WELCOME);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
#ifndef __OPTIMIZE__
        CYListenServer(6666);

        MDCycriptManager* manager = [MDCycriptManager sharedInstance];
        [manager loadCycript:NO];

        NSError* error;
        NSString* result = [manager evaluateCycript:@"UIApp" error:&error];
        NSLog(@"result: %@", result);
        if(error.code != 0){
            NSLog(@"error: %@", error.localizedDescription);
        }
#endif
        [[FLEXManager sharedManager] showExplorer];
        
    }];
}


CHDeclareClass(CustomViewController)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

//add new method
CHDeclareMethod1(void, CustomViewController, newMethod, NSString*, output){
    NSLog(@"This is a new method : %@", output);
}

#pragma clang diagnostic pop

CHOptimizedClassMethod0(self, void, CustomViewController, classMethod){
    NSLog(@"hook class method");
    CHSuper0(CustomViewController, classMethod);
}

CHOptimizedMethod0(self, NSString*, CustomViewController, getMyName){
    //get origin value
    NSString* originName = CHSuper(0, CustomViewController, getMyName);
    
    NSLog(@"origin name is:%@",originName);
    
    //get property
    NSString* password = CHIvar(self,_password,__strong NSString*);
    
    NSLog(@"password is %@",password);
    
    [self newMethod:@"output"];
    
    //set new property
    self.newProperty = @"newProperty";
    
    NSLog(@"newProperty : %@", self.newProperty);
    
    //change the value
    return @"梁泽";
    
}

//add new property
CHPropertyRetainNonatomic(CustomViewController, NSString*, newProperty, setNewProperty);
//1.4com.recycle.easyiPhone 6s PlusB7C76C82-CB78-48F2-897A-FA72D844FA56com.cv.bfs12.1036{"timeStamp":"1563196109","isVPNOn":false,"battery":"93%-Charging","registeredDate":"1563195983","ctCarrier":"02-460-cn","HMotion":[[1,0,1],[1,0,1],[1,0,1],[1,0,1],[1,0,0]],"purchaserDSID":0,"resetDate":"1551227884","systemPlistDate":"1549347287","isJailBroken":false,"RegionInfo":"CH\/A","iphoneType":"iPhone8,2","brightness":"33583","screenSize":"1242*2208"}1563196108bzl

CHConstructor{
//    NSDictionary *testInfo = @{
//                    @"timeStamp" : @"1563196109",
//                    @"isVPNOn": @"false",
//                    @"battery":@"93%-Charging",
//                    @"registeredDate":@"1563195983",
//                    @"ctCarrier":@"02-460-cn",
//                    @"HMotion": @[@[@1,@0,@1],@[@1,@0,@1],@[@1,@0,@1],@[@1,@0,@1],@[@1,@0,@0]],
//                    @"purchaserDSID":@0,
//                    @"resetDate":@"1551227884",
//                    @"systemPlistDate":@"1549347287",
//                    @"isJailBroken": @"false",
//                    @"RegionInfo": @"CH\/A",
//                    @"iphoneType":@"iPhone8,2",
//                    @"brightness":@"33583",
//                    @"screenSize":@"1242*2208"
//    };
    NSString *testInfoStr = @"{\"timeStamp\":\"1563196109\",\"isVPNOn\":false,\"battery\":\"93%-Charging\",\"registeredDate\":\"1563195983\",\"ctCarrier\":\"02-460-cn\",\"HMotion\":[[1,0,1],[1,0,1],[1,0,1],[1,0,1],[1,0,0]],\"purchaserDSID\":0,\"resetDate\":\"1551227884\",\"systemPlistDate\":\"1549347287\",\"isJailBroken\":false,\"RegionInfo\":\"CH\\/A\",\"iphoneType\":\"iPhone8,2\",\"brightness\":\"33583\",\"screenSize\":\"1242*2208\"}";
    NSDictionary *orig_dic = @{
                                  @"timeap" : @"1563196108",
                                  @"app_version" : @"1.4",
                                  @"bundle_id" : @"com.recycle.easy",
                                  @"taskId" : @"36",
                                  @"testInfo" : testInfoStr,
                                  @"sysVersion" : @"12.10",
                                  @"device_type" : @"iPhone 6s Plus",
                                  @"packageName" : @"com.cv.bfs",
                                  @"idfa" : @"B7C76C82-CB78-48F2-897A-FA72D844FA56"
                                  };
    NSArray *keys = [[orig_dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString * _Nonnull obj1, NSString *   _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableString *mstr = @"".mutableCopy;
    for (NSString *key in keys){
        NSObject *value = orig_dic[key];
        [mstr appendFormat:@"%@", value];
    }
    const char *ut = mstr.UTF8String;
    NSLog(@"%@",[mstr stringByReplacingOccurrencesOfString:@"\n" withString:@""]);
    printf("%s",ut);
    
//    const char *cfstr = "d\xE4\xA6\x52\xF0\x47\x8C\x70{\x9A\xA6{&\xD0\x1B\xD1\xE4\xB6!cM\xBD\vQ=\xEE\x33\x69Lt\xB8w\x7Fx\x19\xEB\xE8\xB8.\x11\xB7\x11\xAF\x81\xE4\xB6\x08t\x17\xFA\x83\x0F]\xEC\x7F\x34\xE2\x73\x5AU\x8C\xE9\xF7\x52\xB9";
    const char *cfstr = "\xE4\xA6\x52\xF0\x47\x8C\x70";
    
    printf("cfstr = %s", cfstr);
    NSLog(@"app installation path: %@", [[NSBundle mainBundle] executablePath]);
    /*
     1.4com.recycle.easyiPhone 6s PlusB7C76C82-CB78-48F2-897A-FA72D844FA56com.cv.bfs12.1036{"timeStamp":"1563196109","isVPNOn":false,"battery":"93%-Charging","registeredDate":"1563195983","ctCarrier":"02-460-cn","HMotion":[[1,0,1],[1,0,1],[1,0,1],[1,0,1],[1,0,0]],"purchaserDSID":0,"resetDate":"1551227884","systemPlistDate":"1549347287","isJailBroken":false,"RegionInfo":"CH\/A","iphoneType":"iPhone8,2","brightness":"33583","screenSize":"1242*2208"}1563196108
     
*/
    
    /*
     1.4com.recycle.easyiPhone 6A7C4AF1C-540A-4870-9F37-824E94F2FA0810.10{"timeStamp":"1563261183","isVPNOn":false,"battery":"25%-Charging","registeredDate":"1563261082","ctCarrier":"11-460-cn","HMotion":[[-13,31,39],[-6,39,60],[-7,39,61],[-6,38,61],[0,31,52]],"purchaserDSID":0,"resetDate":"1560421848","systemPlistDate":"1478483098","wifiName":"jk998-guest","isJailBroken":false,"wifiMac":"4c:fa:ca:38:7e:b1","RegionInfo":"LL\/A","iphoneType":"iPhone7,2","brightness":"71242","screenSize":"750*1334"}1563261183bzl5514C2A7-1F8B-4318-A244-E5400F32B670yhhmbgo
     */
    
    /*
     1.4com.recycle.easyiPhone 6A7C4AF1C-540A-4870-9F37-824E94F2FA0810.10{"timeStamp":"1563266761","isVPNOn":false,"battery":"82%-Charging","registeredDate":"1563266733","ctCarrier":"11-460-cn","HMotion":[[-2,14,63],[4,14,66],[2,15,65],[2,15,65],[2,19,23]],"purchaserDSID":0,"resetDate":"1560421848","systemPlistDate":"1478483098","wifiName":"jk998-guest","isJailBroken":false,"wifiMac":"4c:fa:ca:38:7e:b1","RegionInfo":"LL\/A","iphoneType":"iPhone7,2","brightness":"71242","screenSize":"750*1334"}1563266761bzl5514C2A7-1F8B-4318-A244-E5400F32B670yhhmbgo
     */
}

@interface NSDictionary(des)

@end

@implementation NSDictionary(des)

//- (NSString *)description{
//    return <#expression#>
//}

@end

