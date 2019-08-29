//
//  niuniuRobotPlayerCmd.m
//  wechatHook
//
//  Created by antion on 2017/8/6.
//
//

#import "niuniuRobotPlayerCmd.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"

@implementation niuniuRobotPlayerCmd

-(id) init {
    if (self = [super init]) {
        self.mPlayerLastQuery = [@{} mutableCopy];
    }
    return self;
}

-(void) addMsg:(id)msg {
    NSString* fromUsr = [ycFunction getVar:msg name: @"m_nsFromUsr"];
    id CBaseContact = [wxFunction getSelfContact];
    NSString* m_nsUsrName = [ycFunction getVar:CBaseContact name: @"m_nsUsrName"];
    if ([m_nsUsrName isEqualToString: fromUsr]) {//自己发的
        fromUsr = [ycFunction getVar:msg name: @"m_nsToUsr"];
    }
    
    int querySpace = [tmanager.mRobot.mData.mBaseSetting[@"playerCmdQuerySpace"] intValue];
    long long currentTime = [[ycFunction getCurrentTimestamp] longLongValue];
    NSString* lastQueryTime = self.mPlayerLastQuery[fromUsr];
    if (lastQueryTime && currentTime-[lastQueryTime longLongValue] < querySpace) {
        return;
    }
    
    int m_uiMessageType = [ycFunction getVarInt: msg name: @"m_uiMessageType"];
    if (1 == m_uiMessageType) {
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember:fromUsr];
        if (!memData) {
            return;
        }
        
        NSString* m_nsContent = [ycFunction getVar: msg name: @"m_nsContent"];
        if ([m_nsContent isEqualToString: @"查积分"] && [tmanager.mRobot.mData.mBaseSetting[@"playerCmdEnableScore"] isEqualToString: @"true"]) {
            self.mPlayerLastQuery[fromUsr] = [ycFunction getCurrentTimestamp];
            NSString* text = [self getMyScore: memData];
            [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:@""];
        }
        else if ([m_nsContent isEqualToString: @"查上下分"] && [tmanager.mRobot.mData.mBaseSetting[@"playerCmdEnableScoreChanged"] isEqualToString: @"true"]) {
            self.mPlayerLastQuery[fromUsr] = [ycFunction getCurrentTimestamp];
            NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [objDateformat setDateFormat:@"YYYY-MM-dd"];
            NSString* queryDate = [objDateformat stringFromDate: [NSDate date]];
            NSString* text = deString(@"%@%@", [tmanager.mRobot.mCommand newUpScoreRecords:memData queryDate:queryDate], [self getWarrStr]);;
            [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:@""];
        }
        else if ([m_nsContent isEqualToString: @"查统计"] && [tmanager.mRobot.mData.mBaseSetting[@"playerCmdEnableCount"] isEqualToString: @"true"]) {
            self.mPlayerLastQuery[fromUsr] = [ycFunction getCurrentTimestamp];
            NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [objDateformat setDateFormat:@"YYYY-MM-dd"];
            NSString* queryDate = [objDateformat stringFromDate: [NSDate date]];
            NSString* text = deString(@"%@%@", [tmanager.mRobot.mCommand newPlayerResultInfo:memData queryDate:queryDate], [self getWarrStr]);;
            [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:@""];
        }
        else if ([m_nsContent isEqualToString: @"查领包"] && [tmanager.mRobot.mData.mBaseSetting[@"playerCmdEnablePackages"] isEqualToString: @"true"]) {
            self.mPlayerLastQuery[fromUsr] = [ycFunction getCurrentTimestamp];
            NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [objDateformat setDateFormat:@"YYYY-MM-dd"];
            NSString* queryDate = [objDateformat stringFromDate: [NSDate date]];
            NSString* text = deString(@"%@%@", [tmanager.mRobot.mCommand newPlayerBetInfo:memData queryDate:queryDate], [self getWarrStr]);;
            [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:@""];
        }
    }
}

-(NSString*) addTitle: (NSString*)title {
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"　　♤%@♤\n", title];
    [text appendString: @"──────────\n"];
    return text;
}

-(NSString*) getWarrStr {
    return deString(@"──────────\n⚠️%@秒后才能再次查询", tmanager.mRobot.mData.mBaseSetting[@"playerCmdQuerySpace"]);
}

-(NSString*) getMyScore:(NSDictionary*)memData {
    NSMutableString* text = [NSMutableString string];
    [text appendString: [self addTitle: @"基本信息"]];
    [text appendFormat: @"玩家单名: %@\n", memData[@"billName"]];
    [text appendFormat: @"玩家积分: %@\n", memData[@"score"]];
    [text appendString: [self getWarrStr]];
    return text;
}

@end
