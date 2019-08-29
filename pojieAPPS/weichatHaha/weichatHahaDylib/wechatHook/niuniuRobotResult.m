//
//  niuniuRobotResult.m
//  wechatHook
//
//  Created by antion on 2017/2/20.
//
//

#import "niuniuRobotResult.h"
#import "niuniuRobotResultBill.h"
#import "toolManager.h"
#import "niuniuRobot.h"
#import "ycDefine.h"
#import "niuniu.h"
#import "longhu.h"
#import "tema.h"
#import "baijiale.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "niuniuRobotExcelHelper.h"

/*
 //上庄抽水
 */

@implementation niuniuRobotResult {
    NSMutableDictionary* mHongbaoData;
    NSTimer* mQueryHongbaoTimer;
    NSTimeInterval mRecvHongbaoTime;
    UIAlertView* mMask;
}

-(id) init {
    if (self = [super init]) {
        self.mNullHongbao = [@[] mutableCopy];
        self.mRobHongbao = [@[] mutableCopy];
        self.mTimeover = [@[] mutableCopy];
        self.mBanker = [@[] mutableCopy];
        self.mNormal = [@[] mutableCopy];
        self.mReport = [@{} mutableCopy];
        self.mCustomAsLast = [@{} mutableCopy];
        self.mLastAmounts = [@[] mutableCopy];
        self.mDelegate = nil;
        self.mOvertimeNoWin = NO;
        self.mRobNoWin = NO;
        self.mResetSeriesWin = NO;
        self.mResetBonusPool = -1;
        mHongbaoData = [@{} mutableCopy];
    }
    return self;
}


-(void) dealloc {
    [self.mNullHongbao release];
    [self.mRobHongbao release];
    [self.mTimeover release];
    [self.mBanker release];
    [self.mNormal release];
    [self.mReport release];
    [self.mCustomAsLast release];
    [self.mLastAmounts release];
    [mHongbaoData release];
    [super dealloc];
}

-(BOOL) setMount: (NSMutableDictionary*)dic mount:(int)mount {
    int pow = [niuniu amount2pow: mount];
    dic[@"pow"] = deInt2String(pow);
    if ([dic[@"betType"] isEqualToString: @"niuniu"] || dic[@"banker"]) {
        if (dic[@"suoha"] && [dic[@"suoha"] isEqualToString: @"true"]) {
            dic[@"powFact"] = deString(@"%.1f", [niuniu factPowForSuoha: pow]);
        } else if (dic[@"mianyong"] && [dic[@"mianyong"] isEqualToString: @"true"]) {
            dic[@"powFact"] = deString(@"%.1f", [niuniu factPowForMianyong: pow]);
        } else if (dic[@"yibi"] && [dic[@"yibi"] isEqualToString: @"true"]) {
            dic[@"powFact"] = deString(@"%.1f", [niuniu factPowForYibi: pow]);
        } else {
            dic[@"powFact"] = deString(@"%.1f", [niuniu factPow: pow]);
        }
        if (dic[@"banker"]) {
            dic[@"powFactBanker"] = deString(@"%.1f", [niuniu factPowBanker: pow]);
            dic[@"powFactBankerSuoha"] = deString(@"%.1f", [niuniu factPowForSuohaBanker: pow]);
            dic[@"powFactBankerMianyong"] = deString(@"%.1f", [niuniu factPowForMianyongBanker: pow]);
            dic[@"powFactBankerYibi"] = deString(@"%.1f", [niuniu factPowForYibiBanker: pow]);
        }
    } else if([dic[@"betType"] isEqualToString: @"longhu"]) {
        dic[@"powType"] = [longhu pow2card: pow];
    } else if([dic[@"betType"] isEqualToString: @"tema"]) {
        dic[@"powType"] = [tema pow2card: pow];
    } else if([dic[@"betType"] isEqualToString: @"baijiale"]) {
        dic[@"powType"] = @"";
    }
    dic[@"amount"] = [self amountStr: mount];
    return YES;
}

-(BOOL) setResultHandle: (NSMutableDictionary*)dic type:(NSString*)type {
    if ([type isEqualToString: @"overtime"] || [type isEqualToString: @"asLast"]  || [type isEqualToString: @"bankerHead"] || [type isEqualToString: @"noWin"] || [type isEqualToString: @"normal"]) {
        dic[@"resultHandle"] = type;
        return YES;
    }
    return NO;
}

-(NSString*) amountStr:(int)amout {
    if (amout < 1000) {
        return deString(@"%03d", amout);
    }
    return deInt2String(amout);
}

-(NSString*) addTitle: (NSString*)title {
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"　　♤%@♤\n", title];
    [text appendString: @"──────────\n"];
    return text;
}

-(NSString*) genReport {
    [self updateCustomAsLast];
    [self.mReport removeAllObjects];
    
    //检测是否每个玩家都处理完毕
    if (!self.mHasHongbaoData) {
        if (tmanager.mRobot.mEnableNiuniu) {
            if (!self.mBanker[0][@"resultHandle"]) {//庄未判定结果
                return @"庄未判定结果";
            }
        }
        for (NSDictionary* dic in self.mNullHongbao) {
            if (!dic[@"resultHandle"]) {//闲未判定结果
                return @"有闲未判定结果";
            }
        }
    }
    
    //设置
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    int bankerHeadPow = [setting[@"bankerHeadPow"] intValue];//庄平赔倍数
    int everyPlayerHongbaoFee = [setting[@"everyPlayerHongbaoFee"] intValue];
    int normalNiuniuRatioUnder = [setting[@"normalNiuniuRatioUnder"] intValue];
    int normalNiuniuRatioUnderForSuoha = [setting[@"normalNiuniuRatioUnderForSuoha"] intValue];
    int yibiNiuniuRatioUnder = [setting[@"yibiNiuniuRatioUnder"] intValue];
    BOOL everyPlayerHongbaoFeeWin = [setting[@"everyPlayerHongbaoFeeWin"] isEqualToString: @"true"];
    BOOL has001 = [setting[@"has001"] isEqualToString: @"true"];//是否有001跑路规则
    BOOL overtimeIsCompare = [setting[@"overtimeIsCompare"] isEqualToString: @"true"];//超时比点数， 大的才赔
    BOOL isHeshuiMode = [setting[@"isHeshuiMode"] isEqualToString: @"true"];//喝水模式
    BOOL robAddMustLost = [setting[@"robAddMustLost"] isEqualToString: @"true"];//抢包输才补分
    BOOL bankerHeadEndSeriesWin = [setting[@"bankerHeadEndSeriesWin"] isEqualToString: @"true"];//平赔连赢断连
    BOOL bankerHeadNotSeriesWin = [setting[@"bankerHeadNotSeriesWin"] isEqualToString: @"true"];//平赔连赢不加
    BOOL bankerOvertimeNotSeriesWin = [setting[@"bankerOvertimeNotSeriesWin"] isEqualToString: @"true"];//超时连赢不加
    BOOL playerAsLastNotSeriesWin = [setting[@"playerAsLastNotSeriesWin"] isEqualToString: @"true"];//认尾连赢不加
    BOOL playerAsLastEndSeriesWin = [setting[@"playerAsLastEndSeriesWin"] isEqualToString: @"true"];//认尾断连赢
    BOOL seriesWinDaxiaoAsFirst = [setting[@"seriesWinDaxiaoAsFirst"] isEqualToString: @"true"];//大小连赢认第一注
    BOOL seriesWinDaxiaoAsFirstBet = [setting[@"seriesWinDaxiaoAsFirstBet"] isEqualToString: @"true"];//大小押注认第一注
    BOOL seriesWinBaijialeAsFirst = [setting[@"seriesWinBaijialeAsFirst"] isEqualToString: @"true"];//百家乐连赢认第一注
    BOOL seriesWinBaijialeAsFirstBet = [setting[@"seriesWinBaijialeAsFirstBet"] isEqualToString: @"true"];//百家乐押注认第一注
    
    //福利庄
    BOOL fuliBanker = tmanager.mRobot.mBet.mFuliSetting[@"enable"] && [tmanager.mRobot.mBet.mFuliSetting[@"enable"] isEqualToString: @"true"];
    
    NSMutableDictionary* banker = self.mBanker[0];
    if (fuliBanker) {//福利庄
        self.mOvertimeNoWin = YES;
        self.mRobNoWin = YES;
        overtimeIsCompare = NO;
        [tmanager.mRobot.mResult setResultHandle: banker type: @"overtime"];
    }
    
    //庄检测
    if (tmanager.mRobot.mEnableNiuniu) {
        if ([banker[@"resultHandle"] isEqualToString: @"noWin"]) {//庄无输赢重推
            return @"庄被设置为无输赢";
        }
        if ([banker[@"resultHandle"] isEqualToString:@"asLast"]) {//庄认尾赋值
            [self asLast: banker];
        }
        if (overtimeIsCompare && [banker[@"resultHandle"] isEqualToString:@"overtime"] &&
            (!banker[@"amount"] || 0 == [banker[@"amount"] intValue])) {//庄无包认尾
            [self asLast: banker];
        }
    }
    
    //合并闲家
    NSMutableArray* niuniuPlayers = [NSMutableArray array];
    NSMutableArray* longhuPlayers = [NSMutableArray array];
    NSMutableArray* temaPlayers = [NSMutableArray array];
    NSMutableArray* baijialePlayers = [NSMutableArray array];
    NSMutableArray* allPlayers = [NSMutableArray array];
    for (NSMutableDictionary* dic in self.mNullHongbao) {
        dic[@"resultType"] = @"nullHongbao";
        [allPlayers addObject: [NSMutableDictionary dictionaryWithDictionary: dic]];
    }
    for (NSMutableDictionary* dic in self.mTimeover) {
        dic[@"resultType"] = @"timeover";
        [allPlayers addObject: [NSMutableDictionary dictionaryWithDictionary: dic]];
    }
    for (NSMutableDictionary* dic in self.mNormal) {
        dic[@"resultType"] = @"normal";
        [allPlayers addObject: [NSMutableDictionary dictionaryWithDictionary: dic]];
    }
    for (NSMutableDictionary* dic in allPlayers) {
        if ([dic[@"betType"] isEqualToString: @"niuniu"]) {
            [niuniuPlayers addObject: dic];
        } else if ([dic[@"betType"] isEqualToString: @"longhu"]) {
            [longhuPlayers addObject: dic];
        } else if ([dic[@"betType"] isEqualToString: @"tema"]) {
            [temaPlayers addObject: dic];
        } else if ([dic[@"betType"] isEqualToString: @"baijiale"]) {
            [baijialePlayers addObject: dic];
        }
    }
    
    //抢包的
    NSMutableArray* allRobs = [NSMutableArray array];
    for (NSMutableDictionary* dic in self.mRobHongbao) {
        [allRobs addObject: [NSMutableDictionary dictionaryWithDictionary: dic]];
    }
    
    //计算闲理应输赢(牛牛)
    for (NSMutableDictionary* dic in niuniuPlayers) {
        if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {//闲认尾赋值
            [self asLast: dic];
        }
        if (overtimeIsCompare) {
            if ([dic[@"resultHandle"] isEqualToString: @"overtime"] && (!dic[@"amount"] || 0 == [dic[@"amount"] intValue])) {//无包闲认尾
                [self asLast: dic];
            }
        }
        if(has001) {
            if ([banker[@"resultHandle"] isEqualToString:@"asLast"] || [banker[@"resultHandle"] isEqualToString:@"normal"]) {
                if ([banker[@"amount"] intValue] == 1) {//庄001跑路
                    dic[@"winOrLose"] = @"0";
                    continue;
                }
            }
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"]) {
                if ([dic[@"amount"] intValue] == 1) {//闲001跑路
                    dic[@"winOrLose"] = @"0";
                    continue;
                }
            }
        }
        if ([banker[@"resultHandle"] isEqualToString: @"overtime"]) {//庄超时
            if (([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"]) &&
                (!overtimeIsCompare || [niuniu compareAmount:[dic[@"amount"] intValue] b:[banker[@"amount"] intValue] bIsBanker: YES mianyong: [dic[@"mianyong"] isEqualToString: @"true"] yibi: [dic[@"yibi"] isEqualToString: @"true"]] > 0)) {//闲有点数
                dic[@"winOrLose"] = deInt2String((int)([dic[@"powFact"] floatValue]*[dic[@"num"] intValue]));
            } else {
                dic[@"winOrLose"] = @"0";
            }
        }
        else if ([banker[@"resultHandle"] isEqualToString: @"bankerHead"]) {//庄平赔
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"]) {//闲有点数
                if ([dic[@"suoha"] isEqualToString: @"true"]) {
                    dic[@"winOrLose"] = deInt2String([dic[@"num"] intValue]/10*bankerHeadPow);
                } else {
                    dic[@"winOrLose"] = deInt2String([dic[@"num"] intValue]*bankerHeadPow);
                }
            } else if([dic[@"resultHandle"] isEqualToString: @"overtime"]) {//闲超时
                if (self.mOvertimeNoWin) {//超时无输赢
                    dic[@"winOrLose"] = @"0";
                } else {
                    dic[@"winOrLose"] = deInt2String(-[dic[@"num"] intValue]*bankerHeadPow);
                }
            } else {//闲无输赢
                dic[@"winOrLose"] = @"0";
            }
        } else {//庄有点数
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"]) {//闲有点数
                int result = [niuniu compareAmount:[dic[@"amount"] intValue] b:[banker[@"amount"] intValue] bIsBanker: YES mianyong: [dic[@"mianyong"] isEqualToString: @"true"] yibi: [dic[@"yibi"] isEqualToString: @"true"]];
                if (result == 0) {
                    dic[@"winOrLose"] = @"0";
                } else if(result > 0) {
                    dic[@"winOrLose"] = deInt2String((int)([dic[@"powFact"] floatValue]*[dic[@"num"] intValue]));
                } else {
                    if ([dic[@"suoha"] isEqualToString: @"true"]) {
                        dic[@"winOrLose"] = deInt2String((int)(-[banker[@"powFactBankerSuoha"] floatValue]*[dic[@"num"] intValue]));
                    } else if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                        dic[@"winOrLose"] = deInt2String((int)(-[banker[@"powFactBankerMianyong"] floatValue]*[dic[@"num"] intValue]));
                    } else if ([dic[@"yibi"] isEqualToString: @"true"]) {
                        dic[@"winOrLose"] = deInt2String((int)(-[banker[@"powFactBankerYibi"] floatValue]*[dic[@"num"] intValue]));
                    } else {
                        dic[@"winOrLose"] = deInt2String((int)(-[banker[@"powFactBanker"] floatValue]*[dic[@"num"] intValue]));
                    }
                }
            } else if([dic[@"resultHandle"] isEqualToString: @"overtime"] &&
                (!overtimeIsCompare || [niuniu compareAmount:[dic[@"amount"] intValue] b:[banker[@"amount"] intValue] bIsBanker: YES mianyong: [dic[@"mianyong"] isEqualToString: @"true"] yibi: [dic[@"yibi"] isEqualToString: @"true"]] < 0)) {//闲超时
                if (self.mOvertimeNoWin) {//超时无输赢
                    dic[@"winOrLose"] = @"0";
                } else {
                    if ([dic[@"suoha"] isEqualToString: @"true"]) {
                        dic[@"winOrLose"] = deInt2String((int)(-[banker[@"powFactBankerSuoha"] floatValue]*[dic[@"num"] intValue]));
                    } else if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                        dic[@"winOrLose"] = deInt2String((int)(-[banker[@"powFactBankerMianyong"] floatValue]*[dic[@"num"] intValue]));
                    } else if ([dic[@"yibi"] isEqualToString: @"true"]) {
                        dic[@"winOrLose"] = deInt2String((int)(-[banker[@"powFactBankerYibi"] floatValue]*[dic[@"num"] intValue]));
                    } else {
                        dic[@"winOrLose"] = deInt2String((int)(-[banker[@"powFactBanker"] floatValue]*[dic[@"num"] intValue]));
                    }
                }
            } else {//闲无输赢
                dic[@"winOrLose"] = @"0";
            }
        }
    }
    
    //计算闲理应输赢(大小单双)
    for (NSMutableDictionary* dic in longhuPlayers) {
        if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {//闲认尾赋值
            [self asLast: dic];
        }
        if ([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"]) {//闲有点数
            BOOL first = YES;
            int winOrLose = 0;
            for (NSDictionary* v in dic[@"values"]) {
                winOrLose += [longhu computeWinOrLose:dic[@"powType"] num:[v[@"num"] intValue] betType:v[@"type"]];
                if (first) {
                    first = NO;
                    dic[@"winOrLose_daxiao_first"] = deInt2String(winOrLose);
                }
            }
            dic[@"winOrLose"] = deInt2String(winOrLose);
        } else if([dic[@"resultHandle"] isEqualToString: @"overtime"]) {//闲超时
            if (self.mOvertimeNoWin) {//超时无输赢
                dic[@"winOrLose"] = @"0";
            } else {
                dic[@"winOrLose"] = deInt2String(-[dic[@"num"] intValue]);
            }
        } else {//闲无输赢
            dic[@"winOrLose"] = @"0";
        }
        if ([dic[@"winOrLose"] intValue] < 0) {
            if (fuliBanker) {
                dic[@"winOrLose"] = @"0";
            }
        }
    }
    
    //计算闲理应输赢(特码)
    for (NSMutableDictionary* dic in temaPlayers) {
        if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {//闲认尾赋值
            [self asLast: dic];
        }
        if ([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"]) {//闲有点数
            int winOrLose = 0;
            for (NSDictionary* v in dic[@"values"]) {
                winOrLose += [tema computeWinOrLose:[dic[@"pow"] intValue] bet:v[@"bet"] num:v[@"num"]];
            }
            dic[@"winOrLose"] = deInt2String(winOrLose);
        } else if([dic[@"resultHandle"] isEqualToString: @"overtime"]) {//闲超时
            if (self.mOvertimeNoWin) {//超时无输赢
                dic[@"winOrLose"] = @"0";
            } else {
                dic[@"winOrLose"] = deInt2String(-[dic[@"num"] intValue]);
            }
        } else {//闲无输赢
            dic[@"winOrLose"] = @"0";
        }
        if ([dic[@"winOrLose"] intValue] < 0) {
            if (fuliBanker) {
                dic[@"winOrLose"] = @"0";
            }
        }
    }
    
    //计算闲理应输赢(百家乐)
    for (NSMutableDictionary* dic in baijialePlayers) {
        if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {//闲认尾赋值
            [self asLast: dic];
        }
        if ([banker[@"resultHandle"] isEqualToString: @"overtime"]) {//庄超时
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"]) {//闲有点数
                dic[@"winOrLose"] = deInt2String((int)([dic[@"num"] intValue]));
                dic[@"powType"] = @"庄超";
            } else {
                dic[@"winOrLose"] = @"0";
                dic[@"powType"] = @"同超";
            }
        } else {//庄有点数
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"]) {//闲有点数
                BOOL first = YES;
                int winOrLose = 0;
                for (NSDictionary* v in dic[@"values"]) {
                    winOrLose += [baijiale computeWinOrLose:[dic[@"amount"] intValue] banker: [banker[@"amount"] intValue] num:[v[@"num"] intValue] betType:v[@"bet"]];
                    if (first) {
                        first = NO;
                        dic[@"winOrLose_baijiale_first"] = deInt2String(winOrLose);
                    }
                }
                dic[@"powType"] = [baijiale getCardType:[dic[@"amount"] intValue] banker:[banker[@"amount"] intValue]];
                dic[@"winOrLose"] = deInt2String(winOrLose);
            } else if([dic[@"resultHandle"] isEqualToString: @"overtime"]) {//闲超时
                if (self.mOvertimeNoWin) {//超时无输赢
                    dic[@"winOrLose"] = @"0";
                } else {
                    dic[@"winOrLose"] = deInt2String(-[dic[@"num"] intValue]);
                }
                dic[@"powType"] = @"闲超";
            } else {//闲无输赢
                dic[@"winOrLose"] = @"0";
                dic[@"powType"] = @"无";
            }
        }
        if ([dic[@"winOrLose"] intValue] < 0) {
            if (fuliBanker) {
                dic[@"winOrLose"] = @"0";
            }
        }
    }
    
    //将闲排序, 点数大到小， 点数一样按照押注顺序排序(牛牛)
    [niuniuPlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (![a[@"resultHandle"] isEqualToString:@"asLast"] && ![a[@"resultHandle"] isEqualToString:@"normal"]) {
            return -1;
        }
        if (![b[@"resultHandle"] isEqualToString:@"asLast"] && ![b[@"resultHandle"] isEqualToString:@"normal"]) {
            return 1;
        }
        int result = [niuniu compareAmount:[a[@"amount"] intValue] b:[b[@"amount"] intValue] bIsBanker: NO mianyong: [a[@"mianyong"] isEqualToString: @"true"] yibi: [a[@"yibi"] isEqualToString: @"true"]];
        if (result == 0) {//先压为大
            return [a[@"betIndex"] intValue] < [b[@"betIndex"] intValue] ? 1 : -1;
        } else {
            return result > 0;
        }
        return 1;
    }];
    
    //将闲按输赢排序(龙虎)
    [longhuPlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"winOrLose"] intValue] > [b[@"winOrLose"] intValue] ? 1 : -1;
    }];
    
    //将闲按输赢排序(特码)
    [temaPlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"winOrLose"] intValue] > [b[@"winOrLose"] intValue] ? 1 : -1;
    }];
    
    //将闲按输赢排序(百家乐)
    [baijialePlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"winOrLose"] intValue] > [b[@"winOrLose"] intValue] ? 1 : -1;
    }];
    
    //抢包
    int robPay = 0;
    int robIndex = 0;
    if (tmanager.mRobot.mEnableNiuniu) {//牛牛有庄
        BOOL bankerNullHongbao = [banker[@"resultHandle"] isEqualToString: @"asLast"];
        for (int i = (int)[allRobs count]-1; i >= 0; --i) {
            NSMutableDictionary* dic = allRobs[i];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
            int downScore = 0;
            if ([dic[@"resultHandle"] isEqualToString: @"normal"]) {//抢有效包
                if (!self.mLastIsOvertime) {//尾巴不超时
                    if (robIndex == 0 && bankerNullHongbao) {//庄的包
                        dic[@"robTarget"] = @"banker";
                        downScore = [setting[@"robBanker"] intValue];
                        dic[@"coverRobName"] = deFillName(banker[@"billName"]);
                        dic[@"coverRobUserid"] = banker[@"userid"];
                        banker[@"coverRob"] = @"true";
                        if (!self.mRobNoWin) {
                            banker[@"coverRobUp"] = setting[@"robBankerAdd"];
                            robPay += [setting[@"robBanker"] intValue];
                        }
                    } else {//闲包
                        int index = robIndex - (bankerNullHongbao ? 1 : 0);
                        if (index < [self.mNullHongbao count]) {
                            NSMutableDictionary* coverPlayer = self.mNullHongbao[index];
                            for (NSMutableDictionary* v in allPlayers) {
                                if ([v[@"userid"] isEqualToString: coverPlayer[@"userid"]]) {
                                    coverPlayer = v;
                                    break;
                                }
                            }
                            dic[@"robTarget"] = @"player";
                            downScore = [setting[@"robPlayer"] intValue];
                            dic[@"coverRobName"] = deFillName(coverPlayer[@"billName"]);
                            dic[@"coverRobUserid"] = coverPlayer[@"userid"];
                            coverPlayer[@"coverRob"] = @"true";
                            if (!self.mRobNoWin) {
                                int addScore = [setting[@"robPlayerAdd"] intValue];
                                if (robAddMustLost && [coverPlayer[@"winOrLose"] intValue] >= 0) {
                                    addScore = 0;
                                }
                                coverPlayer[@"coverRobUp"] = deInt2String(addScore);
                                robPay += addScore;
                            }
                        } else {
                            dic[@"robTarget"] = @"valid";
                            downScore = [setting[@"robPlayer"] intValue];
                        }
                    }
                    robIndex++;
                } else {
                    dic[@"robTarget"] = @"valid";
                    downScore = [setting[@"robPlayer"] intValue];
                }
            } else {
                dic[@"robTarget"] = @"overtime";
            }
            if (downScore > 0 && !self.mRobNoWin && memData) {
                int score = MIN(downScore, [memData[@"score"] intValue]);
                dic[@"robDown"] = deInt2String(score);
                robPay -= score;
            }
        }
    } else {//无庄
        for (int i = (int)[allRobs count]-1; i >= 0; --i) {
            NSMutableDictionary* dic = allRobs[i];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
            int downScore = 0;
            if ([dic[@"resultHandle"] isEqualToString: @"normal"]) {//抢有效包
                if (!self.mLastIsOvertime) {//尾巴不超时
                    int index = robIndex;
                    if (index < [self.mNullHongbao count]) {
                        NSMutableDictionary* coverPlayer = self.mNullHongbao[index];
                        for (NSMutableDictionary* v in allPlayers) {
                            if ([v[@"userid"] isEqualToString: coverPlayer[@"userid"]]) {
                                coverPlayer = v;
                                break;
                            }
                        }
                        dic[@"robTarget"] = @"player";
                        downScore = [setting[@"robPlayer"] intValue];
                        dic[@"coverRobName"] = deFillName(coverPlayer[@"billName"]);
                        dic[@"coverRobUserid"] = coverPlayer[@"userid"];
                        coverPlayer[@"coverRob"] = @"true";
                        if (!self.mRobNoWin) {
                            int addScore = [setting[@"robPlayerAdd"] intValue];
                            if (robAddMustLost && [coverPlayer[@"winOrLose"] intValue] >= 0) {
                                addScore = 0;
                            }
                            coverPlayer[@"coverRobUp"] = deInt2String(addScore);
                            robPay += addScore;
                        }
                    } else {
                        dic[@"robTarget"] = @"valid";
                        downScore = [setting[@"robPlayer"] intValue];
                    }
                    robIndex++;
                } else {
                    dic[@"robTarget"] = @"valid";
                    downScore = [setting[@"robPlayer"] intValue];
                }
            } else {
                dic[@"robTarget"] = @"overtime";
            }
            if (downScore > 0 && !self.mRobNoWin && memData) {
                int score = MIN(downScore, [memData[@"score"] intValue]);
                dic[@"robDown"] = deInt2String(score);
                robPay -= score;
            }
        }
    }
    
    int origin_bankerMoney = [tmanager.mRobot.mBet getAllBankerFee];//庄钱(扣除上庄费)
    int bankerMoney = origin_bankerMoney;//剩余庄钱
    int totalBankerMoney = 0;//总庄钱(未扣除上庄费)
    int winCount = 0;//赢了几个
    int loseCount = 0;//输了几个
    int drawCount = 0;//平了几个
    int bankerOriginWinOrLose = 0;//庄理应输赢
    int bankerRatioTotal = 0;//庄总抽水
    int playerRatioTotal = 0;//闲总抽水
    int heshuiSubsidyCount = 0;//喝水补贴
    
    if (tmanager.mRobot.mEnableNiuniu) {
        //先扣除基本费用
        bankerMoney -= [setting[@"hongbaoFee"] intValue];
        bankerMoney -= [setting[@"bonusPoolFee"] intValue];
        
        //暗扣
        bankerMoney -= [setting[@"heiFee"] intValue];
        
        //分数不足检测, 自己有多少分， 最多只能输或赢多少分
        for (NSMutableDictionary* dic in niuniuPlayers) {
            int score = [dic[@"score"] intValue];
            if (score > 0 && score < abs([dic[@"winOrLose"] intValue])) {
                dic[@"winOrLose"] = deInt2String(score*([dic[@"winOrLose"] intValue] > 0 ? 1 : -1));
                dic[@"scoreLimit"] = @"true";
            }
        }
        
        //先计算输的玩家
        for (NSMutableDictionary* dic in niuniuPlayers) {
            if ([dic[@"winOrLose"] intValue] < 0) {
                bankerMoney += abs([dic[@"winOrLose"] intValue]);
                dic[@"winOrLoseFact"] = dic[@"winOrLose"];
            }
        }
        
        //再计算赢的玩家, 从大开始赔, 金额不足时喝水
        for (int i = (int)[niuniuPlayers count]-1; i >= 0; --i) {
            NSMutableDictionary* dic = niuniuPlayers[i];
            int winOrLose = [dic[@"winOrLose"] intValue];
            if (winOrLose >= 0) {
                if (bankerMoney <=  [dic[@"winOrLose"] intValue]) {
                    dic[@"winOrLoseFact"] = deInt2String(bankerMoney);
                    bankerMoney = 0;
                } else {
                    dic[@"winOrLoseFact"] = dic[@"winOrLose"];
                    bankerMoney -= [dic[@"winOrLose"] intValue];
                }
                int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
                if (winOrLoseFact < winOrLose) {
                    dic[@"heshui"] = @"true";
                    //喝水补贴
                    float heshuiSubsidyRatio = [niuniu pow2heshuiSubsidy: [dic[@"pow"] intValue]];
                    if (heshuiSubsidyRatio > 0) {
                        int heshuiSubsidy = heshuiSubsidyRatio*winOrLose;
                        if (heshuiSubsidy > winOrLoseFact) {
                            dic[@"heshuiSubsidy"] = @"true";
                            dic[@"winOrLoseFact"] = deInt2String(heshuiSubsidy);
                            
                            heshuiSubsidyCount += heshuiSubsidy-winOrLoseFact;
                        }
                    }
                }
            }
        }
        
        //闲家抽水
        float playerWinRatio = [setting[@"playerWinRatio"] floatValue];
        float playerWinRatioSuoha = [setting[@"playerWinRatioSuoha"] floatValue];
        for (NSMutableDictionary* dic in niuniuPlayers) {
            int winOrLose = [dic[@"winOrLoseFact"] intValue];
            if (winOrLose > 0) {
                if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                    dic[@"playerRatio"] = @"0";
                } else if([dic[@"yibi"] isEqualToString: @"true"]) {
                    float ratio =[setting[@"niuniuYibiWinRatio"] floatValue];
                    if (ratio > 0 && [dic[@"pow"] intValue] > yibiNiuniuRatioUnder) {
                        int winOrLoseFact = winOrLose-winOrLose*ratio;
                        dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact);
                        dic[@"playerRatio"] = deInt2String(winOrLose-winOrLoseFact);
                        playerRatioTotal += winOrLose-winOrLoseFact;
                    }
                } else {
                        if ([dic[@"suoha"] isEqualToString: @"true"]) {
                            if ([dic[@"pow"] intValue] > normalNiuniuRatioUnderForSuoha) {
                                if (playerWinRatioSuoha > 0) {
                                    int winOrLoseFact = winOrLose-winOrLose*playerWinRatioSuoha;
                                    dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact);
                                    dic[@"playerRatio"] = deInt2String(winOrLose-winOrLoseFact);
                                    playerRatioTotal += winOrLose-winOrLoseFact;
                                }
                            }
                        } else {
                            if ([dic[@"pow"] intValue] > normalNiuniuRatioUnder) {
                                if (playerWinRatio > 0) {
                                    int winOrLoseFact = winOrLose-winOrLose*playerWinRatio;
                                    dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact);
                                    dic[@"playerRatio"] = deInt2String(winOrLose-winOrLoseFact);
                                    playerRatioTotal += winOrLose-winOrLoseFact;
                                }
                            }
                        }
                }
            }
            if (everyPlayerHongbaoFee > 0) {
                int score = [dic[@"score"] intValue];
                int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
                if (score + winOrLoseFact > everyPlayerHongbaoFee && (!everyPlayerHongbaoFeeWin || winOrLoseFact > 0)) {
                    dic[@"everyPlayerHongbaoFee"] = deInt2String(everyPlayerHongbaoFee);
                    dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact-everyPlayerHongbaoFee);
                }
            }
        }
    }
    
    if (tmanager.mRobot.mEnableLonghu) {
        //结算庄钱
        for (NSMutableDictionary* dic in longhuPlayers) {
            bankerMoney -= [dic[@"winOrLose"] intValue];
        }
        
        //闲家抽水
        for (NSMutableDictionary* dic in longhuPlayers) {
            int winOrLose = [dic[@"winOrLose"] intValue];
            int winOrLoseFact = winOrLose;
            if (winOrLose > 0) {
                winOrLoseFact = winOrLose-winOrLose*[setting[@"longhuRatioValue"] floatValue];
            }
            dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact);
            if (winOrLose > 0 && winOrLose > winOrLoseFact) {
                dic[@"playerRatio"] = deInt2String(winOrLose-winOrLoseFact);
                playerRatioTotal += winOrLose-winOrLoseFact;
            }
            if (everyPlayerHongbaoFee > 0 && (!everyPlayerHongbaoFeeWin || winOrLoseFact > 0)) {
                int score = [dic[@"score"] intValue];
                if (score + winOrLoseFact > everyPlayerHongbaoFee) {
                    dic[@"everyPlayerHongbaoFee"] = deInt2String(everyPlayerHongbaoFee);
                    dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact-everyPlayerHongbaoFee);
                }
            }
        }
    }
    
    if (tmanager.mRobot.mEnableTema) {
        //结算庄钱
        for (NSMutableDictionary* dic in temaPlayers) {
            bankerMoney -= [dic[@"winOrLose"] intValue];
        }
        
        //闲家抽水
        for (NSMutableDictionary* dic in temaPlayers) {
            int winOrLose = [dic[@"winOrLose"] intValue];
            int winOrLoseFact = winOrLose;
            if (winOrLose > 0) {
                winOrLoseFact = winOrLose-winOrLose*[setting[@"temaRatioValue"] floatValue];
            }
            dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact);
            if (winOrLose > 0 && winOrLose > winOrLoseFact) {
                dic[@"playerRatio"] = deInt2String(winOrLose-winOrLoseFact);
                playerRatioTotal += winOrLose-winOrLoseFact;
            }
            if (everyPlayerHongbaoFee > 0  && (!everyPlayerHongbaoFeeWin || winOrLoseFact > 0)) {
                int score = [dic[@"score"] intValue];
                if (score + winOrLoseFact > everyPlayerHongbaoFee) {
                    dic[@"everyPlayerHongbaoFee"] = deInt2String(everyPlayerHongbaoFee);
                    dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact-everyPlayerHongbaoFee);
                }
            }
        }
    }
    
    if (tmanager.mRobot.mEnableBaijiale) {
        //结算庄钱
        for (NSMutableDictionary* dic in baijialePlayers) {
            bankerMoney -= [dic[@"winOrLose"] intValue];
        }
        
        //闲家抽水
        for (NSMutableDictionary* dic in baijialePlayers) {
            int winOrLose = [dic[@"winOrLose"] intValue];
            int winOrLoseFact = winOrLose;
            if (winOrLose > 0) {
                winOrLoseFact = winOrLose-winOrLose*[setting[@"baijialeRatioValue"] floatValue];
            }
            dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact);
            if (winOrLose > 0 && winOrLose > winOrLoseFact) {
                dic[@"playerRatio"] = deInt2String(winOrLose-winOrLoseFact);
                playerRatioTotal += winOrLose-winOrLoseFact;
            }
            if (everyPlayerHongbaoFee > 0  && (!everyPlayerHongbaoFeeWin || winOrLoseFact > 0)) {
                int score = [dic[@"score"] intValue];
                if (score + winOrLoseFact > everyPlayerHongbaoFee) {
                    dic[@"everyPlayerHongbaoFee"] = deInt2String(everyPlayerHongbaoFee);
                    dic[@"winOrLoseFact"] = deInt2String(winOrLoseFact-everyPlayerHongbaoFee);
                }
            }
        }
    }
    
    //不喝水不够赔
    if (bankerMoney <= 0 && !isHeshuiMode) {
        return @"庄费不够";
    }
    
    //输赢统计
    for (NSMutableDictionary* dic in allPlayers) {
        int winOrLose = [dic[@"winOrLose"] intValue];
        if (winOrLose > 0) {
            loseCount++;
        } else if (winOrLose < 0) {
            winCount++;
        } else {
            drawCount++;
        }
        bankerOriginWinOrLose -= winOrLose;
    }
    
    //庄家抽水
    if (bankerOriginWinOrLose > 0) {
        bankerRatioTotal = [setting[@"bankerWinRatio"] floatValue] * bankerOriginWinOrLose;
    }
    bankerMoney -= bankerRatioTotal;
    
    //所有庄
    NSMutableArray* allBankers = [NSMutableArray array];
    if (banker) {
        [allBankers addObject: banker];
    }
    for (NSDictionary* dic in tmanager.mRobot.mBet.mBankers) {
        if (!banker || ![banker[@"userid"] isEqualToString: dic[@"userid"]]) {
            [allBankers addObject: [NSMutableDictionary dictionaryWithDictionary: dic]];
        }
        totalBankerMoney += [dic[@"num"] intValue];
    }
    
    //所有庄输赢
    for (NSMutableDictionary* dic in allBankers) {
        float ratio = [dic[@"num"] floatValue]/totalBankerMoney;
        dic[@"ratio"] = deString(@"%f", ratio);
        dic[@"winOrLoseFact"] = deInt2String((int)(bankerMoney*ratio-[dic[@"num"] intValue]));
    }
    
    //连赢
    BOOL seriesWinAllowTypeNiuniu = [setting[@"seriesWinAllowTypeNiuniu"] isEqualToString: @"true"];
    BOOL seriesWinAllowTypeNiuniuMianyong = [setting[@"seriesWinAllowTypeNiuniuMianyong"] isEqualToString: @"true"];
    BOOL seriesWinAllowTypeNiuniuYibi = [setting[@"seriesWinAllowTypeNiuniuYibi"] isEqualToString: @"true"];
    BOOL seriesWinAllowTypeDaxiao = [setting[@"seriesWinAllowTypeDaxiao"] isEqualToString: @"true"];
    BOOL seriesWinAllowTypeTema = [setting[@"seriesWinAllowTypeTema"] isEqualToString: @"true"];
    BOOL seriesWinAllowTypeBaijiale = [setting[@"seriesWinAllowTypeBaijiale"] isEqualToString: @"true"];
    int seriesWinResetNum = [setting[@"seriesWinResetNum"] intValue];
    NSMutableDictionary* currentSeriesWin = [NSMutableDictionary dictionary];
    NSMutableDictionary* lastSeriesWin = [NSMutableDictionary dictionary];
    if ([tmanager.mRobot.mData.mRounds count] > 0) {
        NSDictionary* lastRound = [tmanager.mRobot.mData.mRounds lastObject];
        for (NSDictionary* player in lastRound[@"players"]) {
            if (player[@"seriesWin"]) {
                lastSeriesWin[player[@"userid"]] = player[@"seriesWin"];
            }
        }
    }
    for (NSMutableDictionary* dic in allPlayers) {
        BOOL isEndSeries = NO;
        if ([dic[@"betType"] isEqualToString: @"niuniu"]) {
            if (dic[@"mianyong"] && [dic[@"mianyong"] isEqualToString: @"true"]) {
                isEndSeries = !seriesWinAllowTypeNiuniuMianyong;
            } else if (dic[@"yibi"] && [dic[@"yibi"] isEqualToString: @"true"]) {
                isEndSeries = !seriesWinAllowTypeNiuniuYibi;
            } else {
                isEndSeries = !seriesWinAllowTypeNiuniu;
            }
        }
        
        if(([dic[@"betType"] isEqualToString: @"longhu"] && !seriesWinAllowTypeDaxiao) ||
           ([dic[@"betType"] isEqualToString: @"tema"] && !seriesWinAllowTypeTema) ||
           ([dic[@"betType"] isEqualToString: @"baijiale"] && !seriesWinAllowTypeBaijiale) ||
           (playerAsLastEndSeriesWin && [dic[@"resultHandle"] isEqualToString: @"asLast"]) ||
           (bankerHeadEndSeriesWin && [banker[@"resultHandle"] isEqualToString: @"bankerHead"] && [dic[@"betType"] isEqualToString: @"niuniu"])) {
            isEndSeries = YES;
        }
        
        if (isEndSeries) {
            dic[@"seriesWin"] = @"0";
            currentSeriesWin[dic[@"userid"]] = dic[@"seriesWin"];
            continue;
        }
        
        int seriesWin = 0;
        if (!self.mResetSeriesWin && lastSeriesWin[dic[@"userid"]]) {
            seriesWin = [lastSeriesWin[dic[@"userid"]] intValue];
            if (seriesWinResetNum > 0 && seriesWin == seriesWinResetNum) {//超过几把重置
                seriesWin = 0;
            }
        }
        if (!fuliBanker) {
            int winOrLose = [dic[@"winOrLose"] intValue];
            if (seriesWinDaxiaoAsFirst && dic[@"winOrLose_daxiao_first"] && [dic[@"betType"] isEqualToString: @"longhu"]) {
                winOrLose = [dic[@"winOrLose_daxiao_first"] intValue];
            }
            else if (seriesWinBaijialeAsFirst && dic[@"winOrLose_baijiale_first"] && [dic[@"betType"] isEqualToString: @"baijiale"]) {
                winOrLose = [dic[@"winOrLose_baijiale_first"] intValue];
            }
            if (winOrLose > 0) {
                if ( (bankerHeadNotSeriesWin &&
                      [banker[@"resultHandle"] isEqualToString: @"bankerHead"] &&
                      [dic[@"betType"] isEqualToString: @"niuniu"]) ||
                    (bankerOvertimeNotSeriesWin &&
                     [banker[@"resultHandle"] isEqualToString: @"overtime"] &&
                     [dic[@"betType"] isEqualToString: @"niuniu"]) ||
                    (playerAsLastNotSeriesWin &&
                     [dic[@"resultHandle"] isEqualToString: @"asLast"])) {
                        dic[@"seriesContinue"] = @"true";
                } else {
                    if (seriesWin >= 0) {
                        seriesWin++;
                    } else {
                        seriesWin = 1;
                    }
                }
            } else if (winOrLose < 0) {
                if (seriesWin >= 0) {
                    seriesWin = -1;
                } else {
                    seriesWin--;
                }
            } else {
                seriesWin = 0;
            }
        } else {
            dic[@"seriesContinue"] = @"true";
        }
        dic[@"seriesWin"] = deInt2String(seriesWin);
        currentSeriesWin[dic[@"userid"]] = dic[@"seriesWin"];
    }
    
    //连赢自动兑奖
    int seriesMaxRound = 0;
    NSMutableDictionary* autoSeriesWinBonus = [NSMutableDictionary dictionary];
    if ([setting[@"seriesWinAutoBonusEnable"] isEqualToString: @"true"]) {
        int minBonusRound = 0;
        for (int i = 1; i <= 20; ++i) {
            NSString* key = deString(@"seriesWinAutoBonus%d", i);
            if ([setting[key] intValue] > 0) {
                minBonusRound = i;
                break;
            }
        }
        for (NSString* userid in lastSeriesWin) {
            int lastWinNum = [lastSeriesWin[userid] intValue];
            if (lastWinNum >= minBonusRound) {//满足奖励条件
                int currentWinNum = 0;
                if (currentSeriesWin[userid]) {
                    currentWinNum = [currentSeriesWin[userid] intValue];
                }
                if (currentWinNum <= 1) {//断了连赢
                    if (lastWinNum > seriesMaxRound) {
                        seriesMaxRound = lastWinNum;
                    }
                    int bonus = 0;//奖励分数
                    if (lastWinNum > 20) {
                        int roundBonus20 = [setting[@"seriesWinAutoBonus20"] intValue];
                        int bonusExt = [setting[@"seriesWinAutoBonus20up"] intValue];
                        bonus = roundBonus20 + (lastWinNum-20)*bonusExt;
                    } else {
                        bonus = [setting[deString(@"seriesWinAutoBonus%d", lastWinNum)] intValue];
                    }
                    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
                    dic[@"userid"] = userid;
                    dic[@"winRound"] = deInt2String(lastWinNum);
                    dic[@"bonus"] = deInt2String(bonus);
                    dic[@"bonusFact"] = deInt2String(bonus);
                    dic[@"nums"] = [NSMutableArray array];
                    dic[@"bets"] = [NSMutableArray array];
                    dic[@"ratio"] = @"1";
                    dic[@"minBet"] = @"0";
                    autoSeriesWinBonus[userid] = dic;
                }
            }
        }
    }
    if ([autoSeriesWinBonus count] > 0) {
        for (NSString* userid in autoSeriesWinBonus) {
            NSMutableDictionary* playerSeriesBonus = autoSeriesWinBonus[userid];
            for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >= 0; --i) {
                NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
                NSDictionary* player = nil;
                for (NSDictionary* v in dic[@"players"]) {
                    if ([v[@"userid"] isEqualToString: userid]) {
                        player = v;
                        break;
                    }
                }
                if (!player) {
                    break;
                }
                if (player[@"seriesContinue"] && [player[@"seriesContinue"] isEqualToString: @"true"]) {
                    continue;
                }
                int bet = 0;
                if ([player[@"betType"] isEqualToString: @"longhu"]) {
                    if (seriesWinDaxiaoAsFirstBet) {
                        bet = [player[@"values"][0][@"num"] intValue]/10;
                    } else {
                        bet = [player[@"num"] intValue]/10;
                    }
                } else if ([player[@"betType"] isEqualToString: @"baijiale"]) {
                    if (seriesWinBaijialeAsFirstBet) {
                        bet = [player[@"values"][0][@"num"] intValue]/10;
                    } else {
                        bet = [player[@"num"] intValue]/10;
                    }
                } else if (![player[@"betType"] isEqualToString: @"niuniu"] || [player[@"suoha"] isEqualToString: @"true"]) {//龙虎、牛牛梭哈
                    bet = [player[@"num"] intValue]/10;
                } else {//牛牛非梭哈
                    bet = [player[@"num"] intValue];
                }
                if (bet < [playerSeriesBonus[@"minBet"] intValue] || [playerSeriesBonus[@"minBet"] intValue] == 0) {
                    playerSeriesBonus[@"minBet"] = deInt2String(bet);
                }
                [playerSeriesBonus[@"nums"] addObject: deInt2String(bet)];
                [playerSeriesBonus[@"bets"] addObject: player[@"valuesStr"]];

                if ([playerSeriesBonus[@"bets"] count] >= [playerSeriesBonus[@"winRound"] intValue]) {
                    break;
                }
            }
        }
        
        for (NSString* userid in autoSeriesWinBonus) {
            NSMutableDictionary* dic = autoSeriesWinBonus[userid];
            int minbet = [dic[@"minBet"] intValue];
            float radio = 0;
            for (int i = 1; i <= 5; ++i) {
                NSString* key = deString(@"seriesWinAutoBonusRatio%d", i);
                if ([setting[key] isEqualToString: @""]) {
                    break;
                }
                NSArray* array = [setting[key] componentsSeparatedByString: @"-"];
                if (minbet >= [array[0] intValue] && minbet <= [array[1] intValue]) {
                    radio = [array[2] floatValue];
                    break;
                }
            }
            dic[@"ratio"] = deString(@"%f", radio);
            dic[@"bonusFact"] = deInt2String((int)([dic[@"bonus"] intValue]*radio));
        }
    }
    
    //奖池
    int bonusPoolTotal = 0;
    if (self.mResetBonusPool >= 0) {
        bonusPoolTotal = self.mResetBonusPool;
    } else {
        if ([tmanager.mRobot.mData.mRounds count] > 0) {
            NSDictionary* lastRound = [tmanager.mRobot.mData.mRounds lastObject];
            if (lastRound[@"otherInfo"][@"bonusPoolTotal"]) {
                bonusPoolTotal = [lastRound[@"otherInfo"][@"bonusPoolTotal"] intValue];
            }
        }
    }
    bonusPoolTotal += [setting[@"bonusPoolFee"] intValue];
    
//    //奖池奖励 tmp..
    int bankerBonus = 0;
//    if (bonusPoolTotal > 0) {
//        if ([banker[@"resultHandle"] isEqualToString: @"normal"]) {
//            int pow = [banker[@"pow"] intValue];
//            if (15 == pow || 18 == pow) {//炸弹或蛮牛
//                int amount = [banker[@"amount"] intValue]/100;
//                float bonusValue = 0;
//                if (amount >= 10) {
//                    bonusValue = [setting[@"tmpBonusPool10"] floatValue];
//                } else {
//                    bonusValue = [setting[deString(@"tmpBonusPool%d", amount)] floatValue];
//                }
//                float bonusRatio = 0;
//                if (totalBankerMoney < 2000) {
//                    bonusRatio = [setting[@"tmpBonusPool2000"] floatValue];
//                }
//                else if(totalBankerMoney >= 2000 && totalBankerMoney < 3000) {
//                    bonusRatio = [setting[@"tmpBonusPool2000-2900"] floatValue];
//                }
//                else if(totalBankerMoney >= 3000 && totalBankerMoney < 4000) {
//                    bonusRatio = [setting[@"tmpBonusPool3000-3900"] floatValue];
//                }
//                else if(totalBankerMoney >= 4000 && totalBankerMoney < 5000) {
//                    bonusRatio = [setting[@"tmpBonusPool4000-4900"] floatValue];
//                }
//                else if(totalBankerMoney >= 5000 && totalBankerMoney < 6000) {
//                    bonusRatio = [setting[@"tmpBonusPool5000-5900"] floatValue];
//                }
//                else if(totalBankerMoney >= 6000 && totalBankerMoney < 7000) {
//                    bonusRatio = [setting[@"tmpBonusPool6000-6900"] floatValue];
//                }
//                else if(totalBankerMoney >= 7000) {
//                    bonusRatio = [setting[@"tmpBonusPool7000"] floatValue];
//                }
//                bankerBonus = bonusPoolTotal*bonusValue*bonusRatio;
//                if (bankerBonus > 0) {
//                    bonusPoolTotal -= bankerBonus;
//                }
//            }
//        }
//    }
    
    //保存其他信息
    NSMutableDictionary* otherInfo = [NSMutableDictionary dictionary];
    otherInfo[@"origin_bankerMoney"] = deInt2String(origin_bankerMoney);//原本庄钱(扣除上庄费)
    otherInfo[@"bankerMoney"] = deInt2String(bankerMoney);//剩余庄钱
    otherInfo[@"winCount"] = deInt2String(winCount);//赢了几个
    otherInfo[@"loseCount"] = deInt2String(loseCount);//输了几个
    otherInfo[@"drawCount"] = deInt2String(drawCount);//打平几个
    otherInfo[@"bankerOriginWinOrLose"] = deInt2String(bankerOriginWinOrLose);//理应输赢
    otherInfo[@"bankerRatioTotal"] = deInt2String(bankerRatioTotal);//庄抽水
    otherInfo[@"playerRatioTotal"] = deInt2String(playerRatioTotal);//闲抽水
    otherInfo[@"upBankerFee"] = deInt2String(totalBankerMoney-origin_bankerMoney);//上庄抽水
    otherInfo[@"hongbaoFee"] = setting[@"hongbaoFee"];//红包费
    otherInfo[@"bonusPoolFee"] = setting[@"bonusPoolFee"];//奖池费
    otherInfo[@"heiFee"] = setting[@"heiFee"];//暗扣
    otherInfo[@"heshuiSubsidyCount"] = deInt2String(heshuiSubsidyCount);//喝水补贴
    otherInfo[@"robPay"] = deInt2String(robPay);//抢包支出
    otherInfo[@"bonusPoolTotal"] = deInt2String(bonusPoolTotal);//奖池统计
    otherInfo[@"bankerBonus"] = deInt2String(bankerBonus);//庄奖池奖励
    
    self.mReport[@"number"] = deInt2String(tmanager.mRobot.mNumber);
    self.mReport[@"mainBanker"] = banker;
    self.mReport[@"bankers"] = allBankers;
    self.mReport[@"players"] = allPlayers;
    self.mReport[@"niuniuPlayers"] = niuniuPlayers;
    self.mReport[@"longhuPlayers"] = longhuPlayers;
    self.mReport[@"temaPlayers"] = temaPlayers;
    self.mReport[@"baijialePlayers"] = baijialePlayers;
    self.mReport[@"robs"] = allRobs;
    self.mReport[@"autoSeriesWinBonus"] = autoSeriesWinBonus;
    self.mReport[@"otherInfo"] = otherInfo;

    NSString* text = [niuniuRobotResultBill genNiuniuAndLonghuStringBill];
    NSLog(@"结算单: %@", text);
    self.mReport[@"text"] = text;
    
    [[[[UIAlertView alloc] initWithTitle: nil message: text delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"存档", nil] autorelease] show];
    
    return nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
        UIView* view = nil;
        if ([setting[@"showPicBill"] isEqualToString: @"true"]) {
            view = [niuniuRobotResultBill genNiuniuAndLonghuPicBill];
        }
        
        //存档
        NSString* errMsg = [tmanager.mRobot.mData saveCurrentRound];
        
        int round = tmanager.mRobot.mNumber;
        
        if (self.mDelegate && !errMsg) {
            [self.mDelegate resultSaved];
        }
        
        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.mReport[@"text"];
        
        UIImage* billImg = nil;
        if ([setting[@"showPicBill"] isEqualToString: @"true"]) {
            if([setting[@"picHasTop"] isEqualToString: @"true"]) {
                billImg = [tmanager.mRobot.mMembers showPicTop: view];
            } else {
                billImg = [ycFunction savePicWithView: view compressValue: [tmanager.mRobot.mData.mBaseSetting[@"picCompressValue"] floatValue]];
            }
        } else {
            if(tmanager.mRobot.mGameRoom) {
                [tmanager.mRobot.mSendMsg sendText:tmanager.mRobot.mGameRoom content:self.mReport[@"text"] at:nil title:deString(@"第%d期结算", round)];
            }
        }
        
        if (errMsg) {
            [ycFunction showMsg: nil msg: errMsg vc: nil];
        } else {
            self.mOvertimeNoWin = NO;
            self.mRobNoWin = NO;
            self.mResetSeriesWin = NO;
            tmanager.mRobot.mBet.mFuliSetting[@"enable"] = @"false";
            self.mResetBonusPool = -1;
            
            //出结算
            if (billImg && [setting[@"savedAutoSendPic"] isEqualToString: @"true"]) {
                [tmanager.mRobot.mSendMsg sendPic:tmanager.mRobot.mGameRoom img:billImg];
            }
            
            //出积分
            if ([setting[@"savedAutoSendTop"] isEqualToString: @"true"]) {
                NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
                [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm"];
                NSString* timeStr = [objDateformat stringFromDate: [NSDate date]];
                NSString* title = deString(@"[%@]积分榜", timeStr);
                int type = [setting[@"autoSendTopType"] intValue];
                if (1 == type) {
                    NSString* text = [tmanager.mRobot.mMembers getTopStr: NO onlyPlayer: NO onlyTuo:NO];
                    [tmanager.mRobot.mSendMsg addTask:tmanager.mRobot.mGameRoom type: @"text" title: title content:text data:nil image:nil at:nil];
                } else if (2 == type) {
                    NSString* text = [tmanager.mRobot.mMembers getTopStr: NO onlyPlayer: NO onlyTuo:NO];
                    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
                    title = deString(@"%@.txt", title);
                    [tmanager.mRobot.mSendMsg addTask:tmanager.mRobot.mGameRoom type: @"txt" title: title content:nil data:data image:nil at:nil];
                } else if (3 == type) {
                    NSData* data = [niuniuRobotExcelHelper makeScoreTop];
                    title = deString(@"%@.xls", title);
                    [tmanager.mRobot.mSendMsg addTask:tmanager.mRobot.mGameRoom type: @"xls" title: title content:nil data:data image:nil at:nil];
                } else if (4 == type) {
                    UIImage* iamge = [tmanager.mRobot.mMembers showPicTop: nil];
                    [tmanager.mRobot.mSendMsg addTask:tmanager.mRobot.mGameRoom type: @"pic" title: nil content:nil data:nil image:iamge at:nil];
                }
            }
            
            //观战播报
            [tmanager.mRobot.mInviteCheck roundReport];
            
            //输赢播报
            {
                NSArray* rooms = [tmanager.mRobot getBackgroundWithFunc: @"isSendResult"];
                if ([rooms count] <= 0) {
                    return;
                }
                
                if(![wxFunction checkIsInChatroom: rooms[0]]) {
                    [ycFunction showMsg: @"输赢播报失败" msg: @"当前微信号没拉进输赢播报群里。" vc: nil];
                    return;
                }
                NSString* text = [tmanager.mRobot.mCommand lookRound: tmanager.mRobot.mNumber-1];
                NSString* title = deString(@"%d局输赢统计", tmanager.mRobot.mNumber-1);
                [tmanager.mRobot.mSendMsg addTask:rooms[0] type: @"text" title: title content:text data:nil image:nil at:nil];
            }
        }
    }
}

-(void) setHongbaoData:(NSDictionary*)hongbao {
    [self setIsAutoQueryHongbao: NO];
    [self.mNullHongbao removeAllObjects];
    [self.mRobHongbao removeAllObjects];
    [self.mTimeover removeAllObjects];
    [self.mBanker removeAllObjects];
    [self.mNormal removeAllObjects];
    [self.mReport removeAllObjects];
    [self.mLastAmounts removeAllObjects];
    self.mMinSecond = -1;
    self.mMaxSecond = -1;
    self.mTotalAmount = 0;
    self.mHasHongbaoData = NO;
    
    //默认状态
    for (NSDictionary* dic in tmanager.mRobot.mBet.mPlayerBetsValid) {
        [self.mNullHongbao addObject: [NSMutableDictionary dictionaryWithDictionary: dic]];
    }
    
    if (tmanager.mRobot.mEnableNiuniu) {
        [self.mBanker addObject: [NSMutableDictionary dictionaryWithDictionary: [tmanager.mRobot.mBet getMainBanker]]];
    }
    
    if (!hongbao) {
        return;
    }
    
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    BOOL headQuickAs2 = [setting[@"headQuickAs2"] isEqualToString: @"true"];//头包快2秒认第二包
    
    self.mHasHongbaoData = YES;
    
    //记录头包在第几个索引
    int i = 0;
    int minIndex = 0;
    
    //头尾包时间
    for (NSDictionary* one in hongbao[@"record"]) {
        long long second = [one[@"receiveTime"] longLongValue];
        if (self.mMinSecond > second || self.mMinSecond == -1) {
            self.mMinSecond = second;
            minIndex = i;
        }
        if (self.mMaxSecond < second || self.mMaxSecond == -1) {
            self.mMaxSecond = second;
        }
        i++;
        
        //尾巴点数
        [self.mLastAmounts addObject: deInt2String([one[@"receiveAmount"] intValue])];
    }
    
    //头包
    self.mCustomAsLast[@"headAmount"] = [self.mLastAmounts lastObject];
    
    //第二包
    i = 0;
    long long secondTime = self.mMaxSecond;
    for (NSDictionary* one in hongbao[@"record"]) {
        long long second = [one[@"receiveTime"] longLongValue];
        if (secondTime > second && minIndex != i) {
            secondTime = second;
        }
        i++;
    }
    
    //头包比第二包快两秒
    if (headQuickAs2 && secondTime - self.mMinSecond >= 2) {
        self.mMinSecond = secondTime;
    }
    
    //尾包用时
    self.mLastIsOvertime = self.mMaxSecond - self.mMinSecond >= [setting[@"overtime"] intValue];
    
    //红包金额
    self.mTotalAmount = [hongbao[@"totalAmount"] intValue];

    //分组
    for (int i = 0; i < [hongbao[@"record"] count]; ++i) {
        NSDictionary* record = hongbao[@"record"][i];
        long long second = [record[@"receiveTime"] longLongValue];
        BOOL overtime = second - self.mMinSecond >= [setting[@"overtime"] intValue];
        NSMutableDictionary* findDic = nil;
       
        for (int j = 0; j < [self.mNullHongbao count]; ++j) {
            NSMutableDictionary* dic = self.mNullHongbao[j];
            if ([dic[@"userid"] isEqualToString: record[@"userName"]]) {
                [self.mNullHongbao removeObjectAtIndex:j];
                findDic = dic;
                break;
            }
        }
        if (!findDic) {
            for (int j = 0; j < [self.mBanker count]; ++j) {//龙虎没有
                NSMutableDictionary* dic = self.mBanker[j];
                if ([dic[@"userid"] isEqualToString: record[@"userName"]]) {
                    findDic = dic;
                    if (i == [hongbao[@"record"] count]-1) {//庄头包(有可能错)
                        findDic[@"resultHandle"] = @"bankerHead";
                    }
                    break;
                }
            }
        }
        if (!findDic) {
            findDic = [NSMutableDictionary dictionary];
            findDic[@"rob"] = @"true";
            findDic[@"headImg"] = record[@"receiveHeadImg"];
            findDic[@"userid"] = record[@"userName"];
            findDic[@"score"] = @"0";
            
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: record[@"userName"]];
            if (memData) {
                findDic[@"name"] = memData[@"name"];
                findDic[@"billName"] = memData[@"billName"];
                findDic[@"remarkName"] = [niuniuRobotMembers newRemark: memData];
                findDic[@"score"] = memData[@"score"];
            } else {
                id CBaseContact = [wxFunction getContact: record[@"userName"]];
                if (CBaseContact) {
                    findDic[@"name"] = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
                }
            }
        }
        findDic[@"receiveTime"] = record[@"receiveTime"];
        [self setMount: findDic mount: [record[@"receiveAmount"] intValue]];
        if (!findDic[@"resultHandle"] && ![findDic[@"resultHandle"] isEqualToString: @"bankerHead"]) {//不是头包
            findDic[@"resultHandle"] = overtime ? @"overtime" : @"normal";
        }
        if (!findDic[@"banker"]) {//闲家的包
            if (findDic[@"rob"]) {
                [self.mRobHongbao addObject: findDic];
            } else if (overtime) {
                [self.mTimeover addObject: findDic];
            } else {
                [self.mNormal addObject: findDic];
            }
        }
    }
    
    //无包用户设置默认
    for (NSMutableDictionary* dic in self.mNullHongbao) {
        dic[@"resultHandle"] = self.mLastIsOvertime ? @"overtime" : @"asLast";
    }
    
    if (tmanager.mRobot.mEnableNiuniu) {
        //庄没包
        if (!self.mBanker[0][@"resultHandle"]) {
            self.mBanker[0][@"resultHandle"] = self.mLastIsOvertime ? @"overtime" : @"asLast";
        }
    }
}

//来自已有数据
-(void) loadWithRoundData: (NSDictionary*)dic {
    [self.mNullHongbao removeAllObjects];
    [self.mRobHongbao removeAllObjects];
    [self.mTimeover removeAllObjects];
    [self.mBanker removeAllObjects];
    [self.mNormal removeAllObjects];
    [self.mReport removeAllObjects];
    [self.mLastAmounts removeAllObjects];
    
    self.mMinSecond = [dic[@"resultVars"][@"mMinSecond"] longLongValue];
    self.mMaxSecond = [dic[@"resultVars"][@"mMaxSecond"] longLongValue];
    self.mOvertimeNoWin = [dic[@"resultVars"][@"mOvertimeNoWin"] isEqualToString: @"true"];
    self.mRobNoWin = [dic[@"resultVars"][@"mRobNoWin"] isEqualToString: @"true"];
    self.mResetSeriesWin = [dic[@"resultVars"][@"mResetSeriesWin"] isEqualToString: @"true"];
    self.mLastIsOvertime = [dic[@"resultVars"][@"mLastIsOvertime"] isEqualToString: @"true"];
    self.mResetBonusPool = [dic[@"resultVars"][@"mResetBonusPool"] intValue];
    self.mTotalAmount = [dic[@"resultVars"][@"mTotalAmount"] intValue];
    if (dic[@"resultVars"][@"mLastAmounts"] && [dic[@"resultVars"][@"mLastAmounts"] count] > 0) {
        [self.mLastAmounts addObjectsFromArray: dic[@"resultVars"][@"mLastAmounts"]];
    }
    self.mHasHongbaoData = YES;
    
    if (tmanager.mRobot.mEnableNiuniu) {
        for (NSDictionary* banker in dic[@"bankers"]) {
            if ([banker[@"isMain"] isEqualToString: @"true"]) {
                [self.mBanker addObject: [NSMutableDictionary dictionaryWithDictionary: banker]];
            }
        }
    }
    
    for (NSDictionary* player in dic[@"players"]) {
        if ([player[@"resultType"] isEqualToString: @"nullHongbao"]) {
            [self.mNullHongbao addObject: [NSMutableDictionary dictionaryWithDictionary: player]];
        }
        else if ([player[@"resultType"] isEqualToString: @"timeover"]) {
            [self.mTimeover addObject: [NSMutableDictionary dictionaryWithDictionary: player]];
        }
        else if ([player[@"resultType"] isEqualToString: @"normal"]) {
            [self.mNormal addObject: [NSMutableDictionary dictionaryWithDictionary: player]];
        }
        else {
            [self.mNullHongbao addObject: [NSMutableDictionary dictionaryWithDictionary: player]];
        }
    }
    [self.mNullHongbao sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"betIndex"] intValue] > [b[@"betIndex"] intValue] ? 1 : -1;
    }];
    [self.mTimeover sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"betIndex"] intValue] > [b[@"betIndex"] intValue] ? 1 : -1;
    }];
    [self.mNormal sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"betIndex"] intValue] > [b[@"betIndex"] intValue] ? 1 : -1;
    }];
    
    for (NSDictionary* player in dic[@"robs"]) {
        [self.mRobHongbao addObject: [NSMutableDictionary dictionaryWithDictionary: player]];
    }
}

//设置是否自动获取红包
-(void) setIsAutoQueryHongbao:(BOOL)value {
    self.mEnableAutoQueryHongbao = value;
    
    if (self.mEnableAutoQueryHongbao) {
        if (tmanager.mLastHongbaoDetail[@"sendId"] && mHongbaoData[@"args"] && mHongbaoData[@"args"][@"sendId"] && [tmanager.mLastHongbaoDetail[@"sendId"] isEqualToString: mHongbaoData[@"args"][@"sendId"]] && [tmanager.mLastHongbaoDetail[@"totalNum"] intValue] == [tmanager.mLastHongbaoDetail[@"record"] count]) {
            self.mEnableAutoQueryHongbao = NO;
            if (self.mDelegate) {
                [self.mDelegate autoQueryHongbaoEnd];
            }
            return;
        }
        
        if (mHongbaoData[@"args"]) {
            int autoOpenHongbaoWait = [tmanager.mRobot.mData.mBaseSetting[@"autoOpenHongbaoWait"] intValue];
            float waitTime = MAX(.1, autoOpenHongbaoWait-([[NSDate date] timeIntervalSince1970]-mRecvHongbaoTime));
            [self readyQueryHongbaoMoney: waitTime];
        }
    } else {
        [self closeQueryHongbaoTimer];
    }
}

//保存红包消息数据
-(void) saveHongbaoMsg:(id)msg {
    [self closeQueryHongbaoTimer];
    NSDictionary* args = [wxFunction parseHongbaoParams: msg];
    mHongbaoData[@"msg"] = msg;
    mHongbaoData[@"args"] = args;
    mRecvHongbaoTime = [[NSDate date] timeIntervalSince1970];

    if (self.mEnableAutoQueryHongbao) {
        int autoOpenHongbaoWait = [tmanager.mRobot.mData.mBaseSetting[@"autoOpenHongbaoWait"] intValue];
        [self readyQueryHongbaoMoney: autoOpenHongbaoWait];
    }
}

//清除红包消息数据
-(void) clearHongbaoMsg {
    [mHongbaoData removeAllObjects];
}

//准备查询红包点数
-(void) readyQueryHongbaoMoney: (float)second {
    [self closeQueryHongbaoTimer];
    mQueryHongbaoTimer = [NSTimer scheduledTimerWithTimeInterval: second target: self selector: @selector(queryHongbaoMoney) userInfo:nil repeats:NO];
}

//查询红包点数
-(void) queryHongbaoMoney {
    [self closeQueryHongbaoTimer];
    
    if (!self.mEnableAutoQueryHongbao) {
        return;
    }
    
    id msg = mHongbaoData[@"msg"];
    if (!msg) {
        return;
    }
    mHongbaoData[@"autoQuery"] = @1;
    
    id WCRedEnvelopesControlMgr = [wxFunction getMgr: @"WCRedEnvelopesControlMgr"];
    {
        id WCRedEnvelopesControlData = [[[NSClassFromString(@"WCRedEnvelopesControlData") alloc] init] autorelease];
        [WCRedEnvelopesControlData performSelector: @selector(setM_oSelectedMessageWrap:) withObject: msg];
        SEL sel = @selector(startReceiveRedEnvelopesLogic:Data:);
        id (*action)(id, SEL, id, id) = (id (*)(id, SEL, id, id)) objc_msgSend;
        action(WCRedEnvelopesControlMgr, sel, nil, WCRedEnvelopesControlData);
    }
}

//手动查询红包
-(void) manualQueryHongbao {
    [mHongbaoData removeObjectForKey: @"autoQuery"];
    
    if (self.mEnableAutoQueryHongbao) {
        [self setIsAutoQueryHongbao: NO];
        if (self.mDelegate) {
            [self.mDelegate stopAutoQueryHongbao];
        }
    }
}

//关闭查询红包点数定时器
-(void) closeQueryHongbaoTimer {
    if (mQueryHongbaoTimer) {
        [mQueryHongbaoTimer invalidate];
        mQueryHongbaoTimer = nil;
    }
}

//关闭红包窗口检测
-(void) closeHongbaoWindowCheck {
    if (mHongbaoData[@"autoQuery"]) {
        NSArray* windows = [[UIApplication sharedApplication] windows];
        for(UIWindow* w in windows) {
            id WCRedEnvelopesReceiveHomeView = [wxFunction findWCRedEnvelopesReceiveHomeView:w];
            if (WCRedEnvelopesReceiveHomeView) {
                [WCRedEnvelopesReceiveHomeView performSelector: @selector(OnCancelButtonDone)];
            }
        }
    }
}

//接收红包状态
/* 模版
 
 externMess = "";
 hbStatus = 4;//2未领完 3未领完 4领完了
 hbType = 1;
 isSender = 0;//0别人发的 1自己发的
 receiveStatus = 0; //0未打开 2打开了
 sendId = 1000039501201707056016015043113;
 sendUserName = "wxid_30m546wszah252";
 statusMess = "手慢了，红包派完了";
 timingIdentifier = CE5DFDF584B884A5DFF6DD8D5CD08404;
 watermark = "";
 wishing = "恭喜发财，大吉大利";
 */
-(void) recvHongbaoStatus: (NSDictionary*)dic {
    [self closeQueryHongbaoTimer];
    if (!self.mEnableAutoQueryHongbao) {
        return;
    }
    
    if (!dic || !dic[@"sendId"]) {
        return;
    }
    
    if (!mHongbaoData[@"autoQuery"]) {
        return;
    }
    
    if (!mHongbaoData[@"args"] || !mHongbaoData[@"args"][@"sendId"]) {
        return;
    }
    
    if (![dic[@"sendId"] isEqualToString: mHongbaoData[@"args"][@"sendId"]]) {
        return;
    }
    
    if ([dic[@"receiveStatus"] intValue] != 2) {//这个红包自己没打开
        if([dic[@"hbStatus"] intValue] == 4 || [dic[@"isSender"] intValue] == 1) {//红包领完了或者是自己发的
            [tmanager clearHongbaoData];
            id WCRedEnvelopesLogicMgr = [wxFunction getMgr: @"WCRedEnvelopesLogicMgr"];;
            NSMutableDictionary* newArgs = [NSMutableDictionary dictionaryWithDictionary: mHongbaoData[@"args"]];
            newArgs[@"befortTimestamp"] = @"0";
            newArgs[@"limit"] = @"11";
            newArgs[@"offset"] = @"0";
            [WCRedEnvelopesLogicMgr performSelector: @selector(QueryRedEnvelopesDetailRequest:) withObject:mHongbaoData[@"args"]];
        } else {
            [self closeHongbaoWindowCheck];
            [self readyQueryHongbaoMoney: 3];
        }
    }
}

//接收红包详情
/*
 1499236490.309483 {
 amount = 0;
 atomicFunc =     {
 enable = 0;
 };
 canShare = 0;
 changeWording = "已存入零钱，可直接消费";
 hbKind = 1;
 hbStatus = 4;
 hbType = 1;
 headTitle = "66个红包，25秒被抢光";
 isContinue = 1;
 isSender = 0;
 jumpChange = 1;
 operationHeader =     (
 );
 operationTail =     {
 enable = 0;
 };
 recAmount = 13200;
 recNum = 66;
 receiveId = "";
 record =     (
 {
 answer = "";
 receiveAmount = 159;
 receiveId = 1000039501043707057016044507307;
 receiveOpenId = 1000039501043707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = "wxid_0eqccsgni0vm12";
 },
 {
 answer = "";
 receiveAmount = 297;
 receiveId = 1000039501042707057016044507307;
 receiveOpenId = 1000039501042707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = "wxid_o99wvbvealfq22";
 },
 {
 answer = "";
 receiveAmount = 85;
 receiveId = 1000039501041707057016044507307;
 receiveOpenId = 1000039501041707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = "wxid_9i5p475gya9712";
 },
 {
 answer = "";
 receiveAmount = 39;
 receiveId = 1000039501040707057016044507307;
 receiveOpenId = 1000039501040707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = "wxid_2he6m8qb3v3r12";
 },
 {
 answer = "";
 receiveAmount = 395;
 receiveId = 1000039501039707057016044507307;
 receiveOpenId = 1000039501039707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = "wxid_vx574fweosq512";
 },
 {
 answer = "";
 receiveAmount = 36;
 receiveId = 1000039501038707057016044507307;
 receiveOpenId = 1000039501038707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = "wxid_6ko693001bgw22";
 },
 {
 answer = "";
 receiveAmount = 150;
 receiveId = 1000039501037707057016044507307;
 receiveOpenId = 1000039501037707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = "wxid_f49symolm9e722";
 },
 {
 answer = "";
 receiveAmount = 324;
 receiveId = 1000039501036707057016044507307;
 receiveOpenId = 1000039501036707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = "wxid_av1admdcxxeg12";
 },
 {
 answer = "";
 receiveAmount = 26;
 receiveId = 1000039501035707057016044507307;
 receiveOpenId = 1000039501035707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = E3E4Miss20;
 },
 {
 answer = "";
 receiveAmount = 307;
 receiveId = 1000039501034707057016044507307;
 receiveOpenId = 1000039501034707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = "wxid_q3jn6io3fgoh22";
 },
 {
 answer = "";
 receiveAmount = 347;
 receiveId = 1000039501033707057016044507307;
 receiveOpenId = 1000039501033707057016044507307;
 receiveTime = 1499236309;
 state = 1;
 userName = xk463266987;
 }
 );
 sendId = 1000039501201707057016044507307;
 sendUserName = wxid665588888;
 totalAmount = 13200;
 totalNum = 66;
 wishing = "恭喜发财，大吉大利";
 }
 */
-(void) recvHongbaoDetail {
    [self closeQueryHongbaoTimer];
    if (!self.mEnableAutoQueryHongbao) {
        return;
    }
    
    NSDictionary* dic = tmanager.mLastHongbaoDetail;
    if (!dic || !dic[@"sendId"]) {
        return;
    }
    
    if (!mHongbaoData[@"autoQuery"]) {
        return;
    }
    
    if (!mHongbaoData[@"args"] || !mHongbaoData[@"args"][@"sendId"]) {
        return;
    }
    
    if (![dic[@"sendId"] isEqualToString: mHongbaoData[@"args"][@"sendId"]]) {
        return;
    }
    
    if ([dic[@"totalNum"] intValue] != [dic[@"record"] count]) {
        NSMutableDictionary* newArgs = [NSMutableDictionary dictionaryWithDictionary: mHongbaoData[@"args"]];
        newArgs[@"befortTimestamp"] = @"0";
        newArgs[@"limit"] = @"11";
        newArgs[@"offset"] = deInt2String((int)[dic[@"record"] count]);
        id WCRedEnvelopesLogicMgr = [wxFunction getMgr: @"WCRedEnvelopesLogicMgr"];;
        [WCRedEnvelopesLogicMgr performSelector: @selector(QueryRedEnvelopesDetailRequest:) withObject:newArgs];
    } else {
        [self closeHongbaoWindowCheck];
        [self setIsAutoQueryHongbao: NO];
        if (self.mDelegate) {
            [self.mDelegate autoQueryHongbaoEnd];
        }
    }
}

//自定义认尾
-(void) asLast:(NSMutableDictionary*)dic{
    BOOL isBanker = dic[@"banker"];
    BOOL pass100 = (int)tmanager.mRobot.mBet.mBetRecordCount > 100;
    if (self.mCustomAsLast[@"enable"] && [self.mCustomAsLast[@"enable"] isEqualToString: @"true"] &&
        (pass100 || ![self.mCustomAsLast[@"pass100need"] isEqualToString: @"true"])) {//自定义认尾
        int index = [self.mCustomAsLast[isBanker ? @"bankerIndex" : @"playerIndex"] intValue]-1;
        int amount = 29;
        if (index < [self.mLastAmounts count]) {
            amount = [self.mLastAmounts[index] intValue];
        }
        [self setMount: dic mount: amount];
    } else {
        int index = 0;
        if (isBanker) {
            BOOL banerAsLast2;
            if (pass100) {
                banerAsLast2 = [tmanager.mRobot.mData.mBaseSetting[@"banerAsLast2For100"] isEqualToString: @"true"];//庄认尾2(100包以上)
            } else {
                banerAsLast2 = [tmanager.mRobot.mData.mBaseSetting[@"banerAsLast2"] isEqualToString: @"true"];//庄认尾2(100包以内)
            }
            if (banerAsLast2) {
                index = 1;
            }
        }
        int amount = 29;
        if (index < [self.mLastAmounts count]) {
            amount = [self.mLastAmounts[index] intValue];
        }
        [self setMount: dic mount: amount];
    }
}

-(void) setLastAmount: (int)amount index:(int)index {
    if ([self.mLastAmounts count] < index+1) {
        for (int i = (int)[self.mLastAmounts count]; i < index+1; ++i) {
            [self.mLastAmounts addObject: @"029"];
        }
    }
    self.mLastAmounts[index] = deInt2String(amount);
}

-(void) setCustomAsLastEnable:(BOOL)enable {
    self.mCustomAsLast[@"enable"] = enable ? @"true" : @"false";
    if (enable) {
        if (!self.mCustomAsLast[@"type"]) {
            [self setCustomAsLastType: @"default"];
        }
    }
}

//default, while, head
-(void) setCustomAsLastType:(NSString*)type {
    self.mCustomAsLast[@"type"] = type;
    
    if ([type isEqualToString: @"default"]) {
        self.mCustomAsLast[@"pass100need"] = @"true";
        self.mCustomAsLast[@"max"] = @"6";
        self.mCustomAsLast[@"playerIndex"] = @"1";
        self.mCustomAsLast[@"bankerIndex"] = @"2";
        self.mCustomAsLast[@"headAmount"] = @"029";
    }
    else if ([type isEqualToString: @"head"]) {
        self.mCustomAsLast[@"pass100need"] = @"true";
        self.mCustomAsLast[@"max"] = @"11";
        self.mCustomAsLast[@"playerIndex"] = @"1";
        self.mCustomAsLast[@"bankerIndex"] = @"2";
        self.mCustomAsLast[@"headAmount"] = @"029";
    }
}

-(void) setCustomAsLastMax:(int)max {
    self.mCustomAsLast[@"max"] = deInt2String(max);
}

-(void) setPass100Need:(BOOL)pass100need {
    self.mCustomAsLast[@"pass100need"] = pass100need ? @"true" : @"false";
}

-(void) setCustomAsLastPlayerIndex:(int)index {
    self.mCustomAsLast[@"playerIndex"] = deInt2String(index);
}

-(void) setCustomAsLastBankerIndex:(int)index {
    self.mCustomAsLast[@"bankerIndex"] = deInt2String(index);
}

-(void) setCustomHeadAmount: (int)amount {
    self.mCustomAsLast[@"headAmount"] = deInt2String(amount);
}

-(void) updateCustomAsLast {
    BOOL pass100 = (int)tmanager.mRobot.mBet.mBetRecordCount > 100;
    if (self.mCustomAsLast[@"enable"] && [self.mCustomAsLast[@"enable"] isEqualToString: @"true"] &&
        (pass100 || ![self.mCustomAsLast[@"pass100need"] isEqualToString: @"true"])) {//自定义认尾
    } else {
        return;
    }
    if ([self.mCustomAsLast[@"type"] isEqualToString: @"head"]) {
        int headAmount = [self.mCustomAsLast[@"headAmount"] intValue];
        int number = headAmount % 10;
        if (0 == number) {
            number = 10;
        }
        self.mCustomAsLast[@"playerIndex"] = deInt2String(number);
        self.mCustomAsLast[@"bankerIndex"] = deInt2String(number+1);
    }
}

#pragma mark- mask
-(void) showMask: (NSString*)title msg:(NSString*)msg {
    [self hideMask];
    mMask = [[UIAlertView alloc] initWithTitle: title message: msg delegate: nil cancelButtonTitle:nil otherButtonTitles:nil];
    [mMask show];
}

-(void) hideMask {
    [mMask dismissWithClickedButtonIndex:0 animated:NO];
    [mMask release];
    mMask = nil;
}

@end
