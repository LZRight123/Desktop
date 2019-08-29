//
//  niuniuTuos.m
//  wechatHook
//
//  Created by antion on 2017/4/4.
//
//

#import "niuniuRobotTuos.h"
#import "toolManager.h"
#import "wxFunction.h"
#import "ycFunction.h"

@implementation niuniuRobotTuos

//添加托
-(void) addTuoQuick:(NSString*)userid {
    tmanager.mRobot.mData.mTuoList[userid] = @"true";
}

-(NSString*) addTuo:(NSString*)userid {
    NSDictionary* dic = [tmanager.mRobot.mLashous getLashouWithPlayer: userid];
    if (dic) {
        return deString(@"该玩家被拉手[%@. %@]添加过, 无法添加托权限", dic[@"index"], dic[@"billName"]);
    }
    tmanager.mRobot.mData.mTuoList[userid] = @"true";
    [tmanager.mRobot.mData saveTuoListFile];
    return nil;
}

//删除托
-(void) delTuo:(NSString*)userid {
    if (tmanager.mRobot.mData.mTuoList[userid]) {
        tmanager.mRobot.mData.mTuoList[userid] = @"false";
        [tmanager.mRobot.mData saveTuoListFile];
    }
}

//删除曾经是托的记录
-(void) delEverTuo:(NSString*)userid {
    if (tmanager.mRobot.mData.mTuoList[userid]) {
        [tmanager.mRobot.mData.mTuoList removeObjectForKey: userid];
        [tmanager.mRobot.mData saveTuoListFile];
    }
}

//是否托
-(BOOL) isTuo:(NSString*)userid {
    return tmanager.mRobot.mData.mTuoList[userid] && [tmanager.mRobot.mData.mTuoList[userid] isEqualToString: @"true"];
}

//是否曾经是托
-(BOOL) isEverTuo:(NSString*)userid {
    return tmanager.mRobot.mData.mTuoList[userid];
}

//获取托总数
-(int) getTuoCount {
    int count = 0;
    NSArray* values = [tmanager.mRobot.mData.mTuoList allValues];
    for (NSString* value in values) {
        if ([value isEqualToString: @"true"]) {
            ++count;
        }
    }
    return count;
}

//获取所有托
-(NSArray*) getAllTuoDetail: (BOOL)everTuo sortType: (NSString*)sortType{
    NSMutableArray* ret = [NSMutableArray array];
    for (NSString* userid in tmanager.mRobot.mData.mTuoList) {
        if ([tmanager.mRobot.mData.mTuoList[userid] isEqualToString: @"true"] == (!everTuo)) {
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            dic[@"userid"] = userid;
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                dic[@"billName"] = memData[@"billName"];
                dic[@"score"] = memData[@"score"];
                dic[@"index"] = memData[@"index"];
            }
            [ret addObject: dic];
        }
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

@end
