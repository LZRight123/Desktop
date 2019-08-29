//
//  niuniuRobotBet.m
//  wechatHook
//
//  Created by antion on 2017/2/23.
//
//


/*
 下注积分、有效下注、无效下注在出单前未必是准确的, 积分是否足够押注以及是否是庄身份没有检测
 */

#import "niuniuRobotBet.h"
#import "ycFunction.h"
#import "toolManager.h"
#import "niuniuRobot.h"
#import "wxFunction.h"

@implementation niuniuRobotBet

-(id) init {
    if (self = [super init]) {
        self.mPlayerBets = [@[] mutableCopy];
        self.mPlayerBetsValid = [@[] mutableCopy];
        self.mPlayerBetsInvalid = [@[] mutableCopy];
        self.mFuliSetting = [@{} mutableCopy];
        self.mBankers = [@[] mutableCopy];
        self.mShowBillRecords = [@{} mutableCopy];
        self.mBetRecordCount = 0;
        self.mInvalidBetRecordCount = 0;
        self.mBetScoreCount = 0;
        self.mBetScoreSuohaCount = 0;
        self.mBetScoreLonghuCount = 0;
        self.mBetScoreLonghuHeCount = 0;
        self.mBetScoreTemaCount = 0;
        self.mBetScoreBaijialeCount = 0;
        self.mLimitBet = 0;
        self.mLimitSuohaBet = 0;
        self.mLimitLonghuBet = 0;
        self.mLimitLonghuHeBet = 0;
        self.mLimitTema = 0;
        self.mLimitBaijiale = 0;
        self.mDelegate = nil;
        self.mIsRatio = YES;
        self.mIsShowBilled = NO;
        self.mLastBillText = @"";
        self.mLastPlayerCountAndAmountText = @"";
    }
    return self;
}

-(void) dealloc {
    NSLog(@"niuniuHelper dealloc");
    
    if (self.mPlayerBets) {
        [self.mPlayerBets release];
    }
    
    if (self.mPlayerBetsValid) {
        [self.mPlayerBetsValid release];
    }
    
    if (self.mPlayerBetsInvalid) {
        [self.mPlayerBetsInvalid release];
    }
    
    if (self.mFuliSetting) {
        self.mFuliSetting = nil;
    }
    
    if (self.mBankers) {
        [self.mBankers release];
    }
    
    if (self.mShowBillRecords) {
        [self.mShowBillRecords release];
    }
    
    self.mLastBillText = nil;
    self.mLastPlayerCountAndAmountText = nil;
    [super dealloc];
}

//清理下注数据
-(void) clearBetData: (BOOL)clearBanker {
    self.mBetRecordCount = 0;
    self.mBetScoreCount = 0;
    self.mBetScoreSuohaCount = 0;
    self.mBetScoreLonghuCount = 0;
    self.mBetScoreLonghuHeCount = 0;
    self.mBetScoreTemaCount = 0;
    self.mBetScoreBaijialeCount = 0;
    self.mInvalidBetRecordCount = 0;
    self.mIsShowBilled = NO;
    [self.mPlayerBets removeAllObjects];
    [self.mPlayerBetsValid removeAllObjects];
    [self.mPlayerBetsInvalid removeAllObjects];
    
    if (clearBanker) {
        self.mIsRatio = NO;
        [self.mBankers removeAllObjects];
        self.mLimitBet = 0;
        self.mLimitSuohaBet = 0;
        self.mLimitLonghuBet = 0;
        self.mLimitLonghuHeBet = 0;
        self.mLimitTema = 0;
        self.mLimitBaijiale = 0;
    } else {
        self.mBetRecordCount = [self.mBankers count] > 0 ? 1 : 0;
    }
}

//来自已有数据
-(void) loadWithRoundData: (NSDictionary*)dic {
    [self clearBetData: YES];
    
    for (NSDictionary* banker in dic[@"bankers"]) {
        [self addBanker: banker[@"userid"] name: banker[@"name"]];
        [self setBankerFee: [self getBanker: banker[@"userid"]] num:[banker[@"num"] intValue]];
        if (banker[@"isMain"]) {
            [self setMainBanker: [self getBanker: banker[@"userid"]]];
        }
    }
    
    NSMutableArray* array = [NSMutableArray arrayWithArray: dic[@"players"]];
    [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"betIndex"] intValue] > [b[@"betIndex"] intValue] ? 1 : -1;
    }];
    for (NSDictionary* dic in array) {
        [self playerBet: dic[@"name"] userid: dic[@"userid"] num: [dic[@"num"] intValue] values: dic[@"values"] content:@"" from: @"roundData"];
    }
    
    self.mIsRatio = [dic[@"betVars"][@"mIsRatio"] isEqualToString: @"true"];
    {//福利庄
        [self.mFuliSetting removeAllObjects];
        for (NSString* key in dic[@"betVars"][@"mFuliSetting"]) {
            self.mFuliSetting[key] = dic[@"betVars"][@"mFuliSetting"][key];
        }
        if (self.mFuliSetting[@"sections"]) {
            self.mFuliSetting[@"sections"] = [NSMutableArray arrayWithArray: self.mFuliSetting[@"sections"]];
        }
    }
   
    [self endBet];
}

//开始下注
-(void) startBet: (NSString*)type value:(id)value {
    [tmanager.mRobot changeStatus: eNiuniuRobotStatusBet];
    [self clearBetData: YES];
    
    if (![type isEqualToString: @"new"] && [tmanager.mRobot.mData.mRounds count] > 0) {
        NSDictionary* lastRound = [tmanager.mRobot.mData.mRounds lastObject];
        NSArray* bankers = lastRound[@"bankers"];
        int bankerFee = 0;
        if ([type isEqualToString: @"again"]) {//庄续
            bankerFee = [value intValue];
        } else if ([type isEqualToString: @"full"]) {//庄铺
            self.mIsRatio = NO;//铺不抽水
            bankerFee = [lastRound[@"otherInfo"][@"bankerMoney"] intValue];
        }
        if (bankers) {
            for (NSDictionary* banker in bankers) {
                [self addBanker:banker[@"userid"] name:banker[@"name"]];
                [self setBankerFee: [self getBanker: banker[@"userid"]] num:[banker[@"ratio"] floatValue]*bankerFee];
                if (banker[@"isMain"]) {
                    [self setMainBanker: [self getBanker: banker[@"userid"]]];
                }
            }
        }
    }
}

//取消下注(返回)
-(void) cancelBet {
    [tmanager.mRobot changeStatus: eNiuniuRobotStatusNone];
    [self clearBetData: YES];
}

//准备
-(BOOL) ready {
    if (!self.mIsShowBilled) {
        [[[[UIAlertView alloc] initWithTitle: nil message: @"要先出单" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
        return NO;
    }
    [tmanager.mRobot changeStatus: eNiuniuRobotStatusResult];
    [tmanager.mRobot.mResult setHongbaoData: nil];
    return YES;
}

//结束下注
-(NSString*) endBet {
    for (NSMutableDictionary* dic in self.mBankers) {
        int num = [dic[@"num"] intValue];
        if (num == 0) {
            return @"庄费未设置";
        }
        int score = [tmanager.mRobot.mMembers getMemberScore:dic[@"userid"]];
        if (score < num) {
            return deString(@"[%@]庄费不够", dic[@"name"]);
        }
        dic[@"score"] = deInt2String(score);
    }
    
    if ([self.mPlayerBets count] == 0) {
        return @"没有闲";
    }
    
    [self updateLimit];
    BOOL longhuLimitMutil = [tmanager.mRobot.mData.mBaseSetting[@"longhuLimitMutil"] isEqualToString: @"true"];
    int limit = self.mLimitBet;
    int limitSuoha = self.mLimitSuohaBet;
    if (tmanager.mRobot.mEnableNiuniu) {
        if ([self.mBankers count] == 0) {
            return @"没有庄";
        }
        
        if (self.mFuliSetting[@"enable"] && [self.mFuliSetting[@"enable"] isEqualToString: @"true"]) {
            BOOL allNiuniu = [self.mFuliSetting[@"allNiuniu"] isEqualToString: @"true"];
            int value = [self.mFuliSetting[@"value"] intValue];
            for (NSMutableDictionary* dic in self.mPlayerBets) {
                if (allNiuniu || [dic[@"betType"] isEqualToString: @"niuniu"]) {
                    int oldNum = [dic[@"num"] intValue];
                    int newNum = value;
                    BOOL niuniuBet = [dic[@"betType"] isEqualToString: @"niuniu"] && ![dic[@"suoha"] isEqualToString: @"true"];
                    if ([self.mFuliSetting[@"type"] isEqualToString: @"limit"]) {
                        oldNum = niuniuBet ? oldNum : oldNum/10;
                        newNum = oldNum > newNum ? newNum : oldNum;
                    }
                    else if ([self.mFuliSetting[@"type"] isEqualToString: @"section"]) {
                        oldNum = niuniuBet ? oldNum : oldNum/10;
                        for (NSString* str in self.mFuliSetting[@"sections"]) {
                            NSArray* array = [str componentsSeparatedByString: @"-"];
                            if (oldNum >= [array[0] intValue] && oldNum <= [array[1] intValue]) {
                                newNum = [array[2] intValue];
                                break;
                            }
                        }
                    }
                    dic[@"num"] = deInt2String(newNum);
                    [self setBetValues: dic values: @[
                                                      @{
                                                          @"type":@"niuniu",
                                                          @"suoha":@"false",
                                                          @"mianyong":@"false",
                                                          @"yibi":@"false",
                                                          @"num":dic[@"num"]
                                                          }
                                                      ]];
                    [self checkNumValid: dic];
                    [self checkHasScore: dic];
                }
                int score = [tmanager.mRobot.mMembers getMemberScore: dic[@"userid"]];
                if (score < [self.mFuliSetting[@"minScore"] intValue]) {
                    dic[@"valid"] = @"false";
                    [self checkRepeat: dic[@"userid"]];
                }
            }
            [self updateBetCount];
            if (self.mDelegate) {
                [self.mDelegate hasPlayerBet];
            }
        }
    }
    
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    NSMutableArray* allPlayerBet = [NSMutableArray array];
    for (NSInteger i = [self.mPlayerBets count]-1; i >= 0; --i) {
        NSMutableDictionary* dic = self.mPlayerBets[i];
        NSMutableDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (memData) {//更新积分
            dic[@"score"] = memData[@"score"];
        }
        if (![dic[@"hasScore"] isEqualToString: @"true"]) {//更新是否足够积分
            [self checkHasScore: dic];
        }
        if (!dic[@"billName"]) {
            if(memData) {
                dic[@"billName"] = memData[@"billName"];
                dic[@"remarkName"] = [niuniuRobotMembers newRemark: memData];
            }
        }

        NSMutableDictionary* validDic = nil;
        for (NSMutableDictionary* d in allPlayerBet) {
            if ([d[@"userid"] isEqualToString: dic[@"userid"]]) {
                validDic = d;
                break;
            }
        }
        
        if (!validDic) {
            validDic = [NSMutableDictionary dictionaryWithDictionary: dic];
            [allPlayerBet addObject: validDic];
        }
        
        NSDictionary* banker = [self getBanker: validDic[@"userid"]];
        if ([dic[@"valid"] isEqualToString: @"true"] && [dic[@"numValid"] isEqualToString: @"true"] && [dic[@"hasScore"] isEqualToString: @"true"] && !banker) {
            validDic[@"valid"] = dic[@"valid"];
            validDic[@"numValid"] = dic[@"numValid"];
            validDic[@"hasScore"] = dic[@"hasScore"];
            validDic[@"num"] = dic[@"num"];
            validDic[@"values"] = dic[@"values"];
            validDic[@"valuesStr"] = dic[@"valuesStr"];
            validDic[@"suoha"] = dic[@"suoha"];
            validDic[@"betType"] = dic[@"betType"];
            validDic[@"checkOk"] = @"true";
        }
    }
    
    [self.mPlayerBetsValid removeAllObjects];
    [self.mPlayerBetsInvalid removeAllObjects];
    for (NSMutableDictionary* dic in allPlayerBet) {
        if (dic[@"checkOk"]) {
            int score = [tmanager.mRobot.mMembers getMemberScore: dic[@"userid"]];
            if ([dic[@"betType"] isEqualToString: @"niuniu"]) {
                if ([dic[@"suoha"] isEqualToString: @"true"]) {
                    if ([dic[@"num"] intValue] > limitSuoha) {
                        dic[@"num_old"] = dic[@"num"];
                        dic[@"num"] = deInt2String(limitSuoha);
                        dic[@"outScore"] = @"true";
                    }
                    if (score < [dic[@"num"] intValue]) {
                        if (!dic[@"num_old"]) {
                            dic[@"num_old"] = dic[@"num"];
                        }
                        dic[@"num"] = deInt2String(score);
                        dic[@"notEnoughScore"] = @"true";
                    }
                } else {
                    if ([dic[@"num"] intValue] > limit) {
                        dic[@"num_old"] = dic[@"num"];
                        dic[@"num"] = deInt2String(limit);
                        dic[@"outScore"] = @"true";
                    }
                    if (score < [dic[@"num"] intValue]*10) {
                        if (!dic[@"num_old"]) {
                            dic[@"num_old"] = dic[@"num"];
                        }
                        dic[@"num"] = deInt2String(score/10);
                        dic[@"notEnoughScore"] = @"true";
                    }
                }
                [self setBetValues: dic values: dic[@"values"]];
            } else if([dic[@"betType"] isEqualToString: @"longhu"]){
                NSMutableArray* values = [NSMutableArray array];
                BOOL skipZuhe = NO;
                int numCount = 0;
                int maxBetCount = [setting[@"longhuMaxBet"] intValue];
                for (NSDictionary* v in dic[@"values"]) {
                    int num = [v[@"num"] intValue];
                    int newNum = num;
                    int minbet = 0;
                    int maxbet = 0;
                    if ([v[@"type"] isEqualToString: @"合"]) {
                        minbet = [setting[@"longhuMinBetHe"] intValue];
                        maxbet = [setting[@"longhuMaxBetHe"] intValue];
                    } else {
                        minbet = [setting[@"longhuMinBet"] intValue];
                        maxbet = [setting[@"longhuMaxBet"] intValue];
                    }
                    if (newNum > maxbet) {
                        newNum = maxbet;
                        dic[@"outScore"] = @"true";
                    }
                    if (newNum + numCount > maxBetCount) {
                        dic[@"outScore"] = @"true";
                        newNum = maxBetCount-numCount;
                    }
                    if (score < numCount+newNum) {
                        newNum = score-numCount;
                        dic[@"notEnoughScore"] = @"true";
                    }
                    if (newNum < minbet) {
                        dic[@"partInvalid"] = @"true";
                        continue;
                    }
                    if ([v[@"type"] isEqualToString: @"大单"] || [v[@"type"] isEqualToString: @"大双"] || [v[@"type"] isEqualToString: @"小单"] || [v[@"type"] isEqualToString: @"小双"]) {
                        if (skipZuhe) {
                            dic[@"partInvalid"] = @"true";
                            continue;
                        }
                        if (longhuLimitMutil) {
                            skipZuhe = YES;
                        }
                    }
                    [values addObject: @{
                                         @"type":v[@"type"],
                                         @"num":deInt2String(newNum)
                                         }];
                    numCount += newNum;
                }
                dic[@"num"] = deInt2String(numCount);
                [self setBetValues: dic values: values];
            } else if([dic[@"betType"] isEqualToString: @"tema"]){
                int minbet = [setting[@"temaMinBet"] intValue];
                int maxbet = [setting[@"temaMaxBet"] intValue];
                int numCount = 0;
                NSMutableArray* values = [NSMutableArray array];
                for (NSDictionary* v in dic[@"values"]) {
                    int num = [v[@"num"] intValue];
                    int temaLength = (int)[v[@"bet"] length];
                    int numNeed = num * temaLength;
                    if (numNeed + numCount > maxbet) {
                        dic[@"outScore"] = @"true";
                        numNeed = maxbet-numCount;
                    }
                    if (score < numCount+numNeed) {
                        numNeed = score-numCount;
                        dic[@"notEnoughScore"] = @"true";
                    }
                    num = numNeed/temaLength;
                    if (num < minbet) {
                        dic[@"partInvalid"] = @"true";
                        continue;
                    }
                    [values addObject: @{
                                          @"type" : @"tema",
                                          @"bet" : v[@"bet"],
                                          @"num" : deString(@"%d", num),
                                          }];
                    numCount += numNeed;
                }
                dic[@"num"] = deInt2String(numCount);
                [self setBetValues: dic values: values];
            } else if([dic[@"betType"] isEqualToString: @"baijiale"]){
                NSMutableArray* values = [NSMutableArray array];
                int numCount = 0;
                int maxBetCount = [setting[@"baijialeMaxBet"] intValue];
                for (NSDictionary* v in dic[@"values"]) {
                    int num = [v[@"num"] intValue];
                    int newNum = num;
                    int minbet = [setting[@"baijialeMinBet"] intValue];
                    int maxbet = [setting[@"baijialeMaxBet"] intValue];
                    if (newNum > maxbet) {
                        newNum = maxbet;
                        dic[@"outScore"] = @"true";
                    }
                    if (newNum + numCount > maxBetCount) {
                        dic[@"outScore"] = @"true";
                        newNum = maxBetCount-numCount;
                    }
                    if (score < numCount+newNum) {
                        newNum = score-numCount;
                        dic[@"notEnoughScore"] = @"true";
                    }
                    if (newNum < minbet) {
                        dic[@"partInvalid"] = @"true";
                        continue;
                    }
                    [values addObject: @{
                                         @"type":@"baijiale",
                                         @"bet":v[@"bet"],
                                         @"num":deInt2String(newNum)
                                         }];
                    numCount += newNum;
                }
                dic[@"num"] = deInt2String(numCount);
                [self setBetValues: dic values: values];
            }
            [self checkNumValid: dic];
            if (![dic[@"numValid"] isEqualToString: @"true"]) {
                [dic removeObjectForKey: @"checkOk"];
                dic[@"hint"] = @"已下分";
                [self.mPlayerBetsInvalid addObject: dic];
                continue;
            }
            else if (dic[@"outScore"] || dic[@"notEnoughScore"] || [dic[@"partInvalid"] isEqualToString: @"true"] || [dic[@"repeat"] isEqualToString: @"true"]) {
                NSMutableString* hint = [NSMutableString string];
                if([dic[@"repeat"] isEqualToString: @"true"]) {
                    [hint appendString: @"重复"];
                }
                if(dic[@"outScore"]) {
                    if(hint.length > 0) {
                        [hint appendString: @"|"];
                    }
                    [hint appendString: @"庄限"];
                }
                if(dic[@"notEnoughScore"]) {
                    if(hint.length > 0) {
                        [hint appendString: @"|"];
                    }
                    [hint appendString: @"闲限"];
                }
                if(dic[@"partInvalid"]) {
                    if(hint.length > 0) {
                        [hint appendString: @"|"];
                    }
                    [hint appendString: @"部分无效"];
                }
                dic[@"hint"] = hint;
            }
            [self.mPlayerBetsValid addObject: dic];
        } else {
            NSMutableString* hint = [NSMutableString string];
            if (![dic[@"valid"] isEqualToString: @"true"]) {
                [hint appendString: @"图下无"];
            }
            if (![dic[@"numValid"] isEqualToString: @"true"]) {
                if(hint.length > 0) {
                    [hint appendString: @"|"];
                }
                [hint appendString: @"押注低"];
            }
            if (![dic[@"hasScore"] isEqualToString: @"true"]) {
                if(hint.length > 0) {
                    [hint appendString: @"|"];
                }
                [hint appendString: @"无积分"];
            }
            NSDictionary* banker = [self getBanker: dic[@"userid"]];
            if (banker) {
                if(hint.length > 0) {
                    [hint appendString: @"|"];
                }
                [hint appendString: @"庄家身份"];
            }
            dic[@"hint"] = hint;
            [self.mPlayerBetsInvalid addObject: dic];
        }
    }
    
    self.mBetRecordCount = [self.mPlayerBetsValid count]+(tmanager.mRobot.mEnableNiuniu ? 1 : 0);
    self.mInvalidBetRecordCount = [self.mPlayerBetsInvalid count];
    self.mBetScoreCount = 0;
    self.mBetScoreSuohaCount = 0;
    self.mBetScoreLonghuCount = 0;
    self.mBetScoreLonghuHeCount = 0;
    self.mBetScoreTemaCount = 0;
    self.mBetScoreBaijialeCount = 0;
    int index = 0;
    for (NSMutableDictionary* dic in self.mPlayerBetsValid) {
        dic[@"betIndex"] = deInt2String(index++);
        if([dic[@"betType"] isEqualToString: @"niuniu"]) {
            if([dic[@"suoha"] isEqualToString: @"true"]) {
                self.mBetScoreSuohaCount += [dic[@"num"] intValue];
            } else {
                self.mBetScoreCount += [dic[@"num"] intValue];
            }
        } else if([dic[@"betType"] isEqualToString: @"tema"]) {
            for(NSDictionary* value in dic[@"values"]) {
                self.mBetScoreTemaCount += [value[@"num"] intValue];
            }
        } else if([dic[@"betType"] isEqualToString: @"baijiale"]) {
            self.mBetScoreBaijialeCount += [dic[@"num"] intValue];
        } else if([dic[@"betType"] isEqualToString: @"longhu"]) {
            int daxiaoCount = 0;
            int heCount = 0;
            for(NSDictionary* value in dic[@"values"]) {
                if([value[@"type"] isEqualToString: @"合"]) {
                    heCount += [value[@"num"] intValue];
                } else {
                    daxiaoCount += [value[@"num"] intValue];
                }
            }
            self.mBetScoreLonghuCount += daxiaoCount;
            self.mBetScoreLonghuHeCount += heCount;
        }
    }
    if (self.mDelegate) {
        [self.mDelegate headInfoChanged];
    }
    return nil;
}

//添加标题
-(NSString*) addTitle: (NSString*)title {
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"　　♤%@♤\n", title];
    [text appendString: @"──────────\n"];
    return text;
}

-(UILabel*) addLabel: (UIView*)view frame:(CGRect)frame text:(NSString*)text color:(UIColor*)color isLeft:(BOOL)isLeft {
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

-(UIView*) addLine: (UIView*)view frame:(CGRect)frame color:(UIColor*)color {
    UIView* line = [[UIView alloc] initWithFrame: frame];
    line.backgroundColor = color;
    [view addSubview: line];
    [line release];
    return view;
}

//出押注单
-(void) showBill {
    NSString* errMsg = [self endBet];
    if (errMsg) {
        [[[[UIAlertView alloc] initWithTitle: nil message: errMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
        return;
    }
    
    {//二次出单检测
        NSString* key = deInt2String(tmanager.mRobot.mNumber);
        if (self.mShowBillRecords[key]) {
            [tmanager.mRobot.mRework addReworkRecord: @{
                                                  @"type" : @"showBillMore",
                                                  @"round" : key
                                                  }];
        } else {
            self.mShowBillRecords[key] = @"true";
        }
    }
    
    self.mIsShowBilled = YES;
    
    int sendHongbaoSmallNumber = [tmanager.mRobot.mData.mBaseSetting[@"sendHongbaoSmallNumber"] intValue];
    
    NSMutableString* text = [NSMutableString string];
    if (![tmanager.mRobot.mData.mBaseSetting[@"betBillHeadStr"] isEqualToString: @""]) {
        [text appendFormat: @"%@\n", tmanager.mRobot.mData.mBaseSetting[@"betBillHeadStr"]];
    }
    
//    int fee = [tmanager.mRobot.mBet getAllBankerFee];
//    [text appendString: [self addTitle: @"基本信息"]];
//    [text appendString: deString(@"庄上积分: %d\n", fee)];
//    if (tmanager.mRobot.mEnableNiuniu) {
//        if([tmanager.mRobot.mData.mBaseSetting[@"niuniuOnlySuoha"] isEqualToString: @"true"]) {
//            [text appendString: deString(@"牛牛下注: %d\n", (int)self.mBetScoreSuohaCount]);
//        } else {
//            [text appendString: deString(@"牛牛下注: %d\n", (int)self.mBetScoreCount]);
//            [text appendString: deString(@"牛牛梭哈: %d\n", (int)self.mBetScoreSuohaCount]);
//        }
//    }
//    if(tmanager.mRobot.mEnableLonghu) {
//        [text appendString: deString(@"龙虎下注: %d\n", (int)self.mBetScoreLonghuCount+(int)self.mBetScoreLonghuHeCount]);
//    }
//         
//    [text appendString: deString(@"有效下注: %d%@\n", (int)self.mBetRecordCount,tmanager.mRobot.mEnableNiuniu ? @"(含庄)" : @"")];
//    [text appendString: deString(@"无效下注: %d  重复: %d\n", (int)self.mInvalidBetRecordCount, [self getRepeatBetCount])];

//    if([tmanager.mRobot.mBet.mBankers count] > 0) {
//        [text appendString: [self addTitle: @"庄　家"]];
//        for ( NSDictionary* dic in tmanager.mRobot.mBet.mBankers) {
//            [text appendString: deString(@"%@　 上 %@\n", deFillName(dic[@"billName"]), dic[@"num"])];
//        }
//    }
    
    NSMutableArray* niuniuPlayers = [NSMutableArray array];
    NSMutableArray* longhuPlayers = [NSMutableArray array];
    NSMutableArray* temaPlayers = [NSMutableArray array];
    NSMutableArray* baijialePlayers = [NSMutableArray array];
    
//    [text appendString: [self addTitle: @"正常下注"]];
    for ( NSDictionary* dic in tmanager.mRobot.mBet.mPlayerBetsValid) {
//        if(!dic[@"hint"]) {
            if([dic[@"betType"] isEqualToString: @"niuniu"]) {
//                if (tmanager.mRobot.mEnableLonghu) {
//                    [text appendString: deString(@"%@　 %@\n", deFillName(dic[@"billName"]), dic[@"num"])];
//                } else {
//                    BOOL suoha = [dic[@"suoha"] isEqualToString: @"true"];
//                    NSString* betStr = (onlySuoha || !suoha) ? @"下" : @"梭";
//                    [text appendString: deString(@"%@　 %@ %@\n", deFillName(dic[@"billName"]), betStr, dic[@"num"])];
//                }
                [niuniuPlayers addObject: dic];
            } else if([dic[@"betType"] isEqualToString: @"longhu"]){
//                [text appendString: deString(@"%@　 %@\n", deFillName(dic[@"billName"]), dic[@"valuesStr"])];
                [longhuPlayers addObject: dic];
            } else if([dic[@"betType"] isEqualToString: @"tema"]) {
                [temaPlayers addObject: dic];
            } else if([dic[@"betType"] isEqualToString: @"baijiale"]) {
                [baijialePlayers addObject: dic];
            }
//        }
    }
 
//    BOOL addHead = NO;
//    for ( NSDictionary* dic in tmanager.mRobot.mBet.mPlayerBetsValid) {
//        if(dic[@"hint"]) {
//            if(!addHead) {
//                addHead = YES;
//                [text appendString: [self addTitle: @"非正常下注"]];
//            }
//            
//            if([dic[@"betType"] isEqualToString: @"niuniu"]) {
//                BOOL suoha = [dic[@"suoha"] isEqualToString: @"true"];
//                if(dic[@"num_old"]) {
//                    NSString* betStr = (onlySuoha || !suoha) ? @"下" : @"梭";
//                    [text appendString: deString(@"%@　 %@ %@ 认 %@(%@)\n", deFillName(dic[@"billName"]), betStr, dic[@"num_old"], dic[@"num"], dic[@"hint"])];
//                } else {
//                    NSString* betStr = (onlySuoha || !suoha) ? @"" : @"梭";
//                    [text appendString: deString(@"%@　 认 %@%@(%@)\n", deFillName(dic[@"billName"]), betStr, dic[@"num"], dic[@"hint"])];
//                }
//            } else {
//                [text appendString: deString(@"%@　 认 %@(%@)\n", deFillName(dic[@"billName"]), dic[@"valuesStr"], dic[@"hint"])];
//            }
//        }
//    }
    
    [niuniuPlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (a[@"hint"] && b[@"hint"]) {
            return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
        }
        if(a[@"hint"]) {
            return 1;
        }
        if (b[@"hint"]) {
            return -1;
        }
        return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
    }];
    
    [longhuPlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (a[@"hint"] && b[@"hint"]) {
            return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
        }
        if(a[@"hint"]) {
            return 1;
        }
        if (b[@"hint"]) {
            return -1;
        }
        return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
    }];
    
    [temaPlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (a[@"hint"] && b[@"hint"]) {
            return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
        }
        if(a[@"hint"]) {
            return 1;
        }
        if (b[@"hint"]) {
            return -1;
        }
        return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
    }];
    
    [baijialePlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (a[@"hint"] && b[@"hint"]) {
            return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
        }
        if(a[@"hint"]) {
            return 1;
        }
        if (b[@"hint"]) {
            return -1;
        }
        return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
    }];
    
    if ([niuniuPlayers count] > 0) {
        [text appendString: [self addTitle: @"牛　牛"]];
        for (NSDictionary* dic in niuniuPlayers) {
            if (dic[@"hint"]) {
                BOOL suoha = [dic[@"suoha"] isEqualToString: @"true"];
                if(dic[@"num_old"]) {
                    NSString* betStr = !suoha ? @"下" : @"梭";
                    if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                        betStr = @"免";
                    }
                    else if ([dic[@"yibi"] isEqualToString: @"true"]) {
                        betStr = @"一比";
                    }
                    [text appendString: deString(@"%@　 %@ %@ 认 %@(%@)\n", deFillName(dic[@"billName"]), betStr, dic[@"num_old"], dic[@"num"], dic[@"hint"])];
                } else {
                    NSString* betStr = !suoha ? @"" : @"梭";
                    if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                        betStr = @"免";
                    }
                    else if ([dic[@"yibi"] isEqualToString: @"true"]) {
                        betStr = @"一比";
                    }
                    [text appendString: deString(@"%@　 认 %@%@(%@)\n", deFillName(dic[@"billName"]), betStr, dic[@"num"], dic[@"hint"])];
                }
            } else {
                BOOL suoha = [dic[@"suoha"] isEqualToString: @"true"];
                NSString* betStr = !suoha ? @"下" : @"梭";
                if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                    betStr = @"免";
                }
                else if ([dic[@"yibi"] isEqualToString: @"true"]) {
                    betStr = @"一比";
                }
                [text appendString: deString(@"%@　 %@ %@\n", deFillName(dic[@"billName"]), betStr, dic[@"num"])];
            }
        }
    }
    
    if ([longhuPlayers count] > 0) {
        [text appendString: [self addTitle: @"大小单双"]];
        for (NSDictionary* dic in longhuPlayers) {
            if (dic[@"hint"]) {
                [text appendString: deString(@"%@　 认 %@(%@)\n", deFillName(dic[@"billName"]), dic[@"valuesStr"], dic[@"hint"])];
            } else {
                [text appendString: deString(@"%@　 %@\n", deFillName(dic[@"billName"]), dic[@"valuesStr"])];
            }
        }
    }
    
    if ([temaPlayers count] > 0) {
        [text appendString: [self addTitle: @"特　码"]];
        for (NSDictionary* dic in temaPlayers) {
            if (dic[@"hint"]) {
                [text appendString: deString(@"%@　 认 %@(%@)\n", deFillName(dic[@"billName"]), dic[@"valuesStr"], dic[@"hint"])];
            } else {
                [text appendString: deString(@"%@　 %@\n", deFillName(dic[@"billName"]), dic[@"valuesStr"])];
            }
        }
    }
    
    if ([baijialePlayers count] > 0) {
        [text appendString: [self addTitle: @"百家乐"]];
        for (NSDictionary* dic in baijialePlayers) {
            if (dic[@"hint"]) {
                [text appendString: deString(@"%@　 认 %@(%@)\n", deFillName(dic[@"billName"]), dic[@"valuesStr"], dic[@"hint"])];
            } else {
                [text appendString: deString(@"%@　 %@\n", deFillName(dic[@"billName"]), dic[@"valuesStr"])];
            }
        }
    }
    
    BOOL addHead = NO;
    for ( NSDictionary* dic in tmanager.mRobot.mBet.mPlayerBetsInvalid) {
        if(!dic[@"checkOk"]) {
            if(!addHead) {
                addHead = YES;
                [text appendString: [self addTitle: @"无效下注"]];
            }
            [text appendString: deString(@"%@　 %@\n", dic[@"billName"] ? deFillName(dic[@"billName"]) : dic[@"name"], dic[@"hint"])];
        }
    }
    
    if (![tmanager.mRobot.mData.mBaseSetting[@"betBillLastStr"] isEqualToString: @""]) {
        [text appendString: @"──────────\n"];
        [text appendFormat: @"%@\n", tmanager.mRobot.mData.mBaseSetting[@"betBillLastStr"]];
    }
     
     [text appendString: @"──────────\n"];
    int hongbaoCount = (int)tmanager.mRobot.mBet.mBetRecordCount > 100 ? 100 : (int)tmanager.mRobot.mBet.mBetRecordCount;
    NSString* playerCountAndAmountText = deString(@"人数: %d  金额: %d.%d",  (int)tmanager.mRobot.mBet.mBetRecordCount, hongbaoCount*2, sendHongbaoSmallNumber);
     [text appendFormat: @"%@\n", playerCountAndAmountText];

     [[[[UIAlertView alloc] initWithTitle: nil message: text delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"发送", nil] autorelease] show];
    
    //UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    //pasteboard.string = text;
     
    self.mLastBillText = text;
    self.mLastPlayerCountAndAmountText = playerCountAndAmountText;
    NSLog(@"押注单: %@", text);
}

-(UIImage*) showPicBill {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    UIView* view = [[[UIView alloc] initWithFrame: CGRectMake(0, 0, 400, 1000)] autorelease];
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
    int hCount = 0;
    
    int sendHongbaoSmallNumber = [tmanager.mRobot.mData.mBaseSetting[@"sendHongbaoSmallNumber"] intValue];

    NSMutableArray* niuniuPlayers = [NSMutableArray array];
    NSMutableArray* longhuPlayers = [NSMutableArray array];
    NSMutableArray* temaPlayers = [NSMutableArray array];
    NSMutableArray* baijialePlayers = [NSMutableArray array];
    
    for ( NSDictionary* dic in tmanager.mRobot.mBet.mPlayerBetsValid) {
        if([dic[@"betType"] isEqualToString: @"niuniu"]) {
            [niuniuPlayers addObject: dic];
        } else if([dic[@"betType"] isEqualToString: @"longhu"]){
            [longhuPlayers addObject: dic];
        } else if([dic[@"betType"] isEqualToString: @"tema"]) {
            [temaPlayers addObject: dic];
        } else if([dic[@"betType"] isEqualToString: @"baijiale"]) {
            [baijialePlayers addObject: dic];
        }
    }
    
    [niuniuPlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (a[@"hint"] && b[@"hint"]) {
            return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
        }
        if(a[@"hint"]) {
            return 1;
        }
        if (b[@"hint"]) {
            return -1;
        }
        return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
    }];
    
    [longhuPlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (a[@"hint"] && b[@"hint"]) {
            return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
        }
        if(a[@"hint"]) {
            return 1;
        }
        if (b[@"hint"]) {
            return -1;
        }
        return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
    }];
    
    [temaPlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (a[@"hint"] && b[@"hint"]) {
            return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
        }
        if(a[@"hint"]) {
            return 1;
        }
        if (b[@"hint"]) {
            return -1;
        }
        return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
    }];
    
    [baijialePlayers sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (a[@"hint"] && b[@"hint"]) {
            return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
        }
        if(a[@"hint"]) {
            return 1;
        }
        if (b[@"hint"]) {
            return -1;
        }
        return [a[@"num"] intValue] > [b[@"num"] intValue] ? 1 : -1;
    }];
    
    if ([niuniuPlayers count] > 0) {
        NSArray* array = @[
                           @[@120, @"牛牛玩家"],
                           @[@280, @"下注"],
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
        for (NSDictionary* dic in niuniuPlayers) {
            NSString* str;
            if (dic[@"hint"]) {
                BOOL suoha = [dic[@"suoha"] isEqualToString: @"true"];
                if(dic[@"num_old"]) {
                    NSString* betStr = !suoha ? @"下" : @"梭";
                    if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                        betStr = @"免";
                    }
                    else if ([dic[@"yibi"] isEqualToString: @"true"]) {
                        betStr = @"一比";
                    }
                    str = deString(@"%@ %@ 认 %@(%@)", betStr, dic[@"num_old"], dic[@"num"], dic[@"hint"]);
                } else {
                    NSString* betStr = !suoha ? @"" : @"梭";
                    if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                        betStr = @"免";
                    }
                    else if ([dic[@"yibi"] isEqualToString: @"true"]) {
                        betStr = @"一比";
                    }
                    str = deString(@"认 %@%@(%@)", betStr, dic[@"num"], dic[@"hint"]);
                }
            } else {
                BOOL suoha = [dic[@"suoha"] isEqualToString: @"true"];
                NSString* betStr = !suoha ? @"下" : @"梭";
                if ([dic[@"mianyong"] isEqualToString: @"true"]) {
                    betStr = @"免";
                }
                else if ([dic[@"yibi"] isEqualToString: @"true"]) {
                    betStr = @"一比";
                }
                str = deString(@"%@ %@", betStr, dic[@"num"]);
            }
            NSArray* values = @[
                                @[dic[@"billName"]],
                                @[str],
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
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:YES];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
            
            ++index;
        }
    }
    
    if ([longhuPlayers count] > 0) {
        NSArray* array = @[
                           @[@120, @"大小单双玩家"],
                           @[@280, @"下注"],
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
        for (NSDictionary* dic in longhuPlayers) {
            NSString* str;
            if (dic[@"hint"]) {
                str = deString(@"认 %@(%@)", dic[@"valuesStr"], dic[@"hint"]);
            } else {
                str = deString(@"%@", dic[@"valuesStr"]);
            }
            NSArray* values = @[
                                @[dic[@"billName"]],
                                @[str],
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
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:YES];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
            
            ++index;
        }
    }
    
    if ([temaPlayers count] > 0) {
        NSArray* array = @[
                           @[@120, @"特码玩家"],
                           @[@280, @"下注"],
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
        for (NSDictionary* dic in temaPlayers) {
            NSString* str;
            if (dic[@"hint"]) {
                str = deString(@"认 %@(%@)", dic[@"valuesStr"], dic[@"hint"]);
            } else {
                str = deString(@"%@", dic[@"valuesStr"]);
            }
            
            NSArray* values = @[
                                @[dic[@"billName"]],
                                @[str],
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
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:YES];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
            
            ++index;
        }
    }
    
    if ([baijialePlayers count] > 0) {
        NSArray* array = @[
                           @[@120, @"百家乐玩家"],
                           @[@280, @"下注"],
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
        for (NSDictionary* dic in baijialePlayers) {
            NSString* str;
            if (dic[@"hint"]) {
                str = deString(@"认 %@(%@)", dic[@"valuesStr"], dic[@"hint"]);
            } else {
                str = deString(@"%@", dic[@"valuesStr"]);
            }
            
            NSArray* values = @[
                                @[dic[@"billName"]],
                                @[str],
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
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:YES];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
            
            ++index;
        }
    }
    
    NSArray* array = @[
                       @[@120, @"无效玩家"],
                       @[@280, @"原因"],
                       ];
    int wCnt = 0;
    int index = 1;
    BOOL addHead = NO;
    for ( NSDictionary* dic in tmanager.mRobot.mBet.mPlayerBetsInvalid) {
        if(!dic[@"checkOk"]) {
            if(!addHead) {
                addHead = YES;
                [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
                int wCnt = 0;
                for (NSArray* config in array) {
                    int w = [config[0] intValue];
                    [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
                    wCnt += w;
                }
                hCount += titleh;
            }
            
            NSArray* values = @[
                                @[dic[@"billName"] ? dic[@"billName"] : dic[@"name"]],
                                @[dic[@"hint"]],
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
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:YES];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
            
            ++index;
        }
    }
    

    int hongbaoCount = (int)tmanager.mRobot.mBet.mBetRecordCount > 100 ? 100 : (int)tmanager.mRobot.mBet.mBetRecordCount;
    NSString* str = deString(@"人数: %d  金额: %d.%d\n",  (int)tmanager.mRobot.mBet.mBetRecordCount, hongbaoCount*2, sendHongbaoSmallNumber);
    [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
    [self addLabel: view frame:CGRectMake(view.frame.size.width/2-100, hCount, 200, titleh) text:str color: titleColor isLeft:NO];
    hCount += titleh;
    
    //-----------
    float compressValue = [tmanager.mRobot.mData.mBaseSetting[@"picCompressValue"] floatValue];
    
    CGRect frame = view.frame;
    frame.size = CGSizeMake(frame.size.width, hCount);
    view.frame = frame;
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(compressValue < 1){//压缩
        NSData* data = UIImageJPEGRepresentation(viewImage, compressValue);
        if (data) {
            viewImage = [UIImage imageWithData: data];
        }
    }
    return viewImage;
}
         
//报
-(void) sendLimit {
    NSString* bankerName = nil;
    NSString* errMsg = nil;
    for (NSDictionary* dic in self.mBankers) {
        int num = [dic[@"num"] intValue];
        if (num == 0) {
            errMsg = @"庄费未设置";
            break;
        }
        if([dic[@"isMain"] isEqualToString: @"true"]) {
            bankerName = dic[@"billName"];
        }
    }
    
    int bankerMoney = [self getAllBankerFee];
    if(bankerMoney <= 0) {
        errMsg = @"庄费未设置";
    }
    
    if(errMsg) {
        [ycFunction showMsg: errMsg msg:nil vc:nil];
        return;
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendString: [self addTitle: @"开始下注"]];
    [text appendFormat: @"本局庄家: %@\n", bankerName];
    [text appendFormat: @"庄上积分: %d\n", bankerMoney];
    if(tmanager.mRobot.mEnableNiuniu) {
        [text appendFormat: @"牛牛最低下注: %@\n", tmanager.mRobot.mData.mBaseSetting[@"minBet"]];
        [text appendFormat: @"牛牛最高下注: %d\n", self.mLimitBet];
        [text appendFormat: @"牛牛最低梭哈: %@\n", tmanager.mRobot.mData.mBaseSetting[@"minBetSuoha"]];
        [text appendFormat: @"牛牛最高梭哈: %d\n", self.mLimitSuohaBet];
    }
    if(tmanager.mRobot.mEnableLonghu) {
        [text appendFormat: @"大小单双最低下注: %@\n", tmanager.mRobot.mData.mBaseSetting[@"longhuMinBet"]];
        [text appendFormat: @"大小单双最高下注: %d\n", self.mLimitLonghuBet];
        [text appendFormat: @"合最低下注: %@\n", tmanager.mRobot.mData.mBaseSetting[@"longhuMinBetHe"]];
        [text appendFormat: @"合最高下注: %d\n", self.mLimitLonghuHeBet];
    }
    if (tmanager.mRobot.mEnableTema) {
        [text appendFormat: @"特码最低下注: %@\n", tmanager.mRobot.mData.mBaseSetting[@"temaMinBet"]];
        [text appendFormat: @"特码最高下注: %d\n", self.mLimitTema];
    }
    if (tmanager.mRobot.mEnableBaijiale) {
        [text appendFormat: @"百家乐最低下注: %@\n", tmanager.mRobot.mData.mBaseSetting[@"baijialeMinBet"]];
        [text appendFormat: @"百家乐最高下注: %d\n", self.mLimitBaijiale];
    }
    [tmanager.mRobot.mSendMsg sendTextNow:tmanager.mRobot.mGameRoom content:text at:nil title:@""];
}

//@无效人员
-(void) atInvalid {
    if (!self.mIsShowBilled) {
        [[[[UIAlertView alloc] initWithTitle: nil message: @"要先出单" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] autorelease] show];
        return;
    }
    
    if(!tmanager.mRobot.mGameRoom) {
        return;
    }
    
    NSMutableDictionary* allUnderBill = [NSMutableDictionary dictionary];
    NSMutableArray* allBeted = [NSMutableArray array];
    
    //图下无
    for (NSDictionary* dic in self.mPlayerBets) {
        if(![dic[@"valid"] isEqualToString: @"true"]) {
            allUnderBill[dic[@"userid"]] = dic;
        }
    }
    
    //图下无的人有压过
    for ( NSDictionary* dic in tmanager.mRobot.mBet.mPlayerBetsValid) {
        if(allUnderBill[dic[@"userid"]]) {
            [allBeted addObject: dic[@"name"]];
            [allUnderBill removeObjectForKey: dic[@"userid"]];
        }
    }
    
    //重复提示
    NSMutableString* text = [NSMutableString string];
     for ( NSDictionary* dic in tmanager.mRobot.mBet.mPlayerBetsInvalid) {
         if(!dic[@"checkOk"]) {
             [text appendFormat: @"@%@ %@\n", dic[@"name"], dic[@"hint"]];
             if(allUnderBill[dic[@"userid"]]) {
                 [allUnderBill removeObjectForKey: dic[@"userid"]];
             }
         }
     }
    
    //图下无
    NSArray* values = [allUnderBill allValues];
    for ( NSDictionary* dic in values ) {
        [text appendFormat: @"@%@ 图下无\n", dic[@"name"]];
    }
    
    if ([allBeted count] > 0) {
        if (text.length > 0) {
            [text appendString: @"\n"];
        }
        [text appendString: @"───以下玩家有──\n"];
        for ( NSString* name in allBeted ) {
            [text appendFormat: @"@%@ 认单上押注\n", name];
        }
    }

    if(text.length > 0) {
        [tmanager.mRobot.mSendMsg sendTextNow:tmanager.mRobot.mGameRoom content:text at:nil title:@""];
    }
}
     
//消息框
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        if(tmanager.mRobot.mGameRoom) {
            if ([tmanager.mRobot.mData.mBaseSetting[@"showPicBillForBet"] isEqualToString: @"true"]) {
                UIImage* image = [self showPicBill];
                [tmanager.mRobot.mSendMsg sendPic: tmanager.mRobot.mGameRoom img: image];
            } else {
                [tmanager.mRobot.mSendMsg sendTextNow:tmanager.mRobot.mGameRoom content:self.mLastBillText at:nil title:@""];
            }
            if ([tmanager.mRobot.mData.mBaseSetting[@"sendPlayerCountAndAmount"] isEqualToString: @"true"]) {
                [self performSelector: @selector(sendPlayerCountAndAmountText) withObject:nil afterDelay:1];
            }
        }
    }
}

-(void) sendPlayerCountAndAmountText {
    [tmanager.mRobot.mSendMsg sendTextNow:tmanager.mRobot.mGameRoom content:self.mLastPlayerCountAndAmountText at:nil title:@""];
}

//重新加载下注列表
-(BOOL) reloadBetList {
    [self clearBetData: NO];
    
    UIViewController* controller =[ycFunction getCurrentVisableVC];
    if (!controller) {
        return NO;
    }
    NSString* className = NSStringFromClass([controller class]);
    if(![className isEqualToString: @"BaseMsgContentViewController"]) {
        return NO;
    }
    
    id concact = [controller performSelector: @selector(GetContact) withObject:nil];
    id m_nsUsrName = [ycFunction getVar:concact name: @"m_nsUsrName"];
    if (![m_nsUsrName isEqualToString: tmanager.mRobot.mGameRoom]) {//群
        return NO;
    }
    
    NSArray* array = [controller performSelector: @selector(GetMessagesWrapArray) withObject:nil];
    if ([array count] < 200) {
        //多加载200个聊天记录, 一次20个
        for (int i = 0; i < 10; ++i) {
            [controller performSelector:@selector(ScrollToBottomAnimatedAndLoadMoreNode) withObject:nil];
        }
        array = [controller performSelector: @selector(GetMessagesWrapArray) withObject:nil];
    }
    
    BOOL hasBet = NO;
    NSMutableArray* filterArray = [NSMutableArray array];
    for (NSInteger i = [array count]-1; i >= 0; --i) {
        id msg = array[i];
        int m_uiMessageType = [ycFunction getVarInt: msg name: @"m_uiMessageType"];
        NSString* m_nsContent = [ycFunction getVar: msg name: @"m_nsContent"];
        NSString* m_nsRealChatUsr = [ycFunction getVar: msg name: @"m_nsRealChatUsr"];
        
        if(49 == m_uiMessageType) {//xml
            if ([tmanager.mRobot parseIsHongbao: m_nsContent] && hasBet) {//红包
                break;
            }
        } else if(1 == m_uiMessageType) {//普通消息
            if (!hasBet) {
                int bet;
                NSArray* values;
                hasBet = [tmanager.mRobot parseBet:m_nsRealChatUsr content:m_nsContent outBetCount:&bet outValues:&values];
            }
        }
        [filterArray insertObject: msg atIndex: 0];
    }
    
    for (id msg in filterArray) {
        [tmanager.mRobot addMsg: msg isNew: NO];
    }
    return YES;
}

//添加一个庄
-(BOOL) addBanker:(NSString*)userid name:(NSString*)name {
    if ([self getBanker: userid]) {
        return NO;
    }
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"userid"] = userid;
    dic[@"name"] = name;
    dic[@"num"] = @"0";
    dic[@"isMain"] = [self getMainBanker] ? @"false" : @"true";
    dic[@"banker"] = @"true";
    NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
    if(memData) {
        dic[@"billName"] = memData[@"billName"];
        dic[@"remarkName"] = [niuniuRobotMembers newRemark: memData];
    }
    [self.mBankers addObject: dic];
    
    [self updateLimit];
    if (self.mDelegate) {
        [self.mDelegate bankerInfoChanged];
    }
    return YES;
}

//删除一个庄
-(void) removeBankerWithIndex:(int)index {
    NSDictionary* dic = self.mBankers[index];
    if (dic) {
        [self.mBankers removeObjectAtIndex: index];
        NSMutableDictionary* mainBanker = [self getMainBanker];
        if(!mainBanker && [self.mBankers count] > 0) {
            [self setMainBanker: self.mBankers[0]];
        }
        [self updateLimit];
        if (self.mDelegate) {
            [self.mDelegate bankerInfoChanged];
        }
    }
}

//设置庄费
-(void) setBankerFee:(NSMutableDictionary*)dic num:(int)num {
    dic[@"num"] = deInt2String(num);
    [self updateLimit];
    if (self.mDelegate) {
        [self.mDelegate bankerInfoChanged];
    }
}

//设置是否抽水
-(void) setIsRatio:(BOOL)b {
    self.mIsRatio = b;
    if (self.mDelegate) {
        [self.mDelegate bankerInfoChanged];
    }
}

//获取庄家
-(NSMutableDictionary*) getBanker:(NSString*)userid {
    for (NSMutableDictionary* dic in self.mBankers) {
        if ([dic[@"userid"] isEqualToString: userid]) {
            return dic;
        }
    }
    return nil;
}

//获取主庄家
-(NSMutableDictionary*) getMainBanker {
    for (NSMutableDictionary* dic in self.mBankers) {
        if ([dic[@"isMain"] isEqualToString: @"true"]) {
            return dic;
        }
    }
    return nil;
}

//设置主庄家
-(void) setMainBanker:(NSMutableDictionary*)banker {
    for (NSMutableDictionary* dic in self.mBankers) {
        dic[@"isMain"] = @"false";
    }
    banker[@"isMain"] = @"true";
    if (self.mDelegate) {
        [self.mDelegate bankerInfoChanged];
    }
}

//获取总庄费
-(int) getAllBankerFee {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    int count = 0;
    for (NSMutableDictionary* dic in self.mBankers) {
        count += [dic[@"num"] intValue];
    }
    if (self.mIsRatio) {
        count *= 1 - [setting[@"ratio"] floatValue];
    }
    return count;
}

//删除下注
-(void) removeBetWithIndex:(int)index {
    NSDictionary* dic = self.mPlayerBets[index];
    if (dic) {
        NSString* userid = [dic[@"userid"] retain];
        [self.mPlayerBets removeObjectAtIndex: index];
        [self checkRepeat: userid];
        [self updateBetCount];
        [userid release];
        if (self.mDelegate) {
            [self.mDelegate hasBetRemoved];
        }
    }
}

//设置下注是否有效
-(void) setBetValid:(int)index valid:(BOOL)valid {
    NSMutableDictionary* dic = self.mPlayerBets[index];
    if (!dic) {
        return;
    }
    if ([dic[@"valid"] isEqualToString: @"true"] == valid) {
        return;
    }
    dic[@"valid"] = valid ? @"true" : @"false";
    NSString* userid = dic[@"userid"];
    [self checkRepeat: userid];
    [self updateBetCount];
    if (self.mDelegate) {
        [self.mDelegate betHasChanged: userid];
    }
}

//获取某个人的所有下注索引
-(NSArray*) betIndexs:(NSString*)userid {
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < [self.mPlayerBets count]; ++i) {
        NSDictionary* dic = self.mPlayerBets[i];
        if ([dic[@"userid"] isEqualToString: userid]) {
            [array addObject: deInt2String(i)];
        }
    }
    return array;
}

//获取重复个数
-(int) getRepeatBetCount {
    NSMutableDictionary* allPlayer = [NSMutableDictionary dictionary];
    for (NSDictionary* dic in self.mPlayerBets) {
        allPlayer[dic[@"userid"]] = @YES;
    }
    return (int)([self.mPlayerBets count] - [allPlayer count]);
}

//获取托下注个数
-(int) getTuoBetCount {
    int ret = 0;
    for (NSDictionary* dic in self.mPlayerBetsValid) {
        if ([tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
            ++ret;
        }
    }
    return ret;
}

//检测重复
-(void) checkRepeat:(NSString*)userid {
    NSMutableArray* array = [NSMutableArray array];
    for (NSDictionary* dic in self.mPlayerBets) {
        if ([dic[@"userid"] isEqualToString: userid]) {
            [array addObject: dic];
        }
    }
    for (NSMutableDictionary* dic in array) {
        dic[@"repeat"] = [array count] > 1 ? @"true" : @"false";
    }
}
     
//检查下注值是否有效
-(void) checkNumValid:(NSMutableDictionary*)dic {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if([dic[@"betType"] isEqualToString: @"niuniu"]) {
        if([dic[@"suoha"] isEqualToString: @"true"]) {
            dic[@"numValid"] = [dic[@"num"] intValue] >= [setting[@"minBetSuoha"] intValue] ? @"true" : @"false";
        } else {
            dic[@"numValid"] = [dic[@"num"] intValue] >= [setting[@"minBet"] intValue] ? @"true" : @"false";
        }
    } else if([dic[@"betType"] isEqualToString: @"tema"]) {
        dic[@"numValid"] = @"false";
        for(NSDictionary* v in dic[@"values"]) {
            if([v[@"num"] intValue] >= [setting[@"temaMinBet"] intValue]) {
                dic[@"numValid"] = @"true";
                break;
            }
        }
    } else if([dic[@"betType"] isEqualToString: @"baijiale"]) {
        dic[@"numValid"] = @"false";
        for(NSDictionary* v in dic[@"values"]) {
            if([v[@"num"] intValue] >= [setting[@"baijialeMinBet"] intValue]) {
                dic[@"numValid"] = @"true";
                break;
            }
        }
    } else if([dic[@"betType"] isEqualToString: @"longhu"]){
        dic[@"numValid"] = @"false";
        for(NSDictionary* v in dic[@"values"]) {
            if([v[@"type"] isEqualToString: @"合"]) {
                if([v[@"num"] intValue] >= [setting[@"longhuMinBetHe"] intValue]) {
                    dic[@"numValid"] = @"true";
                    break;
                }
            } else {
                if([v[@"num"] intValue] >= [setting[@"longhuMinBet"] intValue]) {
                    dic[@"numValid"] = @"true";
                    break;
                }
            }
        }
    }
}
     
//检查是否足够最低分
-(void) checkHasScore:(NSMutableDictionary*)dic {
    dic[@"hasScore"] = @"false";
    NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
    if(!memData) {
        return;
    }
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if([dic[@"betType"] isEqualToString: @"niuniu"]) {
        if([dic[@"suoha"] isEqualToString: @"true"]) {
            if([memData[@"score"] intValue] >= [setting[@"minBetSuoha"] intValue]) {
                dic[@"hasScore"] = @"true";
            }
        }else {
            if([memData[@"score"] intValue] >= [setting[@"minBet"] intValue]*10) {
                dic[@"hasScore"] = @"true";
            }
        }
    } else if([dic[@"betType"] isEqualToString: @"tema"]) {
        if ([memData[@"score"] intValue] >= [setting[@"temaMinBet"] intValue]) {
            dic[@"hasScore"] = @"true";
        }
    } else if([dic[@"betType"] isEqualToString: @"baijiale"]) {
        if ([memData[@"score"] intValue] >= [setting[@"baijialeMinBet"] intValue]) {
            dic[@"hasScore"] = @"true";
        }
    } else if([dic[@"betType"] isEqualToString: @"longhu"]) {
        int score = [memData[@"score"] intValue];
        int minBet = [setting[@"longhuMinBet"] intValue];
        for(NSDictionary* v in dic[@"values"]) {
            if([v[@"type"] isEqualToString: @"合"]) {
                minBet = [setting[@"longhuMinBetHe"] intValue];
                break;
            }
        }
        if(score >= minBet) {
            dic[@"hasScore"] = @"true";
        }
    }
}
     
//设置押注详细值
-(void) setBetValues: (NSMutableDictionary*)dic values:(NSArray*)values{
    dic[@"betType"] = @"longhu";
    for(NSDictionary* value in values) {
        if([value[@"type"] isEqualToString: @"niuniu"]) {
            dic[@"betType"] = @"niuniu";
            dic[@"suoha"] = value[@"suoha"];
            dic[@"mianyong"] = value[@"mianyong"];
            dic[@"yibi"] = value[@"yibi"];
            break;
        }
        else if([value[@"type"] isEqualToString: @"tema"]) {
            dic[@"betType"] = @"tema";
            break;
        }
        else if([value[@"type"] isEqualToString: @"baijiale"]) {
            dic[@"betType"] = @"baijiale";
            break;
        }
    }
    
    dic[@"values"] = values;
    if([dic[@"betType"] isEqualToString: @"longhu"]) {
        NSMutableString* text = [NSMutableString string];
        for(NSDictionary* v in values) {
            [text appendFormat:@"%@%@", v[@"type"], v[@"num"]];
        }
        dic[@"valuesStr"] = text;
    } else if([dic[@"betType"] isEqualToString: @"tema"]) {
        int index = 0;
        NSMutableString* text = [NSMutableString string];
        for (NSDictionary* dic in values) {
            if (index++ > 0) {
                [text appendString: @"#"];
            }
            [text appendFormat: @"%@买%@", dic[@"bet"], dic[@"num"]];
        }
        dic[@"valuesStr"] = text;
    } else if([dic[@"betType"] isEqualToString: @"baijiale"]) {
        NSMutableString* text = [NSMutableString string];
        for(NSDictionary* v in values) {
            [text appendFormat:@"%@%@", v[@"bet"], v[@"num"]];
        }
        dic[@"valuesStr"] = text;
    } else if([dic[@"betType"] isEqualToString: @"niuniu"]){
        if ([dic[@"mianyong"] isEqualToString: @"true"]) {
            dic[@"valuesStr"] = deString(@"免%@", dic[@"num"]);
        } else if ([dic[@"yibi"] isEqualToString: @"true"]) {
            dic[@"valuesStr"] = deString(@"一比%@", dic[@"num"]);
        } else {
            dic[@"valuesStr"] = deString(@"%@%@", [dic[@"suoha"] isEqualToString: @"true"] ? @"梭哈" : @"", dic[@"num"]);
        }
    }
}
         
//更新限压
-(void) updateLimit {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if(tmanager.mRobot.mEnableNiuniu) {
        int bankerFee = [self getAllBankerFee];
        if(![setting[@"isHeshuiMode"] isEqualToString: @"true"]) {//不喝水
            self.mLimitBet = [setting[@"maxBet"] intValue];
            self.mLimitSuohaBet = [setting[@"maxBetSuoha"] intValue];
        } else {
            self.mLimitBet = bankerFee * [setting[@"betLimit"] floatValue];
            self.mLimitSuohaBet = self.mLimitBet * 10;
        }
    }
    
    if(tmanager.mRobot.mEnableLonghu) {
        self.mLimitLonghuBet = [setting[@"longhuMaxBet"] intValue];
        self.mLimitLonghuHeBet = [setting[@"longhuMaxBetHe"] intValue];
    }
    
    if (tmanager.mRobot.mEnableTema) {
        self.mLimitTema = [setting[@"temaMaxBet"] intValue];
    }
    
    if (tmanager.mRobot.mEnableBaijiale) {
        self.mLimitBaijiale = [setting[@"baijialeMaxBet"] intValue];
    }
}

//更新下注统计
-(void) updateBetCount {
    NSMutableDictionary* playerBets = [NSMutableDictionary dictionary];
    for (NSInteger i = [self.mPlayerBets count]-1; i >= 0; --i) {
        NSDictionary* dic = self.mPlayerBets[i];
        if ([dic[@"valid"] isEqualToString: @"true"] && [dic[@"numValid"] isEqualToString: @"true"] && [dic[@"hasScore"] isEqualToString: @"true"]) {
            playerBets[dic[@"userid"]] = dic;
        }
    }
    self.mBetRecordCount = [playerBets count]+(tmanager.mRobot.mEnableNiuniu ? 1 : 0);//含庄
    self.mInvalidBetRecordCount = [self.mPlayerBets count]-[playerBets count];
    self.mBetScoreCount = 0;
    self.mBetScoreSuohaCount = 0;
    self.mBetScoreLonghuCount = 0;
    self.mBetScoreLonghuHeCount = 0;
    for (NSDictionary* dic in [playerBets allValues]) {
        if([dic[@"betType"] isEqualToString: @"niuniu"]) {
            if([dic[@"suoha"] isEqualToString: @"true"]) {
                self.mBetScoreSuohaCount += [dic[@"num"] intValue];
            } else {
                self.mBetScoreCount += [dic[@"num"] intValue];
            }
        } else if([dic[@"betType"] isEqualToString: @"tema"]) {
            for(NSDictionary* value in dic[@"values"]) {
                self.mBetScoreTemaCount += [value[@"num"] intValue];
            }
        } else if([dic[@"betType"] isEqualToString: @"baijiale"]) {
            self.mBetScoreBaijialeCount += [dic[@"num"] intValue];
        } else if([dic[@"betType"] isEqualToString: @"longhu"]){
            int daxiaoCount = 0;
            int heCount = 0;
            for(NSDictionary* value in dic[@"values"]) {
                if([value[@"type"] isEqualToString: @"合"]) {
                    heCount += [value[@"num"] intValue];
                } else {
                    daxiaoCount += [value[@"num"] intValue];
                }
            }
            self.mBetScoreLonghuCount += daxiaoCount;
            self.mBetScoreLonghuHeCount += heCount;
        }
    }
}

//玩家下注逻辑
-(void) playerBet:(NSString*)name userid:(NSString*)userid num:(int)num values:(NSArray*)values content:(NSString*)content from:(NSString*)from{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"name"] = name;
    dic[@"userid"] = userid;
    dic[@"msgid"] = content;
    dic[@"num"] = deInt2String(num);
    dic[@"repeat"] = @"false";
    dic[@"valid"] = self.mIsShowBilled ? @"false" : @"true";
    dic[@"values"] = values;
    dic[@"score"] = @"0";
    
    NSMutableDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
    if(memData) {
        memData[@"name"] = name;//更新名字
        dic[@"score"] = memData[@"score"];
        dic[@"billName"] = memData[@"billName"];
        dic[@"remarkName"] = [niuniuRobotMembers newRemark: memData];
    }
    
    [self setBetValues: dic values: values];
    [self checkNumValid: dic];
    [self checkHasScore: dic];

    [self.mPlayerBets insertObject:dic atIndex:0];
    [self checkRepeat: userid];
    [self updateBetCount];
    
    if ([from isEqualToString: @"new"] || [from isEqualToString: @"manual"]) {
        if (self.mDelegate) {
            [self.mDelegate hasPlayerBet];
        }
    }
}

//撤回下注
-(void) revokeBet: (NSString*)msgid {
    int index = -1;
    for (int i = 0; i < [self.mPlayerBets count]; ++i) {
        NSString* playerMsgid = self.mPlayerBets[i][@"msgid"];
        if (playerMsgid && [playerMsgid isEqualToString: msgid]) {
            index = i;
            break;
        }
    }
    
    if (-1 == index) {
        return;
    }
        
    NSMutableDictionary* dic = self.mPlayerBets[index];
    if (self.mIsShowBilled) {
        if ([tmanager.mRobot.mData.mBaseSetting[@"revokeMsgHintForShowBill"] isEqualToString: @"true"]) {
            NSString* text = deString(@"❌撤注失败请认单❌\n%@[%@]", dic[@"billName"] ? dic[@"billName"] : dic[@"name"], dic[@"valuesStr"]);
            [tmanager.mRobot.mSendMsg sendTextNow:tmanager.mRobot.mGameRoom content:text at:nil title:@""];
        }
    } else {
        if ([tmanager.mRobot.mData.mBaseSetting[@"revokeMsgHint"] isEqualToString: @"true"]) {
            NSString* text = deString(@"✅撤注成功✅\n%@[%@]", dic[@"billName"] ? dic[@"billName"] : dic[@"name"], dic[@"valuesStr"]);
            [tmanager.mRobot.mSendMsg sendTextNow:tmanager.mRobot.mGameRoom content:text at:nil title:@""];
            [self removeBetWithIndex: index];
        }
    }
}

//设置玩家下注值
-(void) setBetNum:(NSMutableDictionary*)dic num:(int)num values:(NSArray*)values {
    dic[@"num"] = deInt2String(num);
    [self setBetValues: dic values: values];
    [self checkNumValid: dic];
    [self checkHasScore: dic];
    [self updateBetCount];
    if (self.mDelegate) {
        [self.mDelegate betHasChanged: dic[@"userid"]];
    }
}
     
//一键导入
/*
 ──────────
 　　♤牛　牛♤
 ──────────
 卓宝　　　 150
 ＳＬ　　　 248
 大卢　　　 258
 我们的纪　 10000
 洛花有意　 12000
 一二一二　 认 200(重复)
 ｒｙｈｓ　 下 8888 认 1936(闲限)
 ──────────
 　　♤大小单双♤
 ──────────
 顺顺心心　 大200
 鸿运当头　 大200
 ＢＢＧ　　 小400
 三生三世　 小1760
 小兔子　　 单1855
 百变金２　 大1888
 ──────────
 　　♤无效下注♤
 ──────────
 打杂剧赚　 无积分
 ──────────
 发包: 92  金额: 184
 */
-(NSString*) importPlayers: (NSString*)billText {
    [self clearBetData: NO];
    
    int betBegin = (int)[@"哈哈哈哈　 " length];
    NSMutableDictionary* players = [NSMutableDictionary dictionary];
    
    NSString* current = @"null";
    NSArray* lines = [billText componentsSeparatedByString: @"\n"];
    for (NSString* str in lines) {
        if ([str containsString: @"♤牛　牛♤"]) {
            current = @"niuniu";
            continue;
        }
        else if ([str containsString: @"♤大小单双♤"]) {
            current = @"daxiao";
            continue;
        }
        else if ([str containsString: @"♤特　码♤"]) {
            current = @"tema";
            continue;
        }
        else if ([str containsString: @"♤百家乐♤"]) {
            current = @"baijiale";
            continue;
        }
        else if ([str containsString: @"─────"]) {
            continue;
        }
        else if ([str containsString: @"♤无效下注♤"]) {
            break;
        }
        
        if ([current isEqualToString: @"null"]) {
            continue;
        }
        
        NSRange range = [str rangeOfString: @"　"];
        if (range.location != NSNotFound) {
            NSString* playername = [str substringToIndex: range.location];
            NSString* betStr = [str substringFromIndex: betBegin];
            if (playername && betStr) {
                players[playername] = @{
                                        @"type" : current,
                                        @"betstr" : betStr
                                        };
            }
        }
    }
    
    int count2 = 0;
    NSArray* memList = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSDictionary* memData in memList) {
        NSDictionary* dic = players[memData[@"billName"]];
        if (dic) {
            ++count2;
            NSString* type = dic[@"type"];
            if ([type isEqualToString: @"niuniu"]) {
                NSString* str = dic[@"betstr"];
                NSArray* arr = [str componentsSeparatedByCharactersInSet: [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]];
                int betInt = 0;
                for (int i = (int)[arr count]-1; i >= 0; --i) {
                    betInt = [arr[i] intValue];
                    if (betInt > 0) {
                        break;
                    }
                }
                if (betInt > 0) {
                    NSString* bet;
                    if ([str containsString: @"梭"]) {
                        bet = deString(@"梭哈%d", betInt);
                    } else if ([str containsString: @"免"]) {
                        bet = deString(@"免%d", betInt);
                    } else {
                        bet = deInt2String(betInt);
                    }
                    int num;
                    NSArray* values = nil;
                    if ([tmanager.mRobot parseBet:memData[@"userid"] content:bet outBetCount:&num outValues:&values]) {
                        [self playerBet:memData[@"name"] userid:memData[@"userid"] num:num values: values content:@"#导入添加#" from: @"import"];
                    }
                }
            }
            else if ([type isEqualToString: @"daxiao"]) {
                NSString* str = dic[@"betstr"];
                NSRange range = [str rangeOfString: @"认 "];
                if (range.location != NSNotFound) {
                    NSRange range2 = [str rangeOfString: @"("];
                    if (range2.location != NSNotFound) {
                        NSRange range3 = {range.location+range.length, range2.location-1};
                        str = [str substringWithRange: range3];
                    } else {
                        str = [str substringFromIndex: range.location+range.length];
                    }
                }
                int num;
                NSArray* values = nil;
                if ([tmanager.mRobot parseBet:memData[@"userid"] content:str outBetCount:&num outValues:&values]) {
                    [self playerBet:memData[@"name"] userid:memData[@"userid"] num:num values: values content:@"#导入添加#" from: @"import"];
                }
            }
            else if ([type isEqualToString: @"tema"]) {
                NSString* str = dic[@"betstr"];
                NSRange range = [str rangeOfString: @"认 "];
                if (range.location != NSNotFound) {
                    NSRange range2 = [str rangeOfString: @"("];
                    if (range2.location != NSNotFound) {
                        NSRange range3 = {range.location+range.length, range2.location-1};
                        str = [str substringWithRange: range3];
                    } else {
                        str = [str substringFromIndex: range.location+range.length];
                    }
                }
                str = [str stringByReplacingOccurrencesOfString:@"#" withString:@","];
                int num;
                NSArray* values = nil;
                if ([tmanager.mRobot parseBet:memData[@"userid"] content:str outBetCount:&num outValues:&values]) {
                    [self playerBet:memData[@"name"] userid:memData[@"userid"] num:num values: values content:@"#导入添加#" from: @"import"];
                }
            }
            else if ([type isEqualToString: @"baijiale"]) {
                NSString* str = dic[@"betstr"];
                NSRange range = [str rangeOfString: @"认 "];
                if (range.location != NSNotFound) {
                    NSRange range2 = [str rangeOfString: @"("];
                    if (range2.location != NSNotFound) {
                        NSRange range3 = {range.location+range.length, range2.location-1};
                        str = [str substringWithRange: range3];
                    } else {
                        str = [str substringFromIndex: range.location+range.length];
                    }
                }
                int num;
                NSArray* values = nil;
                if ([tmanager.mRobot parseBet:memData[@"userid"] content:str outBetCount:&num outValues:&values]) {
                    [self playerBet:memData[@"name"] userid:memData[@"userid"] num:num values: values content:@"#导入添加#" from: @"import"];
                }
            }
        }
    }
    
    self.mIsShowBilled = YES;
    int count = (int)[self.mPlayerBets count];
    return deString(@"导入了%d个押注记录", count);
}


@end
