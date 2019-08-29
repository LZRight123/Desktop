//
//  niuniuRobotExcelHelper.h
//  wechatHook
//
//  Created by antion on 2017/10/30.
//
//

#import <Foundation/Foundation.h>
#import "ycDefine.h"

@interface niuniuRobotExcelHelper : NSObject

//生成积分榜
+(NSData*) makeScoreTop;

//生成所有数据
+(NSData*) makeAllData: (NSMutableDictionary*)allPlayerData;

//生成管理上下分
+(NSData*) makeAdminScoreChanged:(NSDictionary*)memData allCount:(NSArray*)allCount upScoreCount:(int)upScoreCount downScoreCount:(int)downScoreCount;

//生成反水奖励
+(NSData*) makePlayerBackBonus: (NSMutableDictionary*)allPlayerData diffTuo:(BOOL)diffTuo;

//生成输分奖励
+(NSData*) makeLoseBonus: (NSMutableDictionary*)allPlayerData diffTuo:(BOOL)diffTuo;

//生成局数奖励
+(NSData*) makeRoundsBonus: (NSMutableDictionary*)allPlayerData diffTuo:(BOOL)diffTuo;

//生成集齐奖励
+(NSData*) makeCollectBonus: (NSMutableDictionary*)allPlayerData diffTuo:(BOOL)diffTuo;

//生成机器修改
+(NSData*) makeRobotReworks: (NSMutableArray*)reworkList;

//生成点数统计
+(NSData*) makeAmountCount:(NSDictionary*)bankers players:(NSDictionary*)players tuos:(NSDictionary*)tuos;
    
//生成同点杀统计
+(NSData*) makeBankerSamePowCount: (NSArray*)lists;

//查所有上下分明细
+(NSData*) makeAllScoreChangedDetails:(NSArray*)list;

//查所有群上下分
+(NSData*) makeAllChatroomScoreChanged:(NSDictionary*)chatrooms;

////测试
//+(NSData*) testMake: (NSMutableArray*)allPlayerData;

@end
