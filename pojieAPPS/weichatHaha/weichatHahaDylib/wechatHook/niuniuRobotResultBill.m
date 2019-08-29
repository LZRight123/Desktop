//
//  niuniuResultBill.m
//  wechatHook
//
//  Created by antion on 2017/4/13.
//
//

#import "niuniuRobotResultBill.h"
#import "toolManager.h"
#import "ycDefine.h"
#import "niuniu.h"
#import "ycFunction.h"

@implementation niuniuRobotResultBill

+(NSString*) addTitle: (NSString*)title {
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"　　♤%@♤\n", title];
    [text appendString: @"──────────\n"];
    return text;
}

+(UILabel*) addLabel: (UIView*)view frame:(CGRect)frame text:(NSString*)text color:(UIColor*)color isLeft:(BOOL)isLeft {
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    label.font = [UIFont boldSystemFontOfSize: 18];
    if (isLeft) {
        label.textAlignment = NSTextAlignmentLeft;
    } else {
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.textColor = color;
    label.text =text;
    [view addSubview: label];
    [label release];
    return label;
}

+(UIView*) addLine: (UIView*)view frame:(CGRect)frame color:(UIColor*)color {
    UIView* line = [[UIView alloc] initWithFrame: frame];
    line.backgroundColor = color;
    [view addSubview: line];
    [line release];
    return view;
}

+(NSString*) genNiuniuAndLonghuStringBill {
    NSDictionary* report = tmanager.mRobot.mResult.mReport;
    NSArray* niuniuPlayers = report[@"niuniuPlayers"];
    NSArray* longhuPlayers = report[@"longhuPlayers"];
    NSArray* temaPlayers = report[@"temaPlayers"];
    NSArray* baijialePlayers = report[@"baijialePlayers"];
    NSArray* allPlayers = report[@"players"];
    NSMutableDictionary* banker = report[@"mainBanker"];
    NSArray* allBankers = report[@"bankers"];
    NSArray* allRobs = report[@"robs"];
    NSMutableDictionary* data = report[@"otherInfo"];
    
    //开始生成账单字符串
    NSMutableString* text = [NSMutableString string];
    NSMutableDictionary* shows = [[@{} mutableCopy] autorelease];
    
    //局数, 日期
    NSDate *date = [NSDate date];
    NSDateFormatter *objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"MM-dd HH:mm:ss"];
    [text appendFormat: @"第%d局 %@\n", tmanager.mRobot.mNumber, [objDateformat stringFromDate: date]];
    
    //正常结算(牛牛)
    for (int i = (int)[niuniuPlayers count]-1; i >= 0; --i) {
        NSMutableDictionary* dic = niuniuPlayers[i];
        int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
        int num = (int)[dic[@"num"] intValue];
        if (([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"]) && [dic[@"winOrLose"] intValue] != 0) {//闲有点数， 并且有输赢
            if ([banker[@"resultHandle"] isEqualToString: @"bankerHead"]) {//庄平赔
                if(!shows[@"pingpei"]) {
                    shows[@"pingpei"] = @YES;
                    [text appendString:[self addTitle: @"平　赔"]];
                }
                NSString* mark = nil;
                NSMutableString* tmp = [NSMutableString string];
                if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {
                    [tmp appendString: @"尾"];
                }
                if ([dic[@"suoha"] isEqualToString: @"true"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"梭"];
                }
                if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"免"];
                }
                if ([dic[@"yibi"] isEqualToString: @"true"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"一比"];
                }
                if (tmp.length > 0) {
                    mark = deString(@"[%@]", tmp);
                }
                [text appendFormat:@"%@　%d%@ %@%d%@\n", deFillName(dic[@"billName"]), num, num < 100 ? @"  " : @"", winOrLoseFact >= 0 ? @"+" : @"-", abs(winOrLoseFact), mark ? mark : @""];
            } else {
                if(winOrLoseFact == 0 && !dic[@"heshui"]) {
                    shows[@"heshui"] = @YES;
                    [text appendString:[self addTitle: @"喝　水"]];
                }
                else if (winOrLoseFact != 0 && !shows[@"normal"]) {
                    shows[@"normal"] = @YES;
                    if (tmanager.mRobot.mEnableLonghu) {
                        [text appendString:[self addTitle: @"牛牛结算"]];
                    } else {
                        [text appendString:[self addTitle: @"正常结算"]];
                    }
                }
                NSString* mark = nil;
                NSMutableString* tmp = [NSMutableString string];
                if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {
                    [tmp appendString: @"尾"];
                }
                if ([dic[@"suoha"] isEqualToString: @"true"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"梭"];
                }
                if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"免"];
                }
                if ([dic[@"yibi"] isEqualToString: @"true"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"一比"];
                }
                if (dic[@"scoreLimit"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"限"];
                }
                if (tmp.length > 0) {
                    mark = deString(@"[%@]", tmp);
                }
                [text appendFormat:@"%@　%d%@ x%@ %@%d%@\n", deFillName(dic[@"billName"]), num, num < 100 ? @"  " : @"", [ycFunction formatFloatStr:dic[@"powFact"]], winOrLoseFact >= 0 ? @"+" : @"-", abs(winOrLoseFact), mark ? mark : @""];
            }
        }
    }
    
    //平局的(牛牛)
    for (int i = (int)[niuniuPlayers count]-1; i >= 0; --i) {
        NSMutableDictionary* dic = niuniuPlayers[i];
        if ([dic[@"winOrLose"] intValue] == 0 && ([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"])) {
            if (!shows[@"noWin"]) {
                shows[@"noWin"] = @YES;
                [text appendString:[self addTitle: @"平　局"]];
            }
            if ([dic[@"amount"] intValue] == 1) {
                [text appendFormat: @"%@　001跑路\n", deFillName(dic[@"billName"])];
            } else {
                [text appendFormat: @"%@　无输赢\n", deFillName(dic[@"billName"])];
            }
        }
    }
    
    //正常结算(龙虎)
    for (int i = (int)[longhuPlayers count]-1; i >= 0; --i) {
        NSMutableDictionary* dic = longhuPlayers[i];
        int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
        if (([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"])) {//闲有点数
            if (!shows[@"normalLonghu"]) {
                shows[@"normalLonghu"] = @YES;
                if (tmanager.mRobot.mEnableNiuniu) {
                    [text appendString:[self addTitle: @"大小结算"]];
                } else {
                    [text appendString:[self addTitle: @"牛牛结算"]];
                }
            }
            NSString* mark = nil;
            NSMutableString* tmp = [NSMutableString string];
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {
                [tmp appendString: @"尾"];
            }
            if (tmp.length > 0) {
                mark = deString(@"[%@]", tmp);
            }
            [text appendFormat:@"%@　%.2f(%@) %@%d%@\n%@%@\n", deFillName(dic[@"billName"]), [dic[@"amount"] floatValue]/100, dic[@"powType"], winOrLoseFact >= 0 ? @"+" : @"-", abs(winOrLoseFact), mark ? mark : @"", winOrLoseFact >= 0 ? @"✅" : @"❌", dic[@"valuesStr"]];
        }
    }

    //正常结算(特码)
    for (int i = (int)[temaPlayers count]-1; i >= 0; --i) {
        NSMutableDictionary* dic = temaPlayers[i];
        int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
        if (([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"])) {//闲有点数
            if (!shows[@"normalTema"]) {
                shows[@"normalTema"] = @YES;
                [text appendString:[self addTitle: @"特码结算"]];
            }
            NSString* mark = nil;
            NSMutableString* tmp = [NSMutableString string];
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {
                [tmp appendString: @"尾"];
            }
            if (tmp.length > 0) {
                mark = deString(@"[%@]", tmp);
            }
            [text appendFormat:@"%@　%.2f(%@) %@%d%@\n%@%@\n", deFillName(dic[@"billName"]), [dic[@"amount"] floatValue]/100, dic[@"powType"], winOrLoseFact >= 0 ? @"+" : @"-", abs(winOrLoseFact), mark ? mark : @"", winOrLoseFact >= 0 ? @"✅" : @"❌", dic[@"valuesStr"]];
        }
    }
    
    //正常结算(百家乐)
    for (int i = (int)[baijialePlayers count]-1; i >= 0; --i) {
        NSMutableDictionary* dic = baijialePlayers[i];
        int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
        if (([dic[@"resultHandle"] isEqualToString:@"asLast"] || [dic[@"resultHandle"] isEqualToString:@"normal"])) {//闲有点数
            if (!shows[@"normalBaijiale"]) {
                shows[@"normalBaijiale"] = @YES;
                [text appendString:[self addTitle: @"百家乐结算"]];
            }
            NSString* mark = nil;
            NSMutableString* tmp = [NSMutableString string];
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {
                [tmp appendString: @"尾"];
            }
            if (tmp.length > 0) {
                mark = deString(@"[%@]", tmp);
            }
            [text appendFormat:@"%@　%.2f(%@) %@%d%@\n%@%@\n", deFillName(dic[@"billName"]), [dic[@"amount"] floatValue]/100, dic[@"powType"], winOrLoseFact >= 0 ? @"+" : @"-", abs(winOrLoseFact), mark ? mark : @"", winOrLoseFact >= 0 ? @"✅" : @"❌", dic[@"valuesStr"]];
        }
    }

    //超时
    for (int i = (int)[allPlayers count]-1; i >= 0; --i) {
        NSMutableDictionary* dic = allPlayers[i];
        if ([dic[@"resultHandle"] isEqualToString:@"overtime"] || [dic[@"resultHandle"] isEqualToString:@"noWin"]) {
            if (!shows[@"overtime"]) {
                shows[@"overtime"] = @YES;
                [text appendString:[self addTitle: @"超　时"]];
            }
            int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
            if (0 == winOrLoseFact) {
                [text appendFormat: @"%@　超时无输赢\n", deFillName(dic[@"billName"])];
            } else {
                long long time;
                if (dic[@"receiveTime"]) {//自己有包
                    time = [dic[@"receiveTime"] longLongValue];
                } else {//尾包
                    time = tmanager.mRobot.mResult.mMaxSecond;
                }
                int num = [dic[@"num"] intValue];
                NSString* mark = @"";
                NSMutableString* tmp = [NSMutableString string];
                if ([dic[@"suoha"] isEqualToString: @"true"]) {
                    [tmp appendString: @"梭"];
                }
                if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"免"];
                }
                if ([dic[@"yibi"] isEqualToString: @"true"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"一比"];
                }
                if (dic[@"scoreLimit"]) {
                    if (tmp.length > 0) {
                        [tmp appendString: @"|"];
                    }
                    [tmp appendString: @"限"];
                }
                if (tmp.length > 0) {
                    mark = deString(@"[%@]", tmp);
                }
                [text appendFormat: @"%@　%lld秒 下%d%@ -%d%@\n", deFillName(dic[@"billName"]), time-tmanager.mRobot.mResult.mMinSecond, num, num < 100 ? @" " : @"",  abs(winOrLoseFact), mark];
            }
        }
    }
    
    //抢包
    for (int i = (int)[allRobs count]-1; i >= 0; --i) {
        if (!shows[@"rob"]) {
            shows[@"rob"] = @YES;
            [text appendString:[self addTitle: @"抢　包"]];
        }
        NSMutableDictionary* dic = allRobs[i];
        NSString* robName = dic[@"billName"] ? deFillName(dic[@"billName"]) : dic[@"name"];
        if ([dic[@"robTarget"] isEqualToString: @"banker"]) {
            [text appendFormat: @"%@　抢庄家包\n", robName];
        }
        else if ([dic[@"robTarget"] isEqualToString: @"player"]) {
            [text appendFormat: @"%@　抢　%@\n", robName, dic[@"coverRobName"]];
        }
        else if ([dic[@"robTarget"] isEqualToString: @"valid"]) {
            if (dic[@"receiveTime"]) {
                [text appendFormat: @"%@　抢%lld秒包\n", robName, [dic[@"receiveTime"] longLongValue]-tmanager.mRobot.mResult.mMinSecond];
            } else {
                [text appendFormat: @"%@　抢有效包\n", robName];
            }
        }
        else if ([dic[@"robTarget"] isEqualToString: @"overtime"]) {
            [text appendFormat: @"%@　抢超时包\n", robName];
        }
    }
    
    //抢包、被抢包扣分、补分
    if (!tmanager.mRobot.mResult.mRobNoWin) {
        for (int i = (int)[allRobs count]-1; i >= 0; --i) {
            NSMutableDictionary* dic = allRobs[i];
            NSString* robName = dic[@"billName"] ? deFillName(dic[@"billName"]) : dic[@"name"];
            if (dic[@"robDown"]) {
                int num = [dic[@"robDown"] intValue];
                NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
                if (memData) {
                    int score = [memData[@"score"] intValue];
                    [text appendFormat: @"%@　扣%d 总%d\n", robName, num, MAX(0, score-num)];
                } else {
                    [text appendFormat: @"%@　无会员\n", robName];
                }
            }
        }
        
        if (tmanager.mRobot.mEnableNiuniu && banker[@"coverRobUp"]) {
            int num = [banker[@"coverRobUp"] intValue];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: banker[@"userid"]];
            if (memData) {
                int score = [memData[@"score"] intValue];
                int winOrLoseFact = [banker[@"winOrLoseFact"] intValue];
                [text appendFormat: @"%@　补%d 总%d\n", deFillName(banker[@"billName"]), num, MAX(score+winOrLoseFact, 0)+num];
            } else {//庄不可能获取不到会员信息
                NSLog(@"有下注的不可能获取不到会员信息");
            }
        }
        
        for (NSMutableDictionary* dic in allPlayers) {
            if (dic[@"coverRobUp"]) {
                int num = [dic[@"coverRobUp"] intValue];
                NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
                if (memData) {
                    int score = [memData[@"score"] intValue];
                    int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
                    [text appendFormat: @"%@　补%d 总%d\n", deFillName(dic[@"billName"]), num, MAX(score+winOrLoseFact, 0)+num];
                } else {//有下注的不可能获取不到会员信息
                    NSLog(@"有下注的不可能获取不到会员信息");
                }
            }
        }
    }
    
    //用时统计
    [text appendString:[self addTitle: @"用　时"]];
    {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:tmanager.mRobot.mResult.mMinSecond];
        NSDateFormatter *objDateformat = [[[NSDateFormatter alloc] init] autorelease];
        [objDateformat setDateFormat:@"HH:mm:ss"];
        [text appendString: deString(@"头包: %@\n", [objDateformat stringFromDate: date])];
    }{
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:tmanager.mRobot.mResult.mMaxSecond];
        NSDateFormatter *objDateformat = [[[NSDateFormatter alloc] init] autorelease];
        [objDateformat setDateFormat:@"HH:mm:ss"];
        [text appendString: deString(@"尾包: %@ %lld秒\n", [objDateformat stringFromDate: date], tmanager.mRobot.mResult.mMaxSecond-tmanager.mRobot.mResult.mMinSecond)];
    }
    if(tmanager.mRobot.mEnableNiuniu){
        long long time;
        if (banker[@"receiveTime"]) {//自己有包
            time = [banker[@"receiveTime"] longLongValue];
        } else {//尾包
            time = tmanager.mRobot.mResult.mMaxSecond;
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *objDateformat = [[[NSDateFormatter alloc] init] autorelease];
        [objDateformat setDateFormat:@"HH:mm:ss"];
        [text appendFormat: @"庄包: %@ %lld秒\n", [objDateformat stringFromDate: date], time-tmanager.mRobot.mResult.mMinSecond];
    }
    
    if ([data[@"bankerBonus"] intValue] > 0) {
        [text appendString:[self addTitle: @"奖励"]];
        [text appendFormat: @"庄%@奖励: %@\n", banker[@"amount"], data[@"bankerBonus"]];
    }
    
    //庄倍数
    NSString* powStr;
    if (tmanager.mRobot.mEnableNiuniu) {
        if ([banker[@"resultHandle"] isEqualToString: @"overtime"]) {
            powStr = @"超时";
        } else if ([banker[@"resultHandle"] isEqualToString: @"bankerHead"]) {
            powStr = @"平赔";
        } else {
            powStr = deString(@"%@倍", [ycFunction formatFloatStr:banker[@"powFactBanker"]]);
        }
        
    }
    
    //庄家名字
    NSString* bankerName = nil;
    if (tmanager.mRobot.mEnableNiuniu) {
        bankerName = banker[@"billName"];
    } else {
        if ([allBankers count] == 1) {
            bankerName = allBankers[0][@"billName"];
        } else if([allBankers count] > 1) {
            bankerName = @"[多人]";
        }
    }
    
    
    [text appendString:[self addTitle: @"庄家结算"]];
    [text appendFormat: @"赢%@家 输%@家 平%@家\n", data[@"winCount"], data[@"loseCount"], data[@"drawCount"]];
    if (bankerName) {
        [text appendFormat: @"本  局  庄  家:  %@\n", deFillName(banker[@"billName"])];
    }
    if (tmanager.mRobot.mEnableNiuniu) {
        [text appendFormat: @"庄  家  红  包:  %.02f %@\n", [banker[@"amount"] floatValue]/100, powStr];
    }
    [text appendFormat: @"奖  池  增  加:  %@\n", data[@"bonusPoolFee"]];
    [text appendFormat: @"奖  池  累  计:  %@\n", data[@"bonusPoolTotal"]];
    [text appendFormat: @"本  局  红  包:  %@\n", data[@"hongbaoFee"]];
    [text appendFormat: @"本  局  抽  水:  %d\n", [data[@"playerRatioTotal"] intValue]+[data[@"bankerRatioTotal"] intValue]];
    [text appendFormat: @"本  局  输  赢:  %@\n", data[@"bankerOriginWinOrLose"]];
    [text appendFormat: @"抢  包  支  出:  %@\n", data[@"robPay"]];
    [text appendFormat: @"喝  水  补  贴:  %@\n", data[@"heshuiSubsidyCount"]];
    if (tmanager.mRobot.mEnableNiuniu) {
        [text appendFormat: @"牛  牛  下  注:  %d\n", (int)tmanager.mRobot.mBet.mBetScoreCount];
        [text appendFormat: @"牛  牛  梭  哈:  %d\n", (int)tmanager.mRobot.mBet.mBetScoreSuohaCount];
    }
    if (tmanager.mRobot.mEnableLonghu) {
        [text appendFormat: @"大  小  下  注:  %d\n", (int)tmanager.mRobot.mBet.mBetScoreLonghuCount+(int)tmanager.mRobot.mBet.mBetScoreLonghuHeCount];
    }
    if (tmanager.mRobot.mEnableTema) {
        [text appendFormat: @"特  码  下  注:  %d\n", (int)tmanager.mRobot.mBet.mBetScoreTemaCount];
    }
    if (tmanager.mRobot.mEnableBaijiale) {
        [text appendFormat: @"百  家  乐  注:  %d\n", (int)tmanager.mRobot.mBet.mBetScoreBaijialeCount];
    }
    if (bankerName) {
        [text appendFormat: @"庄  上  积  分:  %@\n", data[@"origin_bankerMoney"]];
        [text appendFormat: @"剩  余  积  分:  %@\n", data[@"bankerMoney"]];
    }
    
    if ([allBankers count] > 1) {//合庄模式
        [text appendString:[self addTitle: @"庄家分红"]];
        for (NSDictionary* dic in allBankers) {
            int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
            [text appendFormat: @"%@ 占%.1f％ %d\n", deFillName(dic[@"billName"]), [dic[@"ratio"] floatValue]*100, winOrLoseFact+[dic[@"num"] intValue]];
        }
    }
    
    if (tmanager.mRobot.mEnableNiuniu) {
        [text appendString:[self addTitle: @"庄家走势"]];
        {
            NSMutableArray* bankers = [NSMutableArray array];
            int count = 0;
            for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >= 0; --i) {
                NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
                for (NSDictionary* banker in dic[@"bankers"]) {
                    if (banker[@"isMain"]) {
                        [bankers insertObject: banker atIndex: 0];
                    }
                }
                if (++count >= 16) {
                    break;
                }
            }
            [bankers addObject: banker];
            
            NSMutableArray* array = [NSMutableArray array];
            for (NSDictionary* dic in bankers) {
                NSString* powStr;
                if ([dic[@"resultHandle"] isEqualToString: @"overtime"]) {
                    powStr = @"超时";
                } else if ([dic[@"resultHandle"] isEqualToString: @"bankerHead"]) {
                    powStr = @"平赔";
                } else {
                    powStr = dic[@"pow"];
                }
                [array addObject: powStr];
            }
            
            //        //测试
            //        array = [[@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"超时"] mutableCopy] autorelease];
            
            int i = 0;
            for (i = 0; i < [array count]; ++i) {
                NSString* powStr = array[i];
                NSString* str;
                if ([ycFunction isInt: powStr]) {
                    str = [niuniu pow2string: [powStr intValue]];
                } else {
                    str = powStr;
                }
                if (i == [array count]-1) {
                    str = deString(@"[%@]", str);
                }
                NSMutableString* widthStr = [NSMutableString stringWithString: str];
                CFStringTransform((CFMutableStringRef)widthStr, NULL, kCFStringTransformFullwidthHalfwidth, true);
                [text appendString: widthStr];
                if (i+1 < [array count]) {
                    [text appendString: @">"];
                }
                if (i%4 == 3) {
                    [text appendString: @"\n"];
                }
            }
            if (i%4 != 0) {
                [text appendString: @"\n"];
            }
        }
    }
    
    [text appendString: @"──────────\n"];
    [text appendString: @"✎﹏千玺机器接单中\n"];
    
    return text;
}

+(UIView*) genNiuniuAndLonghuPicBill {
    NSDictionary* report = tmanager.mRobot.mResult.mReport;
    NSArray* niuniuPlayers = report[@"niuniuPlayers"];
    NSArray* longhuPlayers = report[@"longhuPlayers"];
    NSArray* temaPlayers = report[@"temaPlayers"];
    NSArray* baijialePlayers = report[@"baijialePlayers"];
    NSArray* allPlayers = report[@"players"];
    NSMutableDictionary* banker = report[@"mainBanker"];
    NSArray* allBankers = report[@"bankers"];
    NSArray* allRobs = report[@"robs"];
    NSDictionary* autoSeriesWinBonus = report[@"autoSeriesWinBonus"];
    NSMutableDictionary* data = report[@"otherInfo"];
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    BOOL has001 = [setting[@"has001"] isEqualToString: @"true"];//是否有001跑路规则

    UIView* view = [[[UIView alloc] initWithFrame: CGRectMake(0, 0, 750, 1000)] autorelease];
    view.backgroundColor = [UIColor blackColor];
    
    const int titleh = 34;
    UIColor* titleColor = [UIColor colorWithRed:[setting[@"titleTextR"] floatValue]/255 green:[setting[@"titleTextG"] floatValue]/255 blue:[setting[@"titleTextB"] floatValue]/255 alpha:1];;//标题文字颜色
    UIColor* titleBgColor = [UIColor colorWithRed:[setting[@"titleR"] floatValue]/255 green:[setting[@"titleG"] floatValue]/255 blue:[setting[@"titleB"] floatValue]/255 alpha:1];//标题背景颜色s
    UIColor* textColor = [UIColor blackColor];//文字颜色
    UIColor* textColorErr = [UIColor redColor];//文字错误颜色
    UIColor* textColorWarr = [UIColor colorWithRed:236.0/255 green:93.0/255 blue:15.0/255 alpha:1];//文字警告颜色
    UIColor* textColorSpecial = [UIColor colorWithRed:215.0/255 green:5.0/255 blue:188.0/255 alpha:1];//文字特别颜色
    UIColor* textBgColor = [UIColor whiteColor];//文字背景
    UIColor* textBgColor2 = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];//文字背景2
    UIColor* color1 = [UIColor colorWithRed:[setting[@"trendCurrentR"] floatValue]/255 green:[setting[@"trendCurrentG"] floatValue]/255 blue:[setting[@"trendCurrentB"] floatValue]/255 alpha:1];//往期走势颜色
    UIColor* color2 = [UIColor colorWithRed:[setting[@"trendHighR"] floatValue]/255 green:[setting[@"trendHighG"] floatValue]/255 blue:[setting[@"trendHighB"] floatValue]/255 alpha:1];//这期走势颜色
    int hCount = 0;

    //头部
    {
        UIImage* img = [tmanager.mRobot.mData getBillHeadPic];
        UIImageView* head = [[UIImageView alloc] initWithFrame:CGRectMake(0, hCount, view.frame.size.width, view.frame.size.width/img.size.width*img.size.height)];
        head.image = img;
        head.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview: head];
        [head release];
        hCount += head.frame.size.height;
    }
    
    if (tmanager.mRobot.mEnableNiuniu) {
        //走势图标题
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
        {
            UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(0, hCount, view.frame.size.width, titleh)];
            label.font = [UIFont boldSystemFontOfSize: 18];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = titleColor;
            label.text = deString(@"　庄家点数走势图  第%d期", tmanager.mRobot.mNumber);
            [view addSubview: label];
            [label release];
        }{
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            
            UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(0, hCount, view.frame.size.width, titleh)];
            label.font = [UIFont boldSystemFontOfSize: 18];
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = titleColor;
            label.text = deString(@"账单日期: %@　　", [formatter stringFromDate:date]);
            [view addSubview: label];
            [label release];
        }
        hCount += titleh;
        
        //走势图
        {
            UIImage* img = [tmanager.mRobot.mData getBillTrendPic];
            UIImageView* trend = [[UIImageView alloc] initWithFrame:CGRectMake(0, hCount, view.frame.size.width, view.frame.size.width/img.size.width*img.size.height)];
            trend.image = img;
            trend.contentMode = UIViewContentModeScaleAspectFit;
            [view addSubview: trend];
            [trend release];
            hCount += trend.frame.size.height;
            
            //走势
            NSMutableArray* bankers = [NSMutableArray array];
            int count = 0;
            for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >= 0; --i) {
                NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
                for (NSDictionary* banker in dic[@"bankers"]) {
                    if (banker[@"isMain"]) {
                        [bankers insertObject: banker atIndex: 0];
                    }
                }
                if (++count >= 14) {
                    break;
                }
            }
            [bankers addObject: banker];
            
            NSMutableArray* array = [NSMutableArray array];
            for (NSDictionary* dic in bankers) {
                NSString* powStr;
                if ([dic[@"resultHandle"] isEqualToString: @"overtime"]) {
                    powStr = @"超时";
                } else if ([dic[@"resultHandle"] isEqualToString: @"bankerHead"]) {
                    powStr = @"平赔";
                } else {
                    powStr = dic[@"pow"];
                }
                [array addObject: powStr];
            }
            
            //画线
            int i = 0;
            if ([array count] > 1) {
                UIGraphicsBeginImageContext(trend.frame.size);
                [trend.image drawInRect:CGRectMake(0, 0, trend.frame.size.width, trend.frame.size.height)];
                CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
                CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2);  //线宽
                CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 104.0/255, 23.0/255, 13.0/255, 1);  //颜色
                CGContextBeginPath(UIGraphicsGetCurrentContext());
                
                for (NSString* powStr in array) {
                    int pow = 0;
                    if ([ycFunction isInt: powStr]) {
                        pow = [powStr intValue];
                    }
                    if (i == 0) {
                        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 10+i*49+18, 10+(18-pow)*7+18);  //起点坐标
                    } else {
                        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 10+i*49+18, 10+(18-pow)*7+18);   //终点坐标
                    }
                    ++i;
                }
                
                CGContextStrokePath(UIGraphicsGetCurrentContext());
                trend.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
            }
            
            //画圆
            i = 0;
            for (NSString* powStr in array) {
                NSString* str;
                int pow = 0;
                if ([ycFunction isInt: powStr]) {
                    pow = [powStr intValue];
                    str = [niuniu pow2string: pow];
                } else {
                    str = powStr;
                }
                
                UIColor* color = i == [array count] - 1 ? color2 : color1;
                UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(10+i*49, 10+(18-pow)*7, 36, 36)];
                label.font = [UIFont boldSystemFontOfSize: 17];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = color;
                label.text = str;
                label.layer.masksToBounds = YES;
                label.layer.cornerRadius = label.bounds.size.width/2;
                [trend addSubview: label];
                [label release];
                
                int num = i+(tmanager.mRobot.mNumber-(int)[array count])+1;
                int ofs = num > 9999 ? (i%2)*3 : 0;
                UILabel* round = [[UILabel alloc] initWithFrame: CGRectMake(10+i*49-(50-36)/2, 177+ofs, 50, 20)];
                round.font = [UIFont boldSystemFontOfSize: num > 9999 ? 15 : 17];
                round.textAlignment = NSTextAlignmentCenter;
                round.textColor = color;
                round.text = deInt2String(num);
                [trend addSubview: round];
                [round release];
                
                ++i;
            }
        }
    } else {
        //标题
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: [UIColor blackColor]];
        {
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            
            UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(0, hCount, view.frame.size.width, titleh)];
            label.font = [UIFont boldSystemFontOfSize: 18];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.text = deString(@"[第%d期]　账单日期: %@", tmanager.mRobot.mNumber, [formatter stringFromDate:date]);
            [view addSubview: label];
            [label release];
        }
        hCount += titleh;
    }
    
    if ([data[@"bankerBonus"] intValue] > 0) {
        NSArray* array = @[
                           @[@375, @"庄家点数", banker[@"amount"]],
                           @[@375, @"奖励", data[@"bankerBonus"]],
                           ];
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
        int wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
            wCnt += w;
        }
        hCount += titleh;
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: textBgColor];
        wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[2] color: textColor isLeft:NO];
            label.layer.borderWidth = 1;
            label.layer.borderColor = [textColor CGColor];
            wCnt += w;
        }
        hCount += titleh;
    }
    
    if ([autoSeriesWinBonus count] > 0) {//连赢兑奖
        UIView* seriesWinView = [[UIView alloc] initWithFrame: CGRectMake(0, hCount, view.frame.size.width, 1000)];
        seriesWinView.backgroundColor = [UIColor clearColor];
        seriesWinView.layer.borderWidth = 3;
        seriesWinView.layer.borderColor = [color2 CGColor];
        [view addSubview: seriesWinView];
        [seriesWinView release];
        
        int hCountSeriesWin = 0;
        [self addLine:seriesWinView frame:CGRectMake(0, hCountSeriesWin, seriesWinView.frame.size.width, titleh) color: titleBgColor];
        [self addLabel: seriesWinView frame:CGRectMake(seriesWinView.frame.size.width/2-100, hCountSeriesWin, 200, titleh) text:@"[连赢自动兑奖]" color: titleColor isLeft:NO];
        hCountSeriesWin += titleh;
        
        NSMutableArray* autoSeriesWinBonusArray = [NSMutableArray arrayWithArray: [autoSeriesWinBonus allValues]];
        [autoSeriesWinBonusArray sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            return [a[@"winRound"] intValue] < [b[@"winRound"] intValue] ? 1 : -1;
        }];
        
        NSArray* array = @[
                           @[@120, @"闲家单名"],
                           @[@40, @"连赢"],
                           @[@250, @"下注记录"],
                           @[@80, @"最低下注"],
                           @[@80, @"奖励比例"],
                           @[@90, @"档位奖励"],
                           @[@90, @"实际奖励"],
                           ];
        [self addLine:seriesWinView frame:CGRectMake(0, hCountSeriesWin, seriesWinView.frame.size.width, titleh) color: titleBgColor];
        int wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            [self addLabel: seriesWinView frame:CGRectMake(wCnt, hCountSeriesWin, w, titleh) text:config[1] color: titleColor isLeft:NO];
            wCnt += w;
        }
        hCountSeriesWin += titleh;
        
        int index = 1;
        for (NSDictionary* dic in autoSeriesWinBonusArray) {
            NSString* name = @"";
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember:dic[@"userid"]];
            if (memData) {
                name = memData[@"billName"];
            }
            NSArray* nums = [[dic[@"nums"] reverseObjectEnumerator] allObjects];
            NSArray* values = @[
                                @[name],
                                @[dic[@"winRound"]],
                                @[[nums componentsJoinedByString:@"#"]],
                                @[dic[@"minBet"]],
                                @[deString(@"%.2f%%", [dic[@"ratio"] floatValue]*100)],
                                @[dic[@"bonus"]],
                                @[dic[@"bonusFact"]],
                                ];
            [self addLine:seriesWinView frame:CGRectMake(0, hCountSeriesWin, seriesWinView.frame.size.width, titleh) color: index%2==0?textBgColor2:textBgColor];
            wCnt = 0;
            for (int j = 0; j < [array count]; ++j) {
                NSArray* config = array[j];
                NSArray* value = values[j];
                UIColor* color = textColor;
                if ([value count] > 1) {
                    color = value[1];
                }
                int w = [config[0] intValue];
                UILabel* label = [self addLabel: seriesWinView frame:CGRectMake(wCnt, hCountSeriesWin, w, titleh) text:value[0] color: color isLeft:NO];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCountSeriesWin += titleh;
            
            ++index;
        }
        CGRect frame = seriesWinView.frame;
        frame.size = CGSizeMake(frame.size.width, hCountSeriesWin);
        seriesWinView.frame = frame;
        
        hCount += hCountSeriesWin;
    }
    
    {
        NSArray* array = @[
                           @[@175, @"庄家吃赔", deString(@"赢%@ 输%@ 平%@", data[@"winCount"], data[@"loseCount"], data[@"drawCount"])],
                           @[@115, @"盈利抽水", deInt2String([data[@"playerRatioTotal"] intValue]+[data[@"bankerRatioTotal"] intValue])],
                           @[@115, @"抢包支出", data[@"robPay"]],
                           @[@115, @"红包费用", data[@"hongbaoFee"]],
                           @[@115, @"奖池增加", data[@"bonusPoolFee"]],
                           @[@115, @"奖池累计", data[@"bonusPoolTotal"]],
                           ];
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
        int wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
            wCnt += w;
        }
        hCount += titleh;
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: textBgColor];
        wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[2] color: textColor isLeft:NO];
            label.layer.borderWidth = 1;
            label.layer.borderColor = [textColor CGColor];
            wCnt += w;
        }
        hCount += titleh;
        
    }
    
    {
        if (tmanager.mRobot.mEnableNiuniu) {
            //庄倍数
            NSString* powStr;
            UIColor* powColor = nil;
            if ([banker[@"resultHandle"] isEqualToString: @"overtime"]) {
                powStr = @"超时";
                powColor = textColorErr;
            } else if ([banker[@"resultHandle"] isEqualToString: @"bankerHead"]) {
                powStr = @"平赔";
                powColor = textColorErr;
            } else {
                powStr = deString(@"%@倍[%@]", banker[@"powFactBanker"], [niuniu pow2string: [banker[@"pow"] intValue]]);
                powColor = textColor;
            }
            
            //总下注
            int betCount = 0;
            betCount += (int)tmanager.mRobot.mBet.mBetScoreCount;
            betCount += (int)tmanager.mRobot.mBet.mBetScoreSuohaCount/10;
            betCount += (int)tmanager.mRobot.mBet.mBetScoreLonghuCount/10;
            betCount += (int)tmanager.mRobot.mBet.mBetScoreLonghuHeCount/10;
            betCount += (int)tmanager.mRobot.mBet.mBetScoreTemaCount/10;
            betCount += (int)tmanager.mRobot.mBet.mBetScoreBaijialeCount/10;
            
            NSString* betCountStr = deInt2String(betCount);
            NSArray* array = @[
                               @[@120, @"庄家单名", banker[@"billName"]],
                               @[@126, @"总下注", betCountStr],
                               @[@81, @"点数", deString(@"%.2f", [banker[@"amount"] floatValue]/100)],
                               @[@111, @"倍数", powStr, powColor],
                               @[@101, @"输赢", data[@"bankerOriginWinOrLose"], [data[@"bankerOriginWinOrLose"] intValue] < 0 ? textColorErr : textColor],
                               @[@106, @"庄上积分", data[@"origin_bankerMoney"]],
                               @[@106, @"剩余庄分", data[@"bankerMoney"]],
                               ];
            
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
            int wCnt = 0;
            for (NSArray* config in array) {
                int w = [config[0] intValue];
                [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
                wCnt += w;
            }
            hCount += titleh;
            
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: textBgColor];
            wCnt = 0;
            for (NSArray* config in array) {
                UIColor* color = textColor;
                if ([config count] > 3) {
                    color = config[3];
                }
                int w = [config[0] intValue];
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[2] color: color isLeft:NO];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
        } else {
            //庄名
            UIColor* bankerColor = textColor;
            NSString* bankerName = nil;
            if ([allBankers count] == 1) {
                bankerName = allBankers[0][@"billName"];
            } else if([allBankers count] > 1) {
                bankerName = @"[多人]";
                bankerColor = textColorSpecial;
            }
            if (bankerName) {
                NSArray* array = @[
                                   @[@155, @"庄家单名", bankerName, bankerColor],
                                   @[@297, @"庄上积分", data[@"origin_bankerMoney"]],
                                   @[@298, @"剩余庄分", data[@"bankerMoney"]],
                                   ];
                
                [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
                int wCnt = 0;
                for (NSArray* config in array) {
                    int w = [config[0] intValue];
                    [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
                    wCnt += w;
                }
                hCount += titleh;
                
                [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: textBgColor];
                wCnt = 0;
                for (NSArray* config in array) {
                    UIColor* color = textColor;
                    if ([config count] > 3) {
                        color = config[3];
                    }
                    int w = [config[0] intValue];
                    UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[2] color: color isLeft:NO];
                    label.layer.borderWidth = 1;
                    label.layer.borderColor = [textColor CGColor];
                    wCnt += w;
                }
                hCount += titleh;
            }
        }
    }
    
    //合庄模式
    if ([allBankers count] > 1) {
        NSArray* array = @[
                           @[@155, @"庄家单名"],
                           @[@119, @"庄费"],
                           @[@119, @"占比"],
                           @[@119, @"输赢"],
                           @[@119, @"上局积分"],
                           @[@119, @"剩余积分"],
                           ];
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
        int wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
            wCnt += w;
        }
        hCount += titleh;
        
        int index = 1;
        for (NSDictionary* dic in allBankers) {
            int score = [tmanager.mRobot.mMembers getMemberScore: dic[@"userid"]];
            int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
            NSArray* values = @[
                                @[deString(@"　%d. %@", index, dic[@"billName"])],
                                @[dic[@"num"]],
                                @[deString(@"%.2f％",  [dic[@"ratio"] floatValue]*100)],
                                @[deString(@"%@%d", winOrLoseFact >= 0 ? @"+" : @"", winOrLoseFact), winOrLoseFact < 0 ? textColorErr : textColor],
                                @[deInt2String(score)],
                                @[deInt2String(score+winOrLoseFact)],
                                ];
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: index%2==0?textBgColor2:textBgColor];
            wCnt = 0;
            for (int j = 0; j < [array count]; ++j) {
                NSArray* config = array[j];
                NSArray* value = values[j];
                UIColor* color = textColor;
                if ([value count] > 1) {
                    color = value[1];
                }
                int w = [config[0] intValue];
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:j == 0];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
            
            ++index;
        }
    }
    
    if([niuniuPlayers count] > 0){//牛牛结算
        NSArray* array = @[
                           @[@120, @"牛牛玩家"],
                           @[@40, @"连赢"],
                           @[@91, @"下注"],
                           @[@91, @"点数"],
                           @[@101, @"倍数"],
                           @[@95, @"输赢"],
                           @[@106, @"上局积分"],
                           @[@106, @"剩余积分"],
                           ];
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
        int wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
            wCnt += w;
        }
        hCount += titleh;
        
        //正常结算
        int index = 1;
        for (int i = (int)[niuniuPlayers count]-1; i >= 0; --i, ++index) {
            NSMutableDictionary* dic = niuniuPlayers[i];
            int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
            NSString* amountStr;
            UIColor* amountColor;
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {
                amountStr = deString(@"%.2f[尾]", [dic[@"amount"] floatValue]/100);
                amountColor = textColorWarr;
            } else if([dic[@"resultHandle"] isEqualToString:@"overtime"]){
                if (dic[@"amount"]) {
                    amountStr = deString(@"%.2f[超]", [dic[@"amount"] floatValue]/100);
                } else {
                    amountStr = @"无包[超]";
                }
                amountColor = textColorErr;
            } else if([dic[@"resultHandle"] isEqualToString:@"noWin"]){
                amountStr = @"无输赢";
                amountColor = textColorWarr;
            } else {
                amountStr = deString(@"%.2f", [dic[@"amount"] floatValue]/100);
                amountColor = textColor;
            }
            
            NSString* powStr;
            UIColor* powColor;
            if ([dic[@"amount"] intValue] == 1 && has001) {//001
                powStr = @"免死";
                powColor = textColorWarr;
            } else {
                if (dic[@"pow"]) {
                    powStr = deString(@"%@倍[%@]", [ycFunction formatFloatStr:dic[@"powFact"]], [niuniu pow2string: [dic[@"pow"] intValue]]);
                } else {
                    powStr = @"无";
                }
                powColor = textColor;
            }
            
            NSString* winOrLoseStr;
            UIColor* winOrLoseColor = textColor;
            if (dic[@"heshui"]) {
                if (winOrLoseFact > 0) {
                    NSString* mark = @"";
                    if (dic[@"heshuiSubsidy"]) {
                        mark = @"[补]";
                    }
                    winOrLoseStr = deString(@"+%d%@", winOrLoseFact, mark);
                } else {
                    winOrLoseStr = @"喝水";
                }
                winOrLoseColor = textColorWarr;
            } else if(winOrLoseFact >= 0) {
                NSString* mark = @"";
                if (dic[@"scoreLimit"]) {
                    mark = @"[限]";
                }
                winOrLoseStr = deString(@"+%d%@", winOrLoseFact, mark);
            } else {
                NSString* mark = @"";
                if (dic[@"scoreLimit"]) {
                    mark = @"[限]";
                }
                winOrLoseStr = deString(@"%d%@", winOrLoseFact, mark);
                winOrLoseColor = textColorErr;
            }
            
            int betNum =  [dic[@"num"] intValue];
            NSString* numStr = nil;
            UIColor* numColor = nil;
            if ([dic[@"suoha"] isEqualToString: @"true"]) {
                numStr = deString(@"梭%d", betNum);
                numColor = betNum >= [setting[@"hightBet"] intValue] ? textColorSpecial : textColor;
            } else {
                BOOL mianyong = [dic[@"mianyong"] isEqualToString: @"true"];
                BOOL yibi = [dic[@"yibi"] isEqualToString: @"true"];
                numStr = deString(@"%@%d", mianyong ? @"免" : yibi ? @"一比" : @"" ,betNum);
                numColor = betNum*10 >= [setting[@"hightBet"] intValue] ? textColorSpecial : textColor;
            }
            
            int score = [dic[@"score"] intValue];
            NSArray* values = @[
                                @[deString(@" %d. %@", index, dic[@"billName"])],
                                @[dic[@"seriesWin"], [dic[@"seriesWin"] intValue] >= 0 ? textColor : textColorErr],
                                @[numStr, numColor],
                                @[amountStr, amountColor],
                                @[powStr, powColor],
                                @[winOrLoseStr, winOrLoseColor],
                                @[deInt2String(score)],
                                @[deInt2String(score+winOrLoseFact)],
                                ];
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: index%2==0?textBgColor2:textBgColor];
            wCnt = 0;
            for (int j = 0; j < [array count]; ++j) {
                NSArray* config = array[j];
                NSArray* value = values[j];
                UIColor* color = textColor;
                if ([value count] > 1) {
                    color = value[1];
                }
                int w = [config[0] intValue];
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:j == 0];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
        }
    }
    
    if([longhuPlayers count] > 0){//龙虎结算
        NSArray* array = @[
                           @[@120, @"大小玩家"],
                           @[@40, @"连赢"],
                           @[@141, @"下注"],
                           @[@91, @"点数"],
                           @[@51, @"牌型"],
                           @[@95, @"输赢"],
                           @[@106, @"上局积分"],
                           @[@106, @"剩余积分"],
                           ];
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
        int wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
            wCnt += w;
        }
        hCount += titleh;
        
        //正常结算
        int index = 1;
        for (int i = (int)[longhuPlayers count]-1; i >= 0; --i, ++index) {
            NSMutableDictionary* dic = longhuPlayers[i];
            int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
            NSString* amountStr;
            UIColor* amountColor;
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {
                amountStr = deString(@"%.2f[尾]", [dic[@"amount"] floatValue]/100);
                amountColor = textColorWarr;
            } else if([dic[@"resultHandle"] isEqualToString:@"overtime"]){
                if (dic[@"amount"]) {
                    amountStr = deString(@"%.2f[超]", [dic[@"amount"] floatValue]/100);
                } else {
                    amountStr = @"无包[超]";
                }
                amountColor = textColorErr;
            } else if([dic[@"resultHandle"] isEqualToString:@"noWin"]){
                amountStr = @"无输赢";
                amountColor = textColorWarr;
            } else {
                amountStr = deString(@"%.2f", [dic[@"amount"] floatValue]/100);
                amountColor = textColor;
            }
            
            NSString* powStr;
            UIColor* powColor;
            if (dic[@"powType"]) {
                powStr = dic[@"powType"];
            } else {
                powStr = @"无";
            }
            powColor = textColor;
            
            NSString* winOrLoseStr = deString(@"%@%d", winOrLoseFact >= 0 ? @"+" : @"", winOrLoseFact);
            UIColor* winOrLoseColor = winOrLoseFact >= 0 ? textColor : textColorErr;
            
            int score = [dic[@"score"] intValue];
            NSArray* values = @[
                                @[deString(@" %d. %@", index, dic[@"billName"])],
                                @[dic[@"seriesWin"], [dic[@"seriesWin"] intValue] >= 0 ? textColor : textColorErr],
                                @[dic[@"valuesStr"], [dic[@"num"] intValue] >= [setting[@"hightBet"] intValue] ? textColorSpecial : textColor],
                                @[amountStr, amountColor],
                                @[powStr, powColor],
                                @[winOrLoseStr, winOrLoseColor],
                                @[deInt2String(score)],
                                @[deInt2String(score+winOrLoseFact)],
                                ];
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: index%2==0?textBgColor2:textBgColor];
            wCnt = 0;
            for (int j = 0; j < [array count]; ++j) {
                NSArray* config = array[j];
                NSArray* value = values[j];
                UIColor* color = textColor;
                if ([value count] > 1) {
                    color = value[1];
                }
                int w = [config[0] intValue];
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:j == 0];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                if (2 == j && [dic[@"values"] count] > 1) {
                    label.font = [UIFont boldSystemFontOfSize:14];
                }
                wCnt += w;
            }
            hCount += titleh;
        }
    }
    
    if([temaPlayers count] > 0){//特码结算
        NSArray* array = @[
                           @[@120, @"特码玩家"],
                           @[@40, @"连赢"],
                           @[@141, @"下注"],
                           @[@91, @"点数"],
                           @[@51, @"牌型"],
                           @[@95, @"输赢"],
                           @[@106, @"上局积分"],
                           @[@106, @"剩余积分"],
                           ];
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
        int wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
            wCnt += w;
        }
        hCount += titleh;
        
        //正常结算
        int index = 1;
        for (int i = (int)[temaPlayers count]-1; i >= 0; --i, ++index) {
            NSMutableDictionary* dic = temaPlayers[i];
            int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
            NSString* amountStr;
            UIColor* amountColor;
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {
                amountStr = deString(@"%.2f[尾]", [dic[@"amount"] floatValue]/100);
                amountColor = textColorWarr;
            } else if([dic[@"resultHandle"] isEqualToString:@"overtime"]){
                if (dic[@"amount"]) {
                    amountStr = deString(@"%.2f[超]", [dic[@"amount"] floatValue]/100);
                } else {
                    amountStr = @"无包[超]";
                }
                amountColor = textColorErr;
            } else if([dic[@"resultHandle"] isEqualToString:@"noWin"]){
                amountStr = @"无输赢";
                amountColor = textColorWarr;
            } else {
                amountStr = deString(@"%.2f", [dic[@"amount"] floatValue]/100);
                amountColor = textColor;
            }
            
            NSString* powStr;
            UIColor* powColor;
            if (dic[@"powType"]) {
                powStr = dic[@"powType"];
            } else {
                powStr = @"无";
            }
            powColor = textColor;
            
            NSString* winOrLoseStr = deString(@"%@%d", winOrLoseFact >= 0 ? @"+" : @"", winOrLoseFact);
            UIColor* winOrLoseColor = winOrLoseFact >= 0 ? textColor : textColorErr;
            
            int score = [dic[@"score"] intValue];
            NSArray* values = @[
                                @[deString(@" %d. %@", index, dic[@"billName"])],
                                @[dic[@"seriesWin"], [dic[@"seriesWin"] intValue] >= 0 ? textColor : textColorErr],
                                @[dic[@"valuesStr"], [dic[@"num"] intValue] >= [setting[@"hightBet"] intValue] ? textColorSpecial : textColor],
                                @[amountStr, amountColor],
                                @[powStr, powColor],
                                @[winOrLoseStr, winOrLoseColor],
                                @[deInt2String(score)],
                                @[deInt2String(score+winOrLoseFact)],
                                ];
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: index%2==0?textBgColor2:textBgColor];
            wCnt = 0;
            for (int j = 0; j < [array count]; ++j) {
                NSArray* config = array[j];
                NSArray* value = values[j];
                UIColor* color = textColor;
                if ([value count] > 1) {
                    color = value[1];
                }
                int w = [config[0] intValue];
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:j == 0];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                if (2 == j && [dic[@"values"] count] > 1) {
                    label.font = [UIFont boldSystemFontOfSize:14];
                }
                wCnt += w;
            }
            hCount += titleh;
        }
    }
    
    if([baijialePlayers count] > 0){//百家乐结算
        NSArray* array = @[
                           @[@120, @"百家乐玩家"],
                           @[@40, @"连赢"],
                           @[@141, @"下注"],
                           @[@91, @"点数"],
                           @[@51, @"结果"],
                           @[@95, @"输赢"],
                           @[@106, @"上局积分"],
                           @[@106, @"剩余积分"],
                           ];
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
        int wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
            wCnt += w;
        }
        hCount += titleh;
        
        //正常结算
        int index = 1;
        for (int i = (int)[baijialePlayers count]-1; i >= 0; --i, ++index) {
            NSMutableDictionary* dic = baijialePlayers[i];
            int winOrLoseFact = [dic[@"winOrLoseFact"] intValue];
            NSString* amountStr;
            UIColor* amountColor;
            if ([dic[@"resultHandle"] isEqualToString:@"asLast"]) {
                amountStr = deString(@"%.2f[尾]", [dic[@"amount"] floatValue]/100);
                amountColor = textColorWarr;
            } else if([dic[@"resultHandle"] isEqualToString:@"overtime"]){
                if (dic[@"amount"]) {
                    amountStr = deString(@"%.2f[超]", [dic[@"amount"] floatValue]/100);
                } else {
                    amountStr = @"无包[超]";
                }
                amountColor = textColorErr;
            } else if([dic[@"resultHandle"] isEqualToString:@"noWin"]){
                amountStr = @"无输赢";
                amountColor = textColorWarr;
            } else {
                amountStr = deString(@"%.2f", [dic[@"amount"] floatValue]/100);
                amountColor = textColor;
            }
            
            NSString* powStr;
            UIColor* powColor;
            if (dic[@"powType"]) {
                powStr = dic[@"powType"];
            } else {
                powStr = @"无";
            }
            powColor = textColor;
            
            NSString* winOrLoseStr = deString(@"%@%d", winOrLoseFact >= 0 ? @"+" : @"", winOrLoseFact);
            UIColor* winOrLoseColor = winOrLoseFact >= 0 ? textColor : textColorErr;
            
            int score = [dic[@"score"] intValue];
            NSArray* values = @[
                                @[deString(@" %d. %@", index, dic[@"billName"])],
                                @[dic[@"seriesWin"], [dic[@"seriesWin"] intValue] >= 0 ? textColor : textColorErr],
                                @[dic[@"valuesStr"], [dic[@"num"] intValue] >= [setting[@"hightBet"] intValue] ? textColorSpecial : textColor],
                                @[amountStr, amountColor],
                                @[powStr, powColor],
                                @[winOrLoseStr, winOrLoseColor],
                                @[deInt2String(score)],
                                @[deInt2String(score+winOrLoseFact)],
                                ];
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: index%2==0?textBgColor2:textBgColor];
            wCnt = 0;
            for (int j = 0; j < [array count]; ++j) {
                NSArray* config = array[j];
                NSArray* value = values[j];
                UIColor* color = textColor;
                if ([value count] > 1) {
                    color = value[1];
                }
                int w = [config[0] intValue];
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:j == 0];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
        }
    }
    
    //抢包
    {
        int index = 0;
        NSArray* array = @[
                           @[@155, @"抢包玩家"],
                           @[@70, @"点数"],
                           @[@90, @"扣分"],
                           @[@105, @"剩余积分"],
                           @[@135, @"被抢玩家"],
                           @[@90, @"加分"],
                           @[@105, @"剩余积分"],
                           ];
        if ([allRobs count] > 0) {
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
            int wCnt = 0;
            for (NSArray* config in array) {
                int w = [config[0] intValue];
                [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
                wCnt += w;
            }
            hCount += titleh;
        }
        
        for (int i = (int)[allRobs count]-1; i >= 0; --i) {
            NSMutableArray* values = [[@[
                                         @[@"", textColor],
                                         @[@"", textColor],
                                         @[@"0", textColor],
                                         @[@"无会员", textColorErr],
                                         @[@"", textColor],
                                         @[@"", textColor],
                                         @[@"", textColor],
                                         ] mutableCopy] autorelease];
            int score = 0;
            NSMutableDictionary* dic = allRobs[i];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
            if (memData) {
                score = [memData[@"score"] intValue];
            }
            if ([dic[@"robTarget"] isEqualToString: @"banker"]) {
                int downScore = 0;
                if (memData && dic[@"robDown"]) {
                    downScore = [dic[@"robDown"] intValue];
                }
                values[0] = @[dic[@"billName"] ? dic[@"billName"] : dic[@"name"] ? dic[@"name"] : @"", textColor];
                if (dic[@"amount"]) {
                    values[1] = @[deString(@"%.2f", [dic[@"amount"] floatValue]/100), textColor];
                }
                values[2] = @[deInt2String(downScore), textColor];
                if (memData) {
                    values[3] = @[deInt2String(MAX(0, score-downScore)), textColor];
                }
                downScore = 0;
                if (banker[@"coverRobUp"]) {
                    downScore = [banker[@"coverRobUp"] intValue];
                }
                int winOrLoseFact = [banker[@"winOrLoseFact"] intValue];
                values[4] = @[deString(@"%@[庄家]", banker[@"billName"]), textColorSpecial];
                values[5] = @[deInt2String(downScore), textColor];
                values[6] = @[deInt2String(MAX(0, winOrLoseFact+[tmanager.mRobot.mMembers getMemberScore: banker[@"userid"]])+downScore), textColor];
            }
            else if ([dic[@"robTarget"] isEqualToString: @"player"]) {
                int downScore = 0;
                if (memData && dic[@"robDown"]) {
                    downScore = [dic[@"robDown"] intValue];
                }
                values[0] = @[dic[@"billName"] ? dic[@"billName"] : dic[@"name"] ? dic[@"name"] : @"", textColor];
                if (dic[@"amount"]) {
                    values[1] = @[deString(@"%.2f", [dic[@"amount"] floatValue]/100), textColor];
                }
                values[2] = @[deInt2String(downScore), textColor];
                if (memData) {
                    values[3] = @[deInt2String(MAX(0, score-downScore)), textColor];
                }
                
                NSMutableDictionary* coverPlayerDic = nil;
                for (NSMutableDictionary* tmp in allPlayers) {
                    if ([tmp[@"userid"] isEqualToString: dic[@"coverRobUserid"]]) {
                        coverPlayerDic = tmp;
                        break;
                    }
                }
                
                if (coverPlayerDic) {
                    NSDictionary* coverMemData = [tmanager.mRobot.mMembers getMember: coverPlayerDic[@"userid"]];
                    if (coverMemData) {
                        downScore = 0;
                        if (coverPlayerDic[@"coverRobUp"]) {
                            downScore = [coverPlayerDic[@"coverRobUp"] intValue];
                        }
                        int winOrLoseFact = [coverPlayerDic[@"winOrLoseFact"] intValue];
                        values[4] = @[coverPlayerDic[@"billName"], textColor];
                        values[5] = @[deInt2String(downScore), textColor];
                        values[6] = @[deInt2String(MAX(0, winOrLoseFact+[coverMemData[@"score"] intValue])+downScore), textColor];
                    }
                }
            }
            else if ([dic[@"robTarget"] isEqualToString: @"valid"]) {
                int downScore = 0;
                if (dic[@"robDown"] && memData) {
                    downScore = [dic[@"robDown"] intValue];
                }
                values[0] = @[dic[@"billName"] ? dic[@"billName"] : dic[@"name"] ? dic[@"name"] : @"", textColor];
                if (dic[@"amount"]) {
                    values[1] = @[deString(@"%.2f", [dic[@"amount"] floatValue]/100), textColor];
                }
                values[2] = @[deInt2String(downScore), textColor];
                if (memData) {
                    values[3] = @[deInt2String(MAX(0, score)), textColor];
                }
            }
            else if ([dic[@"robTarget"] isEqualToString: @"overtime"]) {
                values[0] = @[dic[@"billName"] ? dic[@"billName"] : dic[@"name"] ? dic[@"name"] : @"", textColor];
                if (dic[@"amount"]) {
                    values[1] = @[deString(@"%.2f", [dic[@"amount"] floatValue]/100), textColor];
                }
                values[2] = @[@"超时包", textColorErr];
                if (memData) {
                    values[3] = @[deInt2String(MAX(0, score)), textColor];
                }
            }
            
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: index%2==0?textBgColor2:textBgColor];
            int wCnt = 0;
            for (int j = 0; j < [array count]; ++j) {
                NSArray* config = array[j];
                NSArray* value = values[j];
                UIColor* color =  value[1];
                int w = [config[0] intValue];
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft: NO];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
            index++;
        }
    }
    
    {
        NSString* headStr, *lastStr, *bankerStr, *lastPowStr;
        {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:tmanager.mRobot.mResult.mMinSecond];
            NSDateFormatter *objDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [objDateformat setDateFormat:@"HH:mm:ss"];
            headStr = deString(@"%@", [objDateformat stringFromDate: date]);
        }{
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:tmanager.mRobot.mResult.mMaxSecond];
            NSDateFormatter *objDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [objDateformat setDateFormat:@"HH:mm:ss"];
            lastStr = deString(@"%@ %lld秒", [objDateformat stringFromDate: date], tmanager.mRobot.mResult.mMaxSecond-tmanager.mRobot.mResult.mMinSecond);
        }
        if(tmanager.mRobot.mEnableNiuniu){
            long long time;
            if (banker[@"receiveTime"]) {//自己有包
                time = [banker[@"receiveTime"] longLongValue];
            } else {//尾包
                time = tmanager.mRobot.mResult.mMaxSecond;
            }
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
            NSDateFormatter *objDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [objDateformat setDateFormat:@"HH:mm:ss"];
            bankerStr = deString(@"%@ %lld秒", [objDateformat stringFromDate: date], time-tmanager.mRobot.mResult.mMinSecond);
        }{
            if ([tmanager.mRobot.mResult.mLastAmounts count] > 0) {
                lastPowStr = deString(@"%.2f", [tmanager.mRobot.mResult.mLastAmounts[0] floatValue]/100);
            } else {
                lastPowStr = @"";
            }
        }
        
        NSArray* array = nil;
        if (tmanager.mRobot.mEnableNiuniu) {
            array = @[
                      @[@187, @"头包时间", headStr],
                      @[@188, @"庄包时间", bankerStr],
                      @[@187, @"尾包时间", lastStr],
                      @[@188, @"尾包点数", lastPowStr],
                      ];
        } else {
            array = @[
                      @[@250, @"头包时间", headStr],
                      @[@250, @"尾包时间", lastStr],
                      @[@250, @"尾包点数", lastPowStr],
                      ];
        }
        
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
        int wCnt = 0;
        for (NSArray* config in array) {
            int w = [config[0] intValue];
            [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
            wCnt += w;
        }
        hCount += titleh;
        
        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: textBgColor];
        wCnt = 0;
        for (NSArray* config in array) {
            UIColor* color = textColor;
            if ([config count] > 3) {
                color = config[3];
            }
            int w = [config[0] intValue];
            UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[2] color: color isLeft:NO];
            label.layer.borderWidth = 1;
            label.layer.borderColor = [textColor CGColor];
            wCnt += w;
        }
        hCount += titleh;
    }
    
    CGRect frame = view.frame;
    frame.size = CGSizeMake(frame.size.width, hCount);
    view.frame = frame;
    
    return view;
}

@end
