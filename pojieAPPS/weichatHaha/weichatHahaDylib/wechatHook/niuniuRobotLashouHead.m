//
//  niuniuRobotLashouHead.m
//  wechatHook
//
//  Created by antion on 2017/11/10.
//
//

#import "niuniuRobotLashouHead.h"
#import "toolManager.h"
#import "wxFunction.h"
#import "ycFunction.h"

@implementation niuniuRobotLashouHead

//添加拉手团长
-(void) addLashouHead:(NSString*)userid {
    if (!tmanager.mRobot.mData.mLashouHeadList[userid]) {
        tmanager.mRobot.mData.mLashouHeadList[userid] = [NSMutableDictionary dictionary];
    }
    [tmanager.mRobot.mData saveLashouHeadListFile];
}

//删除拉手团长
-(void) delLashouHead:(NSString*)userid {
    [tmanager.mRobot.mData.mLashouHeadList removeObjectForKey: userid];
    [tmanager.mRobot.mData saveLashouHeadListFile];
}

//获取拉手成员人数
-(int) getLashouHeadMemberCount:(NSString*)userid {
    NSDictionary* dic = tmanager.mRobot.mData.mLashouHeadList[userid];
    if (!dic) {
        return 0;
    }
    return (int)[dic count];
}

//添加拉手
-(NSString*) addLashou:(NSString*)userid lashou:(NSString*)lashou {
    return [self addLashou:userid lashou:lashou isSave:YES];
}

-(NSString*) addLashou:(NSString*)userid lashou:(NSString*)lashou isSave:(BOOL)isSave {
    if (!tmanager.mRobot.mData.mLashouHeadList[userid]) {
        return @"拉手团长不存在";
    }
    if (tmanager.mRobot.mData.mLashouHeadList[userid][lashou]) {
        return @"拉手已添加过";
    }
    if (![tmanager.mRobot.mLashous isLashou: lashou]) {
        [tmanager.mRobot.mLashous addLashou: lashou];
    }
    for (NSString* userid in tmanager.mRobot.mData.mLashouHeadList) {
        NSMutableDictionary* dic = tmanager.mRobot.mData.mLashouHeadList[userid];
        if (dic[lashou]) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember:userid];
            if (memData) {
                return deString(@"该拉手已经是团长[%@]的成员", memData[@"billName"]);
            } else {
                return deString(@"该拉手已经是其他团长的成员");
            }
        }
    }
    tmanager.mRobot.mData.mLashouHeadList[userid][lashou] = @"true";
    if (isSave) {
        [tmanager.mRobot.mData saveLashouHeadListFile];
    }
    return nil;
}

//删除拉手
-(NSString*) delLashou:(NSString*)userid lashou:(NSString*)lashou {
    if (!tmanager.mRobot.mData.mLashouHeadList[userid]) {
        return @"拉手团长不存在";
    }
    [tmanager.mRobot.mData.mLashouHeadList[userid] removeObjectForKey: lashou];
    [tmanager.mRobot.mData saveLashouHeadListFile];
    return nil;
}

//获取拉手归属哪个团长
-(NSDictionary*) getLashouHeadWithLashou:(NSString*)lashou {
    NSArray* array = [self getAllLashouHeadDetail];
    for (NSDictionary* dic in array) {
        if ([self isFromlashouHead: dic[@"userid"] lashou: lashou]) {
            return dic;
        }
    }
    return nil;
}

//是否是指定团长的成员
-(BOOL) isFromlashouHead: (NSString*)userid lashou:(NSString*)lashou {
    NSDictionary* dic = tmanager.mRobot.mData.mLashouHeadList[userid];
    if (!dic) {
        return NO;
    }
    return dic[lashou];
}

//是否是拉手团长
-(BOOL) isLashouHead:(NSString*)userid {
    return tmanager.mRobot.mData.mLashouHeadList[userid];
}

//拉手团长转移
-(BOOL) lashouHeadMove: (NSString*)userid destUserid:(NSString*)destUserid {
    NSMutableDictionary* lashouHeadDic = tmanager.mRobot.mData.mLashouHeadList[userid];
    NSMutableDictionary* destLashouHeadDic = tmanager.mRobot.mData.mLashouHeadList[destUserid];
    if (!lashouHeadDic || !destLashouHeadDic) {
        return NO;
    }
    [destLashouHeadDic setValuesForKeysWithDictionary: lashouHeadDic];
    [lashouHeadDic removeAllObjects];
    [tmanager.mRobot.mData saveLashouHeadListFile];
    return YES;
}

//获取指定拉手团长名下所有成员, sortType: index/count
-(NSMutableArray*) getAllLashouHeadMemberDetail:(NSString*)userid sortType: (NSString*)sortType{
    NSMutableArray* ret = [NSMutableArray array];
    if (!tmanager.mRobot.mData.mLashouHeadList[userid]) {
        return ret;
    }
    for (NSString* player in tmanager.mRobot.mData.mLashouHeadList[userid]) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        dic[@"userid"] = player;
        dic[@"count"] = deInt2String([tmanager.mRobot.mLashous getLashouMemberCount:player]);
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: player];
        if (memData) {
            dic[@"name"] = memData[@"name"];
            dic[@"billName"] = memData[@"billName"];
            dic[@"score"] = memData[@"score"];
            dic[@"index"] = memData[@"index"];
        }
        [ret addObject: dic];
    }
    
    if ([sortType isEqualToString: @"count"]) {
        [ret sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            if (!a[@"count"]) {
                return 1;
            }
            if (!b[@"count"]) {
                return -1;
            }
            return [a[@"count"] intValue] < [b[@"count"] intValue] ? 1 : -1;
        }];
    } else if([sortType isEqualToString: @"index"]){
        [ret sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            if (!a[@"index"]) {
                return 1;
            }
            if (!b[@"index"]) {
                return -1;
            }
            return [a[@"index"] intValue] > [b[@"index"] intValue] ? 1 : -1;
        }];
    }
    return ret;
}

//获取所有拉手团长
-(NSMutableArray*) getAllLashouHeadDetail {
    NSMutableArray* ret = [NSMutableArray array];
    for (NSString* userid in tmanager.mRobot.mData.mLashouHeadList) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        dic[@"userid"] = userid;
        dic[@"count"] = deInt2String((int)[tmanager.mRobot.mData.mLashouHeadList[userid] count]);
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        if (memData) {
            dic[@"name"] = memData[@"name"];
            dic[@"billName"] = memData[@"billName"];
            dic[@"score"] = memData[@"score"];
            dic[@"index"] = memData[@"index"];
        }
        [ret addObject: dic];
    }
    [ret sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (!a[@"index"]) {
            return 1;
        }
        if (!b[@"index"]) {
            return -1;
        }
        return [a[@"index"] intValue] > [b[@"index"] intValue] ? 1 : -1;
    }];
    return ret;
}

@end
  
