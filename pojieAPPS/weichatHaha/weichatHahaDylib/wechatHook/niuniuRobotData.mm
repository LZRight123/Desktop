//
//  niuniuRobotData.m
//  wechatHook
//
//  Created by antion on 2017/2/28.
//
//

#import "niuniuRobotData.h"
#import "ycFunction.h"
#import "toolManager.h"
#import "niuniuRobot.h"
#import "JSON.h"
#import "wxFunction.h"

#define niuniuRobotDataRoundsPart 200
#define niuniuRobotDataRoundsMax 100

//--------------------------------------------------------
#define niuniuRobotDataRounds @"niuniuRobotDataRounds_0.02"
#define niuniuRobotDataBaseSetting @"niuniuRobotSetting_0.08"
#define niuniuRobotDataMemberList @"niuniuRobotMembers_0.05"
#define niuniuRobotDataAdminList @"niuniuRobotAdmin_0.02"
#define niuniuRobotDataTuoList @"niuniuRobotTuo_0.01"
#define niuniuRobotDataLashouList @"niuniuRobotLashou_0.01"
#define niuniuRobotDataLashouHeadList @"niuniuRobotLashouHead_0.01"
#define niuniuRobotDataScoreChangedRecords @"niuniuRobotScoreChangedRecords_0.03"
#define niuniuRobotDataBackgroundChatroom @"niuniuRobotBackgroundChatroom_0.01"
#define niuniuRobotDataChatroomInvite @"niuniuRobotDataChatroomInvite_0.02"
#define niuniuRobotDataBillHeadPicFile @"niuniuRobotDataBillHeadPicFile_0.01"
#define niuniuRobotDataBillTrendPicFile @"niuniuRobotDataBillTrendPicFile_0.01"
#define niuniuRobotDataDayInfosFile @"niuniuRobotDataDayInfosFile_0.01"
#define niuniuRobotDataReworksFile @"niuniuRobotDataReworksFile_0.02"

#define deAliTmpFile @"aliTmpFile.zip"
//---------------------------------------------------------------------------------------

@implementation niuniuRobotData {
    UIAlertView* mMask;
}

-(id) init {
    if (self = [super init]) {
        //删除临时文件
        [[NSFileManager defaultManager] removeItemAtPath: [ycFunction fullFilename:deAliTmpFile] error:NULL];
        
        //积分数据
        self.mMemberList = [@{} mutableCopy];
        NSDictionary* memList = [ycFunction readFile: niuniuRobotDataMemberList];
        if (memList) {
            for (NSString* key in memList) {
                NSDictionary* value = memList[key];
                self.mMemberList[key] = [NSMutableDictionary dictionaryWithDictionary: value];
            }
        }
        
        //管理员数据
        self.mAdminList = [@{} mutableCopy];
        NSDictionary* adminList = [ycFunction readFile: niuniuRobotDataAdminList];
        if (adminList) {
            for (NSString* key in adminList) {
                NSDictionary* value = adminList[key];
                self.mAdminList[key] = [NSMutableDictionary dictionaryWithDictionary: value];
            }
        }
        
        //托数据
        self.mTuoList = [@{} mutableCopy];
        NSDictionary* tuolist = [ycFunction readFile: niuniuRobotDataTuoList];
        if (tuolist) {
            [self.mTuoList setValuesForKeysWithDictionary: tuolist];
        }
        
        //拉手数据
        self.mLashouList = [@{} mutableCopy];
        NSDictionary* lashouList = [ycFunction readFile: niuniuRobotDataLashouList];
        if (lashouList) {
            for (NSString* key in lashouList) {
                NSDictionary* value = lashouList[key];
                self.mLashouList[key] = [NSMutableDictionary dictionaryWithDictionary: value];
            }
        }
        
        //拉手数据
        self.mLashouHeadList = [@{} mutableCopy];
        NSDictionary* lashouHeadList = [ycFunction readFile: niuniuRobotDataLashouHeadList];
        if (lashouHeadList) {
            for (NSString* key in lashouHeadList) {
                NSDictionary* value = lashouHeadList[key];
                self.mLashouHeadList[key] = [NSMutableDictionary dictionaryWithDictionary: value];
            }
        }
        
        //进群检测数据
        self.mChatroomInviteList = [@{} mutableCopy];
        NSDictionary* chatroomInvite = [ycFunction readFile: niuniuRobotDataChatroomInvite];
        if (chatroomInvite) {
            for (NSString* key in chatroomInvite) {
                NSDictionary* value = chatroomInvite[key];
                self.mChatroomInviteList[key] = [NSMutableDictionary dictionaryWithDictionary: value];
            }
            self.mChatroomInviteList[@"@chatroom"][@"filters"] = [NSMutableDictionary dictionaryWithDictionary: chatroomInvite[@"@chatroom"][@"filters"]];
        }
        
        //回合数据
        self.mRounds = [@[] mutableCopy];
        for (int i = 0; i < niuniuRobotDataRoundsMax; ++i) {
            NSString* filename = [self getRoundFilename: i];
            NSArray* array = [ycFunction readFileArray:filename];
            if (array) {
                [self.mRounds addObjectsFromArray: array];
            } else {
                break;
            }
        }
        
        //上下分数据
        NSArray* scoreChangedRecords = [ycFunction readFileArray:niuniuRobotDataScoreChangedRecords];
        if (scoreChangedRecords) {
            self.mScoreChangedRecords = [[NSMutableArray alloc] initWithArray: scoreChangedRecords];
        } else {
            self.mScoreChangedRecords = [@[] mutableCopy];
        }
        
        //每日信息
        self.mDayInfosList = [@{} mutableCopy];
        NSDictionary* datainfos = [ycFunction readFile: niuniuRobotDataDayInfosFile];
        if (datainfos) {
            for (NSString* key in datainfos) {
                self.mDayInfosList[key] = [NSMutableDictionary dictionaryWithDictionary: datainfos[key]];
                self.mDayInfosList[key][@"connectedUserids"] = [NSMutableDictionary dictionaryWithDictionary: datainfos[key][@"connectedUserids"]];
            }
        }
        
        //机器人为修改记录
        self.mReworksList = [@[] mutableCopy];
        NSArray* reworksList = [ycFunction readFileArray:niuniuRobotDataReworksFile];
        if (reworksList) {
            [self.mReworksList addObjectsFromArray: reworksList];
        }
        
        //设置
        NSDictionary* setting = [ycFunction readFile: niuniuRobotDataBaseSetting];
        if (setting) {
            //先兼容新的字段
            NSDictionary* defaultSetting = [self getDefaultSetting];
            NSMutableDictionary* newSetting = [NSMutableDictionary dictionary];
            for (NSString* key in defaultSetting) {
                newSetting[key] = setting[key] ? setting[key] : defaultSetting[key];
            }
            self.mBaseSetting = [newSetting mutableCopy];
            [self saveBaseSettingFile];
        } else {
            [self setBaseSettingDefault];
        }
    }
    return self;
}

-(void) dealloc {
    [self.mRounds release];
    [self.mBaseSetting release];
    [super dealloc];
}

//保存回合数据
-(NSString*) saveCurrentRound {
    NSDictionary* report = tmanager.mRobot.mResult.mReport;
    if ([report[@"number"] intValue] != tmanager.mRobot.mNumber || tmanager.mRobot.mNumber - 1 != [self lastRoundNumber]) {
        return @"保存出错， 请重新绑定游戏群！";
    }
    
    if ([self.mRounds count] + 1 >= [self maxSaveRound]) {
        return @"局数存储已满, 请适当删除局数再保存。[设置->存档管理->删除部分局数记录]";
    }
    
    //庄
    NSMutableArray* bankers = [NSMutableArray array];
    for (NSDictionary* dic in report[@"bankers"]) {
        [bankers addObject: [NSMutableDictionary dictionaryWithDictionary: dic]];
    }
    
    //闲
    NSMutableArray* players = [NSMutableArray array];
    for (NSDictionary* dic in report[@"players"]) {
        [players addObject: [NSMutableDictionary dictionaryWithDictionary: dic]];
    }
    
    //抢包
    NSMutableArray* robs = [NSMutableArray array];
    for (NSDictionary* dic in report[@"robs"]) {
        [robs addObject: [NSMutableDictionary dictionaryWithDictionary: dic]];
    }
    
    //其他信息
    NSMutableDictionary* otherInfo = [NSMutableDictionary dictionaryWithDictionary: report[@"otherInfo"]];
    
    //result变量
    NSMutableDictionary* resultVar = [NSMutableDictionary dictionary];
    resultVar[@"mMinSecond"] = deString(@"%lld", tmanager.mRobot.mResult.mMinSecond);
    resultVar[@"mMaxSecond"] = deString(@"%lld", tmanager.mRobot.mResult.mMaxSecond);
    resultVar[@"mOvertimeNoWin"] = tmanager.mRobot.mResult.mOvertimeNoWin ? @"true" : @"false";
    resultVar[@"mRobNoWin"] = tmanager.mRobot.mResult.mRobNoWin ? @"true" : @"false";
    resultVar[@"mResetSeriesWin"] = tmanager.mRobot.mResult.mResetSeriesWin ? @"true" : @"false";
    resultVar[@"mLastIsOvertime"] = tmanager.mRobot.mResult.mLastIsOvertime ? @"true" : @"false";
    resultVar[@"mResetBonusPool"] = deInt2String(tmanager.mRobot.mResult.mResetBonusPool);
    resultVar[@"mLastAmounts"] = [NSArray arrayWithArray: tmanager.mRobot.mResult.mLastAmounts];
    resultVar[@"mTotalAmount"] = deInt2String(tmanager.mRobot.mResult.mTotalAmount);
    
    //bet变量
    NSMutableDictionary* betVars = [NSMutableDictionary dictionary];
    betVars[@"mBetScoreCount"] = deInt2String((int)tmanager.mRobot.mBet.mBetScoreCount);
    betVars[@"mBetScoreSuohaCount"] = deInt2String((int)tmanager.mRobot.mBet.mBetScoreSuohaCount);
    betVars[@"mBetScoreLonghuCount"] = deInt2String((int)tmanager.mRobot.mBet.mBetScoreLonghuCount);
    betVars[@"mBetScoreLonghuHeCount"] = deInt2String((int)tmanager.mRobot.mBet.mBetScoreLonghuHeCount);
    betVars[@"mBetScoreTemaCount"] = deInt2String((int)tmanager.mRobot.mBet.mBetScoreTemaCount);
    betVars[@"mBetScoreBaijialeCount"] = deInt2String((int)tmanager.mRobot.mBet.mBetScoreBaijialeCount);
    betVars[@"mBetRecordCount"] = deInt2String((int)tmanager.mRobot.mBet.mBetRecordCount);
    betVars[@"mInvalidBetRecordCount"] = deInt2String((int)tmanager.mRobot.mBet.mInvalidBetRecordCount);
    betVars[@"mIsRatio"] = tmanager.mRobot.mBet.mIsRatio ? @"true" : @"false";
    betVars[@"mFuliSetting"] = [NSDictionary dictionaryWithDictionary: tmanager.mRobot.mBet.mFuliSetting];
    
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSMutableDictionary* roundAllData = [NSMutableDictionary dictionary];
    roundAllData[@"number"] = deInt2String(tmanager.mRobot.mNumber);
    roundAllData[@"date"] = [objDateformat stringFromDate: [NSDate date]];
    roundAllData[@"timestamp"] = [ycFunction getCurrentTimestamp];
    roundAllData[@"players"] = players;
    roundAllData[@"otherInfo"] = otherInfo;
    roundAllData[@"resultVars"] = resultVar;
    roundAllData[@"betVars"] = betVars;
    roundAllData[@"robs"] = robs;
    roundAllData[@"bankers"] = bankers;
    roundAllData[@"autoSeriesWinBonus"] = report[@"autoSeriesWinBonus"];
    [self.mRounds addObject: roundAllData];
    
    int bankerBonus = [otherInfo[@"bankerBonus"] intValue];//庄奖励
    
//    NSLog(@"%@", roundAllData);
//
    //执行扣分
    for (NSDictionary* dic in bankers) {
        [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:[dic[@"winOrLoseFact"] intValue] isSet: NO params: nil];
        if (dic[@"coverRobUp"]) {
            [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:[dic[@"coverRobUp"] intValue] isSet: NO params: nil];
        }
        if (bankerBonus > 0 && [dic[@"isMain"] isEqualToString: @"true"]) {
            [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:bankerBonus isSet: NO params: nil];
        }
    }
    for (NSDictionary* dic in players) {
        [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:[dic[@"winOrLoseFact"] intValue] isSet: NO params: nil];
        if (dic[@"coverRobUp"]) {
            [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:[dic[@"coverRobUp"] intValue] isSet: NO params: nil];
        }
    }
    for (NSDictionary* dic in robs) {
        if (dic[@"robDown"]) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
            if (memData) {
                [tmanager.mRobot.mMembers addScore: memData[@"userid"] score:-[dic[@"robDown"] intValue] isSet: NO params: nil];
            }
        }
    }
    
    //自动连赢兑奖
    NSDictionary* autoSeriesWinBonus = report[@"autoSeriesWinBonus"];
    if ([autoSeriesWinBonus count] > 0) {
        for (NSString* userid in autoSeriesWinBonus) {
            NSDictionary* dic = autoSeriesWinBonus[userid];
            [tmanager.mRobot.mMembers addScore: userid score:[dic[@"bonusFact"] intValue] isSet: NO params: @{@"type":@"seriesWinBonus", @"donotAutoSave": @"true"}];
        }
        [tmanager.mRobot.mData saveScoreChangedRecordsFile];
    }

    [self saveRoundFile];
    [self saveMemberListFile];
    return nil;
}

//删除上一局
-(NSDictionary*) removeLastRound {
    if ([self.mRounds count] <= 0) {
        return nil;
    }
    NSDictionary* lastRound = [self.mRounds lastObject];
    [lastRound retain];
    [self.mRounds removeLastObject];
    
    NSDictionary* otherInfo = lastRound[@"otherInfo"];
    int bankerBonus = [otherInfo[@"bankerBonus"] intValue];//庄奖励
    
    //执行逆向扣分
    for (NSDictionary* dic in lastRound[@"bankers"]) {
        [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:-[dic[@"winOrLoseFact"] intValue] isSet: NO params: nil];
        if (dic[@"coverRobUp"]) {
            [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:-[dic[@"coverRobUp"] intValue] isSet: NO params: nil];
        }
        if (bankerBonus > 0 && [dic[@"isMain"] isEqualToString: @"true"]) {
            [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:-bankerBonus isSet: NO params: nil];
        }
    }
    for (NSDictionary* dic in lastRound[@"players"]) {
        [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:-[dic[@"winOrLoseFact"] intValue] isSet: NO params: nil];
        if (dic[@"coverRobUp"]) {
            [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:-[dic[@"coverRobUp"] intValue] isSet: NO params: nil];
        }
    }
    for (NSDictionary* dic in lastRound[@"robs"]) {
        if (dic[@"robDown"]) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
            if (memData) {
                [tmanager.mRobot.mMembers addScore: memData[@"userid"] score:[dic[@"robDown"] intValue] isSet: NO params: nil];
            }
        }
    }
    
    //自动连赢兑奖
    NSDictionary* autoSeriesWinBonus = lastRound[@"autoSeriesWinBonus"];
    if ([autoSeriesWinBonus count] > 0) {
        for (NSString* userid in autoSeriesWinBonus) {
            NSDictionary* dic = autoSeriesWinBonus[userid];
            [tmanager.mRobot.mMembers addScore: userid score:-[dic[@"bonusFact"] intValue] isSet: NO params: @{@"type":@"seriesWinBonus", @"donotAutoSave": @"true"}];
        }
        [tmanager.mRobot.mData saveScoreChangedRecordsFile];
    }
    
    [self saveRoundFile];
    [self saveMemberListFile];
    return lastRound;
}

//最后一局局数
-(int) lastRoundNumber {
    if ([self.mRounds count] > 0) {
        return [[self.mRounds lastObject][@"number"] intValue];
    }
    return 0;
}

//最多能存储局数
-(int) maxSaveRound {
    return niuniuRobotDataRoundsPart*niuniuRobotDataRoundsMax;
}

//保存会员数据
-(void) saveMemberListFile {
    [ycFunction saveFile: niuniuRobotDataMemberList dic: self.mMemberList];
}

//保存上下分纪录
-(void) saveScoreChangedRecordsFile {
    [ycFunction saveFileArray:niuniuRobotDataScoreChangedRecords array:self.mScoreChangedRecords];
}

//保存管理员数据
-(void) saveAdminListFile {
    [ycFunction saveFile: niuniuRobotDataAdminList dic: self.mAdminList];
}

//保存托数据
-(void) saveTuoListFile {
    [ycFunction saveFile: niuniuRobotDataTuoList dic: self.mTuoList];
}

//保存拉手数据
-(void) saveLashouListFile {
    [ycFunction saveFile: niuniuRobotDataLashouList dic: self.mLashouList];
}

//保存拉手数据
-(void) saveLashouHeadListFile {
    [ycFunction saveFile: niuniuRobotDataLashouHeadList dic: self.mLashouHeadList];
}

//获取回合数据文件名
-(NSString*) getRoundFilename:(int)part {
    return deString(@"%@_part%d", niuniuRobotDataRounds, part);
}

/*保存回合数据
 part0(0~199)
 part1(200~399)
 part2(400~599)
 ....
 */
-(void) saveRoundFile {
    int roundCount = (int)[self.mRounds count];
    int part = MAX(0, roundCount-1)/niuniuRobotDataRoundsPart;
    int start = part*niuniuRobotDataRoundsPart;
    NSMutableArray* array = [NSMutableArray array];
    for (int i = start; i < start+niuniuRobotDataRoundsPart && i < [self.mRounds count]; ++i) {
        [array addObject: self.mRounds[i]];
    }
    
    NSString* filename = [self getRoundFilename: part];
    [ycFunction saveFileArray:filename array:array];

    
    for (int i = part+1; i < niuniuRobotDataRoundsMax; ++i) {
        NSString* filename = [self getRoundFilename: i];
        if ([[NSFileManager defaultManager] removeItemAtPath: [ycFunction fullFilename:filename] error:NULL]) {
        }
    }
}

//保存所有回合数据
-(void) saveAllRoundFile {
    int roundCount = (int)[self.mRounds count];
    int part = MAX(0, roundCount-1)/niuniuRobotDataRoundsPart;
    for (int j = 0; j <= part; ++j) {
        int start = j*niuniuRobotDataRoundsPart;
        NSMutableArray* array = [NSMutableArray array];
        for (int i = start; i < start+niuniuRobotDataRoundsPart && i < [self.mRounds count]; ++i) {
            [array addObject: self.mRounds[i]];
        }
        
        NSString* filename = [self getRoundFilename: j];
        [ycFunction saveFileArray:filename array:array];
    }
    for (int i = part+1; i < niuniuRobotDataRoundsMax; ++i) {
        NSString* filename = [self getRoundFilename: i];
        if ([[NSFileManager defaultManager] removeItemAtPath: [ycFunction fullFilename:filename] error:NULL]) {
        }
    }
}

//获取默认设置
-(NSDictionary*) getDefaultSetting {
    return @{
             //过时
             @"forceOpenHongbao" : @"false",//过封号点包
             @"topBillEasy" : @"false",//积分榜简洁
             @"topBillMinScore" : @"50",//积分榜低于多少分只显示名字
             @"rewardMin" : @"0",//奖励要求最低押注
             @"baijialePow" : @"1",

             //基本
             @"autoAddMember" : @"false",//自动添加会员
             @"overtime" : @"22",//超时上限
             @"everyPlayerHongbaoFee" : @"0",//玩家红包费
             @"everyPlayerHongbaoFeeWin" : @"false",//玩家红包费赢才扣
             @"headQuickAs2" : @"false",//头包快2秒认第2包

             //庄
             @"banerAsLast2" : @"false",//庄无包认尾2
             @"banerAsLast2For100" : @"true",//庄无包认尾2
             @"bankerHeadPow" : @"1",//庄平赔倍数
             @"ratio" : @"0.05",//上庄抽水
             @"betLimit" : @"0.03",//押注限制
             @"bankerWinRatio" : @"0",//盈利抽水
             @"hongbaoFee" : @"0",//每盘红包费用
             @"bonusPoolFee" : @"0",//每盘奖金池
             @"heiFee" : @"0",//暗扣

             //牌型
             @"0duizi" : @"true",//0开头是对子
             @"012shunzi" : @"true",//012算顺子
             @"210daoshun" : @"true",//210算倒顺
             
             //抢包
             @"robPlayer" : @"0",//抢闲扣分数
             @"robPlayerAdd" : @"0",//抢闲加分数
             @"robBanker" : @"0",//抢庄扣分数
             @"robBankerAdd" : @"0",//抢庄加分数
             @"robAddMustLost" : @"true",//抢包补分必须输才补
             
             //管理命令
             @"upScoreCountShow" : @"true",//上分统计显示
             @"showNiuniuCount" : @"true",//上分统计显示
             @"showJinniuCount" : @"true",//上分统计显示
             @"showDuiziCount" : @"true",//上分统计显示
             @"showShunziCount" : @"true",//上分统计显示
             @"showDaoshunCount" : @"true",//上分统计显示
             @"showManniuCount" : @"true",//上分统计显示
             @"showBaoziCount" : @"true",//上分统计显示
             
             //托命令
             @"tuoAddScoreStart" : @"5000",//托分低于多少能补
             @"tuoAddScoreMin" : @"1000",//托补分下限
             @"tuoAddScoreMax" : @"30000",//托补分上限
             
             //拉手命令
             @"allowLashouSou" : @"true",//允许拉手用搜
             @"allowLashouSouAdd" : @"false",//拉手允许搜
             @"allowLashouCardAutoAdd" : @"true",//推名片直接报备
             @"allowLashouShowFrom" : @"false",//拉手允许搜显示归属
             
             //拉手团长命令
             @"allowLashouHeadSou" : @"true",//允许拉手用搜
             @"allowLashouHeadSouAdd" : @"false",//拉手团长允许搜添加
             @"allowLashouHeadShowFrom" : @"false",//拉手团长允许搜显示归属
             
             //玩家命令开启
             @"playerCmdQuerySpace" : @"60",//查询间隔
             @"playerCmdEnableScore" : @"true",//查积分
             @"playerCmdEnableScoreChanged" : @"false",//查上下分
             @"playerCmdEnableCount" : @"false",//查统计
             @"playerCmdEnablePackages" : @"false",//查领包
             
             //进群检测
             @"chatroomIntiveCheck" : @"false",//进群邀请人检测
             @"chatroomEnterHint" : @"false",//进群提示
             @"chatroomAllowLook" : @"3",//允许观战局数
             @"chatroomRobRound" : @"10",//最近几局抢包
             @"chatroomNewScoreChange" : @"100",//显示最近上分
             
             //牛牛相关
             @"supportNiuniu" : @"true",//支持牛牛
             
             //牛牛基本设置
             @"has001" : @"false",//是否有001跑路
             @"overtimeIsCompare" : @"true",//超时大平小赔
             @"sameMoneyPlayerWin" : @"false",//同金额闲赢
             @"shunziDaoshunCompareAmount" : @"false",//正顺倒顺比金额
             @"daoshunBiShunziDa" : @"false",//倒顺比正顺大
             @"startComparePow" : @"5",//牛几开始比
             @"daPingXiaoPeiPow" : @"0",//牛几以下大平小赔
             @"admitDefeatPow" : @"0",//牛几以下自杀
             @"playerWinRatioSuoha" : @"0.03",//闲梭哈抽水
             @"playerWinRatio" : @"0.03",//闲盈利抽水
             @"normalNiuniuRatioUnder" : @"0",//牛几以下开始抽水
             @"normalNiuniuRatioUnderForSuoha" : @"0",//牛几以下开始抽水
             @"minBet" : @"30",//最低下注
             @"maxBet" : @"5000",//最高下注
             @"minBetSuoha" : @"300",//最高下注
             @"maxBetSuoha" : @"50000",//最高下注

             //牛牛闲赢倍数相关
             @"powNiu1" : @"1",
             @"powNiu2" : @"2",
             @"powNiu3" : @"3",
             @"powNiu4" : @"4",
             @"powNiu5" : @"5",
             @"powNiu6" : @"6",
             @"powNiu7" : @"7",
             @"powNiu8" : @"8",
             @"powNiu9" : @"9",
             @"powNiu10" : @"10",
             @"powJinniu" : @"11",
             @"powDuizi" : @"12",
             @"powDaoshun" : @"13",
             @"powShunzi" : @"13",
             @"powManniu" : @"14",
             @"powBaozi" : @"15",
             
             //牛牛庄赢倍数相关
             @"powBankerNiu1" : @"1",
             @"powBankerNiu2" : @"2",
             @"powBankerNiu3" : @"3",
             @"powBankerNiu4" : @"4",
             @"powBankerNiu5" : @"5",
             @"powBankerNiu6" : @"6",
             @"powBankerNiu7" : @"7",
             @"powBankerNiu8" : @"8",
             @"powBankerNiu9" : @"9",
             @"powBankerNiu10" : @"10",
             @"powBankerJinniu" : @"11",
             @"powBankerDuizi" : @"12",
             @"powBankerDaoshun" : @"13",
             @"powBankerShunzi" : @"13",
             @"powBankerManniu" : @"14",
             @"powBankerBaozi" : @"15",
             
             //牛牛闲赢倍数相关
             @"powSuohaNiu1" : @"1",
             @"powSuohaNiu2" : @"1",
             @"powSuohaNiu3" : @"1",
             @"powSuohaNiu4" : @"1",
             @"powSuohaNiu5" : @"1",
             @"powSuohaNiu6" : @"1",
             @"powSuohaNiu7" : @"1",
             @"powSuohaNiu8" : @"1",
             @"powSuohaNiu9" : @"1",
             @"powSuohaNiu10" : @"1",
             @"powSuohaJinniu" : @"1",
             @"powSuohaDuizi" : @"1",
             @"powSuohaDaoshun" : @"1",
             @"powSuohaShunzi" : @"1",
             @"powSuohaManniu" : @"1",
             @"powSuohaBaozi" : @"1",
             
             //牛牛闲赢倍数相关
             @"powSuohaBankerNiu1" : @"1",
             @"powSuohaBankerNiu2" : @"1",
             @"powSuohaBankerNiu3" : @"1",
             @"powSuohaBankerNiu4" : @"1",
             @"powSuohaBankerNiu5" : @"1",
             @"powSuohaBankerNiu6" : @"1",
             @"powSuohaBankerNiu7" : @"1",
             @"powSuohaBankerNiu8" : @"1",
             @"powSuohaBankerNiu9" : @"1",
             @"powSuohaBankerNiu10" : @"1",
             @"powSuohaBankerJinniu" : @"1",
             @"powSuohaBankerDuizi" : @"1",
             @"powSuohaBankerDaoshun" : @"1",
             @"powSuohaBankerShunzi" : @"1",
             @"powSuohaBankerManniu" : @"1",
             @"powSuohaBankerBaozi" : @"1",

             //牛牛牌型开启
             @"powEnableJinniu" : @"true",
             @"powEnableDuizi" : @"true",
             @"powEnableDaoshun" : @"true",
             @"powEnableShunzi" : @"true",
             @"powEnableManniu" : @"true",
             @"powEnableBaozi" : @"true",
             
             //喝水模式
             @"isHeshuiMode" : @"false",//喝水模式
             
             //牛牛喝水补贴
             @"heshuiSubsidyNiu1" : @"0",
             @"heshuiSubsidyNiu2" : @"0",
             @"heshuiSubsidyNiu3" : @"0",
             @"heshuiSubsidyNiu4" : @"0",
             @"heshuiSubsidyNiu5" : @"0",
             @"heshuiSubsidyNiu6" : @"0",
             @"heshuiSubsidyNiu7" : @"0",
             @"heshuiSubsidyNiu8" : @"0",
             @"heshuiSubsidyNiu9" : @"0",
             @"heshuiSubsidyNiu10" : @"0",
             @"heshuiSubsidyJinniu" : @"0",
             @"heshuiSubsidyDuizi" : @"0",
             @"heshuiSubsidyDaoshun" : @"0",
             @"heshuiSubsidyShunzi" : @"0",
             @"heshuiSubsidyManniu" : @"0",
             @"heshuiSubsidyBaozi" : @"0",
             
             //免佣模式
             @"supportMianyong" : @"false",//支持免佣
             @"startComparePowForMianyong" : @"5",//牛几开始比金额(免佣)
             @"daPingXiaoPeiPowForMianyong" : @"0",//牛几以下大平小赔
             @"admitDefeatPowForMianyong" : @"0",//牛几以下自杀
             
             //免佣闲家倍数
             @"powMianyongNiu1" : @"1",
             @"powMianyongNiu2" : @"2",
             @"powMianyongNiu3" : @"3",
             @"powMianyongNiu4" : @"4",
             @"powMianyongNiu5" : @"5",
             @"powMianyongNiu6" : @"6",
             @"powMianyongNiu7" : @"7",
             @"powMianyongNiu8" : @"8",
             @"powMianyongNiu9" : @"9",
             @"powMianyongNiu10" : @"6",
             @"powMianyongJinniu" : @"11",
             @"powMianyongDuizi" : @"12",
             @"powMianyongDaoshun" : @"13",
             @"powMianyongShunzi" : @"13",
             @"powMianyongManniu" : @"14",
             @"powMianyongBaozi" : @"15",
             
             //免佣庄家倍数
             @"powMianyongBankerNiu1" : @"1",
             @"powMianyongBankerNiu2" : @"2",
             @"powMianyongBankerNiu3" : @"3",
             @"powMianyongBankerNiu4" : @"4",
             @"powMianyongBankerNiu5" : @"5",
             @"powMianyongBankerNiu6" : @"6",
             @"powMianyongBankerNiu7" : @"7",
             @"powMianyongBankerNiu8" : @"8",
             @"powMianyongBankerNiu9" : @"9",
             @"powMianyongBankerNiu10" : @"10",
             @"powMianyongBankerJinniu" : @"11",
             @"powMianyongBankerDuizi" : @"12",
             @"powMianyongBankerDaoshun" : @"13",
             @"powMianyongBankerShunzi" : @"13",
             @"powMianyongBankerManniu" : @"14",
             @"powMianyongBankerBaozi" : @"15",
             
             //一比模式
             @"supportYibi" : @"false",//支持一比
             @"startComparePowForYibi" : @"1",//牛几开始比金额
             @"daPingXiaoPeiPowForYibi" : @"0",//牛几以下大平小赔
             @"admitDefeatPowForYibi" : @"0",//牛几以下自杀
             @"yibiNiuniuRatioUnder" : @"0",//牛几以下开始抽水
             @"niuniuYibiWinRatio" : @"0.05",//闲赢抽水比例
             @"niuniuYibiBetTotalRatio" : @"0.8",//一比流水比例
             @"niuniuYibiBetTotalRatioPlayerBack" : @"0.8",//一比流水比例
             
             //一比倍数
             @"powYibiNiu1" : @"1",
             @"powYibiNiu2" : @"2",
             @"powYibiNiu3" : @"3",
             @"powYibiNiu4" : @"4",
             @"powYibiNiu5" : @"5",
             @"powYibiNiu6" : @"6",
             @"powYibiNiu7" : @"7",
             @"powYibiNiu8" : @"8",
             @"powYibiNiu9" : @"9",
             @"powYibiNiu10" : @"10",
             @"powYibiJinniu" : @"11",
             @"powYibiDuizi" : @"12",
             @"powYibiDaoshun" : @"13",
             @"powYibiShunzi" : @"13",
             @"powYibiManniu" : @"14",
             @"powYibiBaozi" : @"15",
             
             //一比庄赢倍数
             @"powYibiBankerNiu1" : @"1",
             @"powYibiBankerNiu2" : @"2",
             @"powYibiBankerNiu3" : @"3",
             @"powYibiBankerNiu4" : @"4",
             @"powYibiBankerNiu5" : @"5",
             @"powYibiBankerNiu6" : @"6",
             @"powYibiBankerNiu7" : @"7",
             @"powYibiBankerNiu8" : @"8",
             @"powYibiBankerNiu9" : @"9",
             @"powYibiBankerNiu10" : @"10",
             @"powYibiBankerJinniu" : @"11",
             @"powYibiBankerDuizi" : @"12",
             @"powYibiBankerDaoshun" : @"13",
             @"powYibiBankerShunzi" : @"13",
             @"powYibiBankerManniu" : @"14",
             @"powYibiBankerBaozi" : @"15",
             
             //大小单双
             @"supportLonghu" : @"false",//支持龙虎
             @"longhuRatioValue" : @"0.03",//龙虎抽水值
             @"longhuMinBet" : @"200",//龙虎大小最低下注
             @"longhuMaxBet" : @"100000",//龙虎大小最高下注
             @"longhuMinBetHe" : @"200",//龙虎和最低下注
             @"longhuMaxBetHe" : @"20000",//龙虎和最高下注
             @"longhuLimitMutil" : @"false",//龙虎限制组合
             @"longhuHeBackHalf" : @"true",//合退一半
             
             //大小单双倍数
             @"powLonghuDaXiaoDanShuang" : @"1",
             @"powLonghuDaXiaoDanShuangZuhe3" : @"2",
             @"powLonghuDaXiaoDanShuangZuhe2" : @"4",
             @"powLonghuHe" : @"5",
             
             //大小单双牌型开启（大小单双）
             @"daxiaoEnableDa" : @"true",
             @"daxiaoEnableXiao" : @"true",
             @"daxiaoEnableDan" : @"true",
             @"daxiaoEnableShuang" : @"true",
             @"daxiaoEnableHe" : @"true",
             @"daxiaoEnableDaDan" : @"true",
             @"daxiaoEnableDaShuang" : @"true",
             @"daxiaoEnableXiaoDan" : @"true",
             @"daxiaoEnableXiaoShuang" : @"true",
             
             //特码相关
             @"supportTema" : @"false",//支持特码
             @"temaRatioValue" : @"0.03",//特码抽水
             @"temaMinBet" : @"100",//特码最低下注
             @"temaMaxBet" : @"10000",//特码最高下注
             @"temaHeBackHalf" : @"true",//特码合输一半
             
             //特码倍数
             @"powTema" : @"10",
             
             //百家乐相关
             @"supportBaijiale" : @"false",//支持百家乐
             @"baijialeRatioValue" : @"0.03",//百家乐抽水
             @"baijialeMinBet" : @"300",//百家乐最低下注
             @"baijialeMaxBet" : @"50000",//百家乐最高下注
             @"baijialeStartCompare" : @"5",//牛几开始比
             
             //百家乐倍数
             @"baijialePowZhuang" : @"0.95",
             @"baijialePowXian" : @"1",
             @"baijialePowTie" : @"4",
             @"baijialePowZhuangPair" : @"6",
             @"baijialePowXianPair" : @"6",
             
             //牌型开启
             @"baijialeEnableZhuang" : @"true",
             @"baijialeEnableXian" : @"true",
             @"baijialeEnableTie" : @"true",
             @"baijialeEnableZhuangPair" : @"true",
             @"baijialeEnableXianPair" : @"true",

//             //奖池配置
//             @"tmpBonusPool1" : @"0",
//             @"tmpBonusPool2" : @"0",
//             @"tmpBonusPool3" : @"0",
//             @"tmpBonusPool4" : @"0",
//             @"tmpBonusPool5" : @"0",
//             @"tmpBonusPool6" : @"0",
//             @"tmpBonusPool7" : @"0",
//             @"tmpBonusPool8" : @"0",
//             @"tmpBonusPool9" : @"0",
//             @"tmpBonusPool10" : @"0",
//             @"tmpBonusPool2000" : @"0",
//             @"tmpBonusPool2000-2900" : @"0",
//             @"tmpBonusPool3000-3900" : @"0",
//             @"tmpBonusPool4000-4900" : @"0",
//             @"tmpBonusPool5000-5900" : @"0",
//             @"tmpBonusPool6000-6900" : @"0",
//             @"tmpBonusPool7000" : @"0",
             
             //连赢
             @"seriesWinAutoBonusEnable" : @"false",//自动兑奖开关
             @"seriesWinAllowTypeNiuniu" : @"true",//连赢支持牛牛
             @"seriesWinAllowTypeNiuniuMianyong" : @"true",//连赢支持牛牛免佣
             @"seriesWinAllowTypeNiuniuYibi" : @"true",//连赢支持牛牛一比
             @"seriesWinAllowTypeDaxiao" : @"true",//连赢支持大小单双
             @"seriesWinAllowTypeTema" : @"true",//连赢支持特码
             @"seriesWinAllowTypeBaijiale" : @"true",//连赢支持百家乐
             @"seriesWinDaxiaoAsFirst" : @"true",//大小连赢认第一注
             @"seriesWinDaxiaoAsFirstBet" : @"true",//大小押注认第一注
             @"seriesWinBaijialeAsFirst" : @"true",//百家乐连赢认第一注
             @"seriesWinBaijialeAsFirstBet" : @"true",//百家乐押注认第一注
             @"bankerHeadEndSeriesWin" : @"false",//平赔断连
             @"bankerHeadNotSeriesWin" : @"true",//平赔无连赢
             @"bankerOvertimeNotSeriesWin" : @"true",//超时无连赢
             @"playerAsLastEndSeriesWin" : @"false",//无包认尾断连赢
             @"playerAsLastNotSeriesWin" : @"true",//无包认尾不算连赢
             @"seriesWinResetNum" : @"0",//连赢多少把重置
             @"seriesWinAutoBonus1" : @"0",
             @"seriesWinAutoBonus2" : @"0",
             @"seriesWinAutoBonus3" : @"0",
             @"seriesWinAutoBonus4" : @"0",
             @"seriesWinAutoBonus5" : @"0",
             @"seriesWinAutoBonus6" : @"0",
             @"seriesWinAutoBonus7" : @"0",
             @"seriesWinAutoBonus8" : @"0",
             @"seriesWinAutoBonus9" : @"0",
             @"seriesWinAutoBonus10" : @"0",
             @"seriesWinAutoBonus11" : @"0",
             @"seriesWinAutoBonus12" : @"0",
             @"seriesWinAutoBonus13" : @"0",
             @"seriesWinAutoBonus14" : @"0",
             @"seriesWinAutoBonus15" : @"0",
             @"seriesWinAutoBonus16" : @"0",
             @"seriesWinAutoBonus17" : @"0",
             @"seriesWinAutoBonus18" : @"0",
             @"seriesWinAutoBonus19" : @"0",
             @"seriesWinAutoBonus20" : @"0",
             @"seriesWinAutoBonus20up" : @"0",//20把以上每把增加多少
             @"seriesWinAutoBonusRatio1" : @"30-49-0.33",//30-49-0.33  代表押注30~49的奖励33%
             @"seriesWinAutoBonusRatio2" : @"50-99-0.5",
             @"seriesWinAutoBonusRatio3" : @"100-299-0.75",
             @"seriesWinAutoBonusRatio4" : @"300-499-1",
             @"seriesWinAutoBonusRatio5" : @"500-999999999-2",
             
             //反水
             @"playerBackEnable" : @"true",//反水开关
             @"playerBackRatio1" : @"3000-300000-0.04",//代表押注3000～300000反水0.04
             @"playerBackRatio2" : @"300001-500000-0.05",//
             @"playerBackRatio3" : @"500001-999999999-0.07",//
             @"playerBackRatio4" : @"",//
             @"playerBackRatio5" : @"",//
             
             //输分奖励
             @"loseBonusEnable" : @"true",//反水开关
             @"loseBonusRatio1" : @"3000-300000-0.04",//代表押注3000～300000反水0.04
             @"loseBonusRatio2" : @"300001-500000-0.05",//
             @"loseBonusRatio3" : @"500001-999999999-0.07",//
             @"loseBonusRatio4" : @"",//
             @"loseBonusRatio5" : @"",//
             
             //集齐奖励
             @"collectBonusEnable" : @"false",//集齐开关
             @"collectBonusNiuniuMustNotSame" : @"true",//牛牛是否需要不重复
             @"collectBonusJinniuMustNotSame" : @"true",//
             @"collectBonusDuiziMustNotSame" : @"true",//
             @"collectBonusShunziMustNotSame" : @"true",//
             @"collectBonusDaoshunMustNotSame" : @"true",//
             @"collectBonusManniuMustNotSame" : @"true",//
             @"collectBonusBaoziMustNotSame" : @"true",//
             @"collectBonusNiuniuNum" : @"",//牛牛奖励  4-8888-8888
             @"collectBonusJinniuNum" : @"6-3888-1888",//
             @"collectBonusDuiziNum" : @"6-3888-1888",//
             @"collectBonusShunziNum" : @"4-10000-8888",//
             @"collectBonusDaoshunNum" : @"4-10000-8888",//
             @"collectBonusManniuNum" : @"4-10000-8888",//
             @"collectBonusBaoziNum" : @"4-10000-8888",//
             @"collectBonusBetUseAverage" : @"false",//押注值按照平均值
             @"collectBonusRatio1" : @"30-49-0.33",// 50-0.33  代表押注50以下奖励33%
             @"collectBonusRatio2" : @"50-99-0.5",
             @"collectBonusRatio3" : @"100-299-0.75",
             @"collectBonusRatio4" : @"300-499-1",
             @"collectBonusRatio5" : @"500-999999999-2",
       
             //局数奖励
             @"huangzu_roundBonus_enable" : @"false",
             @"huangzu_roundBonus_level1" : @"100",
             @"huangzu_roundBonus_level2" : @"300",
             @"huangzu_roundBonus_level3" : @"1000",
             @"huangzu_roundBonus_roundMust1" : @"40",
             @"huangzu_roundBonus_roundMust2" : @"80",
             @"huangzu_roundBonus_roundMust3" : @"160",
             @"huangzu_roundBonus_roundMust4" : @"320",
             @"huangzu_roundBonus_bonus1_1" : @"188",
             @"huangzu_roundBonus_bonus1_2" : @"288",
             @"huangzu_roundBonus_bonus1_3" : @"588",
             @"huangzu_roundBonus_bonus1_4" : @"888",
             @"huangzu_roundBonus_bonus2_1" : @"218",
             @"huangzu_roundBonus_bonus2_2" : @"588",
             @"huangzu_roundBonus_bonus2_3" : @"1088",
             @"huangzu_roundBonus_bonus2_4" : @"2588",
             @"huangzu_roundBonus_bonus3_1" : @"388",
             @"huangzu_roundBonus_bonus3_2" : @"1088",
             @"huangzu_roundBonus_bonus3_3" : @"1888",
             @"huangzu_roundBonus_bonus3_4" : @"3588",
             @"huangzu_roundBonus_bonus4_1" : @"588",
             @"huangzu_roundBonus_bonus4_2" : @"1888",
             @"huangzu_roundBonus_bonus4_3" : @"3888",
             @"huangzu_roundBonus_bonus4_4" : @"5888",
             
             //前台出单
             @"showPicBill" : @"true",//图片账单
             @"showPicBillForBet" : @"false",//图片押注单
             @"sendPlayerCountAndAmount" : @"false",//单独发人数金额
             @"picHasTop" : @"true",//图片账单包含积分榜
             @"picCompressValue" : @"1",//图片压缩系数
             @"hightBet" : @"5000",//高押注变色
             @"sendHongbaoSmallNumber" : @"0",//发包金额尾数
             @"betBillHeadStr" : @"",//押注单头
             @"betBillLastStr" : @"",//押注单尾
             @"revokeMsgHint" : @"true",//出单前撤注提醒
             @"revokeMsgHintForShowBill" : @"false",//出单后撤注提醒
             @"savedAutoSendPic" : @"true",//存储后自动出图
             @"savedAutoSendTop" : @"false",//存储后自动出积分榜
             @"topHasNewScoreChange" : @"true",//积分榜包含最近上下分
             @"autoSendTopType" : @"3",//存储后自动出积分榜的格式, 1:文字 2:文本 3:表格 4:图片
             @"autoSendTopExcelLineNum" : @"3",//
             @"autoOpenHongbaoWait" : @"10",//自动读取红包等待时间
             
             //图片账单配置
             @"headIndex" : @"false",//默认
             @"trendIndex" : @"false",
             @"titleR" : @"0",
             @"titleG" : @"0",
             @"titleB" : @"0",
             @"titleTextR" : @"255",
             @"titleTextG" : @"255",
             @"titleTextB" : @"255",
             @"trendCurrentR" : @"185",
             @"trendCurrentG" : @"105",
             @"trendCurrentB" : @"0",
             @"trendHighR" : @"218",
             @"trendHighG" : @"96",
             @"trendHighB" : @"125",
            
             };
}

//恢复默认设置
-(void) setBaseSettingDefault {
    self.mBaseSetting = [[self getDefaultSetting] mutableCopy];
    [self saveBaseSettingFile];
}

//保存每天数据
-(void) saveDataInfos {
    [ycFunction saveFile: niuniuRobotDataDayInfosFile dic: self.mDayInfosList];
}

//保存机器人为修改记录
-(void) saveReworksFile {
    [ycFunction saveFileArray: niuniuRobotDataReworksFile array: self.mReworksList];
}

//保存基本设置
-(void) saveBaseSettingFile {
    [ycFunction saveFile: niuniuRobotDataBaseSetting dic: self.mBaseSetting];
}

//保存账单广告图
-(void) saveBillHeadPic: (UIImage*)img {
    self.mBaseSetting[@"headIndex"] = @"true";
    [self saveBaseSettingFile];
    [ycFunction savePicFile:img path:niuniuRobotDataBillHeadPicFile];
}

//获取账单广告图
-(UIImage*) getBillHeadPic {
    if ([self.mBaseSetting[@"headIndex"] isEqualToString: @"true"]) {
        UIImage* img = [ycFunction getPicFile: niuniuRobotDataBillHeadPicFile];
        if (img) {
            return img;
        }
    }
    return [UIImage imageNamed: @"head1.png"];
}

//保存账单走势图背景图
-(void) saveBillTrendPic: (UIImage*)img {
    self.mBaseSetting[@"trendIndex"] = @"true";
    [self saveBaseSettingFile];
    [ycFunction savePicFile:img path:niuniuRobotDataBillTrendPicFile];
}

//获取账单走势图背景图
-(UIImage*) getBillTrendPic {
    if ([self.mBaseSetting[@"trendIndex"] isEqualToString: @"true"]) {
        UIImage* img = [ycFunction getPicFile: niuniuRobotDataBillTrendPicFile];
        if (img) {
            return img;
        }
    }
    return [UIImage imageNamed: @"trend6.png"];
}

//保存后台群
-(void) saveBackgroundChatroom:(NSArray*)array {
    [ycFunction saveFileArray: niuniuRobotDataBackgroundChatroom array: array];
}

//获取缓存保存后台群
-(NSArray*) getBackgroundChatroom {
    return [ycFunction readFileArray:niuniuRobotDataBackgroundChatroom];
}

//保存群邀请数据
-(void) saveChatroomInviteListFile {
    [ycFunction saveFile: niuniuRobotDataChatroomInvite dic: self.mChatroomInviteList];
}

//删除部分回合数据
-(int) clearPartRounds:(int)endRoundNum {
    int count = (int)[self.mRounds count];
    for (int i = 0; i < [self.mRounds count]; ) {
        NSDictionary* dic = self.mRounds[i];
        if ([dic[@"number"] intValue] <= endRoundNum) {
            [self.mRounds removeObjectAtIndex: i];
        } else {
            i++;
        }
    }
    [self saveAllRoundFile];
    tmanager.mRobot.mNumber = [self lastRoundNumber]+1;
    return count-(int)[self.mRounds count];
}

//清空回合
-(void) clearRounds {
    [self.mRounds removeAllObjects];
    [self saveRoundFile];
    tmanager.mRobot.mNumber = [self lastRoundNumber]+1;
}

//删除部分上下分记录
-(int) clearPartScoreChangedRecords:(int)endRoundNum {
    int count = (int)[self.mScoreChangedRecords count];
    for (int i = 0; i < [self.mScoreChangedRecords count]; ) {
        NSDictionary* dic = self.mScoreChangedRecords[i];
        if ([dic[@"round"] intValue] <= endRoundNum) {
            [self.mScoreChangedRecords removeObjectAtIndex: i];
        } else {
            i++;
        }
    }
    [self saveScoreChangedRecordsFile];
    return count-(int)[self.mScoreChangedRecords count];
}

//清空上下分纪录
-(void) clearScoreChangedRecords {
    [self.mScoreChangedRecords removeAllObjects];
    [self saveScoreChangedRecordsFile];
}

//清空会员积分数据
-(void) clearMemberScores {
    [tmanager.mRobot.mMembers clearAllScore];
    [self saveMemberListFile];
}

//清空会员数据
-(void) clearMembers {
    [self.mMemberList removeAllObjects];
    [self saveMemberListFile];
}

//清空管理
-(void) clearAdmins {
    [self.mAdminList removeAllObjects];
    [self saveAdminListFile];
}

//清空托
-(void) clearTuos {
    [self.mTuoList removeAllObjects];
    [self saveTuoListFile];
}

//清空拉手
-(void) clearLashous {
    [self.mLashouList removeAllObjects];
    [self saveLashouListFile];
}

//清空拉手团长
-(void) clearLashouHeads {
    [self.mLashouHeadList removeAllObjects];
    [self saveLashouHeadListFile];
}

-(void) bakAllFiles2Chat {
    UIViewController* controller = [ycFunction getCurrentVisableVC];
    if (!controller) {
        return;
    }
    
    NSString* className = NSStringFromClass([controller class]);
    NSString* target = nil;
    if([className isEqualToString: @"BaseMsgContentViewController"]) {
        id concact = [controller performSelector: @selector(GetContact) withObject:nil];
        target = [ycFunction getVar:concact name: @"m_nsUsrName"];
    }
    if (!target) {
        [ycFunction showMsg: @"界面不在聊天窗口" msg: nil vc: nil];
        return;
    }
    
    NSString* cachePath = [ycFunction getCachesDirectory];
    
    NSArray* files = [self allDataFileNames];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    for (NSString* filename in files) {
        if ([ycFunction isFileExist: filename]) {
            dic[filename] = deString(@"%@/%@", cachePath, filename);
        }
    }
    
    NSString* tmpFileFullPath = deString(@"%@/%@", cachePath, deAliTmpFile);
    if (![ycFunction czip: tmpFileFullPath pw:nil files:dic]) {
        [ycFunction showMsg:@"压缩失败！！" msg:nil vc:nil];
    }
    NSData* data = [NSData dataWithContentsOfFile: tmpFileFullPath];
    [tmanager.mRobot.mSendMsg sendFile:target title: deString(@"备份数据库(%d局).zip", tmanager.mRobot.mNumber) ext:@".zip" data:data];
}

-(void) resumeAllFilesFromZip:(NSString*)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath: path]) {
        [ycFunction showMsg: @"恢复失败" msg: @"zip文件不存在！" vc: nil];
        return;
    }
    NSData* data = [NSData dataWithContentsOfFile: path];
    if (!data || data.length < 1000) {
        [ycFunction showMsg: @"恢复失败" msg: @"zip文件数据异常！" vc: nil];
        return;
    }
    
    [self removeAllDataFile];
    
    if ([ycFunction uzip: path pw:nil outFileRoot: [ycFunction getCachesDirectory]]) {
        [[[[UIAlertView alloc] initWithTitle: @"恢复成功，需要立即重启!" message: nil delegate:self cancelButtonTitle: @"重启" otherButtonTitles: nil] autorelease] show];
    } else {
        [ycFunction showMsg: @"恢复失败" msg: @"数据解压失败！" vc: nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    exit(0);
}

//获取所有文件
-(NSArray*) allDataFileNames {
    NSMutableArray* files = [[@[niuniuRobotDataBaseSetting, niuniuRobotDataMemberList, niuniuRobotDataAdminList, niuniuRobotDataTuoList, niuniuRobotDataLashouList, niuniuRobotDataLashouHeadList, niuniuRobotDataScoreChangedRecords, niuniuRobotDataBackgroundChatroom, niuniuRobotDataChatroomInvite, niuniuRobotDataBillHeadPicFile, niuniuRobotDataBillTrendPicFile, niuniuRobotDataDayInfosFile, niuniuRobotDataReworksFile] mutableCopy] autorelease];
    for (int i = 0; i < niuniuRobotDataRoundsMax; ++i) {
        [files addObject: [self getRoundFilename: i]];
    }
    return files;
}

//删除所有文件缓存
-(void) removeAllDataFile {
    NSArray* files = [self allDataFileNames];
    for (NSString* file in files) {
        [[NSFileManager defaultManager] removeItemAtPath: [ycFunction fullFilename: file] error:NULL];
    }
}

#pragma mark- mark
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

