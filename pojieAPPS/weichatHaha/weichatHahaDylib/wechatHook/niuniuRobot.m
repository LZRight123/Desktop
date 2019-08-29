//
//  niuniuRobot.m
//  wechatHook
//
//  Created by antion mac on 2016/12/9.
//
//

#import "niuniuRobot.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"

/*

颜色-------------
红色: 无效
粉红: 玩家剩余分小于最低押注
黄色: 玩家押注小于最低押注
蓝色（30 144 255）: 重复下注
//灰色: 玩家剩余分小于玩家押注
白色: 正常
 
更新列表-----------------------------
 有人下注
 有人撤回
 置为无效
 置为有效
 有人上分
 有人下分
 新加会员
 
结算可能
正常
无包
抢包
超时
 
个人名片模版
 <?xml version="1.0"?>
 <msg bigheadimgurl="http://wx.qlogo.cn/mmhead/ver_1/gsEA320tQLs5gV5H06wbYrsibBGUcEnZnysBicmobJk2PSh5cdNKkd4TOE2ZPUNxnCMJR8N54WKjbemoibKXCn7tg/0" smallheadimgurl="http://wx.qlogo.cn/mmhead/ver_1/gsEA320tQLs5gV5H06wbYrsibBGUcEnZnysBicmobJk2PSh5cdNKkd4TOE2ZPUNxnCMJR8N54WKjbemoibKXCn7tg/132" username="v1_d5be0b87e3181cc439d83d4f109d6902279e371e0fe6430369e49b431b12f0e0@stranger" nickname="Aaa，朋友圈被封" fullpy="Aaapengyoujuanbeifeng" shortpy="" alias="" imagestatus="3" scene="17" province="福建" city="中国" sign="" sex="1" certflag="0" certinfo="" brandIconUrl="" brandHomeUrl="" brandSubscriptConfigUrl="" brandFlags="0" regionCode="CN_Fujian_Zhangzhou" antispamticket="v2_d0aac70be561e73563f2bf53ce3a2ff5f72c3aaa1f4e6746c7367b824a0f1b736716890cc9e66465e75babbe85105f0b@stranger" />
 */

@interface niuniuRobot () {
}

@end

@implementation niuniuRobot

-(id) init {
    if (self = [super init]) {
        self.mGameRoom = nil;
        self.mGameTitle = nil;
        self.mData = [niuniuRobotData new];
        self.mMembers = [niuniuRobotMembers new];
        self.mBet = [niuniuRobotBet new];
        self.mResult = [niuniuRobotResult new];
        self.mAdmins = [niuniuRobotAdmins new];
        self.mTuos = [niuniuRobotTuos new];
        self.mLashous = [niuniuRobotLashou new];
        self.mLashouHeads = [niuniuRobotLashouHead new];
        self.mCommand = [niuniuRobotCommand new];
        self.mPlayerCmd = [niuniuRobotPlayerCmd new];
        self.mInviteCheck = [niuniuRobotChatRoomInviteCheck new];
        self.mSendMsg = [niuniuRobotSendMsg new];
        self.mTimer = [niuniuRobotTimer new];
        self.mDayInfos = [niuniuRobotDayInfos new];
        self.mRework = [niuniuRobotRework new];
        self.mNumber = [self.mData lastRoundNumber]+1;
        self.mEnableNiuniu = [self.mData.mBaseSetting[@"supportNiuniu"] isEqualToString: @"true"];
        self.mEnableLonghu = [self.mData.mBaseSetting[@"supportLonghu"] isEqualToString: @"true"];
        self.mEnableTema = [self.mData.mBaseSetting[@"supportTema"] isEqualToString: @"true"];
        self.mEnableBaijiale = [self.mData.mBaseSetting[@"supportBaijiale"] isEqualToString: @"true"];
        {
            NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [objDateformat setDateFormat:@"YYYY-MM-dd"];
            self.mQueryDate = [objDateformat stringFromDate: [NSDate date]];
            self.mQueryDateForLashou = [objDateformat stringFromDate: [NSDate date]];
        }
        self.mBackroundRooms = [@[] mutableCopy];
    }
    return self;
}

-(void) dealloc {
    NSLog(@"niuniuHelper dealloc");
    
    self.mGameRoom = nil;
    self.mGameTitle = nil;
    self.mQueryDate = nil;
    
    if (self.mData) {
        [self.mData release];
    }
    if (self.mMembers) {
        [self.mMembers release];
    }
    if (self.mBet) {
        [self.mBet release];
    }
    if (self.mResult) {
        [self.mResult release];
    }
    if (self.mAdmins) {
        [self.mAdmins release];
    }
    if (self.mLashous) {
        [self.mLashous release];
    }
    if (self.mCommand) {
        [self.mCommand release];
    }
    if (self.mSendMsg) {
        [self.mSendMsg release];
    }
    if (self.mTimer) {
        [self.mTimer release];
    }
    if(self.mBackroundRooms) {
        [self.mBackroundRooms release];
    }
    if (self.mDayInfos) {
        [self.mDayInfos release];
    }
    [super dealloc];
}

-(NSString*) getIdentityStr:(NSString*)userid {
    if (!userid) {
        return @"";
    }
    NSMutableString* identityStr = [NSMutableString string];
    BOOL isTuo = [tmanager.mRobot.mTuos isTuo: userid];
    if (isTuo) {
        [identityStr appendString: @"托"];
    } else {
        [identityStr appendString: @"玩家"];
    }
    if ([tmanager.mRobot.mAdmins isAdmin: userid]) {
        [identityStr appendString: @"/管理"];
    }
    if ([tmanager.mRobot.mLashous isLashou: userid]) {
        [identityStr appendString: @"/拉手"];
    }
    if ([tmanager.mRobot.mLashouHeads isLashouHead: userid]) {
        [identityStr appendString: @"/团长"];
    }
    if (!isTuo && [tmanager.mRobot.mTuos isEverTuo: userid]) {
        [identityStr appendString: @" (曾经是托)"];
    }
    return identityStr;
}

//绑定、解绑游戏群
-(void) bindGameRoom: (NSString*)room title:(NSString*)title {
    self.mGameRoom = room;
    self.mGameTitle = title;
    if (room) {
        [self.mInviteCheck bindChatroom];
    }
}
-(void) unbindGameRoom {
    self.mGameRoom = nil;
    self.mGameTitle = nil;
}

//导入上次数据
-(BOOL) loadLastBackgroundData {
    NSArray* lastList = [self.mData getBackgroundChatroom];
    if (lastList) {
        [tmanager.mRobot.mBackroundRooms removeAllObjects];
        [tmanager.mRobot.mBackroundRooms addObjectsFromArray: lastList];
        {//兼容处理
            for (NSMutableDictionary* dic in self.mBackroundRooms) {
                if (dic[@"isMain"]) {
                    [dic removeObjectForKey: @"isMain"];
                }
                if (!dic[@"type"]) {
                    dic[@"type"] = @"default";
                }
                if (!dic[@"robotRework"]) {
                    dic[@"robotRework"] = @"false";
                }
                if (!dic[@"isSendResult"]) {
                    dic[@"isSendResult"] = @"false";
                }
                if (!dic[@"isInviteCheck"]) {
                    dic[@"isInviteCheck"] = @"false";
                }
                if (!dic[@"isHideCard"]) {
                    dic[@"isHideCard"] = @"false";
                }
            }
        }
        return YES;
    }
    return NO;
}

//绑定、解绑后台群
-(void) bindBackgroundRoom: (NSString*)room title:(NSString*)title {
    for (NSDictionary* dic in self.mBackroundRooms) {
        if ([dic[@"room"] isEqualToString: room]) {
            return;
        }
    }
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"room"] = room;
    dic[@"title"] = title;
    dic[@"type"] = @"default";//default, shangfen, xiafen, fuli
    dic[@"isInviteCheck"] = @"false";
    dic[@"isHideCard"] = @"false";
    dic[@"robotRework"] = @"false";
    dic[@"isSendResult"] = @"false";
    [self.mBackroundRooms insertObject: dic atIndex:0];
    [self sortBackgrounds];
}

-(void) unbindBackgroundRoom: (NSString*)room {
    for (int i = 0; i < [self.mBackroundRooms count]; ++i) {
        NSDictionary* dic = self.mBackroundRooms[i];
        if ([dic[@"room"] isEqualToString: room]) {
            [self.mBackroundRooms removeObjectAtIndex: i];
            break;
        }
    }
}

-(BOOL) isBackroundRoom: (NSString*)room {
    for (NSDictionary* dic in self.mBackroundRooms) {
        if ([dic[@"room"] isEqualToString: room]) {
            return YES;
        }
    }
    return NO;
}

-(NSDictionary*) getBackroundRoom: (NSString*)room {
    for (NSDictionary* dic in self.mBackroundRooms) {
        if ([dic[@"room"] isEqualToString: room]) {
            return dic;
        }
    }
    return nil;
}

-(BOOL) setBackgroundType: (NSString*)room type:(NSString*)type only:(BOOL)only{
    BOOL finded = NO;
    for (NSMutableDictionary* dic in self.mBackroundRooms) {
        if ([dic[@"room"] isEqualToString: room]) {
            dic[@"type"] = type;
            finded = YES;
        }
    }
    if (finded && only) {
        for (NSMutableDictionary* dic in self.mBackroundRooms) {
            if (![dic[@"room"] isEqualToString: room] && [dic[@"type"] isEqualToString: type]) {
                dic[@"type"] = @"default";
            }
        }
    }
    [self sortBackgrounds];
    [tmanager.mRobot.mData saveBackgroundChatroom: tmanager.mRobot.mBackroundRooms];
    return finded;
}

-(BOOL) setBackgroundFunc:(NSString *)room func:(NSString *)func value:(BOOL)value only:(BOOL)only{
    BOOL finded = NO;
    for (NSMutableDictionary* dic in self.mBackroundRooms) {
        if ([dic[@"room"] isEqualToString: room]) {
            dic[func] = value ? @"true" : @"false";
            finded = YES;
        }
    }
    if (finded && value && only) {
        for (NSMutableDictionary* dic in self.mBackroundRooms) {
            if (![dic[@"room"] isEqualToString: room] && [dic[func] isEqualToString: @"true"]) {
                dic[func]  = @"false";
            }
        }
    }
    [self sortBackgrounds];
    [tmanager.mRobot.mData saveBackgroundChatroom: tmanager.mRobot.mBackroundRooms];
    return finded;
}

-(NSArray*) getBackgroundWithType:(NSString*)type {
    NSMutableArray* array = [NSMutableArray array];
    for (NSDictionary* dic in self.mBackroundRooms) {
        if ([dic[@"type"] isEqualToString: type]) {
            [array addObject:dic[@"room"]];
        }
    }
    return array;
}

-(NSArray*) getBackgroundWithFunc:(NSString*)func {
    NSMutableArray* array = [NSMutableArray array];
    for (NSDictionary* dic in self.mBackroundRooms) {
        if ([dic[func] isEqualToString: @"true"]) {
            [array addObject:dic[@"room"]];
        }
    }
    return array;
}

-(BOOL) getBackgroundIsType:(NSString*)room type:(NSString*)type {
    for (NSDictionary* dic in self.mBackroundRooms) {
        if ([dic[@"room"] isEqualToString: room]) {
            return [dic[@"type"] isEqualToString: type];
        }
    }
    return NO;
}

-(BOOL) getBackgroundHasFunc:(NSString*)room func:(NSString*)func {
    for (NSDictionary* dic in self.mBackroundRooms) {
        if ([dic[@"room"] isEqualToString: room]) {
            return dic[func] && [dic[func] isEqualToString: @"true"];
        }
    }
    return NO;
}

-(void) sortBackgrounds {
    [self.mBackroundRooms sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (![b[@"type"] isEqualToString: @"default"]) {
            return 1;
        }
        if ([b[@"isInviteCheck"] isEqualToString: @"true"]) {
            return 1;
        }
        if ([b[@"isHideCard"] isEqualToString: @"true"]) {
            return 1;
        }
        if ([b[@"robotRework"] isEqualToString: @"true"]) {
            return 1;
        }
        if ([b[@"isSendResult"] isEqualToString: @"true"]) {
            return 1;
        }
        return -1;
    }];
}

//修改上局
-(BOOL) frontRound {
    if ([self.mData.mRounds count] <= 0) {
        return NO;
    }
    NSDictionary* lastRound = [self.mData removeLastRound];
    if (!lastRound) {
        return NO;
    }
    self.mNumber = [self.mData lastRoundNumber]+1;
    [self.mBet loadWithRoundData: lastRound];
    [self.mResult loadWithRoundData: lastRound];
    [self changeStatus: eNiuniuRobotStatusResult];
    [lastRound release];
    return YES;
}

//存档
-(void) savedResult {
    self.mNumber = [self.mData lastRoundNumber]+1;
    [self changeStatus: eNiuniuRobotStatusNone];
}

//切换状态
-(void) changeStatus:(eNiuniuRobotStatus)status {
    self.mStatus = status;
}

//解析红包标志
-(BOOL) parseIsHongbao:(NSString*)content {
    return [content containsString: hongbaoMark];
}

//解析龙虎下注类型
-(NSString*) parseLonghuBetType: (NSScanner*)scan {
    NSMutableArray* betTypes = [NSMutableArray array];
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    
    if ([setting[@"daxiaoEnableDaDan"] isEqualToString: @"true"]) {
        [betTypes addObject: @"大单"];
    }
    if ([setting[@"daxiaoEnableDaShuang"] isEqualToString: @"true"]) {
        [betTypes addObject: @"大双"];
    }
    if ([setting[@"daxiaoEnableXiaoDan"] isEqualToString: @"true"]) {
        [betTypes addObject: @"小单"];
    }
    if ([setting[@"daxiaoEnableXiaoShuang"] isEqualToString: @"true"]) {
        [betTypes addObject: @"小双"];
    }
    if ([setting[@"daxiaoEnableDa"] isEqualToString: @"true"]) {
        [betTypes addObject: @"大"];
    }
    if ([setting[@"daxiaoEnableXiao"] isEqualToString: @"true"]) {
        [betTypes addObject: @"小"];
    }
    if ([setting[@"daxiaoEnableDan"] isEqualToString: @"true"]) {
        [betTypes addObject: @"单"];
    }
    if ([setting[@"daxiaoEnableShuang"] isEqualToString: @"true"]) {
        [betTypes addObject: @"双"];
    }
    if ([setting[@"daxiaoEnableHe"] isEqualToString: @"true"]) {
        [betTypes addObject: @"合"];
    }
    
    NSString* betType = nil;
    for (NSString* str in betTypes) {
        if ([scan scanString:str intoString: nil]) {
            betType = str;
            break;
        }
    }
    if (!betType) {
        return nil;
    }
    return betType;
}

//解析百家乐下注类型
-(NSString*) parseBaijialeBetType: (NSScanner*)scan {
    NSMutableArray* betTypes = [NSMutableArray array];
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    
    if ([setting[@"baijialeEnableZhuangPair"] isEqualToString: @"true"]) {
        [betTypes addObject: @"庄对"];
    }
    if ([setting[@"baijialeEnableXianPair"] isEqualToString: @"true"]) {
        [betTypes addObject: @"闲对"];
    }
    if ([setting[@"baijialeEnableZhuang"] isEqualToString: @"true"]) {
        [betTypes addObject: @"庄"];
    }
    if ([setting[@"baijialeEnableXian"] isEqualToString: @"true"]) {
        [betTypes addObject: @"闲"];
    }
    if ([setting[@"baijialeEnableTie"] isEqualToString: @"true"]) {
        [betTypes addObject: @"和"];
    }

    NSString* betType = nil;
    for (NSString* str in betTypes) {
        if ([scan scanString:str intoString: nil]) {
            betType = str;
            break;
        }
    }
    if (!betType) {
        return nil;
    }
    return betType;
}

//解析下注
-(BOOL) parseBet:(NSString*)userid content:(NSString*)content outBetCount:(int*)outBetCount outValues:(NSArray**)outValues {
    if (self.mEnableNiuniu) {
        if ([ycFunction isInt: content]) {
            *outBetCount = [content intValue];
            *outValues = @[
                           @{
                               @"type":@"niuniu",
                               @"suoha":@"false",
                               @"mianyong":@"false",
                               @"yibi":@"false",
                               @"num":content
                               }
                           ];
            return *outBetCount > 1;
        }
        if ([content isEqualToString: @"梭哈"]) {
            int score = [self.mMembers getMemberScore: userid];
            *outBetCount = score;
            *outValues = @[
                           @{
                               @"type":@"niuniu",
                               @"suoha":@"true",
                               @"mianyong":@"false",
                               @"yibi":@"false",
                               @"num":content
                               }
                           ];
            return *outBetCount > 1;
        }
        
        NSScanner* scan = [NSScanner scannerWithString: content];
        if ([scan scanString: @"梭哈" intoString: nil] && [scan scanInt: outBetCount]) {
            *outValues = @[
                           @{
                               @"type":@"niuniu",
                               @"suoha":@"true",
                               @"mianyong":@"false",
                               @"yibi":@"false",
                               @"num":deInt2String(*outBetCount)
                               }
                           ];
            return *outBetCount > 1;
        }
        
        scan = [NSScanner scannerWithString: content];
        if ([scan scanInt: outBetCount] && [scan scanString: @"梭哈" intoString: nil]) {
            *outValues = @[
                           @{
                               @"type":@"niuniu",
                               @"suoha":@"true",
                               @"mianyong":@"false",
                               @"yibi":@"false",
                               @"num":deInt2String(*outBetCount)
                               }
                           ];
            return *outBetCount > 1;
        }
        
        if ([tmanager.mRobot.mData.mBaseSetting[@"supportYibi"] isEqualToString: @"true"]) {
            scan = [NSScanner scannerWithString: content];
            if ([scan scanString: @"一比" intoString: nil] && [scan scanInt: outBetCount]) {
                *outValues = @[
                               @{
                                   @"type":@"niuniu",
                                   @"suoha":@"false",
                                   @"yibi":@"true",
                                   @"mianyong":@"false",
                                   @"num":deInt2String(*outBetCount)
                                   }
                               ];
                return *outBetCount > 1;
            }
            
            scan = [NSScanner scannerWithString: content];
            if ([scan scanInt: outBetCount] && [scan scanString: @"一比" intoString: nil]) {
                *outValues = @[
                               @{
                                   @"type":@"niuniu",
                                   @"suoha":@"false",
                                   @"yibi":@"true",
                                   @"mianyong":@"false",
                                   @"num":deInt2String(*outBetCount)
                                   }
                               ];
                return *outBetCount > 1;
            }
        }
        
        if ([tmanager.mRobot.mData.mBaseSetting[@"supportMianyong"] isEqualToString: @"true"]) {
            scan = [NSScanner scannerWithString: content];
            if ([scan scanString: @"免" intoString: nil] && [scan scanInt: outBetCount]) {
                *outValues = @[
                               @{
                                   @"type":@"niuniu",
                                   @"suoha":@"false",
                                   @"mianyong":@"true",
                                   @"yibi":@"false",
                                   @"num":deInt2String(*outBetCount)
                                   }
                               ];
                return *outBetCount > 1;
            }
            
            scan = [NSScanner scannerWithString: content];
            if ([scan scanInt: outBetCount] && [scan scanString: @"免" intoString: nil]) {
                *outValues = @[
                               @{
                                   @"type":@"niuniu",
                                   @"suoha":@"false",
                                   @"mianyong":@"true",
                                   @"yibi":@"false",
                                   @"num":deInt2String(*outBetCount)
                                   }
                               ];
                return *outBetCount > 1;
            }
        }
    }
    
    if(self.mEnableLonghu) {
        NSString* str = [content stringByReplacingOccurrencesOfString: @" " withString: @""];
        NSMutableArray* betValues = [NSMutableArray array];
        NSScanner* scan = [NSScanner scannerWithString: str];
        while (true) {
            NSString* betType = [self parseLonghuBetType: scan];
            if (!betType) {
                break;
            }
            int num;
            if (![scan scanInt:&num]) {
                break;
            }
            [betValues addObject: @{
                                    @"type":betType,
                                    @"num":deInt2String(num)
                                    }];
        }
        if ([betValues count] == 0) {
            scan = [NSScanner scannerWithString: str];
            while (true) {
                int num;
                if (![scan scanInt:&num]) {
                    break;
                }
                NSString* betType = [self parseLonghuBetType: scan];
                if (!betType) {
                    break;
                }
                [betValues addObject: @{
                                        @"type":betType,
                                        @"num":deInt2String(num)
                                        }];
            }
        }
        *outValues = betValues;
        *outBetCount = 0;
        for (NSDictionary* dic in betValues) {
            *outBetCount += [dic[@"num"] intValue];
        }
        if ([betValues count] > 0) {
            return YES;
        }
    }
    
    if (self.mEnableTema) {
        if ([content containsString: @"买"]) {
            NSString* str = content;
            int betCount = 0;
            NSMutableArray* betValues = [NSMutableArray array];
            NSMutableString* temas = [NSMutableString string];
            NSMutableString* num = [NSMutableString string];
            BOOL showBuy = NO;
            NSRange range;
            for(int i = 0; i < str.length; i += range.length){
                range = [str rangeOfComposedCharacterSequenceAtIndex:i];
                NSString* s = [str substringWithRange:range];
                if (showBuy) {
                    if ([s isEqualToString: @" "]) {
                        continue;
                    }
                    if ([s isEqualToString: @","] || [s isEqualToString: @"，"]) {
                        int numInt = [num intValue];
                        if (numInt > 0) {
                            [betValues addObject: @{
                                                     @"type" : @"tema",
                                                     @"bet" : deString(@"%@", temas),
                                                     @"num" : deString(@"%@", num),
                                                     }];
                            betCount += temas.length * numInt;
                        }
                        [temas setString: @""];
                        [num setString: @""];
                        showBuy = NO;
                        continue;
                    }
                    
                    unichar uc = [s characterAtIndex:0];
                    if (s.length == 1 && uc >= '0' && uc <= '9') {
                        [num appendString: s];
                    } else {
                        break;
                    }
                } else {
                    if ([s isEqualToString: @" "]) {
                        continue;
                    }
                    if ([s isEqualToString: @"买"]) {
                        if (temas.length == 0) {
                            break;
                        }
                        showBuy = YES;
                        continue;
                    }
                    unichar uc = [s characterAtIndex:0];
                    if (s.length == 1 && uc >= '0' && uc <= '9') {
                        if (![temas containsString: s]) {
                            [temas appendString: s];
                        }
                    } else {
                        break;
                    }
                }
            }
            if (temas.length > 0 && num.length > 0) {
                int numInt = [num intValue];
                if (numInt > 0) {
                    if (numInt > 0) {
                        [betValues addObject: @{
                                                 @"type" : @"tema",
                                                 @"bet" : deString(@"%@", temas),
                                                 @"num" : deString(@"%@", num),
                                                 }];
                        betCount += temas.length * numInt;
                    }
                }
            }
            if ([betValues count] > 0) {
                *outValues = betValues;
                *outBetCount = betCount;
                return YES;
            }
            
        }
    }
    
    if (self.mEnableBaijiale) {
        NSString* str = [content stringByReplacingOccurrencesOfString: @" " withString: @""];
        NSMutableArray* betValues = [NSMutableArray array];
        NSScanner* scan = [NSScanner scannerWithString: str];
        while (true) {
            NSString* betType = [self parseBaijialeBetType: scan];
            if (!betType) {
                break;
            }
            int num;
            if (![scan scanInt:&num]) {
                break;
            }
            [betValues addObject: @{
                                    @"type":@"baijiale",
                                    @"bet" : betType,
                                    @"num":deInt2String(num)
                                    }];
        }
        if ([betValues count] == 0) {
            scan = [NSScanner scannerWithString: str];
            while (true) {
                int num;
                if (![scan scanInt:&num]) {
                    break;
                }
                NSString* betType = [self parseBaijialeBetType: scan];
                if (!betType) {
                    break;
                }
                [betValues addObject: @{
                                        @"type":@"baijiale",
                                        @"bet" : betType,
                                        @"num":deInt2String(num)
                                        }];
            }
        }
        *outValues = betValues;
        *outBetCount = 0;
        for (NSDictionary* dic in betValues) {
            *outBetCount += [dic[@"num"] intValue];
        }
        if ([betValues count] > 0) {
            return YES;
        }
    }
    return NO;
}

//CMessageWrap(return 消息类型)
-(void) addMsg:(id)msg isNew: (BOOL)isNew{
    BOOL isMe = NO;
    NSString* fromUsr = [ycFunction getVar:msg name: @"m_nsFromUsr"];
    int m_uiMessageType = [ycFunction getVarInt: msg name: @"m_uiMessageType"];
    NSString* m_nsContent = [ycFunction getVar: msg name: @"m_nsContent"];
    NSString* m_nsRealChatUsr = [ycFunction getVar: msg name: @"m_nsRealChatUsr"];
    id CBaseContact = [wxFunction getContact: m_nsRealChatUsr];
    NSString* m_nsNickName = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
    long long m_n64MesSvrID = [ycFunction getVarLonglong: msg name: @"m_n64MesSvrID"];

    if (![fromUsr containsString: @"@chatroom"]) {
        id selfContact = [wxFunction getSelfContact];
        NSString* m_nsUsrName = [ycFunction getVar:selfContact name: @"m_nsUsrName"];
        if ([m_nsUsrName isEqualToString: fromUsr]) {//自己发的
            fromUsr = [ycFunction getVar:msg name: @"m_nsToUsr"];
            m_nsNickName = [ycFunction getVar:selfContact name: @"m_nsNickName"];
            m_nsRealChatUsr = m_nsUsrName;
            isMe = YES;
        }
    }
    
    //if (isNew) {
    //    NSLog(@"m_uiMessageType: %d, %@, %@", m_uiMessageType, fromUsr, m_nsContent);
    //}
    
    if (self.mGameRoom && [self.mGameRoom isEqualToString:fromUsr]) {//游戏群
        if (1 == m_uiMessageType) {//普通消息
            if (self.mStatus == eNiuniuRobotStatusBet) {                
                int bet;
                NSArray* betValues = nil;
                if ([self parseBet:m_nsRealChatUsr content:m_nsContent outBetCount:&bet outValues:&betValues]) {//解析下注
                    [self.mBet playerBet: m_nsNickName userid: m_nsRealChatUsr num: bet values: betValues content: deString(@"%lld", m_n64MesSvrID) from: isNew ? @"new" : @"old"];
                    return;
                }
            }
        }
        else if(47 == m_uiMessageType) {//图片
            
        }
        else if(49 == m_uiMessageType) {//xml
            if ([self parseIsHongbao: m_nsContent]) {//红包
                [self.mResult saveHongbaoMsg: msg];
                return;
            }
        }
        else if(10002 == m_uiMessageType) {//系统消息
            if(isNew && [m_nsContent containsString: @"群聊"]) {
                [self.mInviteCheck addInviteMsg: m_nsContent];
            }
        }
    }
    
    
    if ([self isBackroundRoom:fromUsr] && isNew) {//后台群
        [self.mCommand addMsg: msg isNew: isNew];
    }
    
}

//撤回
-(void) revokeMsg: (NSString*)msgid {
    if (self.mStatus == eNiuniuRobotStatusBet || self.mStatus == eNiuniuRobotStatusResult) {
        [self.mBet revokeBet: (NSString*)msgid];
    }
}

@end
