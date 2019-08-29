//
//  niuniuRobotMembers.m
//  wechatHook
//
//  Created by antion on 2017/2/23.
//
//

#import "niuniuRobotMembers.h"
#import "ycDefine.h"
#import "toolManager.h"
#import "niuniuRobot.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ycFunction.h"
#import "niuniuRobotExcelHelper.h"

@implementation niuniuRobotMembers

-(id) init {
    if (self = [super init]) {
        self.mLastTopText = @"";
        [self performSelector: @selector(updateAllName) withObject: nil afterDelay: .1];
    }
    return self;
}


-(void) dealloc {
    self.mLastTopText = nil;
    [super dealloc];
}

//不足4个字自动填充空白
+(NSString*) formatAndfillName:(NSString*)sourceStr {
    if (!sourceStr) {
        return @"　　　　";
    }
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSMutableString* str = [NSMutableString stringWithString: sourceStr];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformFullwidthHalfwidth, true);
    
    NSMutableArray* words = [NSMutableArray array];
    NSRange range;
    for(int i = 0; i < str.length; i += range.length){
        range = [str rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *s = [str substringWithRange:range];
        [words addObject: s];
    }
    
    NSMutableString* ret = [NSMutableString string];
    int wordCount = 0;
    
    NSDictionary* attributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 14]};
    NSString* defaultStr = @"　";
    int defaultW = [defaultStr sizeWithAttributes: attributes].width;
    
    for (NSString* s in words) {
        int w = [s sizeWithAttributes: attributes].width;
        if (defaultW == w) {
            [ret appendString: s];
            wordCount++;
        }
        
        if (wordCount >= 4) {
            break;
        }
    }
    
    for (int i = wordCount; i < 4; ++i) {
        [ret appendString: defaultStr];
    }
    
    return ret;
}

//特殊名字
+(NSString*) specialBillName {
    for (int i = 1; i < 100; ++i) {
        NSString* name = deString(@"特殊%02d", i);
        name = [niuniuRobotMembers formatName: name];
        if (![tmanager.mRobot.mMembers checkBillNameExist: name]) {
            return name;
        }
    }
    return @"未知单名";
}

//格式化名字
+(NSString*) formatName:(NSString*)sourceStr {
    if (!sourceStr) {
        return [niuniuRobotMembers specialBillName];
    }
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSMutableString* str = [NSMutableString stringWithString: sourceStr];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformFullwidthHalfwidth, true);
    
    NSMutableArray* words = [NSMutableArray array];
    NSRange range;
    for(int i = 0; i < str.length; i += range.length){
        range = [str rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *s = [str substringWithRange:range];
        [words addObject: s];
    }
    
    NSMutableString* ret = [NSMutableString string];
    int wordCount = 0;
    
    NSDictionary* attributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 14]};
    NSString* defaultStr = @"　";
    int defaultW = [defaultStr sizeWithAttributes: attributes].width;
    
    for (NSString* s in words) {
        int w = [s sizeWithAttributes: attributes].width;
        if (defaultW == w) {
            [ret appendString: s];
            wordCount++;
        }
        
        if (wordCount >= 4) {
            break;
        }
    }
    
    if ([ret isEqualToString: @""] || [ret isEqualToString: @"　"] || [ret isEqualToString: @"　　"] || [ret isEqualToString: @"　　　"] || [ret isEqualToString: @"　　　　"]) {
        return [niuniuRobotMembers specialBillName];
    }
    return ret;
}

//生成备注
+(NSString*) newRemark: (NSDictionary*)dic {
    return deString(@"%@#%@", dic[@"index"], dic[@"billName"]);
}

//根据红包名字返回index
+(NSString*) name2index: (NSString*)name {
    if (name.length > 4 && [name characterAtIndex: 4] == '#') {
        NSString* subStr = [name substringToIndex: 4];
        if ([ycFunction isInt: subStr]) {
            int index = [subStr intValue];
            if (index > 1000 && index < 10000) {
                return deInt2String(index);
            }
        }
    }
    return nil;
}

-(int) newIndex {
    const int minIndex = 1000;
    int maxIndex = minIndex;
    NSArray* values = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSDictionary* dic in values) {
        if ([dic[@"index"] intValue] > maxIndex) {
            maxIndex = [dic[@"index"] intValue];
        }
    }
    return maxIndex+1;
}

-(BOOL) checkBillNameExist: (NSString*)billName {
    NSArray* values = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSDictionary* dic in values) {
        if ([dic[@"billName"] isEqualToString: billName]) {
            return YES;
        }
    }
    return NO;
}

//检查所有备注
-(void) updateAllName {
    BOOL hasNewMember = NO;
    if (0 == tmanager.mRobot.mBackroundRooms.count) {
        return;
    }
    id CContactMgr = [wxFunction getMgr: @"CContactMgr"];
    NSArray* allUserid = [CContactMgr performSelector:@selector(getAllContactUserName) withObject: nil];
    for (NSString* userid in allUserid) {
        id CBaseContact = [CContactMgr performSelector:@selector(getContactByName:) withObject: userid];
        if (CBaseContact) {//能获取到信息
            if (tmanager.mRobot.mData.mMemberList[userid]) {//是会员更新名字
                NSString* m_nsNickName = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
                if (m_nsNickName && ![m_nsNickName isEqualToString: @""]) {
                    tmanager.mRobot.mData.mMemberList[userid][@"name"] = m_nsNickName;
                }
                NSString* m_nsEncodeUserName = [ycFunction getVar:CBaseContact name:@"m_nsEncodeUserName"];
                if (m_nsEncodeUserName && ![m_nsEncodeUserName isEqualToString: @""]) {
                    tmanager.mRobot.mData.mMemberList[userid][@"encodeUserid"] = m_nsEncodeUserName;
                }
            } else {//自动加会员
                if ([tmanager.mRobot.mData.mBaseSetting[@"autoAddMember"] isEqualToString: @"true"]) {
                    int m_uiType = [ycFunction getVarInt:CBaseContact name: @"m_uiType"];
                    if ((4 == m_uiType || 7 == m_uiType) && ![userid containsString: @"@"]) {//确保是玩家
                        NSString* m_nsNickName = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
                        if (m_nsNickName && ![m_nsNickName isEqualToString: @""]) {
                            NSString* billName = [niuniuRobotMembers formatName: m_nsNickName];
                            if (![billName hasPrefix: @"特殊"]) {
                                hasNewMember = YES;
                                [self addMember:userid billName:billName];
                            }
                        }
                    }
                }
            }
        }
    }
    if (hasNewMember) {
        [tmanager.mRobot.mData saveMemberListFile];
    }
}

//添加会员
-(NSString*) addMember: (NSString*)userid billName: (NSString*)billName{
    if ([userid containsString: @"@stranger"]) {
        return @"不是好友关系2";
    }
    
    if (tmanager.mRobot.mData.mMemberList[userid]) {
        return @"已经是会员";
    }
    
    if ([self checkBillNameExist: billName]) {//自动后面加数字
        NSMutableArray* words = [NSMutableArray array];
        NSRange range;
        for(int i = 0; i < billName.length; i += range.length){
            range = [billName rangeOfComposedCharacterSequenceAtIndex:i];
            NSString *s = [billName substringWithRange:range];
            [words addObject: s];
        }
        
        NSMutableString* baseWrod = [NSMutableString string];
        if ([words count] >= 1) {
            [baseWrod appendString: words[0]];
        }
        if ([words count] >= 2) {
            [baseWrod appendString: words[1]];
        }
        
        BOOL isExist = YES;
        for (int i = 0; i < 100; ++i) {
            NSMutableString* str = [NSMutableString stringWithString: deString(@"%@%02d", baseWrod, i)];
            CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformFullwidthHalfwidth, true);
            billName = str;
            if (![self checkBillNameExist: billName]) {
                isExist = NO;
                break;
            }
        }
        
        if (isExist) {
            return @"账单名字重复";
        }
    }
    
    NSString* m_nsNickName;
    NSString* encodeUserid;
    
    id CBaseContact = [wxFunction getContact: userid];
    if (CBaseContact) {
        m_nsNickName = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
        encodeUserid = [ycFunction getVar:CBaseContact name:@"m_nsEncodeUserName"];
    } else {
        m_nsNickName = billName;
        encodeUserid = @"";
    }
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"userid"] = userid;
    dic[@"encodeUserid"] = encodeUserid;
    dic[@"name"] = m_nsNickName;
    dic[@"billName"] = billName;
    dic[@"index"] = deInt2String([self newIndex]);
    dic[@"score"] = @"0";
    dic[@"addTime"] = [ycFunction getCurrentTimestamp];
    tmanager.mRobot.mData.mMemberList[userid] = dic;
    return nil;
}

//删除会员
-(NSString*) delMember: (NSString*)userid {
    if (!tmanager.mRobot.mData.mMemberList[userid]) {
        return @"该用户不是会员";
    }
    [tmanager.mRobot.mData.mMemberList removeObjectForKey: userid];
    return nil;
}

//修改会员名字
-(NSString*) renameMemberBillName: (NSString*)userid billName: (NSString*)billName {
    NSMutableDictionary* dic = tmanager.mRobot.mData.mMemberList[userid];
    if (!dic) {
        return @"该用户不是会员";
    }
    
    if ([self checkBillNameExist: billName]) {
        return @"账单名字重复";
    }
    dic[@"billName"] = billName;
    return nil;
}

/*上下分, 设置分
params: 
 type   [command, manual, batch, tuoBatch]
 fromUserid
 fromName
*/
-(BOOL) addScore:(NSString*)userid score:(int)score isSet:(BOOL)isSet params:(NSDictionary*)params {
    NSMutableDictionary* dic = tmanager.mRobot.mData.mMemberList[userid];
    if (dic) {
        [tmanager.mRobot.mDayInfos checkPlayerScoreCount];

        int oldScore = [dic[@"score"] intValue];
        int newScore = oldScore;
        if (isSet) {
            newScore = score;
        } else {
            newScore = MAX(0, oldScore+score);
        }
        dic[@"score"] = deInt2String(newScore);        
        
        if (params) {
            NSMutableDictionary* record = [NSMutableDictionary dictionaryWithDictionary: params];
            record[@"round"] = deInt2String(tmanager.mRobot.mNumber);
            record[@"userid"] = userid;
            record[@"index"] = dic[@"index"];
            record[@"name"] = dic[@"name"];
            record[@"billName"] = dic[@"billName"];
            record[@"oldScore"] = deInt2String(oldScore);
            record[@"newScore"] = deInt2String(newScore);
            {
                NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
                [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                record[@"date"] = [objDateformat stringFromDate: [NSDate date]];
            }
            record[@"timestamp"] = [ycFunction getCurrentTimestamp];
            [tmanager.mRobot.mData.mScoreChangedRecords addObject: record];
            
            if (!params[@"donotAutoSave"]) {
                [tmanager.mRobot.mData saveScoreChangedRecordsFile];
            }
            [tmanager.mRobot.mDayInfos updateQunScoreCount: record];
        }
        return YES;
    }
    return NO;
}

//清空所有会员积分
-(void) clearAllScore {
    NSArray* array = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSMutableDictionary* dic in array) {
        dic[@"score"] = @"0";
    }
}

//获取某个会员
-(NSMutableDictionary*) getMember: (NSString*)userid {
    if (!userid) {
        return nil;
    }
    return tmanager.mRobot.mData.mMemberList[userid];
}

//获取某个会员
-(NSDictionary*) getMemberWithEncodeUserid: (NSString*)encodeUserid {
    NSArray* array = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSDictionary* dic in array) {
        if ([dic[@"encodeUserid"] isEqualToString: encodeUserid]) {
            return dic;
        }
    }
    return nil;
}

//获取某个会员
-(NSDictionary*) getMemberWithIndex: (NSString*)index {
    NSArray* array = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSDictionary* dic in array) {
        if ([dic[@"index"] isEqualToString: index]) {
            return dic;
        }
    }
    return nil;
}

//获取某个会员(测试或免备注模式使用)
-(NSDictionary*) getMemberWithName: (NSString*)name {
    NSArray* array = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSDictionary* dic in array) {
        NSString* n1 = name;
        NSString* n2 = dic[@"name"];
        if (n1.length > 6 && n2.length > 6) {
            n1 = [n1 substringToIndex:6];
            n2 = [n2 substringToIndex:6];
        }
        if ([n1 isEqualToString: n2]) {
            return dic;
        }
    }
    return nil;
}

//搜索会员名片
-(NSArray*) searchMember: (NSString*)keyworld {
    if ([ycFunction isInt: keyworld]) {
        int index = [keyworld intValue];
        if (index >= 1000 && index <= 9999999) {
            NSDictionary* memData = [self getMemberWithIndex: deInt2String(index)];
            if (memData) {
                return @[memData];
            }
        }
    }
    
    NSString* lowercaseKeyworld = [keyworld lowercaseString];
    NSMutableString* keyworldW = [NSMutableString stringWithString: keyworld];
    CFStringTransform((CFMutableStringRef)keyworldW, NULL, kCFStringTransformFullwidthHalfwidth, true);
    
    NSMutableArray* ret = [NSMutableArray array];
    NSArray* values = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSMutableDictionary* dic in values) {
        if ([[dic[@"name"] lowercaseString] containsString: lowercaseKeyworld] || [dic[@"billName"] containsString: keyworldW]) {
            [ret addObject: dic];
        }
    }
    return ret;
}


//获取某个会员的积分
-(int) getMemberScore: (NSString*)userid {
    if (!userid) {
        return -1;
    }
    NSDictionary* dic = tmanager.mRobot.mData.mMemberList[userid];
    if (!dic || !dic[@"score"]) {
        return 0;
    }
    return [dic[@"score"] intValue];
}



//获取总积分
-(int) getAllScoreCount {
    NSArray* datas = [tmanager.mRobot.mData.mMemberList allValues];
    int ret = 0;
    for (NSDictionary* dic in datas) {
        ret += [dic[@"score"] intValue];
    }
    return ret;
}


//获取总积分, 玩家
-(int) getAllScoreCountOnlyPlayer {
    NSArray* datas = [tmanager.mRobot.mData.mMemberList allValues];
    int ret = 0;
    for (NSDictionary* dic in datas) {
        if (![tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
            ret += [dic[@"score"] intValue];
        }
    }
    return ret;
}

-(NSString*) addTitle: (NSString*)title {
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"　　♤%@♤\n", title];
    [text appendString: @"──────────\n"];
    return text;
}

-(NSString*) numFormat:(int)num {
    if (num >= 100) {
        return deString(@"%d.", num);
    }
    
//    if (num >= 100) {
//        int d1, d2;
//        d1 = num/10;
//        d2 = num%10;
//        NSArray* strs1 = @[@"⒑", @"⒒", @"⒓", @"⒔", @"⒕", @"⒖", @"⒗", @"⒘", @"⒙", @"⒚"];
//        NSArray* strs2 = @[@"０", @"⒈", @"⒉", @"⒊", @"⒋", @"⒌", @"⒍", @"⒎", @"⒏", @"⒐"];
//        NSMutableString* ret = [NSMutableString string];
//        [ret appendString: strs1[d1-10]];
//        [ret appendString: strs2[d2]];
//        return ret;
//    }

    int d1, d2;
    d1 = num/10;
    d2 = num%10;
    NSArray* strs1 = @[@"０", @"１", @"２", @"３", @"４", @"５", @"６", @"７", @"８", @"９"];
    NSArray* strs2 = @[@"０", @"⒈", @"⒉", @"⒊", @"⒋", @"⒌", @"⒍", @"⒎", @"⒏", @"⒐"];
    NSMutableString* ret = [NSMutableString string];
    if (num <= 3) {
        [ret appendString: @"№"];
    } else {
        [ret appendString: strs1[d1]];
    }
    [ret appendString: strs2[d2]];
    return ret;
}

//获取积分榜字符串
-(NSString*) getTopStr: (BOOL)showTuo onlyPlayer:(BOOL)onlyPlayer onlyTuo:(BOOL)onlyTuo{
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"积分排行榜\n"];
    {//加日期
        NSDate *date = [NSDate date];
        NSDateFormatter *objDateformat = [[[NSDateFormatter alloc] init] autorelease];
        [objDateformat setDateFormat:@"MM-dd HH:mm:ss"];
        [text appendFormat: @"(%@)\n", [objDateformat stringFromDate: date]];
    }
    [text appendString: @"──────────\n"];
    if (onlyPlayer) {
        int playerCount = 0;
        int playerScores = 0;
        NSArray* datas = [tmanager.mRobot.mData.mMemberList allValues];
        for (NSDictionary* dic in datas) {
            if (![tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                ++playerCount;
                playerScores += [dic[@"score"] intValue];
            }
        }
        [text appendFormat: @"会员: %d\n玩家: %d\n玩家分: %d\n", (int)[tmanager.mRobot.mData.mMemberList count], playerCount, playerScores];
    }else if (onlyTuo) {
        int playerCount = 0;
        int playerScores = 0;
        NSArray* datas = [tmanager.mRobot.mData.mMemberList allValues];
        for (NSDictionary* dic in datas) {
            if ([tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                ++playerCount;
                playerScores += [dic[@"score"] intValue];
            }
        }
        [text appendFormat: @"会员: %d\n托: %d\n托分: %d\n", (int)[tmanager.mRobot.mData.mMemberList count], playerCount, playerScores];
    } else {
        if (showTuo) {
            int tuoScores = 0;
            NSArray* datas = [tmanager.mRobot.mData.mMemberList allValues];
            for (NSDictionary* dic in datas) {
                if ([tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                    tuoScores += [dic[@"score"] intValue];
                }
            }
            [text appendFormat: @"会员: %d\n托分: %d\n玩家分: %d\n", (int)[tmanager.mRobot.mData.mMemberList count], tuoScores, (int)[self getAllScoreCount]-tuoScores];
        } else {
            [text appendFormat: @"会员: %d 总分: %d\n", (int)[tmanager.mRobot.mData.mMemberList count], (int)[self getAllScoreCount]];
        }
    }
    
    [text appendString: @"──────────\n"];
    
    NSMutableArray* scores = [NSMutableArray arrayWithArray: [tmanager.mRobot.mData.mMemberList allValues]];
    [scores sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"score"] intValue] > [b[@"score"] intValue] ? -1 : 1;
    }];
    
    int index = 0;
    for (NSDictionary* dic in scores) {
        if ([dic[@"score"] intValue] > 0) {
            if (onlyPlayer) {
                if (![tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                    ++index;
                    
                    [text appendFormat: @"%@　%@　%@\n", dic[@"index"], deFillName(dic[@"billName"]), dic[@"score"]];
                }
            } else if (onlyTuo) {
                if ([tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                    ++index;
                    
                    [text appendFormat: @"%@　%@　%@\n", dic[@"index"], deFillName(dic[@"billName"]), dic[@"score"]];
                }
            } else {
                ++index;
                
                NSString* tuoStr = @"";
                if (showTuo && [tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                    tuoStr = @"(托)";
                }
                if (showTuo) {
                    [text appendFormat: @"%@. %@　%@%@\n", dic[@"index"], deFillName(dic[@"billName"]), dic[@"score"], tuoStr];
                } else {
                    [text appendFormat: @"%@　%@　%@%@\n", [self numFormat: index], deFillName(dic[@"billName"]), dic[@"score"], tuoStr];
                }
            }
        }
    }
    
    if ([tmanager.mRobot.mData.mBaseSetting[@"topHasNewScoreChange"] isEqualToString: @"true"]) {
        NSMutableArray* newUpScore = [NSMutableArray array];
        NSMutableArray* newDownScore = [NSMutableArray array];
        for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >= 0; --i) {
            NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
            int round = [dic[@"round"] intValue];
            if (tmanager.mRobot.mNumber-round == 1) {
                if ([dic[@"newScore"] intValue] - [dic[@"oldScore"] intValue] > 0) {
                    [newUpScore addObject: dic];
                } else {
                    [newDownScore addObject: dic];
                }
            }
            else if(tmanager.mRobot.mNumber-round > 1) {
                break;
            }
        }
        
        if ([newUpScore count] > 0) {
            [text appendString: [self addTitle: @"最新上分"]];
            for (NSDictionary* dic in newUpScore) {
                int change = abs([dic[@"newScore"] intValue] - [dic[@"oldScore"] intValue]);
                [text appendFormat: @"%@　上%d　总%@\n", deFillName(dic[@"billName"]), change, dic[@"newScore"]];
            }
        }
        
        if ([newDownScore count] > 0) {
            [text appendString: [self addTitle: @"最新下分"]];
            for (NSDictionary* dic in newDownScore) {
                int change = abs([dic[@"newScore"] intValue] - [dic[@"oldScore"] intValue]);
                [text appendFormat: @"%@　下%d　总%@\n", deFillName(dic[@"billName"]), change, dic[@"newScore"]];
            }
        }
    }
    return text;
}

//出单
-(void) showTop {
    NSString* text = [self getTopStr: NO onlyPlayer: NO onlyTuo:NO];
    
    self.mLastTopText = text;
    
//    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = text;

    UIAlertView* view = [[[UIAlertView alloc] initWithTitle: nil message: text delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"发文字", @"发文本", @"发表格", @"发图片", nil] autorelease];
    view.tag = 1;
    [view show];
    
    NSLog(@"排行榜: %@", text);
}

//出图片单
-(UIImage*) showPicTop:(UIView*)resultView {
    UIView* view = [[[UIView alloc] initWithFrame: CGRectMake(0, 0, 750, 1000)] autorelease];
    view.backgroundColor = [UIColor blackColor];
    
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    const int titleh = 34;
    UIColor* titleColor = [UIColor colorWithRed:[setting[@"titleTextR"] floatValue]/255 green:[setting[@"titleTextG"] floatValue]/255 blue:[setting[@"titleTextB"] floatValue]/255 alpha:1];;//标题文字颜色
    UIColor* titleBgColor = [UIColor colorWithRed:[setting[@"titleR"] floatValue]/255 green:[setting[@"titleG"] floatValue]/255 blue:[setting[@"titleB"] floatValue]/255 alpha:1];//标题背景颜色s
    UIColor* textColor = [UIColor blackColor];//文字颜色
    UIColor* textBgColor = [UIColor whiteColor];//文字背景
    UIColor* textBgColor2 = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];//文字背景2
    int hCount = 0;
    
    if (resultView) {
        [view addSubview: resultView];
        hCount += resultView.frame.size.height;
    }
    
    //头部
    if(!resultView){
        UIImage* img = [tmanager.mRobot.mData getBillHeadPic];
        UIImageView* head = [[UIImageView alloc] initWithFrame:CGRectMake(0, hCount, view.frame.size.width, view.frame.size.width/img.size.width*img.size.height)];
        head.image = img;
        head.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview: head];
        [head release];
        hCount += head.frame.size.height;
    }
    
    NSMutableArray* scores = [NSMutableArray arrayWithArray: [tmanager.mRobot.mData.mMemberList allValues]];
    [scores sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"score"] intValue] > [b[@"score"] intValue] ? -1 : 1;
    }];
    
    {
        
        NSArray* array = @[
                           @[@375, @"会员总数", deInt2String((int)[tmanager.mRobot.mData.mMemberList count])],
                           @[@375, @"会员总积分", deInt2String([self getAllScoreCount])],
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
    
    NSArray* array = @[
                       @[@130, @"玩家昵称"],
                       @[@120, @"积分"],
                       @[@130, @"玩家昵称"],
                       @[@120, @"积分"],
                       @[@130, @"玩家昵称"],
                       @[@120, @"积分"],
                       ];
    
    [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
    int wCnt = 0;
    for (NSArray* config in array) {
        int w = [config[0] intValue];
        [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
        wCnt += w;
    }
    hCount += titleh;
    
    int i = 0;
    for (; i < [scores count]; ++i) {
        NSDictionary* dic = scores[i];
        if ([dic[@"score"] intValue] <= 0) {
            break;
        }
        
        if (i%3 == 0) {
            [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: i%6==0?textBgColor2:textBgColor];
        }
        
        {
            UILabel* label = [self addLabel: view frame:CGRectMake((i%3)*(130+120), hCount, 130, titleh) text:deString(@" %d. %@", i+1, dic[@"billName"]) color: textColor isLeft:YES];
            label.layer.borderWidth = 1;
            label.layer.borderColor = [textColor CGColor];
        }{
            UILabel* label = [self addLabel: view frame:CGRectMake((i%3)*(130+120)+130, hCount, 120, titleh) text:dic[@"score"] color: textColor isLeft:NO];
            label.layer.borderWidth = 1;
            label.layer.borderColor = [textColor CGColor];
        }
        
        
        if (i%3 == 2) {
            hCount += titleh;
        }
    }
    if (i%3 != 0) {
        hCount += titleh;
    }
    
    if ([tmanager.mRobot.mData.mBaseSetting[@"topHasNewScoreChange"] isEqualToString: @"true"]) {
        NSMutableArray* newUpScore = [NSMutableArray array];
        NSMutableArray* newDownScore = [NSMutableArray array];
        for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >= 0; --i) {
            NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
            int round = [dic[@"round"] intValue];
            if (tmanager.mRobot.mNumber-round == 1) {
                if ([dic[@"newScore"] intValue] - [dic[@"oldScore"] intValue] > 0) {
                    [newUpScore addObject: dic];
                } else {
                    [newDownScore addObject: dic];
                }
            }
            else if(tmanager.mRobot.mNumber-round > 1) {
                break;
            }
        }
        
        if ([newUpScore count] > 0) {
            {
                NSArray* array = @[
                                   @[@130, @"玩家昵称"],
                                   @[@120, @"最新上分"],
                                   @[@125, @"剩余积分"],
                                   @[@130, @"玩家昵称"],
                                   @[@120, @"最新上分"],
                                   @[@125, @"剩余积分"],
                                   ];
                
                [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
                int wCnt = 0;
                for (NSArray* config in array) {
                    int w = [config[0] intValue];
                    [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
                    wCnt += w;
                }
                hCount += titleh;
                
                
                int i = 0;
                for (; i < [newUpScore count]; ++i) {
                    NSDictionary* dic = newUpScore[i];
                    
                    if (i%2 == 0) {
                        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: i%4==0?textBgColor2:textBgColor];
                    }
                    
                    {
                        UILabel* label = [self addLabel: view frame:CGRectMake((i%2)*(130+120+125), hCount, 130, titleh) text:deString(@" %d. %@", i+1, dic[@"billName"]) color: textColor isLeft:YES];
                        label.layer.borderWidth = 1;
                        label.layer.borderColor = [textColor CGColor];
                    }{
                        int change = abs([dic[@"newScore"] intValue] - [dic[@"oldScore"] intValue]);
                        NSString* str = deString(@"%d", change);
                        UILabel* label = [self addLabel: view frame:CGRectMake((i%2)*(130+120+125)+130, hCount, 120, titleh) text:str color: textColor isLeft:NO];
                        label.layer.borderWidth = 1;
                        label.layer.borderColor = [textColor CGColor];
                    }{
                        UILabel* label = [self addLabel: view frame:CGRectMake((i%2)*(130+120+125)+130+120, hCount, 125, titleh) text:dic[@"newScore"] color: textColor isLeft:NO];
                        label.layer.borderWidth = 1;
                        label.layer.borderColor = [textColor CGColor];
                    }
                    
                    if (i%2 == 1) {
                        hCount += titleh;
                    }
                }
                if (i%2 != 0) {
                    hCount += titleh;
                }
            }
        }
        
        if ([newDownScore count] > 0) {
            {
                NSArray* array = @[
                                   @[@130, @"玩家昵称"],
                                   @[@120, @"最新下分"],
                                   @[@125, @"剩余积分"],
                                   @[@130, @"玩家昵称"],
                                   @[@120, @"最新下分"],
                                   @[@125, @"剩余积分"],
                                   ];
                
                [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
                int wCnt = 0;
                for (NSArray* config in array) {
                    int w = [config[0] intValue];
                    [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:config[1] color: titleColor isLeft:NO];
                    wCnt += w;
                }
                hCount += titleh;
                
                
                int i = 0;
                for (; i < [newDownScore count]; ++i) {
                    NSDictionary* dic = newDownScore[i];
                    
                    if (i%2 == 0) {
                        [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: i%4==0?textBgColor2:textBgColor];
                    }
                    
                    {
                        UILabel* label = [self addLabel: view frame:CGRectMake((i%2)*(130+120+125), hCount, 130, titleh) text:deString(@" %d. %@", i+1, dic[@"billName"]) color: textColor isLeft:YES];
                        label.layer.borderWidth = 1;
                        label.layer.borderColor = [textColor CGColor];
                    }{
                        int change = abs([dic[@"newScore"] intValue] - [dic[@"oldScore"] intValue]);
                        NSString* str = deString(@"%d", change);
                        UILabel* label = [self addLabel: view frame:CGRectMake((i%2)*(130+120+125)+130, hCount, 120, titleh) text:str color: textColor isLeft:NO];
                        label.layer.borderWidth = 1;
                        label.layer.borderColor = [textColor CGColor];
                    }{
                        UILabel* label = [self addLabel: view frame:CGRectMake((i%2)*(130+120+125)+130+120, hCount, 125, titleh) text:dic[@"newScore"] color: textColor isLeft:NO];
                        label.layer.borderWidth = 1;
                        label.layer.borderColor = [textColor CGColor];
                    }
                    
                    if (i%2 == 1) {
                        hCount += titleh;
                    }
                }
                if (i%2 != 0) {
                    hCount += titleh;
                }
            }
        }
    }
    
    
    //--------
    
    CGRect frame = view.frame;
    frame.size = CGSizeMake(frame.size.width, hCount);
    view.frame = frame;
    
    return [ycFunction savePicWithView: view compressValue: [tmanager.mRobot.mData.mBaseSetting[@"picCompressValue"] floatValue]];
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

//获取所有真玩家
-(NSArray*) getMembersOnlyPlayer {
    NSMutableArray* array = [NSMutableArray array];
    NSArray* values = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSDictionary* dic in values) {
        if (![tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
            [array addObject: dic];
        }
    }
    return array;
}

//获取所有会员列表, sortType: index/socre
-(NSArray*) getAllMembers: (NSString*)sortType filterText:(NSString*)filterText{
    NSMutableString* filterTextW = [NSMutableString stringWithString: filterText];
    CFStringTransform((CFMutableStringRef)filterTextW, NULL, kCFStringTransformFullwidthHalfwidth, true);
    
    NSMutableArray* array = [NSMutableArray array];
    NSArray* values = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSMutableDictionary* dic in values) {
        if ([filterText isEqualToString: @""] || [dic[@"name"] containsString: filterText] || [dic[@"billName"] containsString: filterTextW]) {
            [array addObject: dic];
        }
    }
    if ([sortType isEqualToString: @"score"]) {
        [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            return [a[@"score"] intValue] < [b[@"score"] intValue] ? 1 : -1;
        }];
    } else if([sortType isEqualToString: @"index"]){
        [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            return [a[@"index"] intValue] > [b[@"index"] intValue] ? 1 : -1;
        }];
    }
    return array;

}

//获取正常会员列表
-(NSArray*) getNormalMembers: (NSString*)sortType {
    NSMutableArray* array = [NSMutableArray array];
    NSArray* values = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSMutableDictionary* dic in values) {
        id CBaseContact = [wxFunction getContact: dic[@"userid"]];
        if (CBaseContact && [wxFunction isFriend: CBaseContact]) {
            [array addObject: dic];
        }
    }
    if ([sortType isEqualToString: @"score"]) {
        [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            return [a[@"score"] intValue] < [b[@"score"] intValue] ? 1 : -1;
        }];
    } else if([sortType isEqualToString: @"index"]){
        [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            return [a[@"index"] intValue] > [b[@"index"] intValue] ? 1 : -1;
        }];
    }
    return array;
}

//获取有会员无好友列表
-(NSArray*) getNullFriendMembers: (NSString*)sortType {
    NSMutableArray* array = [NSMutableArray array];
    NSArray* values = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSMutableDictionary* dic in values) {
        id CBaseContact = [wxFunction getContact: dic[@"userid"]];
        if (!CBaseContact || ![wxFunction isFriend: CBaseContact]) {
            [array addObject: dic];
        }
    }
    if ([sortType isEqualToString: @"score"]) {
        [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            return [a[@"score"] intValue] < [b[@"score"] intValue] ? 1 : -1;
        }];
    } else if([sortType isEqualToString: @"index"]){
        [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
            return [a[@"index"] intValue] > [b[@"index"] intValue] ? 1 : -1;
        }];
    }
    return array;
}

//获取有好友无会员列表
-(NSArray*) getNullMembers {
    NSMutableArray* array = [NSMutableArray array];
    id MMServiceCenter = [NSClassFromString(@"MMServiceCenter") performSelector: @selector(defaultCenter) withObject: nil];
    id CContactMgr = [MMServiceCenter performSelector: @selector(getService:) withObject: NSClassFromString(@"CContactMgr")];
    NSArray* allUserid = [CContactMgr performSelector:@selector(getAllContactUserName) withObject: nil];
    for (NSString* userid in allUserid) {
        id CBaseContact = [CContactMgr performSelector:@selector(getContactByName:) withObject: userid];
        NSString* m_nsNickName = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
        if ([wxFunction isFriend: CBaseContact]) {//是好友
            if (!tmanager.mRobot.mData.mMemberList[userid]) {//无会员
                NSMutableDictionary* dic = [NSMutableDictionary dictionary];
                dic[@"userid"] = userid;
                dic[@"name"] = m_nsNickName;
                [array addObject: dic];
            }
        }
    }
    return array;
}

//消息框
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (1 == alertView.tag) {//积分榜
        if (0 == buttonIndex) {
            return;
        }
        
        UIViewController* controller =[ycFunction getCurrentVisableVC];
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
            [ycFunction showMsg: @"界面不在群" msg: nil vc: nil];
            return;
        }
        if (1 == buttonIndex) {//文字
            [tmanager.mRobot.mSendMsg sendText: target content:self.mLastTopText at:nil title:@"积分榜"];
        }
        else if(2 == buttonIndex) {//文本
            [tmanager.mRobot.mSendMsg sendFile: target title: @"积分榜.txt" ext: @"txt" data: [self.mLastTopText dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        else if(3 == buttonIndex) {//表格
            [tmanager.mRobot.mSendMsg sendFile: target title: @"积分榜.xls" ext: @"xls" data:[niuniuRobotExcelHelper makeScoreTop]];
        }
        else if(4 == buttonIndex) {//图片
            [tmanager.mRobot.mSendMsg sendPic: target img:[self showPicTop: nil]];
        }
    }
}

@end
