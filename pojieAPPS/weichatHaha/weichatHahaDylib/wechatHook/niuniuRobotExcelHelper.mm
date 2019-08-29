//
//  niuniuRobotExcelHelper.m
//  wechatHook
//
//  Created by antion on 2017/10/30.
//
//

#import "niuniuRobotExcelHelper.h"
#import "toolManager.h"
#import "ycFunction.h"

#include "xlslib.h"
using namespace xlslib_core;
using namespace std;
#define deTmpFileName @"excelHelperTmp000"

@implementation niuniuRobotExcelHelper

+(NSData*) book2data:(workbook*)wb {
    NSString* path = [NSString stringWithFormat: @"%@/%@", [ycFunction getCachesDirectory], deTmpFileName];
    wb->Dump([path UTF8String]);
    return [NSData dataWithContentsOfFile: path];
}

//生成积分榜
+(NSData*) makeScoreTop {
    workbook wb;
    worksheet* ws = wb.sheet("积分榜");
    
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString* timeStr = [objDateformat stringFromDate: [NSDate date]];
    
    
    int scoreCount = 0;
    NSMutableArray* memList = [NSMutableArray array];
    NSMutableArray* array = [NSMutableArray arrayWithArray: [tmanager.mRobot.mData.mMemberList allValues]];
    for (NSDictionary* dic in array) {
        int score = [dic[@"score"] intValue];
        if (score > 0) {
            scoreCount += score;
            [memList addObject: dic];
        }
    }

    [memList sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"score"] intValue] > [b[@"score"] intValue] ? -1 : 1;
    }];
    
    int linePlayerNum = [tmanager.mRobot.mData.mBaseSetting[@"autoSendTopExcelLineNum"] intValue];
    int colMax = linePlayerNum*4-1;
    
    range* _range;
    int index = 0;
    
    ws->label(index, 0, [@"日期" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [timeStr UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, colMax);
    _range = ws->rangegroup(index,0,index,colMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"总人数" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [deInt2String((int)[memList count]) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, colMax);
    _range = ws->rangegroup(index,0,index,colMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"总积分" UTF8String])->fontcolor(CLR_WHITE);;
    ws->label(index, 2, [deInt2String(scoreCount) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, colMax);
    _range = ws->rangegroup(index,0,index,colMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    int beginIndex = index;
    for (int i = 0; i < linePlayerNum; ++i) {
        ws->colwidth(i*4+0, 1200);
        ws->colwidth(i*4+1, 1500);
        ws->colwidth(i*4+2, 2000);
        ws->colwidth(i*4+3, 2500);
        ws->label(index, i*4+0, "序号");
        ws->label(index, i*4+1, "编号");
        ws->label(index, i*4+2, "单名");
        ws->label(index, i*4+3, "积分");
    }
    _range = ws->rangegroup(index,0,index,colMax);
    _range->cellcolor(CLR_ORANGE);
    
    for (int i = 0; i < [memList count]; ++i) {
        if (i % linePlayerNum == 0) {
            ++index;
        }
        NSDictionary* dic = memList[i];
        ws->label(index, (i%linePlayerNum)*4+0, [deInt2String(i+1) UTF8String]);
        ws->label(index, (i%linePlayerNum)*4+1, [dic[@"index"] UTF8String]);
        ws->label(index, (i%linePlayerNum)*4+2, [dic[@"billName"] UTF8String]);
        ws->label(index, (i%linePlayerNum)*4+3, [dic[@"score"] UTF8String]);
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, colMax);
    _range->halign(HALIGN_CENTER);
    return [self book2data: &wb];
}

//导出所有数据
+(NSData*) makeAllData: (NSMutableDictionary*)allPlayerData {
    workbook wb;
    worksheet* ws1 = wb.sheet("玩家");
    worksheet* ws2 = wb.sheet("托");
    worksheet* ws3 = wb.sheet("拉手");
    worksheet* ws4 = wb.sheet("拉手团");
    
    NSMutableArray* players = [NSMutableArray array];
    NSMutableArray* tuos = [NSMutableArray array];
    NSMutableArray* lashous = [tmanager.mRobot.mLashous getAllLashouDetail];
    NSMutableArray* lashouHeads = [tmanager.mRobot.mLashouHeads getAllLashouHeadDetail];
    
    NSArray* allPlayerDataArray = [allPlayerData allValues];
    for (NSDictionary* dic in allPlayerDataArray) {
        NSString* userid = dic[@"userid"];
        if ([tmanager.mRobot.mTuos isTuo: userid]) {
            [tuos addObject: dic];
        } else {
            [players addObject: dic];
        }
        for (NSMutableDictionary* lashou in lashous) {
            if ([tmanager.mRobot.mLashous isFromlashou:lashou[@"userid"] player: userid]) {
                if (!lashou[@"_players"]) {
                    lashou[@"_players"] = [NSMutableArray array];
                }
                [lashou[@"_players"] addObject: dic];
                break;
            }
        }
    }
    
    [players sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"allWinOrLose"] intValue] > [b[@"allWinOrLose"] intValue] ? -1 : 1;
    }];
    
    [tuos sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"allWinOrLose"] intValue] > [b[@"allWinOrLose"] intValue] ? -1 : 1;
    }];
    
    
    [self fillPlayerBet: players worksheet: ws1 index: 0 lashou: nil];
    [self fillPlayerBet: tuos worksheet: ws2 index: 0 lashou: nil];
    
    NSLog(@"lashous: %d", [lashous count]);
    
    for (int i = 0; i < [lashous count]; ) {
        NSMutableDictionary* lashou = lashous[i];
        if (!lashou[@"_players"]) {
            [lashous removeObjectAtIndex: i];
        } else {
            i++;
            int allRoundCount = 0;
            int allRobCount = 0;
            int allBetCount = 0;
            int allBetCountNiuniu = 0;
            int allBetCountMianyong = 0;
            int allBetCountYibi = 0;
            int allBetCountSuoha = 0;
            int allBetCountDaxiao = 0;
            int allBetCountTema = 0;
            int allBetCountBaijiale = 0;
            int allTotalBet = 0;
            int allRatioCount = 0;
            for (NSDictionary* dic in lashou[@"_players"]) {
                allRoundCount += [dic[@"roundCount"] intValue];
                allRobCount += [dic[@"robCount"] intValue];
                allBetCount += [dic[@"betCount"] intValue];
                allBetCountNiuniu += [dic[@"betCountNiuniu"] intValue];
                allBetCountMianyong += [dic[@"betCountMianyong"] intValue];
                allBetCountYibi += [dic[@"betCountYibi"] intValue];
                allBetCountSuoha += [dic[@"betCountSuoha"] intValue];
                allBetCountDaxiao += [dic[@"betCountDaxiao"] intValue];
                allBetCountTema += [dic[@"betCountTema"] intValue];
                allBetCountBaijiale += [dic[@"betCountBaijiale"] intValue];
                allTotalBet += [dic[@"totalBet"] intValue];
                allRatioCount += [dic[@"ratioCount"] intValue];
            }
            lashou[@"allRoundCount"] = deInt2String(allRoundCount);
            lashou[@"allRobCount"] = deInt2String(allRobCount);
            lashou[@"allBetCount"] = deInt2String(allBetCount);
            lashou[@"allBetCountNiuniu"] = deInt2String(allBetCountNiuniu);
            lashou[@"allBetCountMianyong"] = deInt2String(allBetCountMianyong);
            lashou[@"allBetCountYibi"] = deInt2String(allBetCountYibi);
            lashou[@"allBetCountSuoha"] = deInt2String(allBetCountSuoha);
            lashou[@"allBetCountDaxiao"] = deInt2String(allBetCountDaxiao);
            lashou[@"allBetCountTema"] = deInt2String(allBetCountTema);
            lashou[@"allBetCountBaijiale"] = deInt2String(allBetCountBaijiale);
            lashou[@"allTotalBet"] = deInt2String(allTotalBet);
            lashou[@"allRatioCount"] = deInt2String(allRatioCount);
        }
    }
    
    [lashous sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"allTotalBet"] intValue] > [b[@"allTotalBet"] intValue] ? -1 : 1;
    }];
    
    for (NSMutableDictionary* lashou in lashous) {
        for (NSMutableDictionary* lashouHead in lashouHeads) {
            if ([tmanager.mRobot.mLashouHeads isFromlashouHead:lashouHead[@"userid"] lashou:lashou[@"userid"]]) {
                if (!lashouHead[@"_lashous"]) {
                    lashouHead[@"_lashous"] = [NSMutableArray array];
                }
                [lashouHead[@"_lashous"] addObject: lashou];
                lashou[@"hasLashouHead"] = @"true";
                break;
            }
        }
    }
    
    for (int i = 0; i < [lashouHeads count]; ) {
        NSMutableDictionary* lashouHead = lashouHeads[i];
        if (!lashouHead[@"_lashous"]) {
            [lashouHeads removeObjectAtIndex: i];
        } else {
            i++;
            int allRoundCount = 0;
            int allRobCount = 0;
            int allBetCount = 0;
            int allBetCountNiuniu = 0;
            int allBetCountMianyong = 0;
            int allBetCountYibi = 0;
            int allBetCountSuoha = 0;
            int allBetCountDaxiao = 0;
            int allBetCountTema = 0;
            int allBetCountBaijiale = 0;
            int allTotalBet = 0;
            int allRatioCount = 0;
            for (NSDictionary* dic in lashouHead[@"_lashous"]) {
                allRoundCount += [dic[@"allRoundCount"] intValue];
                allRobCount += [dic[@"allRobCount"] intValue];
                allBetCount += [dic[@"allBetCount"] intValue];
                allBetCountNiuniu += [dic[@"betCountNiuniu"] intValue];
                allBetCountMianyong += [dic[@"betCountMianyong"] intValue];
                allBetCountYibi += [dic[@"betCountYibi"] intValue];
                allBetCountSuoha += [dic[@"allBetCountSuoha"] intValue];
                allBetCountDaxiao += [dic[@"allBetCountDaxiao"] intValue];
                allBetCountTema += [dic[@"allBetCountTema"] intValue];
                allBetCountBaijiale += [dic[@"allBetCountBaijiale"] intValue];
                allTotalBet += [dic[@"allTotalBet"] intValue];
                allRatioCount += [dic[@"allRatioCount"] intValue];
            }
            lashouHead[@"allRoundCount"] = deInt2String(allRoundCount);
            lashouHead[@"allRobCount"] = deInt2String(allRobCount);
            lashouHead[@"allBetCount"] = deInt2String(allBetCount);
            lashouHead[@"allBetCountNiuniu"] = deInt2String(allBetCountNiuniu);
            lashouHead[@"allBetCountMianyong"] = deInt2String(allBetCountMianyong);
            lashouHead[@"allBetCountYibi"] = deInt2String(allBetCountYibi);
            lashouHead[@"allBetCountSuoha"] = deInt2String(allBetCountSuoha);
            lashouHead[@"allBetCountDaxiao"] = deInt2String(allBetCountDaxiao);
            lashouHead[@"allBetCountTema"] = deInt2String(allBetCountTema);
            lashouHead[@"allBetCountBaijiale"] = deInt2String(allBetCountBaijiale);
            lashouHead[@"allTotalBet"] = deInt2String(allTotalBet);
            lashouHead[@"allRatioCount"] = deInt2String(allRatioCount);
        }
    }
    
    int index = 0;
    for (NSDictionary* lashou in lashous) {
        if (lashou[@"hasLashouHead"] && [lashou[@"hasLashouHead"] isEqualToString: @"true"]) {
            continue;
        }
        int oldIndex = index;
        {
            ws3->label(index, 0, "拉手编号:")->fontcolor(CLR_WHITE);
            if (lashou[@"index"]) {
                ws3->label(index, 2, [lashou[@"index"] UTF8String])->fontcolor(CLR_WHITE);
            }
            ws3->label(index, 4, "微信:")->fontcolor(CLR_WHITE);
            ws3->label(index, 5, [lashou[@"userid"] UTF8String])->fontcolor(CLR_WHITE);
            ws3->merge(index, 0, index, 1);
            ws3->merge(index, 2, index, 3);
            ws3->merge(index, 5, index, 14);
            ++index;
        }{
            ws3->label(index, 0, "拉手单名:")->fontcolor(CLR_WHITE);
            if (lashou[@"billName"]) {
                ws3->label(index, 2, [lashou[@"billName"] UTF8String])->fontcolor(CLR_WHITE);
            }
            ws3->label(index, 4, "昵称:")->fontcolor(CLR_WHITE);
            if (lashou[@"name"]) {
                ws3->label(index, 5, [lashou[@"name"] UTF8String])->fontcolor(CLR_WHITE);
            }
            ws3->merge(index, 0, index, 1);
            ws3->merge(index, 2, index, 3);
            ws3->merge(index, 5, index, 14);
            ++index;
        }{
            ws3->label(index, 0, "玩家人数:")->fontcolor(CLR_WHITE);
            ws3->label(index, 2, [lashou[@"count"] UTF8String])->fontcolor(CLR_WHITE);
            ws3->label(index, 4, "总局数:")->fontcolor(CLR_WHITE);
            ws3->label(index, 5, [lashou[@"allRoundCount"] UTF8String])->fontcolor(CLR_WHITE);
            ws3->merge(index, 0, index, 1);
            ws3->merge(index, 2, index, 3);
            ws3->merge(index, 5, index, 14);
            ++index;
        }{
            ws3->label(index, 0, "牛牛下注:")->fontcolor(CLR_WHITE);
            ws3->label(index, 2, [lashou[@"allBetCount"] UTF8String])->fontcolor(CLR_WHITE);
            ws3->label(index, 4, "牛牛梭哈:")->fontcolor(CLR_WHITE);
            ws3->label(index, 5, [lashou[@"allBetCountSuoha"] UTF8String])->fontcolor(CLR_WHITE);
            ws3->merge(index, 0, index, 1);
            ws3->merge(index, 2, index, 3);
            ws3->merge(index, 5, index, 14);
            ++index;
        }{
            ws3->label(index, 0, "大小下注:")->fontcolor(CLR_WHITE);
            ws3->label(index, 2, [lashou[@"allBetCountDaxiao"] UTF8String])->fontcolor(CLR_WHITE);
            ws3->label(index, 4, "特码下注:")->fontcolor(CLR_WHITE);
            ws3->label(index, 5, [lashou[@"allBetCountTema"] UTF8String])->fontcolor(CLR_WHITE);
            ws3->merge(index, 0, index, 1);
            ws3->merge(index, 2, index, 3);
            ws3->merge(index, 5, index, 14);
            ++index;
        }{
            ws3->label(index, 0, "百家乐下注:")->fontcolor(CLR_WHITE);
            ws3->label(index, 2, [lashou[@"allBetCountBaijiale"] UTF8String])->fontcolor(CLR_WHITE);
            ws3->label(index, 4, "总下注:")->fontcolor(CLR_WHITE);
            ws3->label(index, 5, [lashou[@"allTotalBet"] UTF8String])->fontcolor(CLR_WHITE);
            ws3->merge(index, 0, index, 1);
            ws3->merge(index, 2, index, 3);
            ws3->merge(index, 5, index, 14);
            range* _range = ws3->rangegroup(oldIndex, 0, index, 14);
            _range->cellcolor(CLR_BLACK);
            ++index;
        }
        index = [self fillPlayerBet:lashou[@"_players"] worksheet:ws3 index:index lashou: nil];
        index += 2;
    }
    if (0 == index) {
        range* _range;
        ws3->label(0, 0, "无记录")->fontcolor(CLR_WHITE);
        ws3->merge(0, 0, 0, 1);
        _range = ws3->rangegroup(0,0,0,1);
        _range->cellcolor(CLR_BLACK);
    }
    
    index = 0;
    for (NSDictionary* lashouHead in lashouHeads) {
        int oldIndex = index;
        {
            ws4->label(index, 0, "团长编号:")->fontcolor(CLR_WHITE);
            if (lashouHead[@"index"]) {
                ws4->label(index, 2, [lashouHead[@"index"] UTF8String])->fontcolor(CLR_WHITE);
            }
            ws4->label(index, 4, "微信:")->fontcolor(CLR_WHITE);
            ws4->label(index, 5, [lashouHead[@"userid"] UTF8String])->fontcolor(CLR_WHITE);
            ws4->merge(index, 0, index, 1);
            ws4->merge(index, 2, index, 3);
            ws4->merge(index, 5, index, 17);
            ++index;
        }{
            ws4->label(index, 0, "团长单名:")->fontcolor(CLR_WHITE);
            if (lashouHead[@"billName"]) {
                ws4->label(index, 2, [lashouHead[@"billName"] UTF8String])->fontcolor(CLR_WHITE);
            }
            ws4->label(index, 4, "昵称:")->fontcolor(CLR_WHITE);
            if (lashouHead[@"name"]) {
                ws4->label(index, 5, [lashouHead[@"name"] UTF8String])->fontcolor(CLR_WHITE);
            }
            ws4->merge(index, 0, index, 1);
            ws4->merge(index, 2, index, 3);
            ws4->merge(index, 5, index, 17);
            ++index;
        }{
            ws4->label(index, 0, "拉手人数:")->fontcolor(CLR_WHITE);
            ws4->label(index, 2, [lashouHead[@"count"] UTF8String])->fontcolor(CLR_WHITE);
            ws4->label(index, 4, "总局数:")->fontcolor(CLR_WHITE);
            ws4->label(index, 5, [lashouHead[@"allRoundCount"] UTF8String])->fontcolor(CLR_WHITE);
            ws4->merge(index, 0, index, 1);
            ws4->merge(index, 2, index, 3);
            ws4->merge(index, 5, index, 17);
            ++index;
        }{
            ws4->label(index, 0, "牛牛下注:")->fontcolor(CLR_WHITE);
            ws4->label(index, 2, [lashouHead[@"allBetCount"] UTF8String])->fontcolor(CLR_WHITE);
            ws4->label(index, 4, "牛牛梭哈:")->fontcolor(CLR_WHITE);
            ws4->label(index, 5, [lashouHead[@"allBetCountSuoha"] UTF8String])->fontcolor(CLR_WHITE);
            ws4->merge(index, 0, index, 1);
            ws4->merge(index, 2, index, 3);
            ws4->merge(index, 5, index, 17);
            ++index;
        }{
            ws4->label(index, 0, "大小下注:")->fontcolor(CLR_WHITE);
            ws4->label(index, 2, [lashouHead[@"allBetCountDaxiao"] UTF8String])->fontcolor(CLR_WHITE);
            ws4->label(index, 4, "特码下注:")->fontcolor(CLR_WHITE);
            ws4->label(index, 5, [lashouHead[@"allBetCountTema"] UTF8String])->fontcolor(CLR_WHITE);
            ws4->merge(index, 0, index, 1);
            ws4->merge(index, 2, index, 3);
            ws4->merge(index, 5, index, 17);
            ++index;
        }{
            ws4->label(index, 0, "百家乐下注:")->fontcolor(CLR_WHITE);
            ws4->label(index, 2, [lashouHead[@"allBetCountBaijiale"] UTF8String])->fontcolor(CLR_WHITE);
            ws4->label(index, 4, "总下注:")->fontcolor(CLR_WHITE);
            ws4->label(index, 5, [lashouHead[@"allTotalBet"] UTF8String])->fontcolor(CLR_WHITE);
            ws4->merge(index, 0, index, 1);
            ws4->merge(index, 2, index, 3);
            ws4->merge(index, 5, index, 17);
            range* _range = ws4->rangegroup(oldIndex, 0, index, 17);
            _range->cellcolor(CLR_BLACK);
            ++index;
        }
        for (NSDictionary* lashou in lashouHead[@"_lashous"]) {
            index = [self fillPlayerBet:lashou[@"_players"] worksheet:ws4 index:index lashou: lashou];
        }
        index += 2;
    }
    if (0 == index) {
        range* _range;
        ws4->label(0, 0, "无记录")->fontcolor(CLR_WHITE);
        ws4->merge(0, 0, 0, 1);
        _range = ws4->rangegroup(0,0,0,1);
        _range->cellcolor(CLR_BLACK);
    }
    
    return [self book2data: &wb];
}

+(int) fillPlayerBet: (NSArray*)list worksheet:(worksheet*)ws index:(int)index lashou:(NSDictionary*)lashou {
    int beginIndex = index;
    NSMutableArray* configs = [[@[
                         @[@"序号", @1200, @"i"],
                         @[@"玩家编号", @2000, @"index"],
                         @[@"玩家单名", @2000, @"billName"],
                         @[@"总上分", @2000, @"_key", @"upScoreCount"],
                         @[@"总下分", @2000, @"_key", @"downScoreCount"],
                         @[@"总输赢", @2000, @"_key", @"allWinOrLose"],
                         @[@"累计抽水", @2000, @"_key", @"ratioCount"],
                         @[@"局数", @1200, @"_key", @"roundCount"],
                         @[@"总下注", @2500, @"_key", @"totalBet"],
                         @[@"平均下注", @2000, @"_key", @"averageBet"],
                         @[@"牛牛下注", @2000, @"_key", @"betCountNiuniu"],
                         @[@"免佣下注", @2000, @"_key", @"betCountMianyong"],
                         @[@"一比下注", @2000, @"_key", @"betCountYibi"],
                         @[@"牛牛梭哈", @2000, @"_key", @"betCountSuoha"],
                         @[@"大小下注", @2000, @"_key", @"betCountDaxiao"],
                         @[@"特码下注", @2000, @"_key", @"betCountTema"],
                         @[@"百家乐下注", @2000, @"_key", @"betCountBaijiale"],
                         @[@"最高15把下注记录", @25000, @"max15"],
                         ] mutableCopy] autorelease];
    
    if (lashou) {
        [configs insertObject:@[@"拉手编号", @2000, @"lashouIndex"] atIndex:1];
        [configs insertObject:@[@"拉手单名", @2000, @"lashouBillName"] atIndex:2];
    }
    
    for (int i = 0; i < [configs count]; ++i) {
        NSArray* array = configs[i];
        ws->colwidth(i, [array[1] intValue]);
        ws->label(index, i, [array[0] UTF8String]);
    }
    
    range* _range;
    _range = ws->rangegroup(index, 0, index, (int)[configs count]-1);
    _range->cellcolor(CLR_ORANGE);
    
    ++index;
    
    for (int i = 0; i < [list count]; ++i) {
        NSDictionary* dic = list[i];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (!memData) {
            memData = @{
                        @"index" : @"无",
                        @"billName" : dic[@"name"] ? dic[@"name"] : @"无"
                        };
        }
        int count = 0;
        NSMutableString* max15 = [NSMutableString string];
        for (NSString* bet in dic[@"betNums"]) {
            if (count > 0) {
                [max15 appendString: @" / "];
            }
            [max15 appendString: bet];
            if (++count >= 15) {
                break;
            }
        }
        NSDictionary* other = @{
                                @"i" : deInt2String(i+1),
                                @"index" : memData[@"index"],
                                @"billName" : memData[@"billName"],
                                @"lashouIndex" : lashou[@"index"] ? lashou[@"index"] : @"",
                                @"lashouBillName" : lashou[@"billName"] ? lashou[@"billName"] : @"",
                                @"max15" : max15
                                };
        for (int j = 0; j < [configs count]; ++j) {
            NSArray* array = configs[j];
            NSString* str = other[array[2]];
            if (!str && [array count] >= 4) {
                str = dic[array[3]];
            }
            if (!str) {
                str = @"";
            }
            ws->label(index, j, [str UTF8String]);
        }
        ++index;
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, (int)[configs count]-1);
    _range->halign(HALIGN_CENTER);
    
    return index;
}

//导出管理上下分
+(NSData*) makeAdminScoreChanged:(NSDictionary*)memData allCount:(NSArray*)allCount upScoreCount:(int)upScoreCount downScoreCount:(int)downScoreCount {
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDateFormatter* hourDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [hourDateformat setDateFormat:@"HH:mm"];
    
    workbook wb;
    worksheet* ws = wb.sheet("sheet1");
    
    font_t * _font = wb.font("Calibri");
    _font->SetBoldStyle(BOLDNESS_BOLD);  // 设置粗字体
    
    xf_t* xf = wb.xformat();
    xf->SetFont(_font);
    
    ws->colwidth(0, 1500);
    ws->colwidth(1, 1500);
    ws->colwidth(2, 3000);
    ws->colwidth(3, 3000);
    
    range* _range;
    
    int index = 0;
    ws->label(index,0,[deString(@"日期: %@", tmanager.mRobot.mQueryDate) UTF8String],xf);
    ws->merge(index, 0, index, 3);
    _range = ws->rangegroup(index,0,index,3);
    _range->cellcolor(CLR_ORANGE);
    index++;
    
    ws->label(index,0,[deString(@"昵称: %@", memData[@"name"]) UTF8String],xf);
    ws->merge(index, 0, index, 3);
    index++;
    
    ws->label(index,0,[deString(@"微信: %@", memData[@"userid"]) UTF8String],xf);
    ws->merge(index, 0, index, 3);
    index++;
    
    ws->label(index,0,[deString(@"给人上分: %d", upScoreCount) UTF8String],xf);
    ws->merge(index, 0, index, 3);
    index++;
    
    ws->label(index,0,[deString(@"给人下分: %d", downScoreCount) UTF8String],xf);
    ws->merge(index, 0, index, 3);
    index++;
    
    ws->label(index,0,"时间",xf);
    ws->label(index,1,"编号",xf);
    ws->label(index,2,"单名",xf);
    ws->label(index,3,"上下分",xf);
    
    _range = ws->rangegroup(index,0,index,3);
    _range->cellcolor(CLR_ORANGE);
    
    index++;
    for (NSDictionary* dic in allCount) {
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        NSDate* date = [objDateformat dateFromString:dic[@"date"]];
        NSString* strHour = [hourDateformat stringFromDate:date];
        ws->label(index,0,[strHour UTF8String],xf);
        ws->label(index,1,[dic[@"index"] UTF8String],xf);
        ws->label(index,2,[deFillName(dic[@"billName"]) UTF8String],xf);
        cell_t* cell = ws->label(index,3,[deString(@"%@%d", change >=0 ? @"+" : @"", change) UTF8String],xf);
        if (change < 0) {
            cell->fontcolor(CLR_RED);
        }
        ++index;
    }
    
    return [self book2data: &wb];
}

//生成反水奖励
+(NSData*) makePlayerBackBonus: (NSMutableDictionary*)allPlayerData diffTuo:(BOOL)diffTuo {
    NSArray* allPlayerDataArr = [allPlayerData allValues];
    workbook wb;
    if (diffTuo) {
        NSMutableArray* players = [NSMutableArray array];
        NSMutableArray* tuos = [NSMutableArray array];
        for (NSDictionary* dic in allPlayerDataArr) {
            if ([dic[@"playerBackBonus"] intValue] > 0) {
                if ([tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                    [tuos addObject: dic];
                } else {
                    [players addObject: dic];
                }
            }
        }
        worksheet* ws1 = wb.sheet("玩家");
        worksheet* ws2 = wb.sheet("托");
        [self fillPlayerBackBonus:players worksheet:ws1];
        [self fillPlayerBackBonus:tuos worksheet:ws2];
    } else {
        NSMutableArray* members = [NSMutableArray array];
        for (NSDictionary* dic in allPlayerDataArr) {
            if ([dic[@"playerBackBonus"] intValue] > 0) {
                [members addObject: dic];
            }
        }
        worksheet* ws1 = wb.sheet("所有");
        [self fillPlayerBackBonus:members worksheet:ws1];
    }
    return [self book2data: &wb];
}

+(void) fillPlayerBackBonus: (NSMutableArray*)list worksheet:(worksheet*)ws {
    [list sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"playerBackBonus"] intValue] > [b[@"playerBackBonus"] intValue] ? -1 : 1;
    }];
    
    int allBonusCount = 0;
    for (NSDictionary* dic in list) {
        allBonusCount += [dic[@"playerBackBonus"] intValue];
    }
    
    range* _range;
    int index = 0;
    
    ws->label(index, 0, [@"日期" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [tmanager.mRobot.mQueryDate UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 12);
    _range = ws->rangegroup(index,0,index,12);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"奖励人数" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [deInt2String((int)[list count]) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 12);
    _range = ws->rangegroup(index,0,index,12);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"奖励总分" UTF8String])->fontcolor(CLR_WHITE);;
    ws->label(index, 2, [deInt2String(allBonusCount) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 12);
    _range = ws->rangegroup(index,0,index,12);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"注意" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [@"总押注 = 牛牛下注 + 免佣下注 + 一比下注 + 牛牛梭哈÷10 + 大小下注÷10 + 特码下注÷10 + 百家乐下注÷10" UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 12);
    _range = ws->rangegroup(index,0,index,12);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    int beginIndex = index;
    NSArray* configs = @[
                         @[@"序号", @1200, @"i"],
                         @[@"编号", @1500, @"index"],
                         @[@"玩家单名", @2000, @"billName"],
                         @[@"反水", @2000, @"_key", @"playerBackBonus"],
                         @[@"反水比例", @2000, @"playerBackRadio"],
                         @[@"总押注", @2500, @"totalBetForPlayerBack"],
                         @[@"牛牛下注", @2000, @"_key", @"betCountNiuniu"],
                         @[@"免佣下注", @2000, @"_key", @"betCountMianyong"],
                         @[@"一比下注", @2000, @"_key", @"betCountYibi"],
                         @[@"牛牛梭哈", @2000, @"_key", @"betCountSuoha"],
                         @[@"大小下注", @2000, @"_key", @"betCountDaxiao"],
                         @[@"特码下注", @2000, @"_key", @"betCountTema"],
                         @[@"百家乐下注", @2000, @"_key", @"betCountBaijiale"],
                         ];

    for (int i = 0; i < [configs count]; ++i) {
        NSArray* array = configs[i];
        ws->colwidth(i, [array[1] intValue]);
        ws->label(index, i, [array[0] UTF8String]);
    }
    
    _range = ws->rangegroup(index, 0, index, (int)[configs count]-1);
    _range->cellcolor(CLR_ORANGE);
    ++index;
    
    for (int i = 0; i < [list count]; ++i) {
        NSDictionary* dic = list[i];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (!memData) {
            memData = @{
                        @"index" : @"无",
                        @"billName" : @"无"
                        };
        }
        NSDictionary* other = @{
                                @"i" : deInt2String(i+1),
                                @"index" : memData[@"index"],
                                @"billName" : memData[@"billName"],
                                @"totalBetForPlayerBack" : deInt2String([dic[@"totalBetForPlayerBack"] intValue]/10),
                                @"playerBackRadio" : deString(@"%.2f", [dic[@"playerBackRadio"] floatValue])
                                };
        for (int j = 0; j < [configs count]; ++j) {
            NSArray* array = configs[j];
            NSString* str = other[array[2]];
            if (!str && [array count] >= 4) {
                str = dic[array[3]];
            }
            if (!str) {
                str = @"";
            }
            ws->label(index, j, [str UTF8String]);
        }
        ++index;
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, (int)[configs count]-1);
    _range->halign(HALIGN_CENTER);
}

//生成输分奖励
+(NSData*) makeLoseBonus: (NSMutableDictionary*)allPlayerData diffTuo:(BOOL)diffTuo {
    NSArray* allPlayerDataArr = [allPlayerData allValues];
    workbook wb;
    if (diffTuo) {
        NSMutableArray* players = [NSMutableArray array];
        NSMutableArray* tuos = [NSMutableArray array];
        for (NSDictionary* dic in allPlayerDataArr) {
            if ([dic[@"loseBonus"] intValue] > 0) {
                if ([tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                    [tuos addObject: dic];
                } else {
                    [players addObject: dic];
                }
            }
        }
        worksheet* ws1 = wb.sheet("玩家");
        worksheet* ws2 = wb.sheet("托");
        [self fillLoseBonus:players worksheet:ws1];
        [self fillLoseBonus:tuos worksheet:ws2];
    } else {
        NSMutableArray* members = [NSMutableArray array];
        for (NSDictionary* dic in allPlayerDataArr) {
            if ([dic[@"loseBonus"] intValue] > 0) {
                [members addObject: dic];
            }
        }
        worksheet* ws1 = wb.sheet("所有");
        [self fillLoseBonus:members worksheet:ws1];
    }
    return [self book2data: &wb];
}

+(void) fillLoseBonus: (NSMutableArray*)list worksheet:(worksheet*)ws {
    [list sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"loseBonus"] intValue] > [b[@"loseBonus"] intValue] ? -1 : 1;
    }];
    
    int allBonusCount = 0;
    for (NSDictionary* dic in list) {
        allBonusCount += [dic[@"loseBonus"] intValue];
    }
    
    range* _range;
    int index = 0;
    
    ws->label(index, 0, [@"日期" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [tmanager.mRobot.mQueryDate UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 5);
    _range = ws->rangegroup(index,0,index,5);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"奖励人数" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [deInt2String((int)[list count]) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 5);
    _range = ws->rangegroup(index,0,index,5);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"奖励总分" UTF8String])->fontcolor(CLR_WHITE);;
    ws->label(index, 2, [deInt2String(allBonusCount) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 5);
    _range = ws->rangegroup(index,0,index,5);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    int beginIndex = index;
    NSArray* configs = @[
                         @[@"序号", @1200, @"i"],
                         @[@"编号", @1500, @"index"],
                         @[@"玩家单名", @2000, @"billName"],
                         @[@"总输赢", @2500, @"_key", @"allWinOrLose"],
                         @[@"输分奖励", @2000, @"_key", @"loseBonus"],
                         @[@"奖励比例", @2000, @"loseBonusRadio"],
                         ];
    
    for (int i = 0; i < [configs count]; ++i) {
        NSArray* array = configs[i];
        ws->colwidth(i, [array[1] intValue]);
        ws->label(index, i, [array[0] UTF8String]);
    }
    
    _range = ws->rangegroup(index, 0, index, (int)[configs count]-1);
    _range->cellcolor(CLR_ORANGE);
    ++index;
    
    for (int i = 0; i < [list count]; ++i) {
        NSDictionary* dic = list[i];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (!memData) {
            memData = @{
                        @"index" : @"无",
                        @"billName" : @"无"
                        };
        }
        NSDictionary* other = @{
                                @"i" : deInt2String(i+1),
                                @"index" : memData[@"index"],
                                @"billName" : memData[@"billName"],
                                @"loseBonusRadio" : deString(@"%.2f", [dic[@"loseBonusRadio"] floatValue])
                                };
        for (int j = 0; j < [configs count]; ++j) {
            NSArray* array = configs[j];
            NSString* str = other[array[2]];
            if (!str && [array count] >= 4) {
                str = dic[array[3]];
            }
            if (!str) {
                str = @"";
            }
            ws->label(index, j, [str UTF8String]);
        }
        ++index;
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, (int)[configs count]-1);
    _range->halign(HALIGN_CENTER);
}

//生成局数奖励
+(NSData*) makeRoundsBonus: (NSMutableDictionary*)allPlayerData diffTuo:(BOOL)diffTuo {
    NSArray* allPlayerDataArr = [allPlayerData allValues];
    workbook wb;
    if (diffTuo) {
        NSMutableArray* players = [NSMutableArray array];
        NSMutableArray* tuos = [NSMutableArray array];
        for (NSDictionary* dic in allPlayerDataArr) {
            if ([dic[@"bonus"] intValue] > 0) {
                if ([tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                    [tuos addObject: dic];
                } else {
                    [players addObject: dic];
                }
            }
        }
        worksheet* ws1 = wb.sheet("玩家");
        worksheet* ws2 = wb.sheet("托");
        [self fillRoundsBonus:players worksheet:ws1];
        [self fillRoundsBonus:tuos worksheet:ws2];
    } else {
        NSMutableArray* members = [NSMutableArray array];
        for (NSDictionary* dic in allPlayerDataArr) {
            if ([dic[@"bonus"] intValue] > 0) {
                [members addObject: dic];
            }
        }
        worksheet* ws1 = wb.sheet("所有");
        [self fillRoundsBonus:members worksheet:ws1];
    }
    return [self book2data: &wb];
}

+(void) fillRoundsBonus: (NSMutableArray*)list worksheet:(worksheet*)ws {
    [list sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"bonus"] intValue] > [b[@"bonus"] intValue] ? -1 : 1;
    }];
    
    int allBonusCount = 0;
    for (NSDictionary* dic in list) {
        allBonusCount += [dic[@"bonus"] intValue];
    }
    
    range* _range;
    int index = 0;
    
    ws->label(index, 0, [@"日期" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [tmanager.mRobot.mQueryDate UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 7);
    _range = ws->rangegroup(index,0,index,7);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"奖励人数" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [deInt2String((int)[list count]) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 7);
    _range = ws->rangegroup(index,0,index,7);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"奖励总分" UTF8String])->fontcolor(CLR_WHITE);;
    ws->label(index, 2, [deInt2String(allBonusCount) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 7);
    _range = ws->rangegroup(index,0,index,7);
    _range->cellcolor(CLR_BLACK);
    index++;

    int beginIndex = index;
    NSMutableArray* configs = [[@[
                         @[@"序号", @1200, @"i"],
                         @[@"编号", @1500, @"index"],
                         @[@"玩家单名", @2000, @"billName"],
                         @[@"奖励", @2000, @"_key", @"bonus"],
                         ] mutableCopy] autorelease];
    
    int lastBetMax = 0;
    for (int i = 0; i < 3; ++i) {
        NSString* key = deString(@"huangzu_roundBonus_level%d", i+1);
        int betMax = [tmanager.mRobot.mData.mBaseSetting[key] intValue];
        NSString* title = deString(@"局数(押注%d~%d)", lastBetMax, betMax-1);
        [configs addObject: @[title, @5000, @"_key", deString(@"count%d", i+1)]];
        lastBetMax = betMax;
        if (2 == i) {
            NSString* title = deString(@"局数(押注%d以上)", lastBetMax);
            [configs addObject: @[title, @5000, @"_key", @"count4"]];
        }
    }
    
    for (int i = 0; i < [configs count]; ++i) {
        NSArray* array = configs[i];
        ws->colwidth(i, [array[1] intValue]);
        ws->label(index, i, [array[0] UTF8String]);
    }
    
    _range = ws->rangegroup(index, 0, index, (int)[configs count]-1);
    _range->cellcolor(CLR_ORANGE);
    ++index;
    
    for (int i = 0; i < [list count]; ++i) {
        NSDictionary* dic = list[i];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (!memData) {
            memData = @{
                        @"index" : @"无",
                        @"billName" : @"无"
                        };
        }
        NSDictionary* other = @{
                                @"i" : deInt2String(i+1),
                                @"index" : memData[@"index"],
                                @"billName" : memData[@"billName"],
                                };
        for (int j = 0; j < [configs count]; ++j) {
            NSArray* array = configs[j];
            NSString* str = other[array[2]];
            if (!str && [array count] >= 4) {
                str = dic[array[3]];
            }
            if (!str) {
                str = @"";
            }
            ws->label(index, j, [str UTF8String]);
        }
        ++index;
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, (int)[configs count]-1);
    _range->halign(HALIGN_CENTER);
}

//生成集齐奖励
+(NSData*) makeCollectBonus: (NSMutableDictionary*)allPlayerData diffTuo:(BOOL)diffTuo{
    NSArray* allPlayerDataArr = [allPlayerData allValues];
    workbook wb;
    if (diffTuo) {
        NSMutableArray* players = [NSMutableArray array];
        NSMutableArray* tuos = [NSMutableArray array];
        for (NSDictionary* dic in allPlayerDataArr) {
            if ([dic[@"collectBonus"] intValue] > 0) {
                if ([tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                    [tuos addObject: dic];
                } else {
                    [players addObject: dic];
                }
            }
        }
        worksheet* ws1 = wb.sheet("玩家");
        worksheet* ws2 = wb.sheet("托");
        [self fillCollectBonus:players worksheet:ws1];
        [self fillCollectBonus:tuos worksheet:ws2];
    } else {
        NSMutableArray* members = [NSMutableArray array];
        for (NSDictionary* dic in allPlayerDataArr) {
            if ([dic[@"collectBonus"] intValue] > 0) {
                [members addObject: dic];
            }
        }
        worksheet* ws1 = wb.sheet("所有");
        [self fillCollectBonus:members worksheet:ws1];
    }
    return [self book2data: &wb];
}

+(void) fillCollectBonus: (NSMutableArray*)list worksheet:(worksheet*)ws {
    [list sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"collectBonus"] intValue] > [b[@"collectBonus"] intValue] ? -1 : 1;
    }];
    
    int allBonusCount = 0;
    for (NSDictionary* dic in list) {
        allBonusCount += [dic[@"collectBonus"] intValue];
    }
    
    ws->colwidth(0, 1200);
    ws->colwidth(1, 1200);
    ws->colwidth(2, 5000);
    ws->colwidth(3, 3000);
    ws->colwidth(4, 3000);
    ws->colwidth(5, 50000);
    
    range* _range;
    int index = 0;
    
    ws->label(index, 0, [@"日期" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [tmanager.mRobot.mQueryDate UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 5);
    _range = ws->rangegroup(index,0,index,5);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"奖励人数" UTF8String])->fontcolor(CLR_WHITE);
    ws->label(index, 2, [deInt2String((int)[list count]) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 5);
    _range = ws->rangegroup(index,0,index,5);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [@"奖励总分" UTF8String])->fontcolor(CLR_WHITE);;
    ws->label(index, 2, [deInt2String(allBonusCount) UTF8String])->fontcolor(CLR_WHITE);;
    ws->merge(index, 0, index, 1);
    ws->merge(index, 2, index, 5);
    _range = ws->rangegroup(index,0,index,5);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    NSArray* types = @[
                       @[@"niuniu", @"牛牛"],
                       @[@"jinniu", @"金牛"],
                       @[@"duizi", @"对子"],
                       @[@"shunzi", @"顺子"],
                       @[@"daoshun", @"倒顺"],
                       @[@"manniu", @"满牛"],
                       @[@"baozi", @"豹子"],
                       ];
    for (NSDictionary* dic in list) {
        NSString* collectBonus = dic[@"collectBonus"];
        NSDictionary* collectBonusDetails = dic[@"collectBonusDetails"];
        NSString* memIndex = @"无";
        NSString* billName = @"无";
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (memData) {
            memIndex = memData[@"index"];
            billName = memData[@"billName"];
        }
        NSString* title = deString(@"编号: %@  单名: %@  总奖励: %@", memIndex, billName, collectBonus);
        ws->label(index, 0, [title UTF8String]);
        ws->merge(index, 0, index, 5);
        _range = ws->rangegroup(index,0,index,5);
        _range->cellcolor(CLR_ORANGE);
        index++;
        for (NSArray* arr in types) {
            NSDictionary* dic = collectBonusDetails[arr[0]];
            if (dic) {
                ws->label(index, 0, [arr[1] UTF8String]);
                ws->label(index, 1, [deString(@"%@个", dic[@"hasNum"]) UTF8String]);
                ws->label(index, 2, [deString(@"奖励%@+%@", dic[@"baseBonus"], dic[@"moreBonus"]) UTF8String]);
                ws->label(index, 3, [deString(@"最低押%@", dic[@"minBet"]) UTF8String]);
                ws->label(index, 4, [deString(@"平均押%@", dic[@"averageBet"]) UTF8String]);
                ws->label(index, 5, [deString(@"押注记录: %@", dic[@"betDetailStr"]) UTF8String]);
                index++;
            }
        }
    }
}

//生成机器修改
+(NSData*) makeRobotReworks: (NSMutableArray*)reworkList {
    workbook wb;
    worksheet* ws = wb.sheet("sheet1");
    
    range* _range;
    int index = 0;
    
    int beginIndex = index;
    NSArray* configs = @[
                         @[@"时间", @3000, @"time"],
                         @[@"局数", @1500, @"round"],
                         @[@"播报", @1500, @"push"],
                         @[@"编号", @2000, @"index"],
                         @[@"单名", @2000, @"billName"],
                         @[@"身份", @3000, @"identity"],
                         @[@"修改类型", @1500, @"type"],
                         @[@"变动", @5000, @"change"],
                         ];
    
    for (int i = 0; i < [configs count]; ++i) {
        NSArray* array = configs[i];
        ws->colwidth(i, [array[1] intValue]);
        ws->label(index, i, [array[0] UTF8String]);
    }
    
    _range = ws->rangegroup(index, 0, index, (int)[configs count]-1);
    _range->cellcolor(CLR_ORANGE);
    ++index;
   
    for (NSDictionary* dic in reworkList) {
        NSString* userid = dic[@"userid"];
        NSDate* date = [NSDate dateWithTimeIntervalSince1970: [dic[@"time"] longLongValue]];
        NSString* dateStr = [ycFunction getFormatTimeStr: date format: @"MM-dd HH:mm:ss"];
        NSString* change = @"";
        NSString* type = @"";
        if ([dic[@"type"] isEqualToString: @"scoreChange"]) {
            type = @"上下分";
            change = deString(@"%@ 改 %@", dic[@"oldScore"], dic[@"newScore"]);
        }
        else if ([dic[@"type"] isEqualToString: @"amountChange"]) {
            type = @"红包金额";
            change = deString(@"%.2f 改 %.2f", [dic[@"oldAmount"] floatValue], [dic[@"newAmount"] floatValue]);
        }
        else if ([dic[@"type"] isEqualToString: @"betChange"]) {
            type = @"下注金额";
            change = deString(@"%@ 改 %@", dic[@"oldBet"], dic[@"newBet"]);
        }
        else if ([dic[@"type"] isEqualToString: @"resultChange"]) {
            type = @"结算状态";
            NSString* oldResult = [tmanager.mRobot.mRework resultStr: dic[@"oldResult"]];
            NSString* newResult = [tmanager.mRobot.mRework resultStr: dic[@"newResult"]];
            change = deString(@"%@ 改 %@", oldResult, newResult);
        }
        else if ([dic[@"type"] isEqualToString: @"betImport"]) {
            type = @"押注单外部导入";
            change = dic[@"msg"];
        }
        else if ([dic[@"type"] isEqualToString: @"hongbaoImport"]) {
            type = @"红包外部导入";
        }
        else if([dic[@"type"] isEqualToString: @"tuoDelete"]) {
            type = @"删除托";
            change = deString(@"操作者: %@", dic[@"admin"] ? dic[@"admin"] : @"机器人");
        }
        else if([dic[@"type"] isEqualToString: @"showBillMore"]) {
            type = @"二次出单";
            change = deString(@"%@局二次以上出单", dic[@"round"]);
        }
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        NSDictionary* values = @{
                                 @"time" : dateStr,
                                 @"round" : dic[@"round"],
                                 @"push" : [dic[@"isSend"] isEqualToString: @"true"] ? @"成功" : @"失败",
                                 @"type" : type,
                                 @"index" : memData ? memData[@"index"] : @"",
                                 @"billName" : memData ? memData[@"billName"] : userid ? userid : @"",
                                 @"identity" : [tmanager.mRobot getIdentityStr: userid],
                                 @"change" : change,
                                 };
        for (int i = 0; i < [configs count]; ++i) {
            NSArray* array = configs[i];
            NSString* key = array[2];
            ws->label(index, i, [values[key] UTF8String]);
        }
        ++index;
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, (int)[configs count]-1);
    _range->halign(HALIGN_CENTER);
    return [self book2data: &wb];
}

//生成点数统计
+(NSData*) makeAmountCount:(NSDictionary*)bankers players:(NSDictionary*)players tuos:(NSDictionary*)tuos {
    workbook wb;
    worksheet* ws1 = wb.sheet("玩家");
    worksheet* ws2 = wb.sheet("托");
    worksheet* ws3 = wb.sheet("庄");
    [self fillAmountCount: players worksheet: ws1];
    [self fillAmountCount: tuos worksheet: ws2];
    [self fillAmountCount: bankers worksheet: ws3];
    return [self book2data: &wb];
}
    
//生成同点杀统计
+(NSData*) makeBankerSamePowCount: (NSArray*)lists {
    workbook wb;
    worksheet* ws1 = wb.sheet("全部");
    worksheet* ws2 = wb.sheet("玩家");
    worksheet* ws3 = wb.sheet("托");

    NSMutableArray* tuos = [NSMutableArray array];
    NSMutableArray* players = [NSMutableArray array];
    for (NSDictionary* dic in lists) {
        if ([tmanager.mRobot.mTuos isTuo:dic[@"playerUserid"]]) {
            [tuos addObject: dic];
        } else {
            [players addObject: dic];
        }
    }
    
    [self fillBankerSamePowCount: lists worksheet: ws1];
    [self fillBankerSamePowCount: players worksheet: ws2];
    [self fillBankerSamePowCount: tuos worksheet: ws3];

    return [self book2data: &wb];
}
    
+(void) fillBankerSamePowCount: (NSArray*)lists worksheet:(worksheet*)ws {
    NSArray* configs = @[
                         @[@"局数", @4000, @"round"],
                         @[@"庄家编号", @4000, @"key", @"banker_index"],
                         @[@"庄家单名", @4000, @"key", @"banker_billName"],
                         @[@"庄家牌型", @4000, @"bankerCard"],
                         @[@"庄家点数", @4000, @"bankerAmount"],
                         @[@"闲家编号", @4000, @"key", @"player_index"],
                         @[@"闲家单名", @4000, @"key", @"player_billName"],
                         @[@"闲家点数", @4000, @"playerAmount"],
                         @[@"闲家下注", @4000, @"betStr"],
                         @[@"可盈利", @4000, @"win"],
                         ];
    int indexMax = (int)[configs count];
    
    int betCount = 0;
    int winCount = 0;
    for (NSDictionary* dic in lists) {
        betCount += [dic[@"betNum"] intValue];
        winCount += [dic[@"win"] intValue];
    }
    
    range* _range;
    int index = 0;
    
    ws->label(index,0,[deString(@"日期: %@", tmanager.mRobot.mQueryDate) UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [deString(@"同点杀个数: %d", (int)[lists count]) UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [deString(@"总下注: %d", betCount) UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [deString(@"总可盈利: %d", winCount) UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    int beginIndex = index;
    for (int i = 0; i < [configs count]; ++i) {
        NSArray* array = configs[i];
        ws->colwidth(i, [array[1] intValue]);
        ws->label(index, i, [array[0] UTF8String]);
    }
    
    _range = ws->rangegroup(index, 0, index, (int)[configs count]-1);
    _range->cellcolor(CLR_ORANGE);
    ++index;
    
    for (NSDictionary* dic in lists) {
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"bankerUserid"]];
        if (!memData) {
            memData = @{
                        @"index" : @"无",
                        @"billName" : dic[@"bankerUserid"]
                        };
        }
        NSDictionary* memDataPlayer = [tmanager.mRobot.mMembers getMember: dic[@"playerUserid"]];
        if (!memDataPlayer) {
            memDataPlayer = @{
                              @"index" : @"无",
                              @"billName" : dic[@"playerUserid"]
                              };
        }
        NSDictionary* other = @{
                                @"banker_index" : memData[@"index"],
                                @"banker_billName" : memData[@"billName"],
                                @"player_index" : memDataPlayer[@"index"],
                                @"player_billName" : memDataPlayer[@"billName"],
                                };
        for (int j = 0; j < [configs count]; ++j) {
            NSArray* array = configs[j];
            NSString* str = dic[array[2]];
            if (!str) {
                str = other[array[3]];
            }
            if (!str) {
                str = @"";
            }
            ws->label(index, j, [str UTF8String]);
        }
        ++index;
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, (int)[configs count]-1);
    _range->halign(HALIGN_CENTER);
}

+(NSString*) getPowTypePercentageStr:(NSDictionary*)dic pow:(NSString*)pow hongbaoCount:(int)hongbaoCount {
    int count = 0;
    if (dic[pow]) {
        count = [dic[pow][0] intValue];
    }
    return deString(@"%d个(%.2f%%)", count, 100.0*count/hongbaoCount);
}

+(NSString*) getPowTypeWinOrLoseStr:(NSDictionary*)dic pow:(NSString*)pow {
    int winorlose = 0;
    if (dic[pow]) {
        winorlose = [dic[pow][1] intValue];
    }
    return deString(@"%@%d", winorlose > 0 ? @"+" : @"", winorlose);
}

+(void) fillAmountCount: (NSDictionary*)list worksheet:(worksheet*)ws {
    int all_hongbao_num = 0;
    NSMutableDictionary* all_powType_num = [NSMutableDictionary dictionary];
    NSMutableDictionary* all_powTypeCount = [NSMutableDictionary dictionary];
    for (NSString* userid in list) {
        int hongbao_num = 0;
        NSMutableDictionary* powTypeCount = [NSMutableDictionary dictionary];
        all_powTypeCount[userid] = powTypeCount;
        
        NSArray* values = list[userid];
        for (NSArray* arr in values) {
            if (!all_powType_num[arr[0]]) {
                all_powType_num[arr[0]] = @[@"1", @"0"];
            } else {
                all_powType_num[arr[0]] = @[deInt2String([all_powType_num[arr[0]][0] intValue]+1), deInt2String([all_powType_num[arr[0]][1] intValue]+[arr[2] intValue])];
            }
            if (!powTypeCount[arr[0]]) {
                powTypeCount[arr[0]] = @[@"1", @"0"];
            } else {
                powTypeCount[arr[0]] = @[deInt2String([powTypeCount[arr[0]][0] intValue]+1), deInt2String([powTypeCount[arr[0]][1] intValue]+[arr[2] intValue])];
            }
            hongbao_num++;
            all_hongbao_num++;
        }
        powTypeCount[@"hongbao_num"] = deInt2String(hongbao_num);
    }
    
    NSArray* configs = @[
                         @[@"编号", @2000, @"index"],
                         @[@"单名", @2000, @"billName"],
                         @[@"抢包个数", @2000, @"hongbaoNum"],
                         @[@"牛1", @4000, @"1"],
                         @[@"输赢", @4000, @"winOrLose", @"1"],
                         @[@"牛2", @4000, @"2"],
                         @[@"输赢", @4000, @"winOrLose", @"2"],
                         @[@"牛3", @4000, @"3"],
                         @[@"输赢", @4000, @"winOrLose", @"3"],
                         @[@"牛4", @4000, @"4"],
                         @[@"输赢", @4000, @"winOrLose", @"4"],
                         @[@"牛5", @4000, @"5"],
                         @[@"输赢", @4000, @"winOrLose", @"5"],
                         @[@"牛6", @4000, @"6"],
                         @[@"输赢", @4000, @"winOrLose", @"6"],
                         @[@"牛7", @4000, @"7"],
                         @[@"输赢", @4000, @"winOrLose", @"7"],
                         @[@"牛8", @4000, @"8"],
                         @[@"输赢", @4000, @"winOrLose", @"8"],
                         @[@"牛9", @4000, @"9"],
                         @[@"输赢", @4000, @"winOrLose", @"9"],
                         @[@"牛牛", @4000, @"10"],
                         @[@"输赢", @4000, @"winOrLose", @"10"],
                         @[@"金牛", @4000, @"11"],
                         @[@"输赢", @4000, @"winOrLose", @"11"],
                         @[@"对子", @4000, @"12"],
                         @[@"输赢", @4000, @"winOrLose", @"12"],
                         @[@"倒顺", @4000, @"13"],
                         @[@"输赢", @4000, @"winOrLose", @"13"],
                         @[@"正顺", @4000, @"14"],
                         @[@"输赢", @4000, @"winOrLose", @"14"],
                         @[@"满牛", @4000, @"15"],
                         @[@"输赢", @4000, @"winOrLose", @"15"],
                         @[@"豹子", @4000, @"18"],
                         @[@"输赢", @4000, @"winOrLose", @"18"],
                         ];
    int indexMax = (int)[configs count];
    
    range* _range;
    int index = 0;
    
    ws->label(index, 0, [deString(@"总采集红包总数: %d", all_hongbao_num) UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    NSString* line1 = deString(@"牛1: %@, 牛2: %@, 牛3: %@, 牛4: %@, 牛5: %@",
                               [self getPowTypePercentageStr: all_powType_num pow: @"1" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"2" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"3" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"4" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"5" hongbaoCount: all_hongbao_num]);
    ws->label(index, 0, [line1 UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    
    NSString* line2 = deString(@"牛6: %@, 牛7: %@, 牛8: %@, 牛9: %@, 牛牛: %@",
                               [self getPowTypePercentageStr: all_powType_num pow: @"6" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"7" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"8" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"9" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"10" hongbaoCount: all_hongbao_num]);
    ws->label(index, 0, [line2 UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    
    NSString* line3 = deString(@"金牛: %@, 对子: %@, 倒顺: %@, 正顺: %@, 满牛: %@, 豹子: %@",
                               [self getPowTypePercentageStr: all_powType_num pow: @"11" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"12" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"13" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"14" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"15" hongbaoCount: all_hongbao_num],
                               [self getPowTypePercentageStr: all_powType_num pow: @"18" hongbaoCount: all_hongbao_num]);
    ws->label(index, 0, [line3 UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, "")->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, "各点数输赢:")->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    NSString* line4 = deString(@"牛1: %@, 牛2: %@, 牛3: %@, 牛4: %@, 牛5: %@",
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"1" ],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"2" ],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"3" ],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"4" ],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"5" ]);
    ws->label(index, 0, [line4 UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    
    NSString* line5 = deString(@"牛6: %@, 牛7: %@, 牛8: %@, 牛9: %@, 牛牛: %@",
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"6" ],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"7" ],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"8" ],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"9" ],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"10"]);
    ws->label(index, 0, [line5 UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    
    NSString* line6 = deString(@"金牛: %@, 对子: %@, 倒顺: %@, 正顺: %@, 满牛: %@, 豹子: %@",
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"11"],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"12"],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"13"],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"14"],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"15"],
                               [self getPowTypeWinOrLoseStr: all_powType_num pow: @"18"]);
    ws->label(index, 0, [line6 UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    int beginIndex = index;
    for (int i = 0; i < [configs count]; ++i) {
        NSArray* array = configs[i];
        ws->colwidth(i, [array[1] intValue]);
        ws->label(index, i, [array[0] UTF8String]);
    }
    
    _range = ws->rangegroup(index, 0, index, (int)[configs count]-1);
    _range->cellcolor(CLR_ORANGE);
    ++index;
    
    for (NSString* userid in all_powTypeCount) {
        NSDictionary* powTypeCount = all_powTypeCount[userid];
        int hongbao_num = [powTypeCount[@"hongbao_num"] intValue];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        if (!memData) {
            memData = @{
                        @"index" : @"无",
                        @"billName" : userid
                        };
        }
        NSDictionary* other = @{
                                @"index" : memData[@"index"],
                                @"billName" : memData[@"billName"],
                                @"hongbaoNum" : deInt2String(hongbao_num)
                                };
        for (int j = 0; j < [configs count]; ++j) {
            NSArray* array = configs[j];
            NSString* str = other[array[2]];
            if (!str) {
                if ([array[2] isEqualToString: @"winOrLose"]) {
                    str = [self getPowTypeWinOrLoseStr: powTypeCount pow: array[3]];
                } else {
                    str = [self getPowTypePercentageStr: powTypeCount pow: array[2] hongbaoCount: hongbao_num];
                }
                
            }
            if (!str) {
                str = @"";
            }
            ws->label(index, j, [str UTF8String]);
        }
        ++index;
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, (int)[configs count]-1);
    _range->halign(HALIGN_CENTER);
}

//查所有上下分明细
+(NSData*) makeAllScoreChangedDetails:(NSArray*)list {
    workbook wb;
    {
        worksheet* ws = wb.sheet("所有");
        [self fillAllScoreChangedDetails:list type:nil worksheet: ws];
    }{
        worksheet* ws = wb.sheet("机器后台");
        [self fillAllScoreChangedDetails:list type:@"manual" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("管理命令");
        [self fillAllScoreChangedDetails:list type:@"command" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("连赢奖励");
        [self fillAllScoreChangedDetails:list type:@"seriesWinBonus" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("反水奖励");
        [self fillAllScoreChangedDetails:list type:@"playerBack" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("集齐奖励");
        [self fillAllScoreChangedDetails:list type:@"collectBonus" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("局数奖励");
        [self fillAllScoreChangedDetails:list type:@"roundBonus" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("上局奖励");
        [self fillAllScoreChangedDetails:list type:@"lastRoundBonus" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("输分奖励");
        [self fillAllScoreChangedDetails:list type:@"loseBonus" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("托自助");
        [self fillAllScoreChangedDetails:list type:@"tuoSelf" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("托批量");
        [self fillAllScoreChangedDetails:list type:@"tuoBatch" worksheet: ws];
    }{
        worksheet* ws = wb.sheet("未知");
        [self fillAllScoreChangedDetails:list type:@"unknow" worksheet: ws];
    }
    return [self book2data: &wb];
}

+(void) fillAllScoreChangedDetails:(NSArray*)list type:(NSString*)type  worksheet:(worksheet*)ws {
    NSArray* configs = @[
                         @[@"时间", @2000, @"time"],
                         @[@"局数", @2000, @"round"],
                         @[@"类型", @2000, @"type"],
                         @[@"管理编号", @2000, @"adminIndex"],
                         @[@"管理单名", @2000, @"adminBillName"],
                         @[@"玩家编号", @2000, @"index"],
                         @[@"玩家单名", @2000, @"billName"],
                         @[@"原分数", @2000, @"oldScore"],
                         @[@"新分数", @2000, @"newScore"],
                         @[@"分数变动", @2000, @"scoreChange"],
                         @[@"群名", @20000, @"chatroom"],
                         ];
    range* _range;
    int index = 0;
    
    int beginIndex = index;
    for (int i = 0; i < [configs count]; ++i) {
        NSArray* array = configs[i];
        ws->colwidth(i, [array[1] intValue]);
        ws->label(index, i, [array[0] UTF8String]);
    }
    
    _range = ws->rangegroup(index, 0, index, (int)[configs count]-1);
    _range->cellcolor(CLR_ORANGE);
    ++index;
    
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDateFormatter* hourDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [hourDateformat setDateFormat:@"HH:mm"];
    
    for (NSDictionary* dic in list) {
        NSString* from = @"";
        if ([dic[@"type"] isEqualToString: @"command"]) {
            from = @"命令上下分";
        } else if ([dic[@"type"] isEqualToString: @"manual"]) {
            from = @"机器后台";
        } else if ([dic[@"type"] isEqualToString: @"tuoBatch"]) {
            from = @"托批量";
        } else if ([dic[@"type"] isEqualToString: @"tuoSelf"]) {
            from = @"托自助";
        } else if ([dic[@"type"] isEqualToString: @"bonus"]) {
            from = @"活动奖励";
        } else if ([dic[@"type"] isEqualToString: @"playerBack"]) {
            from = @"反水奖励";
        } else if ([dic[@"type"] isEqualToString: @"loseBonus"]) {
            from = @"输分奖励";
        } else if ([dic[@"type"] isEqualToString: @"seriesWinBonus"]) {
            from = @"连赢兑奖";
        } else if ([dic[@"type"] isEqualToString: @"lastRoundBonus"]) {
            from = @"上局奖励";
        } else if ([dic[@"type"] isEqualToString: @"roundBonus"]) {
            from = @"局数奖励";
        } else if ([dic[@"type"] isEqualToString: @"collectBonus"]) {
            from = @"集齐奖励";
        } else {
            from = @"未知";
        }
        
        NSString* dicType = dic[@"type"];
        if (!dicType) {
            dicType = @"unknow";
        }
        
        if (type && ![type isEqualToString: dicType]) {
            continue;
        }
        
        NSDate* date = [objDateformat dateFromString:dic[@"date"]];
        NSString* strHour = [hourDateformat stringFromDate:date];
        
        NSString* adminIndex = @"";
        NSString* adminBillName = @"";
        if (dic[@"fromUserid"]) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"fromUserid"]];
            if (memData) {
                adminIndex = memData[@"index"];
                adminBillName = memData[@"billName"];
            }
        }
        
        NSString* playerIndex = @"";
        NSString* playerBillName = @"";
        if (dic[@"userid"]) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
            if (memData) {
                playerIndex = memData[@"index"];
                playerBillName = memData[@"billName"];
            }
        }
        
        int scoreChange = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        NSString* scoreChangeStr = deString(@"%@%d", scoreChange > 0 ? @"+" : @"", scoreChange);
        
        NSString* chatroom = @"";
        if (dic[@"chatroom"]) {
            chatroom = dic[@"chatroom"];
            NSDictionary* dic = [tmanager.mRobot getBackroundRoom: chatroom];
            if (dic) {
                chatroom = dic[@"title"];
            }
        }
        
        NSDictionary* values = @{
                                 @"time" : strHour,
                                 @"round" : dic[@"round"],
                                 @"type" : from,
                                 @"adminIndex" : adminIndex,
                                 @"adminBillName" : adminBillName,
                                 @"index" : playerIndex,
                                 @"billName" : playerBillName,
                                 @"oldScore" : dic[@"oldScore"],
                                 @"newScore" : dic[@"newScore"],
                                 @"scoreChange" : scoreChangeStr,
                                 @"chatroom" : chatroom,
                                 };
        for (int j = 0; j < [configs count]; ++j) {
            NSArray* array = configs[j];
            NSString* str = values[array[2]];
            if (!str) {
                str = @"";
            }
            ws->label(index, j, [str UTF8String]);
        }
        ++index;
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, (int)[configs count]-1);
    _range->halign(HALIGN_CENTER);
}

//查所有群上下分
+(NSData*) makeAllChatroomScoreChanged:(NSDictionary*)chatrooms {
    workbook wb;
    for (NSString* chatroom in chatrooms) {
        NSString* name = chatroom;
        NSDictionary* dic = [tmanager.mRobot getBackroundRoom: chatroom];
        if (dic) {
            name = dic[@"title"];
        }
        worksheet* ws = wb.sheet([name UTF8String]);
        [self fillChatroomScoreChanged: chatrooms[chatroom] worksheet: ws];
    }
    return [self book2data: &wb];
}

//查所有群上下分
+(void) fillChatroomScoreChanged:(NSArray*)list worksheet:(worksheet*)ws {
    NSArray* configs = @[
                         @[@"时间", @2000, @"time"],
                         @[@"局数", @2000, @"round"],
                         @[@"类型", @2000, @"type"],
                         @[@"管理编号", @2000, @"adminIndex"],
                         @[@"管理单名", @2000, @"adminBillName"],
                         @[@"玩家编号", @2000, @"index"],
                         @[@"玩家单名", @2000, @"billName"],
                         @[@"原分数", @2000, @"oldScore"],
                         @[@"新分数", @2000, @"newScore"],
                         @[@"分数变动", @2000, @"scoreChange"],
                         ];
    int indexMax = (int)[configs count];
    int playerUpCount = 0;
    int playerDownCount = 0;
    int tuoUpCount = 0;
    int tuoDownCount = 0;
    for (NSDictionary* dic in list) {
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        BOOL isTuo = [tmanager.mRobot.mTuos isTuo: dic[@"userid"]];
        if (change > 0) {
            if (isTuo) {
                tuoUpCount += abs(change);
            } else {
                playerUpCount += abs(change);
            }
        } else {
            if (isTuo) {
                tuoDownCount += abs(change);
            } else {
                playerDownCount += abs(change);
            }
        }
    }

    range* _range;
    int index = 0;
    
    ws->label(index, 0, [deString(@"玩家总上分: %d", playerUpCount) UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [deString(@"玩家总下分: %d", playerDownCount) UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [deString(@"托总上分: %d", tuoUpCount) UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    ws->label(index, 0, [deString(@"托总下分: %d", tuoDownCount) UTF8String])->fontcolor(CLR_WHITE);
    ws->merge(index, 0, index, indexMax);
    _range = ws->rangegroup(index,0,index,indexMax);
    _range->cellcolor(CLR_BLACK);
    index++;
    
    int beginIndex = index;
    for (int i = 0; i < [configs count]; ++i) {
        NSArray* array = configs[i];
        ws->colwidth(i, [array[1] intValue]);
        ws->label(index, i, [array[0] UTF8String]);
    }
    
    _range = ws->rangegroup(index, 0, index, (int)[configs count]-1);
    _range->cellcolor(CLR_ORANGE);
    ++index;
    
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDateFormatter* hourDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [hourDateformat setDateFormat:@"HH:mm"];
    
    for (NSDictionary* dic in list) {
        NSString* from = @"";
        if ([dic[@"type"] isEqualToString: @"command"]) {
            from = @"命令上下分";
        } else if ([dic[@"type"] isEqualToString: @"manual"]) {
            from = @"机器后台";
        } else if ([dic[@"type"] isEqualToString: @"tuoBatch"]) {
            from = @"托批量";
        } else if ([dic[@"type"] isEqualToString: @"tuoSelf"]) {
            from = @"托自助";
        } else if ([dic[@"type"] isEqualToString: @"bonus"]) {
            from = @"活动奖励";
        } else if ([dic[@"type"] isEqualToString: @"playerBack"]) {
            from = @"反水奖励";
        } else if ([dic[@"type"] isEqualToString: @"loseBonus"]) {
            from = @"输分奖励";
        } else if ([dic[@"type"] isEqualToString: @"seriesWinBonus"]) {
            from = @"连赢兑奖";
        } else if ([dic[@"type"] isEqualToString: @"lastRoundBonus"]) {
            from = @"上局奖励";
        } else if ([dic[@"type"] isEqualToString: @"roundBonus"]) {
            from = @"局数奖励";
        } else if ([dic[@"type"] isEqualToString: @"collectBonus"]) {
            from = @"集齐奖励";
        } else {
            from = @"未知";
        }
        
        NSString* dicType = dic[@"type"];
        if (!dicType) {
            dicType = @"unknow";
        }
        
        NSDate* date = [objDateformat dateFromString:dic[@"date"]];
        NSString* strHour = [hourDateformat stringFromDate:date];
        
        NSString* adminIndex = @"";
        NSString* adminBillName = @"";
        if (dic[@"fromUserid"]) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"fromUserid"]];
            if (memData) {
                adminIndex = memData[@"index"];
                adminBillName = memData[@"billName"];
            }
        }
        
        NSString* playerIndex = @"";
        NSString* playerBillName = @"";
        if (dic[@"userid"]) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
            if (memData) {
                playerIndex = memData[@"index"];
                playerBillName = memData[@"billName"];
            }
        }
        
        int scoreChange = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        NSString* scoreChangeStr = deString(@"%@%d", scoreChange > 0 ? @"+" : @"", scoreChange);
        
        NSString* chatroom = @"";
        if (dic[@"chatroom"]) {
            chatroom = dic[@"chatroom"];
            NSDictionary* dic = [tmanager.mRobot getBackroundRoom: chatroom];
            if (dic) {
                chatroom = dic[@"title"];
            }
        }
        
        NSDictionary* values = @{
                                 @"time" : strHour,
                                 @"round" : dic[@"round"],
                                 @"type" : from,
                                 @"adminIndex" : adminIndex,
                                 @"adminBillName" : adminBillName,
                                 @"index" : playerIndex,
                                 @"billName" : playerBillName,
                                 @"oldScore" : dic[@"oldScore"],
                                 @"newScore" : dic[@"newScore"],
                                 @"scoreChange" : scoreChangeStr,
                                 @"chatroom" : chatroom,
                                 };
        for (int j = 0; j < [configs count]; ++j) {
            NSArray* array = configs[j];
            NSString* str = values[array[2]];
            if (!str) {
                str = @"";
            }
            ws->label(index, j, [str UTF8String]);
        }
        ++index;
    }
    
    _range = ws->rangegroup(beginIndex, 0, index, (int)[configs count]-1);
    _range->halign(HALIGN_CENTER);
}

////测试
//+(NSData*) testMake: (NSMutableArray*)players {
//    workbook wb;
//    worksheet* ws1 = wb.sheet("玩家");
//    
//    [self fillPlayerBet: players worksheet: ws1 index: 0 lashou: nil];
//    
//    return [self book2data: &wb];
//}

@end
