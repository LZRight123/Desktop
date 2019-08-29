//
//  toolManager.m
//  wechatHook
//
//  Created by antion on 16/11/12.
//
//

#import "toolManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ycFunction.h"
#import "wxFunction.h"
#import "JSON.h"

@implementation toolManager {
    NSMutableArray* mChatRecords;
}

+(toolManager*) getInst {
    static toolManager* inst = nil;
    if (!inst) {
        inst = [toolManager new];
    }
    return inst;
}

-(id) init {
    self = [super init];
    if (self) {
        [self performSelector:@selector(initWindows) withObject:nil afterDelay:1];
        mChatRecords = nil;
        self.mLastHongbaoDetail = [@{} mutableCopy];
        self.mRobot = nil;
    }
    return self;
}

-(void) initWindows {
    self.mWindows = [toolWindows new];
}

//收到一条新消息
-(void) asyncOnAddMsg:(id)arg1 arg2:(id)arg2 {
    NSString* fromUsr = [ycFunction getVar:arg2 name: @"m_nsFromUsr"];
    id CBaseContact = [wxFunction getSelfContact];
    NSString* m_nsUsrName = [ycFunction getVar:CBaseContact name: @"m_nsUsrName"];
    if ([m_nsUsrName isEqualToString: fromUsr]) {//自己发的
        fromUsr = [ycFunction getVar:arg2 name: @"m_nsToUsr"];
    }
    
    if (self.mRobot) {
        if (![fromUsr containsString: @"@chatroom"]) {
            [self.mRobot.mPlayerCmd addMsg:arg2];
        }
        if ([self.mRobot.mGameRoom isEqualToString: fromUsr] || [self.mRobot isBackroundRoom: fromUsr]) {
            [self.mRobot addMsg: arg2 isNew: YES];
        }
    }
}

//撤回消息
/*
 <sysmsg type="revokemsg"><revokemsg><session>7848555233@chatroom</session><msgid>1635527761</msgid><newmsgid>2102833168583384840</newmsgid><replacemsg><![CDATA["云中" 撤回了一条消息]]></replacemsg></revokemsg></sysmsg>
 */
-(void) onRevokeMsg:(id)msg {
    if (self.mRobot && self.mRobot.mGameRoom) {
        NSString* m_nsContent = [ycFunction getVar: msg name: @"m_nsContent"];
        NSRange range;
        NSString* value; {
            range = [m_nsContent rangeOfString: @"<session>"];
            value = [m_nsContent substringFromIndex: range.location+range.length];
            range = [value rangeOfString: @"</session>"];
            value = [value substringToIndex: range.location];
        }
        if (value && [self.mRobot.mGameRoom isEqualToString: value]) {
            range = [m_nsContent rangeOfString: @"<newmsgid>"];
            value = [m_nsContent substringFromIndex: range.location+range.length];
            range = [value rangeOfString: @"</newmsgid>"];
            value = [value substringToIndex: range.location];
            [self.mRobot revokeMsg: value];
        }
    }
}

//收到一个红包
-(void) recvHongbao:(id)arg1 {
    NSLog(@"%@", arg1);

    NSDictionary* dic = arg1;
    if (!tmanager.mLastHongbaoDetail[@"sendId"] || ![dic[@"sendId"] isEqualToString: tmanager.mLastHongbaoDetail[@"sendId"]]) {
        tmanager.mLastHongbaoDetail[@"sendId"] = dic[@"sendId"];
        tmanager.mLastHongbaoDetail[@"totalNum"] = dic[@"totalNum"];
        tmanager.mLastHongbaoDetail[@"totalAmount"] = dic[@"totalAmount"];
        tmanager.mLastHongbaoDetail[@"record"] = [NSMutableArray array];
        for (NSDictionary* one in dic[@"record"]) {
            [tmanager.mLastHongbaoDetail[@"record"] addObject: one];
        }
    } else {
        for (NSDictionary* one in dic[@"record"]) {
            for (int i = 0; i < [tmanager.mLastHongbaoDetail[@"record"] count]; ) {
                NSDictionary* existOne = tmanager.mLastHongbaoDetail[@"record"][i];
                if ([one[@"receiveId"] isEqualToString: existOne[@"receiveId"]]) {
                    [tmanager.mLastHongbaoDetail[@"record"] removeObjectAtIndex: i];
                } else {
                    ++i;
                }
            }
        }
        for (NSDictionary* one in dic[@"record"]) {
            [tmanager.mLastHongbaoDetail[@"record"] addObject: one];
        }
    }

    if (tmanager.mRobot) {
        [tmanager.mRobot.mResult recvHongbaoDetail];
    }
}

//清空红包数据
-(void) clearHongbaoData {
    [tmanager.mLastHongbaoDetail removeAllObjects];
}

//开始启动牛牛机器人
-(void) startNiuniuRobot {
    if (!self.mRobot) {
        self.mRobot = [niuniuRobot new];
    }
}

//关闭机器人
-(void) stopNiuniuRobot {
    if (self.mRobot) {
        [self.mRobot release];
        self.mRobot = nil;
    }
}

@end
