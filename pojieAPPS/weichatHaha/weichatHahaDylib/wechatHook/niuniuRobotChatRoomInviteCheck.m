//
//  niuniuRobotChatRoomInviteCheck.m
//  wechatHook
//
//  Created by antion on 2017/8/14.
//
//

#import "niuniuRobotChatRoomInviteCheck.h"
#import "toolManager.h"
#import "wxFunction.h"
#import "ycFunction.h"

/*
 userid
 name
 filter
 inviterUserid
 inviterName
 round
 time
 date
 from  update/rob/invite
 robNotScoreCount
 robRound
 
 识别失败的统计
 在群的人却不在数据里， 可能就是识别失败的人？
 任务缓存?
 更新昵称
 */

@implementation niuniuRobotChatRoomInviteCheck {
}

-(id) init {
    if (self = [super init]) {
    }
    return self;
}

-(void) dealloc {
    [super dealloc];
}

-(NSString*) addTitle: (NSString*)title {
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"　　♤%@♤\n", title];
    [text appendString: @"──────────\n"];
    return text;
}

//是否开启功能
-(BOOL) isEnable {
    return [tmanager.mRobot.mData.mBaseSetting[@"chatroomIntiveCheck"] isEqualToString: @"true"];
}

//获取数据归属哪个群
-(NSString*) getChatroom {
    NSDictionary* dic = tmanager.mRobot.mData.mChatroomInviteList[@"@chatroom"];
    if (dic) {
        return dic[@"id"];
    }
    return nil;
}

//获取群所有玩家名片
-(NSArray*) getChatroomMemberCContacts {
    id CContactClass = NSClassFromString(@"CContact");
    return [CContactClass getChatRoomMemberWithoutMyself: tmanager.mRobot.mGameRoom];
}

//获取身份
-(NSString*) getIdentity: (NSString*)userid {
    if (!userid) {
        return @"识别失败";
    }
    else if ([tmanager.mRobot.mTuos isTuo: userid]) {
        return @"托";
    }
    else if ([tmanager.mRobot.mAdmins isAdmin: userid]) {
        return @"管理";
    }
    else if([tmanager.mRobot.mLashous isLashou: userid]) {
        return @"拉手";
    }
    else if([tmanager.mRobot.mMembers getMember: userid]) {
        return @"玩家";
    }
    return @"打酱油";
}

//创建一个新的列表id
-(NSString*) listid {
    for (int i = 0; i < 10000; ++i) {
        NSString* key = deInt2String(i+1);
        if (tmanager.mRobot.mData.mChatroomInviteList[@"@chatroom"][@"filters"][key]) {
            continue;
        }
        BOOL exist = NO;
        for (NSString* userid in tmanager.mRobot.mData.mChatroomInviteList) {
            if ([userid hasPrefix: @"@"]) {
                continue;
            }
            NSDictionary* dic = tmanager.mRobot.mData.mChatroomInviteList[userid];
            if (dic[@"listid"] && [dic[@"listid"] isEqualToString: key]) {
                exist = YES;
                break;
            }
        }
        if (exist) {
            continue;
        }
        return key;
    }
    return @"";
}

//获取最新上下分记录
-(NSString*) getNewScoreChange: (NSString*)userid start:(int)start {
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        int round = [dic[@"round"] intValue];
        if (round < start) {
            return @"无";
        }
        
        if ([dic[@"userid"] isEqualToString: userid]) {
            NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSDateFormatter* hourDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [hourDateformat setDateFormat:@"MM-dd HH:mm"];
            NSDate* date = [objDateformat dateFromString:dic[@"date"]];
            NSString* strHour = [hourDateformat stringFromDate:date];
            int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
            return deString(@"%@%d(%@)", change >= 0 ? @"+" : @"", change, strHour);
        }
    }
    return @"无";
}

//绑定群
-(void) bindChatroom {
    NSString* oldChatroom = [self getChatroom];
    if (!oldChatroom || ![oldChatroom isEqualToString: tmanager.mRobot.mGameRoom]) {
        [tmanager.mRobot.mData.mChatroomInviteList removeAllObjects];
        tmanager.mRobot.mData.mChatroomInviteList[@"@chatroom"] = [NSMutableDictionary dictionary];
        tmanager.mRobot.mData.mChatroomInviteList[@"@chatroom"][@"id"] = tmanager.mRobot.mGameRoom;
        tmanager.mRobot.mData.mChatroomInviteList[@"@chatroom"][@"filters"] = [NSMutableDictionary dictionary];
        NSArray* existPlayers = [self getChatroomMemberCContacts];
        for (id CContact in existPlayers) {
            NSString* userid = [ycFunction getVar:CContact name:@"m_nsUsrName"];
            NSMutableDictionary* player = [NSMutableDictionary dictionary];
            player[@"userid"] = userid;
            player[@"name"] = [ycFunction getVar:CContact name: @"m_nsNickName"];
            player[@"filter"] = @"true";
            tmanager.mRobot.mData.mChatroomInviteList[userid] = player;
        }
        [tmanager.mRobot.mData saveChatroomInviteListFile];
    }
}

//"xxxx"邀请"xxx"加入了群聊
-(void) addInviteMsg:(NSString*)content {
    if (![self isEnable]) {
        return;
    }
    
    NSString* nickname1 = nil;
    NSString* username1 = nil;
    NSString* nickname2 = nil;
    NSString* username2 = nil;
    
    do {
        NSRange range;
        NSString* tmpStr = content;
        NSString* value; {
            range = [tmpStr rangeOfString: @"<username><![CDATA["];
            if (range.location == NSNotFound) {
                break;
            }
            value = [tmpStr substringFromIndex: range.location+range.length];
            tmpStr = value;
            range = [tmpStr rangeOfString: @"]]></username>"];
            if (range.location == NSNotFound) {
                break;
            }
            value = [tmpStr substringToIndex: range.location];
        }
        if (value) {
            username1 = value;
            range = [tmpStr rangeOfString: @"<nickname><![CDATA["];
            if (range.location == NSNotFound) {
                break;
            }
            value = [tmpStr substringFromIndex: range.location+range.length];
            tmpStr = value;
            range = [tmpStr rangeOfString: @"]]></nickname>"];
            if (range.location == NSNotFound) {
                break;
            }
            value = [tmpStr substringToIndex: range.location];
            if (value) {
                nickname1 = value;
                range = [tmpStr rangeOfString: @"<username><![CDATA["];
                if (range.location == NSNotFound) {
                    break;
                }
                value = [tmpStr substringFromIndex: range.location+range.length];
                tmpStr = value;
                range = [tmpStr rangeOfString: @"]]></username>"];
                if (range.location == NSNotFound) {
                    break;
                }
                value = [tmpStr substringToIndex: range.location];
                if (value) {
                    username2 = value;
                    range = [tmpStr rangeOfString: @"<nickname><![CDATA["];
                    if (range.location == NSNotFound) {
                        break;
                    }
                    value = [tmpStr substringFromIndex: range.location+range.length];
                    tmpStr = value;
                    range = [tmpStr rangeOfString: @"]]></nickname>"];
                    if (range.location == NSNotFound) {
                        break;
                    }
                    value = [tmpStr substringToIndex: range.location];
                    if (value) {
                        nickname2 = value;
                    }
                }
            }
        }
    } while (0);
    
    if (!nickname1 || !nickname2 || !username1 || !username2) {
        NSString* text = deString(@"[识别失败]\n%@", content);
        if (nickname1) {
            text = deString(@"[信息不足]\n%@邀请了玩家进群", nickname1);
        }
        NSArray* rooms = [tmanager.mRobot getBackgroundWithFunc: @"isInviteCheck"];
        if ([rooms count] > 0) {
            [tmanager.mRobot.mSendMsg sendTextNow: rooms[0] content: text at:nil title:@""];
        }
        return;
    }
    
    NSString* playerUserid = username2;
    NSString* playerName = nickname2;
    NSString* inviterUserid = username1;
    NSString* inviterName = nickname1;
    
    NSString* date; {
        NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
        [objDateformat setDateFormat:@"MM-dd HH:mm"];
        date = [objDateformat stringFromDate: [NSDate date]];
    }
    
    if ([tmanager.mRobot.mData.mBaseSetting[@"chatroomEnterHint"] isEqualToString: @"true"]) {
        NSString* playerIdentity = [self getIdentity:playerUserid];
        if (![playerIdentity isEqualToString: @"托"] && ![playerIdentity isEqualToString: @"管理"] && ![playerIdentity isEqualToString: @"拉手"]) {
            NSMutableString* text = [NSMutableString string];
            [text appendString: [self addTitle: @"有人进群"]];
            [text appendFormat: @"邀请者身份: %@\n", [self getIdentity:inviterUserid]];
            [text appendFormat: @"邀请者昵称: %@\n", inviterName];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: inviterUserid];
            if (memData) {
                [text appendFormat: @"邀请者单名: %@\n", deFillName(memData[@"billName"])];
                [text appendFormat: @"邀请者编号: %@\n", memData[@"index"]];
                [text appendFormat: @"邀请者分数: %@\n", memData[@"score"]];
            }
            [text appendFormat: @"进群者身份: %@\n", playerIdentity];
            [text appendFormat: @"进群者昵称: %@\n", playerName];
            NSDictionary* memDataPlayer = [tmanager.mRobot.mMembers getMember: playerUserid];
            if (memDataPlayer) {
                [text appendFormat: @"进群者单名: %@\n", deFillName(memDataPlayer[@"billName"])];
                [text appendFormat: @"进群者编号: %@\n", memDataPlayer[@"index"]];
                [text appendFormat: @"进群者分数: %@\n", memDataPlayer[@"score"]];
            }
            [text appendFormat: @"进群时间: %@", date];
            NSArray* rooms = [tmanager.mRobot getBackgroundWithFunc: @"isInviteCheck"];
            if ([rooms count] > 0) {
                [tmanager.mRobot.mSendMsg sendTextNow: rooms[0] content: text at:nil title:@""];
            }
        }
    }
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"userid"] = playerUserid;
    dic[@"name"] = playerName;
    dic[@"inviterUserid"] = inviterUserid;
    dic[@"inviterName"] = inviterName;
    dic[@"round"] = deInt2String(tmanager.mRobot.mNumber);
    dic[@"time"] = [ycFunction getCurrentTimestamp];
    dic[@"date"] = date;
    dic[@"from"] = @"invite";
    dic[@"listid"] = [self listid];
    tmanager.mRobot.mData.mChatroomInviteList[playerUserid] = dic;
    [tmanager.mRobot.mData saveChatroomInviteListFile];
}

//每局播报
-(void) roundReport {
    if (![self isEnable]) {
        return;
    }
    
    if ([tmanager.mRobot.mData.mRounds count] < 1) {
        return;
    }
    
    NSDictionary* lastRound = [tmanager.mRobot.mData.mRounds lastObject];
    NSString* round = lastRound[@"number"];
    int roundInt = [round intValue];
    for (NSDictionary* player in lastRound[@"players"]) {
        NSMutableDictionary* data = tmanager.mRobot.mData.mChatroomInviteList[player[@"userid"]];
        if (data) {
            data[@"round"] = round;
            data[@"bet"] = @"true";
        }
    }
    
    for (NSDictionary* player in lastRound[@"robs"]) {
        if (![player[@"robTarget"] isEqualToString: @"overtime"]) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: player[@"userid"]];
            if (!memData || [memData[@"score"] intValue] <= 0) {//抢包无分
                NSMutableDictionary* data = tmanager.mRobot.mData.mChatroomInviteList[player[@"userid"]];
                if (!data) {//怎么会？？
                    NSString* name = @"未知";
                    if (memData) {
                        name = memData[@"name"];
                    } else {
                        id CBaseContact = [wxFunction getContact: player[@"userid"]];
                        if (CBaseContact) {
                            name = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
                        }
                    }
                    data = [NSMutableDictionary dictionary];
                    data[@"userid"] = player[@"userid"];
                    data[@"name"] = name;
                    data[@"inviterName"] = @"未知";
                    data[@"round"] = round;
                    {
                        NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
                        [objDateformat setDateFormat:@"MM-dd HH:mm"];
                        data[@"date"] = [objDateformat stringFromDate: [NSDate date]];
                    }
                    data[@"from"] = @"rob";
                    tmanager.mRobot.mData.mChatroomInviteList[player[@"userid"]] = data;
                }
                if (data[@"robNotScoreCount"]) {
                    data[@"robNotScoreCount"] = deInt2String([data[@"robNotScoreCount"] intValue] + 1);
                } else {
                    data[@"robNotScoreCount"] = @"1";
                }
                data[@"robRound"] = round;
            }
        }
    }
    
    [tmanager.mRobot.mData saveChatroomInviteListFile];
    
    NSArray* rooms = [tmanager.mRobot getBackgroundWithFunc: @"isInviteCheck"];
    if ([rooms count] <= 0) {
        return;
    }
    
    if(![wxFunction checkIsInChatroom: rooms[0]]) {
        [ycFunction showMsg: @"播报观战失败" msg: @"当前微信号没拉进播报观战群里。" vc: nil];
        return;
    }
    
    int chatroomAllowLook = [tmanager.mRobot.mData.mBaseSetting[@"chatroomAllowLook"] intValue];
    int chatroomNewScoreChange = [tmanager.mRobot.mData.mBaseSetting[@"chatroomNewScoreChange"] intValue];
    int chatroomRobRound = [tmanager.mRobot.mData.mBaseSetting[@"chatroomRobRound"] intValue];
    
    NSMutableArray* hasScoreLook = [NSMutableArray array];
    NSMutableArray* notScoreLook = [NSMutableArray array];
    for (NSString* userid in tmanager.mRobot.mData.mChatroomInviteList) {
        if ([userid hasPrefix: @"@"]) {
            continue;
        }
        NSDictionary* dic = tmanager.mRobot.mData.mChatroomInviteList[userid];
        if (dic[@"filter"] || dic[@"bet"]) {
            continue;
        }
        if (dic[@"listid"] && tmanager.mRobot.mData.mChatroomInviteList[@"@chatroom"][@"filters"][dic[@"listid"]]) {
            continue;
        }
        NSString* identity = [self getIdentity: userid];
        if ([identity isEqualToString: @"托"] || [identity isEqualToString: @"管理"] || [identity isEqualToString: @"拉手"]) {
            continue;
        }
        if (roundInt - [dic[@"round"] intValue] < chatroomAllowLook) {
            continue;
        }
        int score = [tmanager.mRobot.mMembers getMemberScore: userid];
        if (score > 0) {
            [hasScoreLook addObject: dic];
        } else {
            [notScoreLook addObject: dic];
        }
    }
    
    if ([hasScoreLook count] >= 2) {
        [hasScoreLook sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
            int aLookCount = roundInt - [a[@"round"] intValue];
            int bLookCount = roundInt - [b[@"round"] intValue];
            return aLookCount > bLookCount ? -1 : 1;
        }];
    }
    if ([notScoreLook count] >= 2) {
        [notScoreLook sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
            int aLookCount = roundInt - [a[@"round"] intValue];
            int bLookCount = roundInt - [b[@"round"] intValue];
            return aLookCount > bLookCount ? -1 : 1;
        }];
    }
    
    NSMutableArray* robs = [NSMutableArray array];
    for (NSString* userid in tmanager.mRobot.mData.mChatroomInviteList) {
        if ([userid hasPrefix: @"@"]) {
            continue;
        }
        NSDictionary* dic = tmanager.mRobot.mData.mChatroomInviteList[userid];
        if (!dic[@"robRound"] || !dic[@"robNotScoreCount"]) {
            continue;
        }
        if (roundInt - [dic[@"robRound"] intValue] > chatroomRobRound) {
            continue;
        }
        NSString* identity = [self getIdentity: userid];
        if ([identity isEqualToString: @"托"] || [identity isEqualToString: @"管理"] || [identity isEqualToString: @"拉手"]) {
            continue;
        }
        [robs addObject: dic];
    }
    
    if ([hasScoreLook count] >= 2) {
        [hasScoreLook sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
            int aLookCount = roundInt - [a[@"round"] intValue];
            int bLookCount = roundInt - [b[@"round"] intValue];
            return aLookCount > bLookCount ? -1 : 1;
        }];
    }
    if ([notScoreLook count] >= 2) {
        [notScoreLook sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
            int aLookCount = roundInt - [a[@"round"] intValue];
            int bLookCount = roundInt - [b[@"round"] intValue];
            return aLookCount > bLookCount ? -1 : 1;
        }];
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"第%@局播报\n", round];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"显示观战%d局以上\n", chatroomAllowLook];
    [text appendFormat: @"显示近%d局最新上分\n", chatroomNewScoreChange];
    [text appendFormat: @"显示近%d局无分抢包\n", chatroomRobRound];
    if ([notScoreLook count] > 0) {
        [text appendString: [self addTitle: @"无分观战"]];
        int index = 0;
        for (NSDictionary* dic in notScoreLook) {
            if (index++ > 0) {
                [text appendString: @"──────────\n"];
            }
            NSString* userid = dic[@"userid"];
            [text appendFormat: @"邀请者[%@]: %@\n", [self getIdentity:dic[@"inviterUserid"]], dic[@"inviterName"]];
            [text appendFormat: @"(%@)观战者[%@]: %@\n", dic[@"listid"], [self getIdentity:userid], dic[@"name"]];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                [text appendFormat: @"(%@. %@　%@分)\n", memData[@"index"], memData[@"billName"], memData[@"score"]];
                [text appendFormat: @"最近上分: %@\n", [self getNewScoreChange: userid start: roundInt-chatroomNewScoreChange]];
            }
            NSString* isBefore = @"";
            if (dic[@"from"] && ![dic[@"from"] isEqualToString: @"invite"]) {
                isBefore = @"之前";
            }
            [text appendFormat: @"进群时间: %@%@\n", dic[@"date"], isBefore];
            [text appendFormat: @"观战局数: %d\n", roundInt - [dic[@"round"] intValue]];
        }
    }
    if ([hasScoreLook count] > 0) {
        [text appendString: [self addTitle: @"有分观战"]];
        int index = 0;
        for (NSDictionary* dic in hasScoreLook) {
            if (index++ > 0) {
                [text appendString: @"──────────\n"];
            }
            NSString* userid = dic[@"userid"];
            [text appendFormat: @"邀请者[%@]: %@\n", [self getIdentity:dic[@"inviterUserid"]], dic[@"inviterName"]];
            [text appendFormat: @"(%@)观战者[%@]: %@\n", dic[@"listid"], [self getIdentity:userid], dic[@"name"]];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                [text appendFormat: @"(%@. %@　%@分)\n", memData[@"index"], memData[@"billName"], memData[@"score"]];
                [text appendFormat: @"最近上分: %@\n", [self getNewScoreChange: userid start: roundInt-chatroomNewScoreChange]];
            }
            NSString* isBefore = @"";
            if (dic[@"from"] && ![dic[@"from"] isEqualToString: @"invite"]) {
                isBefore = @"之前";
            }
            [text appendFormat: @"进群时间: %@%@\n", dic[@"date"], isBefore];
            [text appendFormat: @"观战局数: %d\n", roundInt - [dic[@"round"] intValue]];
        }
    }
    if ([robs count] > 0) {
        [text appendString: [self addTitle: @"无分抢包"]];
        int index = 0;
        for (NSDictionary* dic in robs) {
            if (index++ > 0) {
                [text appendString: @"──────────\n"];
            }
            NSString* userid = dic[@"userid"];
            [text appendFormat: @"邀请者[%@]: %@\n", [self getIdentity:dic[@"inviterUserid"]], dic[@"inviterName"]];
            [text appendFormat: @"抢包者[%@]: %@\n", [self getIdentity:userid], dic[@"name"]];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                [text appendFormat: @"(%@. %@　%@分)\n", memData[@"index"], memData[@"billName"], memData[@"score"]];
                [text appendFormat: @"最近上分: %@\n", [self getNewScoreChange: userid start: roundInt-chatroomNewScoreChange]];
            }
            
            if (dic[@"date"]) {
                NSString* isBefore = @"";
                if (dic[@"from"] && ![dic[@"from"] isEqualToString: @"invite"]) {
                    isBefore = @"之前";
                }
                [text appendFormat: @"进群时间: %@%@\n", dic[@"date"], isBefore];
            }
            int rob = roundInt-[dic[@"robRound"] intValue];
            [text appendFormat: @"最近抢包: %@\n", rob == 0 ? @"本局" : deString(@"%d局前", rob)];
            [text appendFormat: @"抢包次数: %@\n", dic[@"robNotScoreCount"]];
        }
    }
    
    if ([notScoreLook count] == 0 && [hasScoreLook count] == 0 && [robs count] == 0) {
        [text appendString: @"──────────\n"];
        [text appendString: @"暂无数据\n"];
    }
    [tmanager.mRobot.mSendMsg sendText: rooms[0] content: text at:nil title:deString(@"%d局播报", roundInt)];
}

//定时处理任务
-(void) handleTasks {
    if (![self isEnable]) {
        return;
    }
    NSString* oldChatroom = [self getChatroom];
    if (!tmanager.mRobot.mGameRoom || !oldChatroom || ![oldChatroom isEqualToString: tmanager.mRobot.mGameRoom]) {
        return;
    }
    
    NSArray* existPlayers = [self getChatroomMemberCContacts];
    if (!existPlayers || [existPlayers count] <= 0) {//确保在群里， 防止突然封号等特殊情况
        return;
    }
    
    //数据更新
    BOOL hasChange = NO;
    NSMutableDictionary* userids = [NSMutableDictionary dictionary];
    for (NSString* userid in tmanager.mRobot.mData.mChatroomInviteList) {
        userids[userid] = @"false";
    }
    userids[@"@chatroom"] = @"true";
    
    for (id CContact in existPlayers) {
        NSString* userid = [ycFunction getVar:CContact name:@"m_nsUsrName"];
        if (userids[userid]) {
            userids[userid] = @"true";
        } else {//应该是昵称搜不到userid的那些人
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            dic[@"userid"] = userid;
            dic[@"name"] = [ycFunction getVar:CContact name: @"m_nsNickName"];
            dic[@"inviterName"] = @"未知";
            dic[@"round"] = deInt2String(tmanager.mRobot.mNumber);
            {
                NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
                [objDateformat setDateFormat:@"MM-dd HH:mm"];
                dic[@"date"] = [objDateformat stringFromDate: [NSDate date]];
            }
            dic[@"from"] = @"update";
            dic[@"listid"] = [self listid];
            tmanager.mRobot.mData.mChatroomInviteList[userid] = dic;
            hasChange = YES;
        }
    }
    
    //移群的处理
    for (NSString* userid in userids) {
        NSString* isInChatroom = userids[userid];
        if (![isInChatroom isEqualToString: @"true"]) {
            hasChange = YES;
            [tmanager.mRobot.mData.mChatroomInviteList removeObjectForKey: userid];
        }
    }
    
    if (hasChange) {
        [tmanager.mRobot.mData saveChatroomInviteListFile];
    }
}

//过滤
-(void) filter:(int)listid isCancel:(BOOL)isCancel {
    NSString* hint = nil;
    NSString* key = deInt2String(listid);
    if (isCancel) {
        for (NSString* userid in tmanager.mRobot.mData.mChatroomInviteList) {
            if ([userid hasPrefix: @"@"]) {
                continue;
            }
            NSDictionary* dic = tmanager.mRobot.mData.mChatroomInviteList[userid];
            if (dic[@"listid"] && [dic[@"listid"] isEqualToString: key]) {
                hint = deString(@"[取消过滤]\n(%@)观战者[%@]: %@\n", dic[@"listid"], [self getIdentity:userid], dic[@"name"]);
            }
        }
        [tmanager.mRobot.mData.mChatroomInviteList[@"@chatroom"][@"filters"] removeObjectForKey: key];
    } else {
        for (NSString* userid in tmanager.mRobot.mData.mChatroomInviteList) {
            if ([userid hasPrefix: @"@"]) {
                continue;
            }
            NSDictionary* dic = tmanager.mRobot.mData.mChatroomInviteList[userid];
            if (dic[@"listid"] && [dic[@"listid"] isEqualToString: key]) {
                tmanager.mRobot.mData.mChatroomInviteList[@"@chatroom"][@"filters"][key] = @"true";
                hint = deString(@"[过滤]\n(%@)观战者[%@]: %@\n", dic[@"listid"], [self getIdentity:userid], dic[@"name"]);
                break;
            }
        }
    }
    if (hint) {
        NSArray* rooms = [tmanager.mRobot getBackgroundWithFunc: @"isInviteCheck"];
        if ([rooms count] > 0) {
            [tmanager.mRobot.mSendMsg sendTextNow: rooms[0] content: hint at:nil title:@"过滤"];
        }
    }
}

//查过滤
-(void) checkFilter {
    NSMutableString* text = [NSMutableString string];
    [text appendString: [self addTitle: @"过滤名单"]];
    for (NSString* userid in tmanager.mRobot.mData.mChatroomInviteList) {
        if ([userid hasPrefix: @"@"]) {
            continue;
        }
        NSDictionary* dic = tmanager.mRobot.mData.mChatroomInviteList[userid];
        if (dic[@"listid"] && tmanager.mRobot.mData.mChatroomInviteList[@"@chatroom"][@"filters"][dic[@"listid"]]) {
            [text appendFormat: @"(%@)观战者[%@]: %@\n", dic[@"listid"], [self getIdentity:userid], dic[@"name"]];
        }
    }
    NSArray* rooms = [tmanager.mRobot getBackgroundWithFunc: @"isInviteCheck"];
    if ([rooms count] > 0) {
        [tmanager.mRobot.mSendMsg sendTextNow: rooms[0] content: text at:nil title:@"过滤名单"];
    }
}

@end
