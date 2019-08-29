//
//  niuniuRobotLashou.m
//  wechatHook
//
//  Created by antion on 2017/3/8.
//
//

#import "niuniuRobotLashou.h"
#import "toolManager.h"
#import "wxFunction.h"
#import "ycFunction.h"

@implementation niuniuRobotLashou

-(void) addLashou:(NSString*)userid {
    if (!tmanager.mRobot.mData.mLashouList[userid]) {
        tmanager.mRobot.mData.mLashouList[userid] = [NSMutableDictionary dictionary];
    }
    [tmanager.mRobot.mData saveLashouListFile];
}

-(void) delLashou:(NSString*)userid {
    [tmanager.mRobot.mData.mLashouList removeObjectForKey: userid];
    [tmanager.mRobot.mData saveLashouListFile];
}

//获取拉手成员人数
-(int) getLashouMemberCount:(NSString*)userid {
    NSDictionary* dic = tmanager.mRobot.mData.mLashouList[userid];
    if (!dic) {
        return 0;
    }
    return (int)[dic count];
}

//是否是拉手
-(BOOL) isLashou:(NSString*)userid {
    return tmanager.mRobot.mData.mLashouList[userid];
}

-(NSMutableArray*) getAllLashouDetail {
    NSMutableArray* ret = [NSMutableArray array];
    for (NSString* userid in tmanager.mRobot.mData.mLashouList) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        dic[@"userid"] = userid;
        dic[@"count"] = deInt2String((int)[tmanager.mRobot.mData.mLashouList[userid] count]);
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

//获取指定拉手名下所有成员, sortType: index/score
-(NSArray*) getAllLashouMemberDetail:(NSString*)userid sortType: (NSString*)sortType{
    NSMutableArray* ret = [NSMutableArray array];
    if (!tmanager.mRobot.mData.mLashouList[userid]) {
        return ret;
    }
    for (NSString* player in tmanager.mRobot.mData.mLashouList[userid]) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        dic[@"userid"] = player;
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: player];
        if (memData) {
            dic[@"name"] = memData[@"name"];
            dic[@"billName"] = memData[@"billName"];
            dic[@"score"] = memData[@"score"];
            dic[@"index"] = memData[@"index"];
        }
        [ret addObject: dic];
    }
    
    if ([sortType isEqualToString: @"score"]) {
        [ret sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            if (!a[@"score"]) {
                return 1;
            }
            if (!b[@"score"]) {
                return -1;
            }
            return [a[@"score"] intValue] < [b[@"score"] intValue] ? 1 : -1;
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

-(NSString*) addPlayer:(NSString*)userid player:(NSString*)player{
    if (!tmanager.mRobot.mData.mLashouList[userid]) {
        return @"拉手不存在";
    }
    if (tmanager.mRobot.mData.mLashouList[userid][player]) {
        return @"玩家已添加过";
    }
    for (NSString* userid in tmanager.mRobot.mData.mLashouList) {
        NSMutableDictionary* dic = tmanager.mRobot.mData.mLashouList[userid];
        if (dic[player]) {
//            NSDictionary* memData = [tmanager.mRobot.mMembers getMember:userid];
//            if (memData) {
//                return deString(@"该玩家已经是拉手[%@]的成员", memData[@"billName"]);
//            } else {
                return deString(@"该玩家已经是其他拉手的成员");
//            }
        }
    }
    if ([tmanager.mRobot.mTuos isTuo: player]) {
        return deString(@"该玩家已经是其他拉手的成员");
    }
    tmanager.mRobot.mData.mLashouList[userid][player] = @"true";
    [tmanager.mRobot.mData saveLashouListFile];
    return nil;
}

-(NSString*) delPlayer:(NSString*)userid player:(NSString*)player{
    if (!tmanager.mRobot.mData.mLashouList[userid]) {
        return @"拉手不存在";
    }
    [tmanager.mRobot.mData.mLashouList[userid] removeObjectForKey: player];
    [tmanager.mRobot.mData saveLashouListFile];
    return nil;
}

//获取玩家归属哪个拉手
-(NSDictionary*) getLashouWithPlayer:(NSString*)player {
    NSArray* userids = [tmanager.mRobot.mData.mLashouList allKeys];
    NSString* lashouUserid = nil;
    for (NSString* userid in userids) {
        if ([self isFromlashou: userid player: player]) {
            lashouUserid = userid;
            break;
        }
    }
    if (lashouUserid) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        dic[@"userid"] = lashouUserid;
        dic[@"count"] = deInt2String((int)[tmanager.mRobot.mData.mLashouList[lashouUserid] count]);
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: lashouUserid];
        if (memData) {
            dic[@"name"] = memData[@"name"];
            dic[@"billName"] = memData[@"billName"];
            dic[@"score"] = memData[@"score"];
            dic[@"index"] = memData[@"index"];
        }
        return dic;
    }
    return nil;
}

//是否是指定拉手的成员
-(BOOL) isFromlashou: (NSString*)userid player:(NSString*)player {
    NSDictionary* dic = tmanager.mRobot.mData.mLashouList[userid];
    if (!dic) {
        return NO;
    }
    return dic[player];
}

//拉手转移
-(BOOL) lashouMove: (NSString*)userid destUserid:(NSString*)destUserid {
    NSMutableDictionary* lashouDic = tmanager.mRobot.mData.mLashouList[userid];
    NSMutableDictionary* destLashouDic = tmanager.mRobot.mData.mLashouList[destUserid];
    if (!lashouDic || !destLashouDic) {
        return NO;
    }
    [destLashouDic setValuesForKeysWithDictionary: lashouDic];
    [lashouDic removeAllObjects];
    [tmanager.mRobot.mData saveLashouListFile];
    return YES;
}

@end
