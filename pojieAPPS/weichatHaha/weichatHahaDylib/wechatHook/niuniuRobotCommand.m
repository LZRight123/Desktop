//
//  niuniuRobotCommand.m
//  wechatHook
//
//  Created by antion on 2017/3/8.
//
//

#import "niuniuRobotCommand.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import "niuniuRobot.h"
#import "niuniu.h"
#import "longhu.h"
#import "niuniuRobotExcelHelper.h"

/*
 个人名片模版
 <?xml version="1.0"?>
 <msg bigheadimgurl="http://wx.qlogo.cn/mmhead/ver_1/gsEA320tQLs5gV5H06wbYrsibBGUcEnZnysBicmobJk2PSh5cdNKkd4TOE2ZPUNxnCMJR8N54WKjbemoibKXCn7tg/0" smallheadimgurl="http://wx.qlogo.cn/mmhead/ver_1/gsEA320tQLs5gV5H06wbYrsibBGUcEnZnysBicmobJk2PSh5cdNKkd4TOE2ZPUNxnCMJR8N54WKjbemoibKXCn7tg/132" username="v1_d5be0b87e3181cc439d83d4f109d6902279e371e0fe6430369e49b431b12f0e0@stranger" nickname="Aaa，朋友圈被封" fullpy="Aaapengyoujuanbeifeng" shortpy="" alias="" imagestatus="3" scene="17" province="福建" city="中国" sign="" sex="1" certflag="0" certinfo="" brandIconUrl="" brandHomeUrl="" brandSubscriptConfigUrl="" brandFlags="0" regionCode="CN_Fujian_Zhangzhou" antispamticket="v2_d0aac70be561e73563f2bf53ce3a2ff5f72c3aaa1f4e6746c7367b824a0f1b736716890cc9e66465e75babbe85105f0b@stranger" />
 
 //        ❌❌❌❌❌❌❌❌❌❌
 //        ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
 */

#define commandWaitTime 60

@implementation niuniuRobotCommand {
    NSMutableDictionary* mWaitCards;
}
    
-(id) init {
    if (self = [super init]) {
        mWaitCards = [NSMutableDictionary new];
    }
    return self;
}

-(void) dealloc {
    [mWaitCards release];
    [super dealloc];
}

-(void) addMsg:(id)msg isNew: (BOOL)isNew{
    BOOL isMe = NO;
    NSString* fromUsr = [ycFunction getVar:msg name: @"m_nsFromUsr"];
    int m_uiMessageType = [ycFunction getVarInt: msg name: @"m_uiMessageType"];
    NSString* m_nsContent = [ycFunction getVar: msg name: @"m_nsContent"];
    NSString* m_nsRealChatUsr = [ycFunction getVar: msg name: @"m_nsRealChatUsr"];
    id CBaseContact = [wxFunction getContact: m_nsRealChatUsr];
    NSString* m_nsNickName = [ycFunction getVar:CBaseContact name: @"m_nsNickName"];
    
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

    BOOL isAdmin = [tmanager.mRobot.mAdmins isAdmin: m_nsRealChatUsr];
    BOOL isLashou = [tmanager.mRobot.mLashous isLashou: m_nsRealChatUsr];
    BOOL isLashouHead = [tmanager.mRobot.mLashouHeads isLashouHead: m_nsRealChatUsr];
    BOOL isTuo = [tmanager.mRobot.mTuos isTuo: m_nsRealChatUsr];
    
    if (1 == m_uiMessageType) {//普通消息
        if (isMe || isAdmin || isLashou || isLashouHead) {//搜
            if ([m_nsContent isEqualToString: @"查日期"]) {
                NSString* text = nil;
                if (!isMe && !isAdmin) {
                    text = @"‘查日期’已更改为管理专用，如需查日期请使用‘查拉手日期’";
                } else {
                    text = [self getQueryDate];
                }
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            int value;
            NSScanner* scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"设日期" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd]) {//设置查询日期
                NSString* text = nil;
                if (!isMe && !isAdmin) {
                    text = @"‘设日期’已更改为管理专用，如需设日期请使用‘设拉手日期’";
                } else {
                    text = [self setQueryDate: value];
                }
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            NSString* searchCMD = @"搜";
            if ([m_nsContent hasPrefix: searchCMD] && [m_nsContent length] > [searchCMD length]) {
                if (isMe || isAdmin || (isLashou && [tmanager.mRobot.mData.mBaseSetting[@"allowLashouSou"] isEqualToString: @"true"]) ||
                    (isLashouHead && [tmanager.mRobot.mData.mBaseSetting[@"allowLashouHeadSou"] isEqualToString: @"true"])) {
                    NSString* keyworld = [m_nsContent substringFromIndex: [searchCMD length]];
                    NSString* text = [self searchPlayer:keyworld sayerUserid: m_nsRealChatUsr sayerName: m_nsNickName isAdmin:isMe || isAdmin];
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                    return;
                } else {
                    NSString* text = @"";
                    if (isLashou && isLashouHead) {
                        text = @"拉手、团长";
                    } else if(isLashou) {
                        text = @"拉手";
                    } else if(isLashouHead) {
                        text = @"团长";
                    }
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: deString(@"%@已禁止使用'搜'功能, 请联系管理员！", text) at: nil title:m_nsContent];
                    return;
                }
            }
        }

        if (isLashou || isLashouHead) {
            if ([m_nsContent isEqualToString: @"查拉手日期"]) {
                NSString* text = [self getQueryDateForLashou];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            int value;
            NSScanner* scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"设拉手日期" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd]) {//设置查询日期
                NSString* text = [self setQueryDateForLashou: value];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
        }

        if (isMe || isAdmin) {
            if ([m_nsContent hasPrefix: @"#查分#"] ||
                 [m_nsContent hasPrefix: @"#上分#"] ||
                 [m_nsContent hasPrefix: @"#下分#"] ||
                 [m_nsContent hasPrefix: @"#分数清零#"]) {
                NSString* text = [self financeContentParse:m_nsContent sayerUserid:m_nsRealChatUsr sayerName:m_nsNickName hasPower: isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"] fromUsr:fromUsr];
                [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: nil title:m_nsContent];
                return;
            }

            if ([m_nsContent isEqualToString: @"导出所有数据"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"daochusuoyoushuju"])) {
                [self exportAllData: fromUsr];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"出单"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chudan"])) {
                NSString* text = [tmanager.mRobot.mMembers getTopStr: NO onlyPlayer: NO onlyTuo:NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"出单2"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chudan"])) {
                NSString* text = [tmanager.mRobot.mMembers getTopStr: YES onlyPlayer: NO onlyTuo: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"出单3"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chudan"])) {
                NSString* text = [tmanager.mRobot.mMembers getTopStr: NO onlyPlayer: YES onlyTuo: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"出单4"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chudan"])) {
                NSString* text = [tmanager.mRobot.mMembers getTopStr: NO onlyPlayer: NO onlyTuo: YES];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }

            if ([m_nsContent isEqualToString: @"查所有上下分"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chasuoyoushangxiafen"])) {
                NSString* text = [self queryAllScoreChanged];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查所有上下分明细"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chasuoyoushangxiafen"])) {
                [self chasuoyoushangxiafenmingxi: fromUsr];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查所有群上下分"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chasuoyoushangxiafen"])) {
                [self chasuoyouqunshangxiafen: fromUsr];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查所有拉手名单"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chasuoyoulashou"])) {
                NSString* text = [self newAllLashouNames];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查所有拉手"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chasuoyoulashou"])) {
                NSString* text = [self newAllLashou];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
             
            if ([m_nsContent isEqualToString: @"查托名单"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chatuo"])) {
                NSString* text = [self queryAllTuoMembers];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"托分清零"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"tuofenqingling"])) {
                NSString* text = [self clearAllTuoScore];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查概率"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chagailv"])) {
                NSString* text = [self newLonghuChance];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查点数"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chadianshu"])) {
                [self chadianshu: fromUsr];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查输赢"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chashuying"])) {
                NSString* text = [self newWinOrLoseTop: NO onlyPlayer: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查输赢2"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chashuying"])) {
                NSString* text = [self newWinOrLoseTop: YES onlyPlayer: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查输赢3"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chashuying"])) {
                NSString* text = [self newWinOrLoseTop: NO onlyPlayer: YES];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查反水奖励"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chafanshui"])) {
                [self queryPlayerBack: fromUsr diffTuo: YES];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查反水奖励2"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chafanshui"])) {
                [self queryPlayerBack: fromUsr diffTuo: NO];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"执行反水奖励"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"zhixingfanshui"])) {
                NSString* text = [self exePlayerBack: m_nsRealChatUsr sayerName:m_nsNickName isCancel: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"取消反水奖励"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"quxiaofanshui"])) {
                NSString* text = [self exePlayerBack: m_nsRealChatUsr sayerName:m_nsNickName isCancel: YES];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查输分奖励"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chafanshui"])) {
                [self queryLoseBonus: fromUsr diffTuo: YES];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查输分奖励2"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chafanshui"])) {
                [self queryLoseBonus: fromUsr diffTuo: NO];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"执行输分奖励"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"zhixingfanshui"])) {
                NSString* text = [self exeLoseBonus: m_nsRealChatUsr sayerName:m_nsNickName isCancel: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"取消输分奖励"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"quxiaofanshui"])) {
                NSString* text = [self exeLoseBonus: m_nsRealChatUsr sayerName:m_nsNickName isCancel: YES];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"清理档案"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"qinglidangan"])) {
                [self qinglidangan: fromUsr];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"帮助"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"bangzhu"])) {
                NSString* text = [self newAllCommandString];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
//            if ([m_nsContent isEqualToString: @"测试"]) {
//                NSString* text = [self test];
//                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:@""];
//                return;
//            }
            
            if ([m_nsContent isEqualToString: @"批量添加托"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"tianjiatuo"])) {
                NSString* text = [self batchAddTuo: fromUsr];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查局数奖励"]  && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {
                [self queryRoundBonus:fromUsr diffTuo: YES];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查局数奖励2"]  && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {
                [self queryRoundBonus:fromUsr diffTuo: NO];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"执行局数奖励"]  && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {
                NSString* text = [self exeRoundBonus: m_nsRealChatUsr sayerName:m_nsNickName isCancel: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"取消局数奖励"]  && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {
                NSString* text = [self exeRoundBonus: m_nsRealChatUsr sayerName:m_nsNickName isCancel: YES];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查集齐奖励"]  && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {
                [self queryCollectBonus:fromUsr diffTuo: YES];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查集齐奖励2"]  && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {
                [self queryCollectBonus:fromUsr diffTuo: NO];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"执行集齐奖励"]  && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {
                NSString* text = [self exeCollectBonus: m_nsRealChatUsr sayerName:m_nsNickName isCancel: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"取消集齐奖励"]  && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {
                NSString* text = [self exeCollectBonus: m_nsRealChatUsr sayerName:m_nsNickName isCancel: YES];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            int value;
            NSScanner* scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"上局奖励" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangjujiangli"])) {//奖励活动
                NSString* text = [self lastRoundPlayerAddScore: value sayerUserid:m_nsRealChatUsr sayerName:m_nsNickName];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"查局数" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chajushu"])) {//查指定局数
                NSString* text = [self lookRound: value];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查托点包"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chatuodianbao"])) {
                NSString* text = [self queryAllTuoAmount: 0 start: 0 end: 24];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"查托点包" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chatuodianbao"])) {//查托点包指定几点到几点
                if (value <= 100) {
                    NSString* text = [self queryAllTuoAmount: value start:0 end: 24];
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                } else {
                    int back = value/10000;
                    int start = value/100%100;
                    int end = value%100;
                    if (end >= start && start >= 0 && start <= 24 && end >= 0 && end <= 24) {
                        NSString* text = [self queryAllTuoAmount: back start: start end: end];
                        [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                    }
                }
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查流水"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chaliushui"])) {
                NSString* text = [self newTotalInfo: 0 end:24];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"查流水" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chaliushui"])) {//查流水指定几点到几点
                int start = value/100;
                int end = value%100;
                if (end >= start && start >= 0 && start <= 24 && end >= 0 && end <= 24) {
                    NSString* text = [self newTotalInfo: start end:end];
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                }
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查修改"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chaxiugai"])) {
                [self chaxiugai: fromUsr day: 0];
                return;
            }
            
            scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"查修改" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chaxiugai"])) {
                if (value >= 2) {
                    [self chaxiugai: fromUsr day: value];
                } else {
                    [self chaxiugai: fromUsr day: 0];
                }
                return;
            }
            
            scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"查同点庄杀概率" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd]) {
                if (value <= 18 && value > 0) {
                    [self chatongdianzhuangshagailv: fromUsr pow: value];
                }
                return;
            }
            
            if ([tmanager.mRobot getBackgroundHasFunc: fromUsr func:@"isInviteCheck"]) {
                if ([m_nsContent isEqualToString: @"查过滤"]) {
                    [tmanager.mRobot.mInviteCheck checkFilter];
                    return;
                }
                
                scan = [NSScanner scannerWithString: m_nsContent];
                if ([scan scanString: @"过滤" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd]) {
                    [tmanager.mRobot.mInviteCheck filter:value isCancel:NO];
                    return;
                }
                
                scan = [NSScanner scannerWithString: m_nsContent];
                if ([scan scanString: @"取消过滤" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd]) {
                    [tmanager.mRobot.mInviteCheck filter:value isCancel:YES];
                    return;
                }
            }
        }
        
        if (isLashou) {
            if ([m_nsContent isEqualToString: @"查拉手成员"]) {
                NSString* text = [self newLashouTops: m_nsRealChatUsr name: m_nsNickName];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查拉手流水"]) {
                NSString* text = [self newLashouMembers: m_nsRealChatUsr name: m_nsNickName queryDate: tmanager.mRobot.mQueryDateForLashou];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
        }
        
        if (isLashouHead) {
            if ([m_nsContent isEqualToString: @"查团长成员"]) {
                NSString* text = [self newLashouHeadTops: m_nsRealChatUsr name: m_nsNickName];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查团长流水"]) {
                NSString* text = [self newLashouHeadMembers: m_nsRealChatUsr name: m_nsNickName];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
        }
        
        if (isTuo) {
            int value;
            NSScanner* scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"上分" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd]) {//托自助上分
                NSString* text = [self tuoSelfChangeScore: m_nsRealChatUsr name: m_nsNickName value: value];
                [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: nil title:@""];
                return;
            }
            
            scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"下分" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd]) {//托自助下分
                NSString* text = [self tuoSelfChangeScore: m_nsRealChatUsr name:m_nsNickName value: -value];
                [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: nil title:@""];
                return;
            }
        }
        
        //带名片
        NSDictionary* dic = mWaitCards[m_nsRealChatUsr];
        if (!dic) {
            return;
        }
        
        dic = [[dic retain] autorelease];
        [mWaitCards removeObjectForKey: m_nsRealChatUsr];
        
        if (llabs([[ycFunction getCurrentTimestamp] longLongValue] - [dic[@"time"] longLongValue]) > commandWaitTime) {
            return;
        }
        
        if (dic[@"type"] && [dic[@"type"] isEqualToString: @"zhuanyi"]) {
            return;
        }
        
        NSDictionary* memData = [tmanager.mRobot.mMembers getMemberWithEncodeUserid: dic[@"encodeUserid"]];
        if (!memData) {
            memData = [tmanager.mRobot.mMembers getMember: dic[@"encodeUserid"]];
        }
        if (!memData) {
            return;
        }
        
        if (isMe || isAdmin) {
            if ([m_nsContent isEqualToString: @"添加拉手"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"tianjialashou"])) {
                NSString* text = [self addLashou: memData sayerName: m_nsNickName isRemove: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"删除拉手"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shanchulashou"])) {
                NSString* text = [self addLashou: memData sayerName: m_nsNickName isRemove: YES];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"删除拉手成员归属"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shanchulashou"])) {
                NSString* text = [self delLashouPlayer: memData sayerName: m_nsNickName];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"添加团长"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"tianjiatuanzhang"])) {
                NSString* text = [self addLashouHead: memData sayerName: m_nsNickName isRemove: NO];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"删除团长"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shanchutuanzhang"])) {
                NSString* text = [self addLashouHead: memData sayerName: m_nsNickName isRemove: YES];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"删除团长成员归属"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shanchutuanzhang"])) {
                NSString* text = [self delLashouHeadLashou: memData sayerName: m_nsNickName];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"批量添加团长成员"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"tianjiatuanzhang"])) {
                NSString* text = [self batchAddLashouHeadMember:fromUsr memData: memData];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"添加托"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"tianjiatuo"])) {
                NSString* errMsg = [tmanager.mRobot.mTuos addTuo: memData[@"userid"]];
                if (errMsg) {
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: errMsg at: nil title:m_nsContent];
                } else {
                    NSString* text = deString(@"@%@\n[添加托]\n编号: %@\n昵称: %@\n单名: %@\n托总人数: %d\n", m_nsNickName, memData[@"index"], memData[@"name"], memData[@"billName"], [tmanager.mRobot.mTuos getTuoCount]);
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                }
                return;
            }
            
            if ([m_nsContent isEqualToString: @"删除托"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shanchutuo"])) {
                [tmanager.mRobot.mTuos delTuo: memData[@"userid"]];
                NSString* text = deString(@"@%@\n[删除托]\n编号: %@\n昵称: %@\n单名: %@\n托总人数: %d\n", m_nsNickName, memData[@"index"], memData[@"name"], memData[@"billName"], [tmanager.mRobot.mTuos getTuoCount]);
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                
                [tmanager.mRobot.mRework addReworkRecord: @{
                                                      @"type" : @"tuoDelete",
                                                      @"userid" : memData[@"userid"],
                                                      @"admin" : m_nsRealChatUsr
                                                      }];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查明细"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chamingxi"])) {
                UIImage* img = [self queryPlayerAllDetail: memData];
                [tmanager.mRobot.mSendMsg sendPic:fromUsr img:img];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查统计"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chatongji"])) {
                NSString* text = [self newPlayerResultInfo: memData queryDate:tmanager.mRobot.mQueryDate];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查领包"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chalingbao"])) {
                NSString* text = [self newPlayerBetInfo: memData queryDate:tmanager.mRobot.mQueryDate];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查上下分"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chashangxiafen"])) {
                NSString* text = [self newUpScoreRecords: memData queryDate:tmanager.mRobot.mQueryDate];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查管理上下分"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chaguanlishangxiafen"])) {
                [self queryAdminScoreChanged:memData target:fromUsr replyType:@"text"];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"导出管理上下分"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chaguanlishangxiafen"])) {
                [self queryAdminScoreChanged:memData target:fromUsr replyType:@"file"];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"查拉手"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"chalashou"])) {
                NSString* text = [self newLashouMembers: memData[@"userid"] name: memData[@"name"] queryDate: tmanager.mRobot.mQueryDate];
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([ycFunction isInt: m_nsContent] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {//上下分
                int changeScore = [m_nsContent intValue];
                if (changeScore < 0) {
                    NSString* errMsg = [self canDownScore:abs(changeScore) memData:memData from:m_nsNickName];
                    if (errMsg) {
                        [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: errMsg at: nil title:m_nsContent];
                        return;
                    }
                }
                int oldScore = [memData[@"score"] intValue];
                if ([tmanager.mRobot.mMembers addScore: memData[@"userid"] score: changeScore isSet: NO params: @{
                                                                                                            @"type":@"command",
                                                                                                            @"chatroom":fromUsr,
                                                                                                            @"fromUserid":m_nsRealChatUsr,
                                                                                                            @"fromName":m_nsNickName}]) {
                    NSString* text = [self newScoreChangedMsg: oldScore memData: memData from: nil chatroom: fromUsr];
                    [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: nil title:m_nsContent];
                    [tmanager.mRobot.mData saveMemberListFile];
                }
                return;
            }
            
            int value;
            NSScanner* scan = [NSScanner scannerWithString: m_nsContent];
            if ([scan scanString: @"下" intoString: nil] && [scan scanInt: &value] && [scan isAtEnd]) {//下分
                int changeScore = -abs(value);
                if (changeScore < 0) {
                    NSString* errMsg = [self canDownScore:abs(changeScore) memData:memData from:m_nsNickName];
                    if (errMsg) {
                        [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: errMsg at: nil title:m_nsContent];
                        return;
                    }
                }
                int oldScore = [memData[@"score"] intValue];
                if ([tmanager.mRobot.mMembers addScore: memData[@"userid"] score: changeScore isSet: NO params: @{
                                                                                                            @"type":@"command",
                                                                                                            @"chatroom":fromUsr,
                                                                                                            @"fromUserid":m_nsRealChatUsr,
                                                                                                            @"fromName":m_nsNickName}]) {
                    NSString* text = [self newScoreChangedMsg: oldScore memData: memData from: nil chatroom: fromUsr];
                    [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: nil title:m_nsContent];
                    [tmanager.mRobot.mData saveMemberListFile];
                }
                return;
            }
            
            if ([m_nsContent isEqualToString: @"清零"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"shangxiafen"])) {//清零
                int oldScore = [memData[@"score"] intValue];
                NSString* errMsg = [self canDownScore:oldScore memData:memData from:m_nsNickName];
                if (errMsg) {
                    [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: errMsg at: nil title:m_nsContent];
                    return;
                }
                
                if ([tmanager.mRobot.mMembers addScore: memData[@"userid"] score: 0 isSet: YES params: @{
                                                                                                   @"type":@"command",
                                                                                                   @"chatroom":fromUsr,
                                                                                                   @"fromUserid":m_nsRealChatUsr,
                                                                                                   @"fromName":m_nsNickName}]) {
                    NSString* text = [self newScoreChangedMsg: oldScore memData: memData from: nil chatroom: fromUsr];
                    [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: nil title:m_nsContent];
                    [tmanager.mRobot.mData saveMemberListFile];
                }
                return;
            }
            
            if ([m_nsContent isEqualToString: @"转移"] && (isMe || [tmanager.mRobot.mAdmins hasPower:m_nsRealChatUsr key: @"zhuanyi"])) {//分数转移
                mWaitCards[m_nsRealChatUsr] = @{
                                                @"type" : @"zhuanyi",
                                                @"userid" : memData[@"userid"],
                                                @"time" : [ycFunction getCurrentTimestamp],
                                                };
                return;
            }
        }
        
        if (isLashou) {
            if ([m_nsContent isEqualToString: @"添加拉手成员"]) {
                if (dic[@"by"] && [dic[@"by"] isEqualToString: @"search"] && ![tmanager.mRobot.mData.mBaseSetting[@"allowLashouSouAdd"] isEqualToString: @"true"]) {
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: deString(@"@%@\n%@", m_nsNickName, @"用搜的方式不允许添加成员，请使用名片或者咨询管理员！") at: m_nsRealChatUsr title:m_nsContent];
                    return;
                }
                NSString* errMsg = [tmanager.mRobot.mLashous addPlayer:m_nsRealChatUsr player:memData[@"userid"]];
                if (errMsg) {
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: deString(@"@%@\n[%@]拉手成员添加失败(%@)", m_nsNickName, memData[@"name"], errMsg) at: m_nsRealChatUsr title:m_nsContent];
                    return;
                }
                NSString* text = deString(@"@%@\n[添加拉手成员]\n编号: %@\n昵称: %@\n单名: %@\n成员总人数: %d\n", m_nsNickName, memData[@"index"], memData[@"name"], memData[@"billName"], [tmanager.mRobot.mLashous getLashouMemberCount:m_nsRealChatUsr]);
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"删除拉手成员"]) {
                [tmanager.mRobot.mLashous delPlayer:m_nsRealChatUsr player:memData[@"userid"]];
                NSString* text = deString(@"@%@\n[删除拉手成员]\n编号: %@\n昵称: %@\n单名: %@\n成员总人数: %d\n", m_nsNickName, memData[@"index"], memData[@"name"], memData[@"billName"], [tmanager.mRobot.mLashous getLashouMemberCount:m_nsRealChatUsr]);
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
        }
        
        if (isLashouHead) {
            if ([m_nsContent isEqualToString: @"添加团长成员"]) {
                if (dic[@"by"] && [dic[@"by"] isEqualToString: @"search"] && ![tmanager.mRobot.mData.mBaseSetting[@"allowLashouHeadSouAdd"] isEqualToString: @"true"]) {
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: deString(@"@%@\n%@", m_nsNickName, @"用搜的方式不允许添加成员，请使用名片或者咨询管理员！") at: m_nsRealChatUsr title:m_nsContent];
                    return;
                }
                NSString* errMsg = [tmanager.mRobot.mLashouHeads addLashou:m_nsRealChatUsr lashou:memData[@"userid"]];
                if (errMsg) {
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: deString(@"@%@\n[%@]团长成员添加失败(%@)", m_nsNickName, memData[@"name"], errMsg) at: m_nsRealChatUsr title:m_nsContent];
                    return;
                }
                NSString* text = deString(@"@%@\n[添加团长成员]\n编号: %@\n昵称: %@\n单名: %@\n成员总人数: %d\n", m_nsNickName, memData[@"index"], memData[@"name"], memData[@"billName"], [tmanager.mRobot.mLashouHeads getLashouHeadMemberCount:m_nsRealChatUsr]);
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
            
            if ([m_nsContent isEqualToString: @"删除团长成员"]) {
                [tmanager.mRobot.mLashouHeads delLashou:m_nsRealChatUsr lashou:memData[@"userid"]];
                NSString* text = deString(@"@%@\n[删除团长成员]\n编号: %@\n昵称: %@\n单名: %@\n成员总人数: %d\n", m_nsNickName, memData[@"index"], memData[@"name"], memData[@"billName"], [tmanager.mRobot.mLashouHeads getLashouHeadMemberCount:m_nsRealChatUsr]);
                [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                return;
            }
        }
    }
    else if(42 == m_uiMessageType) {//名片
        if (isMe || isAdmin || isLashou || isLashouHead) {
            
            NSDictionary* zhuanyiMemData = nil;
            {//转分检测
                NSDictionary* card = mWaitCards[m_nsRealChatUsr];
                if (card) {
                    card = [[card retain] autorelease];
                    [mWaitCards removeObjectForKey: m_nsRealChatUsr];
                    
                    if (llabs([[ycFunction getCurrentTimestamp] longLongValue] - [card[@"time"] longLongValue]) < commandWaitTime) {
                        if (card[@"type"] && [card[@"type"] isEqualToString: @"zhuanyi"]) {
                            zhuanyiMemData = [tmanager.mRobot.mMembers getMember: card[@"userid"]];
                        }
                    }
                }
            }
            
            NSRange range;
            NSString* encodeUserid; {
                range = [m_nsContent rangeOfString: @"username=\""];
                encodeUserid = [m_nsContent substringFromIndex: range.location+range.length];
                range = [encodeUserid rangeOfString: @"\""];
                encodeUserid = [encodeUserid substringToIndex: range.location];
            }
            NSString* nickname; {
                range = [m_nsContent rangeOfString: @"nickname=\""];
                if (range.location < [m_nsContent length] && range.length > 0) {
                    nickname = [m_nsContent substringFromIndex: range.location+range.length];
                    range = [nickname rangeOfString: @"\""];
                    nickname = [nickname substringToIndex: range.location];
                } else {
                    nickname = @"无法识别";
                }
            }
            
            BOOL isNew = NO;
            NSDictionary* memData = [tmanager.mRobot.mMembers getMemberWithEncodeUserid: encodeUserid];
            if (!memData) {
                memData = [tmanager.mRobot.mMembers getMember: encodeUserid];
            }
            
            if (!memData) {
                id CBaseContact = [wxFunction getContact:encodeUserid];
                if (!CBaseContact) {
                    [tmanager.mRobot.mSendMsg sendText: fromUsr content: deString(@"@%@\n[%@]不是好友关系", m_nsNickName, nickname) at: m_nsRealChatUsr title:m_nsContent];
                    return;
                }
                
                NSString* userid = [ycFunction getVar:CBaseContact name: @"m_nsUsrName"];
                memData = [tmanager.mRobot.mMembers getMember: userid];
                if (!memData) {
                    NSString* errMsg = [tmanager.mRobot.mMembers addMember:userid billName:[niuniuRobotMembers formatName: nickname]];
                    if (errMsg) {
                        [tmanager.mRobot.mSendMsg sendText: fromUsr content: deString(@"@%@\n[%@]会员添加失败(%@)", m_nsNickName, nickname, errMsg) at: m_nsRealChatUsr title:m_nsContent];
                        return;
                    }
                    [tmanager.mRobot.mData saveMemberListFile];
                    isNew = YES;
                    memData = [tmanager.mRobot.mMembers getMember: userid];
                }
            }
            
            if (isMe || isAdmin) {
                if (zhuanyiMemData) {//转分
                    int zhuanyiScore = [zhuanyiMemData[@"score"] intValue];
                    if (zhuanyiScore <= 0) {
                        NSString* text = deString(@"[分数转移失败]\n[%@]无积分", zhuanyiMemData[@"billName"]);
                        [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: m_nsRealChatUsr title:@"分数转移"];
                        return;
                    }
                    NSString* errMsg = [self canDownScore:abs(zhuanyiScore) memData:zhuanyiMemData from:m_nsRealChatUsr];
                    if (errMsg) {
                        [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: errMsg at: m_nsRealChatUsr title:@"分数转移"];
                        return;
                    }
                    int score = [memData[@"score"] intValue];
                    [tmanager.mRobot.mMembers addScore:zhuanyiMemData[@"userid"] score:0 isSet:YES params:@{
                                                                                               @"type":@"command",
                                                                                               @"chatroom":fromUsr,
                                                                                               @"fromUserid":m_nsRealChatUsr,
                                                                                               @"fromName":m_nsNickName}];
                    [tmanager.mRobot.mMembers addScore:memData[@"userid"] score:zhuanyiScore isSet:NO params:@{
                                                                                               @"type":@"command",
                                                                                               @"chatroom":fromUsr,
                                                                                               @"fromUserid":m_nsRealChatUsr,
                                                                                               @"fromName":m_nsNickName}];
                    [tmanager.mRobot.mData saveMemberListFile];

                    NSMutableString* text = [NSMutableString string];
                    [text appendFormat: @"[分数转移]\n"];
                    [text appendFormat: @"编号: %@\n", zhuanyiMemData[@"index"]];
                    [text appendFormat: @"昵称: %@\n", zhuanyiMemData[@"name"]];
                    [text appendFormat: @"单名: %@\n", zhuanyiMemData[@"billName"]];
                    [text appendFormat: @"原分: %d  -  %d\n", zhuanyiScore, zhuanyiScore];
                    [text appendString: @"现分: 0\n"];
                    [text appendString: @"──────────\n"];
                    if (isNew) {
                        if ([memData[@"billName"] hasPrefix: @"特殊"]) {
                            [text appendFormat: @"⚠️新玩家-> 玩家昵称无法识别, 已修改玩家账单名为(%@), 请提醒玩家!!!⚠️\n", memData[@"billName"]];
                        } else {
                            [text appendString: @"⚠️新玩家⚠️\n"];
                        }
                    }
                    [text appendFormat: @"编号: %@\n", memData[@"index"]];
                    [text appendFormat: @"昵称: %@\n", memData[@"name"]];
                    [text appendFormat: @"单名: %@\n", memData[@"billName"]];
                    [text appendFormat: @"原分: %d  +  %d\n", score, zhuanyiScore];
                    [text appendFormat: @"现分: %@\n", memData[@"score"]];
                    [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: m_nsRealChatUsr title:@""];
                } else {
                    if (![tmanager.mRobot getBackgroundHasFunc:fromUsr func: @"isHideCard"]) {
                        NSMutableString* text = [NSMutableString string];
                        [text appendFormat: @"@%@\n", m_nsNickName];
                        if (isNew) {
                            if ([memData[@"billName"] hasPrefix: @"特殊"]) {
                                [text appendFormat: @"⚠️新玩家-> 玩家昵称无法识别, 已修改玩家账单名为(%@), 请提醒玩家!!!⚠️\n", memData[@"billName"]];
                            } else {
                                [text appendString: @"⚠️新玩家⚠️\n"];
                            }
                        }
                        [text appendFormat: @"编号: %@\n", memData[@"index"]];
                        [text appendFormat: @"身份: %@\n", [tmanager.mRobot getIdentityStr: memData[@"userid"]]];
                        NSDictionary* lashou = [tmanager.mRobot.mLashous getLashouWithPlayer: memData[@"userid"]];
                        if (lashou) {
                            if (lashou[@"billName"]) {
                                [text appendFormat: @"归属拉手: %@#%@\n", lashou[@"index"], lashou[@"billName"]];
                            } else {
                                [text appendFormat: @"归属拉手: %@\n", lashou[@"userid"]];
                            }
                        }
                        
                        if ([tmanager.mRobot.mLashous isLashou: memData[@"userid"]]) {
                            NSDictionary* lashouHead = [tmanager.mRobot.mLashouHeads getLashouHeadWithLashou: memData[@"userid"]];
                            if (lashouHead) {
                                if (lashouHead[@"billName"]) {
                                    [text appendFormat: @"归属团长: %@#%@\n", lashouHead[@"index"], lashouHead[@"billName"]];
                                } else {
                                    [text appendFormat: @"归属团长: %@\n", lashouHead[@"userid"]];
                                }
                            }
                        }
                        [text appendFormat: @"昵称: %@\n", nickname];
                        [text appendFormat: @"单名: %@\n", memData[@"billName"]];
                        [text appendFormat: @"分数: %@\n", memData[@"score"]];
                        [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: m_nsRealChatUsr title:@""];

                    }
                    mWaitCards[m_nsRealChatUsr] = @{
                                                    @"encodeUserid" : encodeUserid,
                                                    @"time" : [ycFunction getCurrentTimestamp],
                                                    };
                }
            } else if(isLashou || isLashouHead) {//拉手
                if (memData) {
                    NSString* hint = nil;
                    if ([tmanager.mRobot.mData.mBaseSetting[@"allowLashouCardAutoAdd"] isEqualToString: @"true"] && !isLashouHead) {//推名片自动报备
                        NSString* errMsg = [tmanager.mRobot.mLashous addPlayer:m_nsRealChatUsr player:memData[@"userid"]];
                        BOOL isLashouSelfMember = errMsg && [errMsg isEqualToString: @"玩家已添加过"];
                        if (isLashouSelfMember) {
                            hint = @"⚠️已经添加过⚠️";
                        } else {
                            if (errMsg) {
                                [tmanager.mRobot.mSendMsg sendText: fromUsr content: deString(@"@%@\n[%@]拉手成员添加失败(%@)", m_nsNickName, memData[@"name"], errMsg) at: m_nsRealChatUsr title:m_nsContent];
                                return;
                            }
                            NSString* text = deString(@"@%@\n[添加拉手成员]\n编号: %@\n昵称: %@\n单名: %@\n成员总人数: %d\n", m_nsNickName, memData[@"index"], memData[@"name"], memData[@"billName"], [tmanager.mRobot.mLashous getLashouMemberCount:m_nsRealChatUsr]);
                            [tmanager.mRobot.mSendMsg sendText: fromUsr content: text at: nil title:m_nsContent];
                            return;
                        }
                        
                    }
                    NSMutableString* text = [NSMutableString string];
                    [text appendFormat: @"@%@\n", m_nsNickName];
                    if (hint) {
                        [text appendFormat: @"%@\n", hint];
                    }
                    [text appendFormat: @"编号: %@\n", memData[@"index"]];
                    [text appendFormat: @"昵称: %@\n", nickname];
                    [text appendFormat: @"单名: %@\n", memData[@"billName"]];
                    [text appendFormat: @"分数: %@\n", memData[@"score"]];
                    [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: text at: m_nsRealChatUsr title:@""];
                    mWaitCards[m_nsRealChatUsr] = @{
                                                    @"encodeUserid" : encodeUserid,
                                                    @"time" : [ycFunction getCurrentTimestamp],
                                                    };

                } else {
                    [tmanager.mRobot.mSendMsg sendTextNow: fromUsr content: deString(@"@%@\n[%@]未上过分或者无好友关系", m_nsNickName, nickname) at: m_nsRealChatUsr title:@""];
                }
            }
        }
    }
}

-(NSString*) newScoreChangedMsg: (int)oldScore memData:(NSDictionary*)memData from:(NSString*)from chatroom:(NSString*)chatroom{
    int newScore = [memData[@"score"] intValue];
    int changeScore = newScore-oldScore;
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"[分数变动]\n"];
    [text appendFormat: @"编号: %@\n", memData[@"index"]];
    [text appendFormat: @"昵称: %@\n", memData[@"name"]];
    [text appendFormat: @"单名: %@\n", memData[@"billName"]];
    [text appendFormat: @"原分: %d  %@  %d\n", oldScore, changeScore < 0 ? @"-" : @"+", abs(changeScore)];
    [text appendFormat: @"现分: %d\n", newScore];
    if (from) {
        [text appendFormat: @"来自: %@", from];
    }
    if (chatroom && [tmanager.mRobot.mData.mBaseSetting[@"upScoreCountShow"] isEqualToString: @"true"]) {
        NSDictionary* dic = [tmanager.mRobot.mDayInfos getQunUpScoreCount: chatroom];
        if (dic) {
            [text appendString: @"──────────\n"];
            [text appendFormat: @"今日本群上分: %@\n", dic[@"upCount"]];
            [text appendFormat: @"今日本群下分: %@", dic[@"downCount"]];
        }
        
    }
    return text;
}

//是否能下分
-(NSString*) canDownScore: (int)downScore memData:(NSDictionary*)memData from:(NSString*)from {
    int playerScore = [memData[@"score"] intValue];
    if (playerScore < downScore) {
        return deString(@"❌❌❌❌❌❌❌❌❌❌\n⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n@%@\n下分失败[分数不足]\n⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n❌❌❌❌❌❌❌❌❌❌", from);
    }

    if ((tmanager.mRobot.mStatus == eNiuniuRobotStatusBet && tmanager.mRobot.mBet.mIsShowBilled) || tmanager.mRobot.mStatus == eNiuniuRobotStatusResult) {
        NSDictionary* playerDic = nil;
        for (NSDictionary* dic in tmanager.mRobot.mBet.mPlayerBetsValid) {
            if ([dic[@"userid"] isEqualToString: memData[@"userid"]]) {
                playerDic = dic;
                break;
            }
        }
        if (playerDic) {
            int maxKeepScore = 0;
            if ([playerDic[@"betType"] isEqualToString: @"niuniu"]) {
                if (playerDic[@"suoha"] && [playerDic[@"suoha"] isEqualToString: @"true"]) {
                    maxKeepScore = [playerDic[@"num"] intValue];
                } else {
                    //最低需要保留炸弹倍数
                    maxKeepScore = [playerDic[@"num"] intValue] * [tmanager.mRobot.mData.mBaseSetting[@"powBaozi"] intValue];
                }
            } else {
                maxKeepScore = [playerDic[@"num"] intValue];
            }
            if (playerScore - maxKeepScore < downScore) {
                return deString(@"❌❌❌❌❌❌❌❌❌❌\n⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n@%@\n下分失败[该玩家正在等待结算]\n当前分数: %d\n锁定分数: %d\n最多可下: %d\n⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n❌❌❌❌❌❌❌❌❌❌", from, playerScore, MIN(playerScore, maxKeepScore), MAX(playerScore - maxKeepScore, 0));
            }
        }
    }
    return nil;
}

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

-(NSDictionary*) financeContent2Dic: (NSString*)content {
    NSArray* lines = [content componentsSeparatedByString: @"\n"];
    NSString* head = lines[0];
    if ([head hasPrefix: @"#查分#"] || [head hasPrefix: @"#分数清零#"]) {
        if ([lines count] >= 3) {
            NSString* line = lines[1];
            NSString* title = @"微信: ";
            if ([line hasPrefix: title] && [line length] > [title length]) {
                NSString* userid = [line substringFromIndex: [title length]];
                line = lines[2];
                NSString* title = @"昵称: ";
                if ([line hasPrefix: title] && [line length] > [title length]) {
                    NSString* nickname = [line substringFromIndex: [title length]];
                    NSString* type = [head hasPrefix: @"#查分#"] ? @"queryScore" : @"clearScore";
                    return @{
                             @"type" : type,
                             @"userid" : userid,
                             @"nickname" : nickname
                             };
                }
            }
        }
        return nil;
    }
    else if ([head hasPrefix: @"#上分#"] || [head hasPrefix: @"#下分#"]) {
        if ([lines count] >= 4) {
            NSString* line = lines[1];
            int score;
            NSScanner* scan = [NSScanner scannerWithString: line];
            if ([scan scanString: @"分数: " intoString: nil] && [scan scanInt: &score] && [scan isAtEnd]) {
                line = lines[2];
                NSString* title = @"微信: ";
                if ([line hasPrefix: title] && [line length] > [title length]) {
                    NSString* userid = [line substringFromIndex: [title length]];
                    line = lines[3];
                    NSString* title = @"昵称: ";
                    if ([line hasPrefix: title] && [line length] > [title length]) {
                        NSString* nickname = [line substringFromIndex: [title length]];
                        NSString* type = [head hasPrefix: @"#上分#"] ? @"upScore" : @"downScore";
                        return @{
                                 @"type" : type,
                                 @"userid" : userid,
                                 @"score" : deInt2String(score),
                                 @"nickname" : nickname
                                 };
                    }
                }
            }
        }
        return nil;
    }
    return nil;
}

-(NSString*) financeContentParse: (NSString*)content sayerUserid:(NSString*)sayerUserid sayerName:(NSString*)sayerName hasPower:(BOOL)hasPower fromUsr:(NSString*)fromUsr{
    NSDictionary* dic = [self financeContent2Dic: content];
    if (!dic) {
        return deString(@"@%@\n无效的指令", sayerName);
    }
    
    NSString* head = deString(@"[回应]: %@\n%@\n──────────\n", sayerUserid, dic[@"userid"]);
    if (!hasPower) {
        return deString(@"%@没有上下分权限.", head);
    }
    
    if ([dic[@"type"] isEqualToString:@"queryScore"]) {
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (!memData) {
            return deString(@"%@分数: 0", head);
        }
        NSMutableString* text = [NSMutableString string];
        [text appendFormat: @"编号: %@\n", memData[@"index"]];
        [text appendFormat: @"身份: %@\n", [tmanager.mRobot getIdentityStr: memData[@"userid"]]];
        [text appendFormat: @"昵称: %@\n", memData[@"name"]];
        [text appendFormat: @"单名: %@\n", memData[@"billName"]];
        [text appendFormat: @"分数: %@\n", memData[@"score"]];
        return deString(@"%@%@", head, text);
    } else if ([dic[@"type"] isEqualToString:@"upScore"]) {
        BOOL isNew = NO;
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (!memData) {
            NSString* errMsg = [tmanager.mRobot.mMembers addMember:dic[@"userid"] billName:[niuniuRobotMembers formatName: dic[@"nickname"]]];
            if (errMsg) {
                return deString(@"%@\n[%@]会员添加失败(%@)", head, dic[@"nickname"], errMsg);
            }
            isNew = YES;
            memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        }
        int changeScore = [dic[@"score"] intValue];
        int oldScore = [memData[@"score"] intValue];
        if ([tmanager.mRobot.mMembers addScore: memData[@"userid"] score: changeScore isSet: NO params: @{
                                                                                                    @"type":@"command",
                                                                                                    @"chatroom":fromUsr,
                                                                                                    @"fromUserid":sayerUserid,
                                                                                                    @"fromName":sayerName}]) {
            [tmanager.mRobot.mData saveMemberListFile];
            NSString* hint = @"";
            if (isNew) {
                if ([memData[@"billName"] hasPrefix: @"特殊"]) {
                    hint = deString(@"⚠️新玩家, 玩家昵称无法识别, 已修改玩家账单名为(%@), 请提醒玩家!!!⚠️\n──────────\n", memData[@"billName"]);
                } else {
                    hint = @"⚠️新玩家⚠️\n──────────\n";
                }
            } else if([tmanager.mRobot.mTuos isTuo: memData[@"userid"]]) {
                hint = @"⚠️此人是托⚠️\n──────────\n";
            }
            NSString* text = [self newScoreChangedMsg: oldScore memData: memData from: nil chatroom: fromUsr];
            return deString(@"%@%@%@", head, hint, text);
        }
    } else if ([dic[@"type"] isEqualToString:@"downScore"] || [dic[@"type"] isEqualToString:@"clearScore"]) {
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (!memData) {
            return deString(@"%@❌❌❌❌❌❌❌❌❌❌\n⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n下分失败[分数不足]\n⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n❌❌❌❌❌❌❌❌❌❌", head);
        }
        int changeScore;
        if ([dic[@"type"] isEqualToString:@"downScore"]) {
            changeScore = [dic[@"score"] intValue];
        } else {
            changeScore = -[memData[@"score"] intValue];
        }
        if (changeScore >= 0) {
            return deString(@"%@下分失败.", head);
        }
        NSString* errMsg = [self canDownScore:abs(changeScore) memData:memData from:sayerName];
        if (errMsg) {
            return deString(@"%@%@", head, errMsg);
        }
        int oldScore = [memData[@"score"] intValue];
        if ([tmanager.mRobot.mMembers addScore: memData[@"userid"] score: changeScore isSet: NO params: @{
                                                                                                    @"type":@"command",
                                                                                                    @"chatroom":fromUsr,
                                                                                                    @"fromUserid":sayerUserid,
                                                                                                    @"fromName":sayerName}]) {
            [tmanager.mRobot.mData saveMemberListFile];
            NSString* hint = @"";
            if([tmanager.mRobot.mTuos isTuo: memData[@"userid"]]) {
                hint = @"⚠️此人是托⚠️\n──────────\n";
            }
            NSString* text = [self newScoreChangedMsg: oldScore memData: memData from: nil chatroom: fromUsr];
            return deString(@"%@%@%@", head, hint, text);
        }
    }
    return deString(@"%@无效的指令.", head);
}

//所有数据字段
-(NSMutableDictionary*) allPlayerDataDictionary {
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"userid"] = @"";
    dic[@"allWinOrLose"] = @"0";
    dic[@"robScore"] = @"0";
    dic[@"roundCount"] = @"0";
    dic[@"betCount"] = @"0";//牛牛总下注
    dic[@"betCountForPlayerBack"] = @"0";//牛牛总下注(反水)
    dic[@"betCountNiuniu"] = @"0";
    dic[@"betCountSuoha"] = @"0";
    dic[@"betCountYibi"] = @"0";
    dic[@"betCountMianyong"] = @"0";
    dic[@"betCountDaxiao"] = @"0";
    dic[@"betCountTema"] = @"0";
    dic[@"betCountBaijiale"] = @"0";
    dic[@"totalBet"] = @"0";//所有总下注
    dic[@"totalBetForPlayerBack"] = @"0";//所有总下注(反水)
    dic[@"averageBet"] = @"0";
    dic[@"ratioCount"] = @"0";
    dic[@"robCount"] = @"0";
    dic[@"upScoreCount"] = @"0";
    dic[@"downScoreCount"] = @"0";
    dic[@"betNums"] = [NSMutableArray array];
    dic[@"niuniuArr"] = [NSMutableArray array];
    dic[@"jinniuArr"] = [NSMutableArray array];
    dic[@"duiziArr"] = [NSMutableArray array];
    dic[@"shunziArr"] = [NSMutableArray array];
    dic[@"daoshunArr"] = [NSMutableArray array];
    dic[@"manniuArr"] = [NSMutableArray array];
    dic[@"baoziArr"] = [NSMutableArray array];
    dic[@"niuniuArr2"] = [NSMutableArray array];
    dic[@"jinniuArr2"] = [NSMutableArray array];
    dic[@"duiziArr2"] = [NSMutableArray array];
    dic[@"shunziArr2"] = [NSMutableArray array];
    dic[@"daoshunArr2"] = [NSMutableArray array];
    dic[@"manniuArr2"] = [NSMutableArray array];
    dic[@"baoziArr2"] = [NSMutableArray array];
    return dic;
}

-(NSMutableDictionary*) allPlayerData {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    NSMutableDictionary* allPlayer = [NSMutableDictionary dictionary];
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        BOOL isBankerHead = NO;
        for (NSDictionary* player in dic[@"bankers"]) {
            NSMutableDictionary* values = allPlayer[player[@"userid"]];
            if (!values) {
                values = [self allPlayerDataDictionary];
                values[@"userid"] = player[@"userid"];
                allPlayer[player[@"userid"]] = values;
            }
            
            int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
            values[@"allWinOrLose"] = deInt2String([values[@"allWinOrLose"] intValue] + winOrLoseFact);
            
            if (player[@"coverRobUp"]) {
                values[@"robScore"] = deInt2String([values[@"robScore"] intValue] + [player[@"coverRobUp"] intValue]);
            }
            
            if ([player[@"isMain"] isEqualToString: @"true"]) {
                if ([player[@"resultHandle"] isEqualToString: @"bankerHead"]) {
                    isBankerHead = YES;
                }
            }
        }
        
        BOOL isFuliBanker = NO;
        if (dic[@"betVars"][@"mFuliSetting"] && dic[@"betVars"][@"mFuliSetting"][@"enable"] && [dic[@"betVars"][@"mFuliSetting"][@"enable"] isEqualToString: @"true"]) {
            isFuliBanker = YES;
        }
        
        for (NSDictionary* player in dic[@"players"]) {
            NSMutableDictionary* values = allPlayer[player[@"userid"]];
            if (!values) {
                values = [self allPlayerDataDictionary];
                values[@"userid"] = player[@"userid"];
                allPlayer[player[@"userid"]] = values;
            }
            
            int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
            values[@"allWinOrLose"] = deInt2String([values[@"allWinOrLose"] intValue] + winOrLoseFact);
            
            if (player[@"coverRobUp"]) {
                values[@"robScore"] = deInt2String([values[@"robScore"] intValue] + [player[@"coverRobUp"] intValue]);
            }
            
            values[@"roundCount"] = deInt2String([values[@"roundCount"] intValue]+1);
            
            if ([player[@"betType"] isEqualToString: @"niuniu"]) {
                if (player[@"suoha"] && [player[@"suoha"] isEqualToString: @"true"]) {
                    values[@"betCountSuoha"] = deInt2String([values[@"betCountSuoha"] intValue]+[player[@"num"] intValue]);
                } else {
                    int num = [player[@"num"] intValue];
                    int num2 = num;
                    if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        values[@"betCountYibi"] = deInt2String([values[@"betCountYibi"] intValue]+num);
                        num *= [setting[@"niuniuYibiBetTotalRatio"] floatValue];
                        num2 *= [setting[@"niuniuYibiBetTotalRatioPlayerBack"] floatValue];
                    }
                    else if (player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"]) {
                        values[@"betCountMianyong"] = deInt2String([values[@"betCountMianyong"] intValue]+num);
                    }
                    else {
                        values[@"betCountNiuniu"] = deInt2String([values[@"betCountNiuniu"] intValue]+num);
                    }
                    values[@"betCount"] = deInt2String([values[@"betCount"] intValue]+num);
                    values[@"betCountForPlayerBack"] = deInt2String([values[@"betCountForPlayerBack"] intValue]+num2);
                }
            } else if ([player[@"betType"] isEqualToString: @"tema"]) {
                values[@"betCountTema"] = deInt2String([values[@"betCountTema"] intValue]+[player[@"num"] intValue]);
            } else if ([player[@"betType"] isEqualToString: @"baijiale"]) {
                values[@"betCountBaijiale"] = deInt2String([values[@"betCountBaijiale"] intValue]+[player[@"num"] intValue]);
            } else if ([player[@"betType"] isEqualToString: @"longhu"]){
                values[@"betCountDaxiao"] = deInt2String([values[@"betCountDaxiao"] intValue]+[player[@"num"] intValue]);
            }
            
            if (player[@"playerRatio"]) {
                values[@"ratioCount"] = deInt2String([values[@"ratioCount"] intValue]+[player[@"playerRatio"] intValue]);
            }
            
            int bet = [player[@"num"] intValue];
            if (![player[@"betType"] isEqualToString: @"niuniu"] || [player[@"suoha"] isEqualToString: @"true"]) {//daxiao,tema,baijiale
                bet = [player[@"num"] intValue]/10;
            } else {//牛牛非梭哈
                bet = [player[@"num"] intValue];
            }
            [values[@"betNums"] addObject: deInt2String(bet)];
            
            BOOL bankerHeadNull = isBankerHead && [player[@"betType"] isEqualToString: @"niuniu"];
            if ([player[@"resultHandle"] isEqualToString: @"normal"] && !bankerHeadNull && !isFuliBanker) {//正常情况下才算奖励
                int amount = [player[@"amount"] intValue];
                int pow = [niuniu amount2pow: amount];
                NSString* arrKey = @"";
                if (10 == pow) {
                    arrKey = @"niuniuArr";
                } else if (11 == pow) {
                    arrKey = @"jinniuArr";
                } else if (12 == pow) {
                    arrKey = @"duiziArr";
                } else if (13 == pow) {
                    arrKey = @"daoshunArr";
                } else if (14 == pow) {
                    arrKey = @"shunziArr";
                } else if (15 == pow) {
                    arrKey = @"manniuArr";
                } else if (18 == pow) {
                    arrKey = @"baoziArr";
                }
                if (![arrKey isEqualToString: @""]) {
                    NSString* notSameKey = deString(@"%@2", arrKey);
                    NSString* amountStr = player[@"amount"];
                    NSString* betStr = deInt2String(bet);
                    [values[arrKey] insertObject:@[amountStr, betStr] atIndex:0];

                    BOOL needAdd = YES;
                    for (int i = 0; i < [values[notSameKey] count]; ++i) {
                        NSString* existAmount = values[notSameKey][i][0];
                        if ([amountStr isEqualToString: existAmount]) {
                            int existBet = [values[notSameKey][i][1] intValue];
                            if (bet >= existBet) {
                                [values[notSameKey] removeObjectAtIndex: i];
                            } else {
                                needAdd = NO;
                            }
                            break;
                        }
                    }
                    if (needAdd) {
                        [values[notSameKey] insertObject:@[amountStr, betStr] atIndex:0];
                    }
                }
            }
        }
        
        for (NSDictionary* player in dic[@"robs"]) {
            NSMutableDictionary* values = allPlayer[player[@"userid"]];
            if (!values) {
                values = [self allPlayerDataDictionary];
                values[@"userid"] = player[@"userid"];
                allPlayer[player[@"userid"]] = values;
            }
            
            if (player[@"robDown"]) {
                values[@"robScore"] = deInt2String([values[@"robScore"] intValue] - [player[@"robDown"] intValue]);
            }
            
            values[@"robCount"] = deInt2String([values[@"robCount"] intValue]+1);
        }
    }
    
    finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        NSMutableDictionary* values = allPlayer[dic[@"userid"]];
        if (!values) {
            values = [self allPlayerDataDictionary];
            values[@"userid"] = dic[@"userid"];
            allPlayer[dic[@"userid"]] = values;
        }
        
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        if (change > 0) {
            values[@"upScoreCount"] = deInt2String([values[@"upScoreCount"] intValue]+abs(change));
        } else {
            values[@"downScoreCount"] = deInt2String([values[@"downScoreCount"] intValue]+abs(change));
        }
    }
    
    NSArray* allPlayerDataArr = [allPlayer allValues];
    for (NSMutableDictionary* dic in allPlayerDataArr) {
        int totalBet = [dic[@"betCount"] intValue]*10 + [dic[@"betCountSuoha"] intValue] + [dic[@"betCountDaxiao"] intValue] + [dic[@"betCountTema"] intValue] + [dic[@"betCountBaijiale"] intValue];
        int totalBetForPlayerBack = [dic[@"betCountForPlayerBack"] intValue]*10 + [dic[@"betCountSuoha"] intValue] + [dic[@"betCountDaxiao"] intValue] + [dic[@"betCountTema"] intValue] + [dic[@"betCountBaijiale"] intValue];
        int averageBet = totalBet/[dic[@"roundCount"] intValue];
        dic[@"totalBet"] = deInt2String(totalBet);
        dic[@"totalBetForPlayerBack"] = deInt2String(totalBetForPlayerBack);
        dic[@"averageBet"] = deInt2String(averageBet);
        
        [dic[@"betNums"] sortUsingComparator: ^NSComparisonResult(NSString* a, NSString* b) {
            return [a intValue] < [b intValue] ? 1 : -1;
        }];
    }
    return allPlayer;
}

//导出所有数据
-(void) exportAllData: (NSString*)target {
    NSString* title = deString(@"[%@]所有数据.xls", tmanager.mRobot.mQueryDate);
    NSData* data = [niuniuRobotExcelHelper makeAllData: [self allPlayerData]];
    [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
}

//生成流水字符串
-(NSString*) newTotalInfo:(int)start end:(int)end {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDateFormatter *hourDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [hourDateformat setDateFormat:@"HH"];
    
    //龙虎
    //    int allWinOrLose = 0;//总输赢
    
    //牛牛
    int upBankerFee = 0;//上庄抽水
    int hongbaoFee = 0;//红包费抽水
    int bonusPoolFee = 0;//奖池费
    
    int startRound = 0;//开始局数
    int endRound = 0;//结束局数
    int allUpScores = 0;//总上分
    int allDownScores = 0;//总下分
    int allTuoUpScores = 0;//总上分
    int allTuoDownScores = 0;//总下分
    int heiFee = 0;//暗扣统计
    float allHongbaoAmount = 0;//红包支出
    int heshuiSubsidyCount = 0;//喝水补贴
    
    int tuoBetCount = 0;
    int tuoBetCountSuoha = 0;
    int tuoBetCountDaxiao = 0;
    int tuoBetCountTema = 0;
    int tuoBetCountBaijiale = 0;
    int tuoRatioTotal = 0;
    int tuoRobUp = 0;
    int tuoRobDown = 0;
    int tuoWinOrLose = 0;
    int tuoBankerRatioCount = 0;
    int tuoEveryPlayerHongbaoFeeCount = 0;
    int tuoBankerWinCount = 0;
    int tuoNiuniuWinCount = 0;
    int tuoNiuniuMianyongWinCount = 0;
    int tuoNiuniuYibiWinCount = 0;
    int tuoDaxiaoWinCount = 0;
    int tuoTemaWinCount = 0;
    int tuoBaijialeWinCount = 0;
    
    int playerBetCount = 0;
    int playerBetCountSuoha = 0;
    int playerBetCountDaxiao = 0;
    int playerBetCountTema = 0;
    int playerBetCountBaijiale = 0;
    int playerRatioTotal = 0;
    int playerEveryPlayerHongbaoFeeCount = 0;
    int playerRobUp = 0;
    int playerRobDown = 0;
    int playerWinOrLose = 0;
    int playerBankerRatioCount = 0;
    int playerBankerWinCount = 0;
    int playerNiuniuWinCount = 0;
    int playerNiuniuMianyongWinCount = 0;
    int playerNiuniuYibiWinCount = 0;
    int playerDaxiaoWinCount = 0;
    int playerTemaWinCount = 0;
    int playerBaijialeWinCount = 0;
    
    [tmanager.mRobot.mDayInfos checkPlayerScoreCount];
    int yesterdayScoreCount = [tmanager.mRobot.mDayInfos getPlayerScore: [ycFunction getLastdayDateWithDate: tmanager.mRobot.mQueryDate]];
    int currentScoresCount = [tmanager.mRobot.mDayInfos getPlayerScore: tmanager.mRobot.mQueryDate];
    if (-2 == currentScoresCount && [tmanager.mRobot.mQueryDate isEqualToString: [ycFunction getTodayDate]]) {
        currentScoresCount = [tmanager.mRobot.mMembers getAllScoreCountOnlyPlayer];
    }
    int shangfenQunCount = 0;
    if ([[tmanager.mRobot getBackgroundWithType: @"shangfen"] count] <= 0) {
        shangfenQunCount = -1;
    }
    int xiafenQunCount = 0;
    if ([[tmanager.mRobot getBackgroundWithType: @"xiafen"] count] <= 0) {
        xiafenQunCount = -1;
    }
    int fuliQunCount = 0;
    if ([[tmanager.mRobot getBackgroundWithType: @"fuli"] count] <= 0) {
        fuliQunCount = -1;
    }
    

    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        NSDate* date = [objDateformat dateFromString:dic[@"date"]];
        NSString* strHour = [hourDateformat stringFromDate:date];
        int hour = [strHour intValue];
        
        if (hour < start || hour >= end) {//时间限制
            continue;
        }
        
        BOOL bankerIsTuo = YES;
        for (NSDictionary* player in dic[@"bankers"]) {
            if ([player[@"isMain"] isEqualToString: @"true"]) {
                int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
                int robUp = 0;
                if (player[@"coverRobUp"]) {
                    robUp = [player[@"coverRobUp"] intValue];
                }
                BOOL isTuo = [tmanager.mRobot.mTuos isTuo: player[@"userid"]];
                if (isTuo) {
                    tuoRobUp += robUp;
                    tuoWinOrLose += winOrLoseFact;
                    tuoBankerWinCount += winOrLoseFact;
                } else {
                    playerRobUp += robUp;
                    playerWinOrLose += winOrLoseFact;
                    playerBankerWinCount += winOrLoseFact;
                }
                bankerIsTuo = isTuo;
                break;
            }
        }
        
        for (NSDictionary* player in dic[@"players"]) {
            int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
            int robUp = 0;
            int betNiuniu = 0;
            int betNiuniuSuoha = 0;
            int betDaxiao = 0;
            int betTema = 0;
            int betBaijiale = 0;
            int ratio = 0;
            int everyPlayerHongbaoFee = 0;
            
            if (player[@"coverRobUp"]) {
                robUp = [player[@"coverRobUp"] intValue];
            }
            
            BOOL isTuo = [tmanager.mRobot.mTuos isTuo: player[@"userid"]];
            if ([player[@"betType"] isEqualToString: @"niuniu"]) {
                if (player[@"suoha"] && [player[@"suoha"] isEqualToString: @"true"]) {
                    betNiuniuSuoha = [player[@"num"] intValue];
                } else {
                    betNiuniu = [player[@"num"] intValue];
                    if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        betNiuniu *= [setting[@"niuniuYibiBetTotalRatio"] floatValue];
                    }
                }
                if (isTuo) {
                    if (player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"]) {
                        tuoNiuniuMianyongWinCount += winOrLoseFact;
                    } else if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        tuoNiuniuYibiWinCount += winOrLoseFact;
                    } else {
                        tuoNiuniuWinCount += winOrLoseFact;
                    }
                } else {
                    if (player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"]) {
                        playerNiuniuMianyongWinCount += winOrLoseFact;
                    } else if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        playerNiuniuYibiWinCount += winOrLoseFact;
                    } else {
                        playerNiuniuWinCount += winOrLoseFact;
                    }
                }
            } else if ([player[@"betType"] isEqualToString: @"tema"]) {
                betTema = [player[@"num"] intValue];
                if (isTuo) {
                    tuoTemaWinCount += winOrLoseFact;
                } else {
                    playerTemaWinCount += winOrLoseFact;
                }
            } else if ([player[@"betType"] isEqualToString: @"baijiale"]) {
                betBaijiale = [player[@"num"] intValue];
                if (isTuo) {
                    tuoBaijialeWinCount += winOrLoseFact;
                } else {
                    playerBaijialeWinCount += winOrLoseFact;
                }
            } else if ([player[@"betType"] isEqualToString: @"longhu"]){
                betDaxiao = [player[@"num"] intValue];
                if (isTuo) {
                    tuoDaxiaoWinCount += winOrLoseFact;
                } else {
                    playerDaxiaoWinCount += winOrLoseFact;
                }
            }
            
            if (player[@"playerRatio"]) {
                ratio = [player[@"playerRatio"] intValue];
            }
            
            if (player[@"everyPlayerHongbaoFee"]) {
                everyPlayerHongbaoFee = [player[@"everyPlayerHongbaoFee"] intValue];
            }
            
            if (isTuo) {
                tuoBetCount += betNiuniu;
                tuoBetCountSuoha += betNiuniuSuoha;
                tuoBetCountDaxiao += betDaxiao;
                tuoBetCountTema += betTema;
                tuoBetCountBaijiale += betBaijiale;
                tuoRatioTotal += ratio;
                tuoRobUp += robUp;
                tuoWinOrLose += winOrLoseFact;
                tuoEveryPlayerHongbaoFeeCount += everyPlayerHongbaoFee;
            } else {
                playerBetCount += betNiuniu;
                playerBetCountSuoha += betNiuniuSuoha;
                playerBetCountDaxiao += betDaxiao;
                playerBetCountTema += betTema;
                playerBetCountBaijiale += betBaijiale;
                playerRatioTotal += ratio;
                playerRobUp += robUp;
                playerWinOrLose += winOrLoseFact;
                playerEveryPlayerHongbaoFeeCount += everyPlayerHongbaoFee;
            }
        }
        
        for (NSDictionary* player in dic[@"robs"]) {
            int robDown = 0;
            if (player[@"robDown"]) {
                robDown = [player[@"robDown"] intValue];
            }
            
            BOOL isTuo = [tmanager.mRobot.mTuos isTuo: player[@"userid"]];
            if (isTuo) {
                tuoRobDown += robDown;
            } else {
                playerRobDown += robDown;
            }
        }
            
        
        if (0 == endRound) {
            endRound = [dic[@"number"] intValue];
        }
        startRound = [dic[@"number"] intValue];
        allHongbaoAmount += [dic[@"resultVars"][@"mTotalAmount"] floatValue]/100;
        if (tmanager.mRobot.mEnableNiuniu) {
            if (bankerIsTuo) {
                tuoBankerRatioCount += [dic[@"otherInfo"][@"bankerRatioTotal"] intValue];
            } else {
                playerBankerRatioCount += [dic[@"otherInfo"][@"bankerRatioTotal"] intValue];
            }
            upBankerFee += [dic[@"otherInfo"][@"upBankerFee"] intValue];
            hongbaoFee += [dic[@"otherInfo"][@"hongbaoFee"] intValue];
            bonusPoolFee += [dic[@"otherInfo"][@"bonusPoolFee"] intValue];
            if (dic[@"otherInfo"][@"heiFee"]) {
                heiFee += [dic[@"otherInfo"][@"heiFee"] intValue];
            }
            if (dic[@"otherInfo"][@"heshuiSubsidyCount"]) {
                heshuiSubsidyCount += [dic[@"otherInfo"][@"heshuiSubsidyCount"] intValue];
            }
        }
//        if(enableLonghu) {
//            allWinOrLose += [dic[@"otherInfo"][@"bankerOriginWinOrLose"] intValue];
//        }
    }
    
    finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        NSDate* date = [objDateformat dateFromString:dic[@"date"]];
        NSString* strHour = [hourDateformat stringFromDate:date];
        int hour = [strHour intValue];
        
        if (hour < start || hour >= end) {//时间限制
            continue;
        }
        
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        BOOL isTuo = [tmanager.mRobot.mTuos isTuo: dic[@"userid"]];
        if (change > 0) {
            if (isTuo) {
                allTuoUpScores += abs(change);
            } else {
                allUpScores += abs(change);
            }
        } else {
            if (isTuo) {
                allTuoDownScores += abs(change);
            } else {
                allDownScores += abs(change);
            }
        }
        
        if ([dic[@"type"] isEqualToString: @"command"] && dic[@"chatroom"]) {
            NSDictionary* chatroom = [tmanager.mRobot getBackroundRoom: dic[@"chatroom"]];
            if (chatroom) {
                if ([chatroom[@"type"] isEqualToString: @"shangfen"]) {
                    shangfenQunCount += change;
                }else if ([chatroom[@"type"] isEqualToString: @"xiafen"]) {
                    xiafenQunCount += change;
                }else if ([chatroom[@"type"] isEqualToString: @"fuli"]) {
                    fuliQunCount += change;
                }
            }
            
        }
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", tmanager.mRobot.mQueryDate];
    [text appendFormat: @"[%02d:00:00~%02d:00:00]\n", start, end];
    [text appendString: [self addTitle: @"流水"]];
    [text appendFormat: @"开始局数: %d\n", startRound];
    [text appendFormat: @"结束局数: %d\n", endRound];
    [text appendFormat: @"累计局数: %d\n", endRound-startRound+1];
    [text appendFormat: @"发包支出: %.2f\n", allHongbaoAmount];
    [text appendFormat: @"上庄费用: %d\n", upBankerFee];
    [text appendFormat: @"红包费用: %d\n", hongbaoFee];
    [text appendFormat: @"奖池费用: %d\n", bonusPoolFee];
    if (tmanager.mRobot.mEnableNiuniu) {
        if (heiFee > 0) {
            [text appendFormat: @"其他费用: %d\n", heiFee];
        }
        if (heshuiSubsidyCount > 0) {
            [text appendFormat: @"喝水补贴: %d\n", heshuiSubsidyCount];
        }
    }
    [text appendString: [self addTitle: @"群"]];
    [text appendString: @"注: 实际盈亏 = 财务总上分 - 财务总下分 - (今日留分 - 昨日留分)\n"];
    [text appendString: @"──────────\n"];
    if (yesterdayScoreCount < 0 || currentScoresCount < 0 || shangfenQunCount == -1 || xiafenQunCount == -1) {
        [text appendString: @"实际盈亏: 无法计算\n"];
    } else {
        [text appendFormat: @"实际盈亏: %d\n", shangfenQunCount + xiafenQunCount - currentScoresCount + yesterdayScoreCount];
    }
    if (yesterdayScoreCount < 0) {
        [text appendString: @"昨日留分: 无记录\n"];
    } else {
        [text appendFormat: @"昨日留分: %d\n", yesterdayScoreCount];
    }
    if (currentScoresCount < 0) {
        [text appendFormat: @"今日留分: %@\n", currentScoresCount == -2 ? @"未过24点" : @"无记录"];
    } else {
        [text appendFormat: @"今日留分: %d\n", currentScoresCount];
    }
    if (shangfenQunCount == -1) {
        [text appendString: @"上分群统计: 未绑定\n"];
    } else {
        [text appendFormat: @"上分群统计: %d\n", shangfenQunCount];
    }
    if (xiafenQunCount == -1) {
        [text appendString: @"下分群统计: 未绑定\n"];
    } else {
        [text appendFormat: @"下分群统计: %d\n", xiafenQunCount];
    }
    if (fuliQunCount == -1) {
        [text appendString: @"福利群统计: 未绑定\n"];
    } else {
        [text appendFormat: @"福利群统计: %d\n", fuliQunCount];
    }
    [text appendString: [self addTitle: @"玩家"]];
    [text appendFormat: @"总上分: %d\n", allUpScores];
    [text appendFormat: @"总下分: %d\n", allDownScores];
    [text appendFormat: @"总输赢: %d\n", playerWinOrLose];
    [text appendFormat: @"开庄输赢: %d\n", playerBankerWinCount];
    [text appendFormat: @"牛牛输赢: %d\n", playerNiuniuWinCount];
    [text appendFormat: @"免佣输赢: %d\n", playerNiuniuMianyongWinCount];
    [text appendFormat: @"一比输赢: %d\n", playerNiuniuYibiWinCount];
    [text appendFormat: @"大小输赢: %d\n", playerDaxiaoWinCount];
    [text appendFormat: @"特码输赢: %d\n", playerTemaWinCount];
    [text appendFormat: @"百家乐输赢: %d\n", playerBaijialeWinCount];
    [text appendFormat: @"庄总抽水: %d\n", playerBankerRatioCount];
    [text appendFormat: @"闲总抽水: %d\n", playerRatioTotal];
    [text appendFormat: @"闲抽红包: %d\n", playerEveryPlayerHongbaoFeeCount];
    [text appendFormat: @"抢包扣分: %d\n", playerRobDown];
    [text appendFormat: @"抢包补分: %d\n", playerRobUp];
    [text appendFormat: @"牛牛下注: %d\n", playerBetCount];
    [text appendFormat: @"牛牛梭哈: %d\n", playerBetCountSuoha];
    [text appendFormat: @"大小下注: %d\n", playerBetCountDaxiao];
    [text appendFormat: @"特码下注: %d\n", playerBetCountTema];
    [text appendFormat: @"百家下注: %d\n", playerBetCountBaijiale];
    [text appendString: [self addTitle: @"托"]];
    [text appendFormat: @"总上分: %d\n", allTuoUpScores];
    [text appendFormat: @"总下分: %d\n", allTuoDownScores];
    [text appendFormat: @"总输赢: %d\n", tuoWinOrLose];
    [text appendFormat: @"开庄输赢: %d\n", tuoBankerWinCount];
    [text appendFormat: @"牛牛输赢: %d\n", tuoNiuniuWinCount];
    [text appendFormat: @"免佣输赢: %d\n", tuoNiuniuMianyongWinCount];
    [text appendFormat: @"一比输赢: %d\n", tuoNiuniuYibiWinCount];
    [text appendFormat: @"大小输赢: %d\n", tuoDaxiaoWinCount];
    [text appendFormat: @"特码输赢: %d\n", tuoTemaWinCount];
    [text appendFormat: @"百家乐输赢: %d\n", tuoBaijialeWinCount];
    [text appendFormat: @"庄总抽水: %d\n", tuoBankerRatioCount];
    [text appendFormat: @"闲总抽水: %d\n", tuoRatioTotal];
    [text appendFormat: @"闲抽红包: %d\n", tuoEveryPlayerHongbaoFeeCount];
    [text appendFormat: @"抢包扣分: %d\n", tuoRobDown];
    [text appendFormat: @"抢包补分: %d\n", tuoRobUp];
    [text appendFormat: @"牛牛下注: %d\n", tuoBetCount];
    [text appendFormat: @"牛牛梭哈: %d\n", tuoBetCountSuoha];
    [text appendFormat: @"大小下注: %d\n", tuoBetCountDaxiao];
    [text appendFormat: @"特码下注: %d\n", tuoBetCountTema];
    [text appendFormat: @"百家下注: %d\n", tuoBetCountBaijiale];
    
//    if(enableLonghu) {
//        [text appendFormat: @"累计输赢: %d\n", allWinOrLose];
//        [text appendFormat: @"累计盈亏: %d\n", allWinOrLose+playerRatioTotal+allRobFee];
//    }
    return text;
}

//获得一个拉手成员的下注详情
-(NSDictionary*) getLashouMemberBetDetail: (NSString*)userid queryDate:(NSString*)queryDate{
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    NSDictionary* allMembers = tmanager.mRobot.mData.mLashouList[userid];
    if (!allMembers) {//不是拉手
        return 0;
    }
    
    NSMutableDictionary* members = [NSMutableDictionary dictionary];
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: queryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        for (NSDictionary* v in dic[@"players"]) {
            NSString* playerid = v[@"userid"];
            if ([tmanager.mRobot.mLashous isFromlashou: userid player: playerid]) {
                if (!members[playerid]) {
                    members[playerid] = [NSMutableDictionary dictionary];
                    members[playerid][@"roundCount"] = @"0";
                    members[playerid][@"betCount"] = @"0";
                    members[playerid][@"betCountSuoha"] = @"0";
                    members[playerid][@"betCountDaxiao"] = @"0";
                    members[playerid][@"betCountTema"] = @"0";
                    members[playerid][@"betCountBaijiale"] = @"0";
                    members[playerid][@"ratioCount"] = @"0";
                    members[playerid][@"robCount"] = @"0";
                }
                members[playerid][@"roundCount"] = deInt2String([members[playerid][@"roundCount"] intValue]+1);
                if ([v[@"betType"] isEqualToString: @"niuniu"]) {
                    if (v[@"suoha"] && [v[@"suoha"] isEqualToString: @"true"]) {
                        members[playerid][@"betCountSuoha"] = deInt2String([members[playerid][@"betCountSuoha"] intValue]+[v[@"num"] intValue]);
                    } else {
                        int num = [v[@"num"] intValue];
                        if (v[@"yibi"] && [v[@"yibi"] isEqualToString: @"true"]) {
                            num *= [setting[@"niuniuYibiBetTotalRatio"] floatValue];
                        }
                        members[playerid][@"betCount"] = deInt2String([members[playerid][@"betCount"] intValue]+num);
                    }
                } else if ([v[@"betType"] isEqualToString: @"tema"]) {
                    members[playerid][@"betCountTema"] = deInt2String([members[playerid][@"betCountTema"] intValue]+[v[@"num"] intValue]);
                } else if ([v[@"betType"] isEqualToString: @"baijiale"]) {
                    members[playerid][@"betCountBaijiale"] = deInt2String([members[playerid][@"betCountBaijiale"] intValue]+[v[@"num"] intValue]);
                } else if ([v[@"betType"] isEqualToString: @"longhu"]){
                    members[playerid][@"betCountDaxiao"] = deInt2String([members[playerid][@"betCountDaxiao"] intValue]+[v[@"num"] intValue]);
                }
                
                if (v[@"playerRatio"]) {
                    members[playerid][@"ratioCount"] = deInt2String([members[playerid][@"ratioCount"] intValue]+[v[@"playerRatio"] intValue]);
                }
            }
        }
        
        for (NSDictionary* v in dic[@"robs"]) {
            NSString* playerid = v[@"userid"];
            if ([tmanager.mRobot.mLashous isFromlashou: userid player: playerid]) {
                if (!members[playerid]) {
                    members[playerid] = [NSMutableDictionary dictionary];
                    members[playerid][@"roundCount"] = @"0";
                    members[playerid][@"betCount"] = @"0";
                    members[playerid][@"betCountSuoha"] = @"0";
                    members[playerid][@"betCountDaxiao"] = @"0";
                    members[playerid][@"betCountTema"] = @"0";
                    members[playerid][@"betCountBaijiale"] = @"0";
                    members[playerid][@"ratioCount"] = @"0";
                    members[playerid][@"robCount"] = @"0";
                }
                members[playerid][@"robCount"] = deInt2String([members[playerid][@"robCount"] intValue]+1);
            }
        }
    }
    
    int allRoundCount = 0;
    int allRobCount = 0;
    int allBetCount = 0;
    int allBetCountSuoha = 0;
    int allBetCountDaxiao = 0;
    int allBetCountTema = 0;
    int allBetCountBaijiale = 0;
    int allRatioCount = 0;
    for (NSString* playerid in members) {
        NSDictionary* dic = members[playerid];
        allRoundCount += [dic[@"roundCount"] intValue];
        allRobCount += [dic[@"robCount"] intValue];
        allBetCount += [dic[@"betCount"] intValue];
        allBetCountSuoha += [dic[@"betCountSuoha"] intValue];
        allBetCountDaxiao += [dic[@"betCountDaxiao"] intValue];
        allBetCountTema += [dic[@"betCountTema"] intValue];
        allBetCountBaijiale += [dic[@"betCountBaijiale"] intValue];
        allRatioCount += [dic[@"ratioCount"] intValue];
    }
    
    return @{
             @"allRoundCount":deInt2String(allRoundCount),
             @"allRobCount":deInt2String(allRobCount),
             @"allBetCount":deInt2String(allBetCount),
             @"allBetCountSuoha":deInt2String(allBetCountSuoha),
             @"allBetCountDaxiao":deInt2String(allBetCountDaxiao),
             @"allBetCountTema":deInt2String(allBetCountTema),
             @"allBetCountBaijiale":deInt2String(allBetCountBaijiale),
             @"allRatioCount":deInt2String(allRatioCount),
             @"members":members
             };
}

//查询所有拉手
-(NSString*) newAllLashou {
    NSMutableArray* array = [tmanager.mRobot.mLashous getAllLashouDetail];
    for (NSMutableDictionary* dic in array) {
        NSDictionary* allbetInfo = [self getLashouMemberBetDetail: dic[@"userid"] queryDate: tmanager.mRobot.mQueryDate];
        if (allbetInfo) {
            dic[@"allbetInfo"] = allbetInfo;
        }
    }
    
    [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (!a[@"allbetInfo"]) {
            return 1;
        }
        if (!b[@"allbetInfo"]) {
            return -1;
        }
        return [a[@"allbetInfo"][@"allBetCount"] intValue]*10+[a[@"allbetInfo"][@"allBetCountSuoha"] intValue]+[a[@"allbetInfo"][@"allBetCountDaxiao"] intValue]+[a[@"allbetInfo"][@"allBetCountTema"] intValue]+[a[@"allbetInfo"][@"allBetCountBaijiale"] intValue] >
        [b[@"allbetInfo"][@"allBetCount"] intValue]*10+[b[@"allbetInfo"][@"allBetCountSuoha"] intValue]+[b[@"allbetInfo"][@"allBetCountDaxiao"] intValue]+[b[@"allbetInfo"][@"allBetCountTema"] intValue]+[b[@"allbetInfo"][@"allBetCountBaijiale"] intValue] ? -1 : 1;
    }];
    
    NSMutableString* text = [NSMutableString string];
    [text appendString: [self addTitle: @"拉手名单"]];
    
    int index = 0;
    for (NSDictionary* dic in array) {
        NSDictionary* allbetInfo = dic[@"allbetInfo"];
        if (!allbetInfo) {
            continue;
        }
        
        NSDictionary* lashouHead = [tmanager.mRobot.mLashouHeads getLashouHeadWithLashou: dic[@"userid"]];
        
        if (index++ > 0) {
            [text appendString: @"──────────\n"];
        }
        [text appendFormat: @"%@. %@\n", dic[@"index"], dic[@"billName"]];
        [text appendFormat: @"微信号: %@\n", dic[@"userid"]];
        if (lashouHead) {
            if (lashouHead[@"index"]) {
                [text appendFormat: @"归属团长: %@# %@\n", lashouHead[@"index"], lashouHead[@"billName"]];
            } else {
                [text appendFormat: @"归属团长: %@\n", lashouHead[@"userid"]];
            }
        }
        [text appendFormat: @"人数: %@ 局数: %@\n", dic[@"count"], allbetInfo[@"allRoundCount"]];
        if (tmanager.mRobot.mEnableNiuniu) {
            [text appendFormat: @"牛牛下注: %d\n", [allbetInfo[@"allBetCount"] intValue]];
            [text appendFormat: @"牛牛梭哈: %d\n", [allbetInfo[@"allBetCountSuoha"] intValue]];
        }
        if (tmanager.mRobot.mEnableLonghu) {
            [text appendFormat: @"大小下注: %d\n", [allbetInfo[@"allBetCountDaxiao"] intValue]];
        }
        if (tmanager.mRobot.mEnableTema) {
            [text appendFormat: @"特码下注: %d\n", [allbetInfo[@"allBetCountTema"] intValue]];
        }
        if (tmanager.mRobot.mEnableBaijiale) {
            [text appendFormat: @"百家乐下注: %d\n", [allbetInfo[@"allBetCountBaijiale"] intValue]];
        }
    }
    return text;
}

//查询所有拉手
-(NSString*) newAllLashouNames {
    NSMutableArray* array = [tmanager.mRobot.mLashous getAllLashouDetail];
    
    NSMutableString* text = [NSMutableString string];
    [text appendString: [self addTitle: @"拉手名单"]];
    [text appendFormat: @"拉手总数: %d\n", (int)[array count]];
    [text appendString: @"──────────\n"];

    for (NSDictionary* dic in array) {
        if (dic[@"index"]) {
            [text appendFormat: @"%@　%@　%@人\n", dic[@"index"], deFillName(dic[@"billName"]), dic[@"count"]];
        }
    }
    return text;
}

//查询指定拉手
-(NSString*) newLashouMembers:(NSString*)userid name:(NSString*)name queryDate:(NSString*)queryDate{
    NSDictionary* allMembers = tmanager.mRobot.mData.mLashouList[userid];
    if (!allMembers) {
        return deString(@"[%@]不是拉手", name);
    }

    NSDictionary* allbetInfo = [self getLashouMemberBetDetail: userid queryDate: queryDate];
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", queryDate];
    [text appendString: [self addTitle: @"拉手详情"]];
    [text appendFormat: @"拉手名字: %@\n", name];
    [text appendFormat: @"成员人数: %d\n", (int)[allMembers count]];
    [text appendFormat: @"成员总局数: %@\n", allbetInfo[@"allRoundCount"]];
    if (tmanager.mRobot.mEnableNiuniu) {
        [text appendFormat: @"牛牛总下注: %@\n", allbetInfo[@"allBetCount"]];
        [text appendFormat: @"牛牛总梭哈: %@\n", allbetInfo[@"allBetCountSuoha"]];
    }
    if (tmanager.mRobot.mEnableLonghu) {
        [text appendFormat: @"大小总下注: %@\n", allbetInfo[@"allBetCountDaxiao"]];
    }
    if (tmanager.mRobot.mEnableTema) {
        [text appendFormat: @"特码总下注: %@\n", allbetInfo[@"allBetCountTema"]];
    }
    if (tmanager.mRobot.mEnableBaijiale) {
        [text appendFormat: @"百家乐总下注: %@\n", allbetInfo[@"allBetCountBaijiale"]];
    }
//    [text appendFormat: @"成员总水费: %@\n", allbetInfo[@"allRatioCount"]];
    [text appendFormat: @"成员总抢包: %@\n", allbetInfo[@"allRobCount"]];
    
    NSMutableDictionary* members = allbetInfo[@"members"];
    if ([members count] > 0) {
        [text appendString: [self addTitle: @"有玩成员"]];
        int index = 0;
        for (NSString* playerid in members) {
            if (index++ > 0) {
                [text appendString: @"──────────\n"];
            }
            NSDictionary* dic = members[playerid];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: playerid];
            if (!memData) {
                [text appendString: @"名字: 获取失败\n"];
            } else {
                [text appendFormat: @"编号: %@\n", memData[@"index"]];
                [text appendFormat: @"单名: %@\n", memData[@"billName"]];
            }
            [text appendFormat: @"微信: %@\n", playerid];
            [text appendFormat: @"局数: %@　抢包: %@\n", dic[@"roundCount"], dic[@"robCount"]];
            if (tmanager.mRobot.mEnableNiuniu) {
                [text appendFormat: @"牛牛下注: %@\n", dic[@"betCount"]];
                [text appendFormat: @"牛牛梭哈: %@\n", dic[@"betCountSuoha"]];
            }
            if (tmanager.mRobot.mEnableLonghu) {
                [text appendFormat: @"大小下注: %@\n", dic[@"betCountDaxiao"]];
            }
            if (tmanager.mRobot.mEnableTema) {
                [text appendFormat: @"特码下注: %@\n", dic[@"betCountTema"]];
            }
            if (tmanager.mRobot.mEnableBaijiale) {
                [text appendFormat: @"百家乐下注: %@\n", dic[@"betCountBaijiale"]];
            }
            
            
            //平均值
            int allBet = [dic[@"betCount"] intValue]*10 + [dic[@"betCountSuoha"] intValue] + [dic[@"betCountDaxiao"] intValue] + [dic[@"betCountTema"] intValue] + [dic[@"betCountBaijiale"] intValue];
            [text appendFormat: @"平均下注: %d\n", allBet/[dic[@"roundCount"] intValue]];
        }
    }
    
    if ([allMembers count] > [members count]) {
        [text appendString: [self addTitle: @"没玩成员"]];
        int index = 0;
        for (NSString* playerid in allMembers) {
            if (!members[playerid]) {
                if (index++ > 0) {
                    [text appendString: @"──────────\n"];
                }
                NSDictionary* memData = [tmanager.mRobot.mMembers getMember: playerid];
                if (!memData) {
                    [text appendString: @"名字: 获取失败\n"];
                } else {
                    [text appendFormat: @"名字: %@\n", memData[@"billName"]];
                }
                [text appendFormat: @"微信: %@\n", playerid];
            }
        }
    }
    return text;
}

//生成拉手排行榜
-(NSString*) newLashouTops:(NSString*)userid name:(NSString*)name{
    NSArray* array = [tmanager.mRobot.mLashous getAllLashouMemberDetail: userid sortType: @"score"];
    int scoreCount = 0;
    for (NSDictionary* dic in array) {
        if (dic[@"score"]) {
            scoreCount += [dic[@"score"] intValue];
        }
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"拉手[%@]\n", name];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"成员: %d 总分: %d\n", (int)[array count], scoreCount];
    [text appendString: @"──────────\n"];
    
    for (NSDictionary* dic in array) {
        NSString* indexNO = dic[@"index"];
        if (!indexNO) {
            indexNO = @"未知";
        }
        if (dic[@"score"]) {
            [text appendFormat: @"%@. %@　%@\n",  indexNO, deFillName(dic[@"billName"]), dic[@"score"]];
        } else if(dic[@"name"]) {
            [text appendFormat: @"%@. %@　无会员\n", indexNO, dic[@"name"]];
        } else {
            [text appendFormat: @"%@. %@　无好友\n", indexNO, dic[@"userid"]];
        }
    }
    return text;
}

//生成玩家下注信息
-(NSString*) newPlayerBetInfo:(NSDictionary*)memData queryDate:(NSString*)queryDate{
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", queryDate];
    [text appendString: [self addTitle: @"基本信息"]];
    [text appendFormat: @"玩家编号: %@\n", memData[@"index"]];
    [text appendFormat: @"玩家名字: %@\n", memData[@"name"]];
    [text appendFormat: @"账单名字: %@\n", memData[@"billName"]];
    [text appendString: [self addTitle: @"领包情况"]];
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: queryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        NSDictionary* player = nil;
        for (NSDictionary* v in dic[@"players"]) {
            if ([v[@"userid"] isEqualToString: memData[@"userid"]]) {
                player = v;
                break;
            }
        }
        if (player) {
            BOOL isniuniu = [player[@"betType"] isEqualToString:@"niuniu"];
            NSString* amountStr = @"";
            if ([player[@"resultHandle"] isEqualToString: @"normal"] || [player[@"resultHandle"] isEqualToString: @"asLast"]) {
                BOOL isAsLast = [player[@"resultHandle"] isEqualToString: @"asLast"];
                amountStr = deString(@"%.2f(%@)%@", [player[@"amount"] floatValue]/100, player[isniuniu ? @"powFact" : @"powType"], isAsLast ? @"[尾]" : @"");
            }
            else if ([player[@"resultHandle"] isEqualToString: @"overtime"]) {
                amountStr = @"超时";
            }
            else if ([player[@"resultHandle"] isEqualToString: @"noWin"]) {
                amountStr = @"无输赢";
            }
            
            int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
            BOOL suoha = player[@"suoha"] && [player[@"suoha"] isEqualToString: @"true"];
            BOOL mianyong = player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"];
            BOOL yibi = player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"];
            BOOL isFuliBanker = NO;
            if (dic[@"betVars"][@"mFuliSetting"] && dic[@"betVars"][@"mFuliSetting"][@"enable"] && [dic[@"betVars"][@"mFuliSetting"][@"enable"] isEqualToString: @"true"]) {
                isFuliBanker = YES;
            }
            NSString* betStr = isniuniu ? deString(@"%@%@", mianyong ? @"免" : yibi ? @"一比" : suoha ? @"梭" : @"下", player[@"num"]) : player[@"valuesStr"];
            if (isFuliBanker) {
                betStr = deString(@"%@(福)", betStr);
            }
            [text appendFormat: @"%@局: %@ %@ %@%d\n", dic[@"number"], betStr, amountStr, winOrLoseFact >= 0 ? @"+" : @"-", abs(winOrLoseFact)];
            
            if (player[@"coverRobUp"]) {
                [text appendFormat: @"%@局: 被抢包 +%@\n", dic[@"number"], player[@"coverRobUp"]];
            }
        }
        
        player = nil;
        for (NSDictionary* v in dic[@"robs"]) {
            if ([v[@"userid"] isEqualToString: memData[@"userid"]]) {
                player = v;
                break;
            }
        }
        if (player) {
            if (player[@"robDown"]) {
                [text appendFormat: @"%@局: 抢包 -%@\n", dic[@"number"], player[@"robDown"]];
            }
        }
    }
    return text;
}

//生成玩家输赢信息
-(NSString*) newPlayerResultInfo:(NSDictionary*)memData queryDate:(NSString*)queryDate{
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    
    int upScoreCount = 0;//
    int downScoreCount = 0;//
    int roundCount = 0;//
    int betCountNiuniu = 0;//
    int betCountMianyong = 0;//
    int betCountYibi = 0;//
    int betCountSuoha = 0;//
    int betCountDaxiao = 0;//
    int betCountTema = 0;
    int betCountBaijiale = 0;
    int ratioCount = 0;//
    int allWinOrLose = 0;//
    int robCount = 0;//
    int robScore = 0;//
    NSMutableArray* niuniuArr = [NSMutableArray array];
    NSMutableArray* jinniuArr = [NSMutableArray array];
    NSMutableArray* duiziArr = [NSMutableArray array];
    NSMutableArray* shunziArr = [NSMutableArray array];
    NSMutableArray* daoshunArr = [NSMutableArray array];
    NSMutableArray* manniuArr = [NSMutableArray array];
    NSMutableArray* baoziArr = [NSMutableArray array];
    NSMutableDictionary* niuniuDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* jinniuDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* duiziDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* shunziDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* daoshunDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* manniuDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* baoziDic = [NSMutableDictionary dictionary];
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: queryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        NSDictionary* player = nil;
        for (NSDictionary* v in dic[@"players"]) {
            if ([v[@"userid"] isEqualToString: memData[@"userid"]]) {
                player = v;
                break;
            }
        }
        if (player) {
            ++roundCount;
            if ([player[@"betType"] isEqualToString: @"niuniu"]) {
                if (player[@"suoha"] && [player[@"suoha"] isEqualToString: @"true"]) {
                    betCountSuoha += [player[@"num"] intValue];
                } else {
                    if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        betCountYibi += [player[@"num"] intValue];
                    }
                    else if (player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"]) {
                        betCountMianyong += [player[@"num"] intValue];
                    }
                    else {
                        betCountNiuniu += [player[@"num"] intValue];
                    }
                }
            } else if ([player[@"betType"] isEqualToString: @"tema"]) {
                betCountTema += [player[@"num"] intValue];
            } else if ([player[@"betType"] isEqualToString: @"baijiale"]) {
                betCountBaijiale += [player[@"num"] intValue];
            } else if ([player[@"betType"] isEqualToString: @"longhu"]) {
                betCountDaxiao += [player[@"num"] intValue];
            }
            
            int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
            if (player[@"playerRatio"]) {
                ratioCount += [player[@"playerRatio"] intValue];
            }
            allWinOrLose += winOrLoseFact;
            if (player[@"coverRobUp"]) {
                robScore += [player[@"coverRobUp"] intValue];
            }
            BOOL isBankerHead = NO;
            for (NSDictionary* banker in dic[@"bankers"]) {
                if ([banker[@"isMain"] isEqualToString: @"true"]) {
                    if ([banker[@"resultHandle"] isEqualToString: @"bankerHead"]) {
                        isBankerHead = YES;
                    }
                    break;
                }
            }
            BOOL bankerHeadNull = isBankerHead && [player[@"betType"] isEqualToString: @"niuniu"];
            BOOL isFuliBanker = NO;
            if (dic[@"betVars"][@"mFuliSetting"] && dic[@"betVars"][@"mFuliSetting"][@"enable"] && [dic[@"betVars"][@"mFuliSetting"][@"enable"] isEqualToString: @"true"]) {
                isFuliBanker = YES;
            }
            if ([player[@"resultHandle"] isEqualToString: @"normal"] && !bankerHeadNull && !isFuliBanker) {//正常情况下才算奖励
                NSString* amountStr = player[@"amount"];
                int amount = [player[@"amount"] intValue];
                int pow = [niuniu amount2pow: amount];
                if (10 == pow) {
                    [niuniuArr addObject: amountStr];
                    niuniuDic[amountStr] = @"true";
                } else if (11 == pow) {
                    [jinniuArr addObject: amountStr];
                    jinniuDic[amountStr] = @"true";
                } else if (12 == pow) {
                    [duiziArr addObject: amountStr];
                    duiziDic[amountStr] = @"true";
                } else if (13 == pow) {
                    [daoshunArr addObject: amountStr];
                    daoshunDic[amountStr] = @"true";
                } else if (14 == pow) {
                    [shunziArr addObject: amountStr];
                    shunziDic[amountStr] = @"true";
                } else if (15 == pow) {
                    [manniuArr addObject: amountStr];
                    manniuDic[amountStr] = @"true";
                } else if (18 == pow) {
                    [baoziArr addObject: amountStr];
                    baoziDic[amountStr] = @"true";
                }
            }
        }
        
        player = nil;
        for (NSDictionary* v in dic[@"robs"]) {
            if ([v[@"userid"] isEqualToString: memData[@"userid"]]) {
                player = v;
                break;
            }
        }
        if (player) {
            ++robCount;
            if (player[@"robDown"]) {
                robScore -= [player[@"robDown"] intValue];
            }
        }
    }
    
    finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: queryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        if (![dic[@"userid"] isEqualToString: memData[@"userid"]]) {
            continue;
        }
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        if (change > 0) {
            upScoreCount += abs(change);
        } else {
            downScoreCount += abs(change);
        }
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", queryDate];
    [text appendString: [self addTitle: @"基本信息"]];
    [text appendFormat: @"玩家编号: %@\n", memData[@"index"]];
    [text appendFormat: @"玩家名字: %@\n", memData[@"name"]];
    [text appendFormat: @"账单名字: %@\n", memData[@"billName"]];
    [text appendFormat: @"累计上分: %d\n", upScoreCount];
    [text appendFormat: @"累计下分: %d\n", downScoreCount];
    [text appendFormat: @"有玩局数: %d\n", roundCount];
    if (tmanager.mRobot.mEnableNiuniu) {
        [text appendFormat: @"牛牛下注: %d\n", betCountNiuniu];
        [text appendFormat: @"免佣下注: %d\n", betCountMianyong];
        [text appendFormat: @"一比下注: %d\n", betCountYibi];
        [text appendFormat: @"牛牛梭哈: %d\n", betCountSuoha];
    }
    if (tmanager.mRobot.mEnableLonghu) {
        [text appendFormat: @"大小下注: %d\n", betCountDaxiao];
    }
    if (tmanager.mRobot.mEnableTema) {
        [text appendFormat: @"特码下注: %d\n", betCountTema];
    }
    if (tmanager.mRobot.mEnableBaijiale) {
        [text appendFormat: @"百家乐下注: %d\n", betCountBaijiale];
    }
//    [text appendFormat: @"贡献水费: %d\n", ratioCount];
    [text appendFormat: @"抢包次数: %d\n", robCount];
    [text appendFormat: @"抢包盈亏: %d\n", robScore];
    [text appendFormat: @"实际输赢: %d\n", allWinOrLose+robScore];
    [text appendString: [self addTitle: @"集奖情况"]];
    if ([setting[@"showNiuniuCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"牛牛统计: %d\n", (int)[niuniuArr count]];
    }
    if ([setting[@"showJinniuCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"金牛统计: %d\n", (int)[jinniuArr count]];
    }
    if ([setting[@"showDuiziCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"对子统计: %d\n", (int)[duiziArr count]];
    }
    if ([setting[@"showShunziCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"顺子统计: %d\n", (int)[shunziArr count]];
    }
    if ([setting[@"showDaoshunCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"倒顺统计: %d\n", (int)[daoshunArr count]];
    }
    if ([setting[@"showManniuCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"满牛统计: %d\n", (int)[manniuArr count]];
    }
    if ([setting[@"showBaoziCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"豹子统计: %d\n", (int)[baoziArr count]];
    }
    
    
    if ([setting[@"showNiuniuCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"牛牛不重复: %d\n", (int)[niuniuDic count]];
    }
    if ([setting[@"showJinniuCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"金牛不重复: %d\n", (int)[jinniuDic count]];
    }
    if ([setting[@"showDuiziCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"对子不重复: %d\n", (int)[duiziDic count]];
    }
    if ([setting[@"showShunziCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"顺子不重复: %d\n", (int)[shunziDic count]];
    }
    if ([setting[@"showDaoshunCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"倒顺不重复: %d\n", (int)[daoshunDic count]];
    }
    if ([setting[@"showManniuCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"满牛不重复: %d\n", (int)[manniuDic count]];
    }
    if ([setting[@"showBaoziCount"] isEqualToString: @"true"]) {
        [text appendFormat: @"豹子不重复: %d\n", (int)[baoziDic count]];
    }
    return text;
}

//生成所有托
-(NSString*) queryAllTuoMembers {
    NSArray* array = [tmanager.mRobot.mTuos getAllTuoDetail: NO sortType:@"index"];
    
    NSMutableString* text = [NSMutableString string];
    [text appendString: @"托名单\n"];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"托人数: %d\n", (int)[array count]];
    [text appendString: @"──────────\n"];
    
    int i = 0;
    for (NSDictionary* dic in array) {
        if (dic[@"score"]) {
            [text appendFormat: @"%@. %@",  dic[@"index"], deFillName(dic[@"billName"])];
            
            ++i;
            if (i % 2 == 0) {
                [text appendString: @"\n"];
            } else {
                [text appendString: @" "];
            }
        }
    }
    return text;
}

//查托点包
-(NSString*) queryAllTuoAmount: (int)back start:(int)start end:(int)end {
    NSMutableDictionary* allTuoDetails = [NSMutableDictionary dictionary];
    
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDateFormatter *hourDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [hourDateformat setDateFormat:@"HH"];
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        NSDate* date = [objDateformat dateFromString:dic[@"date"]];
        NSString* strHour = [hourDateformat stringFromDate:date];
        int hour = [strHour intValue];
        
        if (hour < start || hour >= end) {//时间限制
            continue;
        }
        
        for (NSDictionary* v in dic[@"players"]) {
            NSString* userid = v[@"userid"];
            if ([tmanager.mRobot.mTuos isTuo: userid]) {
                NSMutableDictionary* data = allTuoDetails[userid];
                if (!data) {
                    data = [NSMutableDictionary dictionary];
                    data[@"userid"] = userid;
                    data[@"amount"] = @"0";
                    data[@"rob"] = @"0";
                    data[@"overtime"] = @"0";
                    data[@"round"] = @"0";
                    allTuoDetails[userid] = data;
                }
                data[@"round"] = deInt2String([data[@"round"] intValue]+1);
                if ([v[@"resultType"] isEqualToString: @"normal"] || [v[@"resultType"] isEqualToString: @"timeover"]) {
                    data[@"amount"] = deInt2String([data[@"amount"] intValue]+[v[@"amount"] intValue]);
                }
                if ([v[@"resultHandle"] isEqualToString: @"overtime"]) {
                    data[@"overtime"] = deInt2String([data[@"overtime"] intValue]+1);
                }
            }
        }

        for (NSDictionary* v in dic[@"robs"]) {
            NSString* userid = v[@"userid"];
            if ([tmanager.mRobot.mTuos isTuo: userid]) {
                NSMutableDictionary* data = allTuoDetails[userid];
                if (!data) {
                    data = [NSMutableDictionary dictionary];
                    data[@"userid"] = userid;
                    data[@"amount"] = @"0";
                    data[@"rob"] = @"0";
                    data[@"overtime"] = @"0";
                    data[@"round"] = @"0";
                    allTuoDetails[userid] = data;
                }
                data[@"rob"] = deInt2String([data[@"rob"] intValue]+1);
                data[@"amount"] = deInt2String([data[@"amount"] intValue]+[v[@"amount"] intValue]);
            }
        }

        if (tmanager.mRobot.mEnableNiuniu) {
            for (NSDictionary* banker in dic[@"bankers"]) {
                NSString* userid = banker[@"userid"];
                if ([banker[@"isMain"] isEqualToString: @"true"] && [tmanager.mRobot.mTuos isTuo: userid]) {
                    if (![banker[@"resultHandle"] isEqualToString: @"asLast"]) {
                        NSMutableDictionary* data = allTuoDetails[userid];
                        if (!data) {
                            data = [NSMutableDictionary dictionary];
                            data[@"userid"] = userid;
                            data[@"amount"] = @"0";
                            data[@"rob"] = @"0";
                            data[@"overtime"] = @"0";
                            data[@"round"] = @"0";
                            allTuoDetails[userid] = data;
                        }
                        data[@"amount"] = deInt2String([data[@"amount"] intValue]+[banker[@"amount"] intValue]);
                    }
                }
            }
        }
    }
    
    float tuoBack = back/100.0;
    
    NSMutableArray* lists = [NSMutableArray array];
    [lists addObjectsFromArray: [allTuoDetails allValues]];
    
    [lists sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"amount"] intValue] > [b[@"amount"] intValue] ? -1 : 1;
    }];
    
    float allMountCount = 0;
    for (NSDictionary* dic in lists) {
        allMountCount += [dic[@"amount"] floatValue]/100;
    }
    
    NSMutableString* text = [NSMutableString string];
    if (back > 0) {
        [text appendFormat: @"%@ 反: %d%%\n", tmanager.mRobot.mQueryDate, back];
    } else {
        [text appendFormat: @"%@\n", tmanager.mRobot.mQueryDate];
    }
    [text appendFormat: @"[%02d:00:00~%02d:00:00]\n", start, end];
    [text appendString: [self addTitle: @"托点包"]];
    [text appendFormat: @"总点包: %.2f\n", allMountCount];
    [text appendFormat: @"参与人数: %d\n", (int)[lists count]];
    [text appendString: @"──────────\n"];
    
    int index = 0;
    for (NSDictionary* dic in lists) {
        if (index++ > 0) {
            [text appendString: @"──────────\n"];
        }
        NSString* name = dic[@"userid"];
        NSString* index = @"未知";
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (memData) {
            name = memData[@"billName"];
            index = memData[@"index"];
        }
        
        float amount = [dic[@"amount"] floatValue]/100;
        if (back > 0) {
            [text appendFormat: @"%@　包%.2f 反%.2f\n", deFillName(name), amount, amount*tuoBack];
        } else {
            [text appendFormat: @"%@　点包: %.2f\n", deFillName(name), amount];
        }
        [text appendFormat: @"编号%@ 局%@ 抢%@ 超%@\n", index, dic[@"round"], dic[@"rob"], dic[@"overtime"]];
    }
    return text;
}

//托分清零
-(NSString*) clearAllTuoScore {
    NSArray* array = [tmanager.mRobot.mTuos getAllTuoDetail: NO sortType:@"score"];
    
    NSMutableString* text = [NSMutableString string];
    [text appendString: [self addTitle: @"托分清零"]];
    
    int roleCount = 0;
    int scoreCount = 0;
    
    for (NSDictionary* dic in array) {
        if (dic[@"score"] && [dic[@"score"] intValue] > 0) {
            int score = [dic[@"score"] intValue];
            roleCount++;
            scoreCount += score;
            [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:0 isSet:YES params:@{@"type":@"tuoBatch", @"donotAutoSave":@"true"}];
            [text appendFormat: @"%@. %@　下%d\n",  dic[@"index"], deFillName(dic[@"billName"]), score];
        }
    }
    
    [text appendString: @"──────────\n"];
    [text appendFormat: @"人数: %d\n", roleCount];
    [text appendFormat: @"共下分: %d", scoreCount];
    
    [tmanager.mRobot.mData saveMemberListFile];
    [tmanager.mRobot.mData saveScoreChangedRecordsFile];
    return text;
}

//生成上下分纪录
-(NSString*) newUpScoreRecords:(NSDictionary*)memData queryDate:(NSString*)queryDate{
    int upScoreCount = 0;
    int downScoreCount = 0;
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: queryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        if (![dic[@"userid"] isEqualToString: memData[@"userid"]]) {
            continue;
        }
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        if (change > 0) {
            upScoreCount += abs(change);
        } else {
            downScoreCount += abs(change);
        }
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", queryDate];
    [text appendString: [self addTitle: @"基本信息"]];
    [text appendFormat: @"玩家编号: %@\n", memData[@"index"]];
    [text appendFormat: @"玩家名字: %@\n", memData[@"name"]];
    [text appendFormat: @"账单名字: %@\n", memData[@"billName"]];
    [text appendFormat: @"累计上分: %d\n", upScoreCount];
    [text appendFormat: @"累计下分: %d\n", downScoreCount];
    [text appendString: @"──────────\n"];
    
    finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: queryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        if (![dic[@"userid"] isEqualToString: memData[@"userid"]]) {
            continue;
        }
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        NSString* fromName = dic[@"fromName"];
        if (!fromName) {
            fromName = @"无";
        }
        NSString* type = @"";
        if ([dic[@"type"] isEqualToString: @"command"]) {
            type = @"命令";
        } else if ([dic[@"type"] isEqualToString: @"manual"]) {
            type = @"机器人";
        } else if ([dic[@"type"] isEqualToString: @"tuoBatch"]) {
            type = @"托批量";
        } else if ([dic[@"type"] isEqualToString: @"tuoSelf"]) {
            type = @"托自助";
        } else if ([dic[@"type"] isEqualToString: @"bonus"]) {
            type = @"活动奖";
        } else if ([dic[@"type"] isEqualToString: @"playerBack"]) {
            type = @"反水奖";
        } else if ([dic[@"type"] isEqualToString: @"loseBonus"]) {
            type = @"输分奖";
        } else if ([dic[@"type"] isEqualToString: @"seriesWinBonus"]) {
            type = @"连赢奖";
        } else if ([dic[@"type"] isEqualToString: @"lastRoundBonus"]) {
            type = @"上局奖";
        } else if ([dic[@"type"] isEqualToString: @"roundBonus"]) {
            type = @"局数奖";
        } else if ([dic[@"type"] isEqualToString: @"collectBonus"]) {
            type = @"集齐奖";
        }
        [text appendFormat: @"%@局: %@%d[%@] %@[%@]\n", dic[@"round"], change >=0 ? @"+" : @"", change, fromName, type, dic[@"date"]];
        [text appendString: @"──────────\n"];
    }
    return text;
}

//生成龙虎概率
-(NSString*) newLonghuChance {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    int overtime = [setting[@"overtime"] intValue];
    NSMutableDictionary* allRecords = [NSMutableDictionary dictionary];
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        long long minSecond = [dic[@"resultVars"][@"mMinSecond"] longLongValue];
        for (NSDictionary* v in dic[@"players"]) {
            if ([v[@"resultType"] isEqualToString: @"normal"] || [v[@"resultType"] isEqualToString: @"timeover"]) {
                if (v[@"receiveTime"]) {
                    long long second = [v[@"receiveTime"] longLongValue]-minSecond;
                    if (second >= 0 && second <= overtime) {
                        NSString* key = deInt2String((int)second);
                        if (!allRecords[key]) {
                            allRecords[key] = [NSMutableArray array];
                        }
                        int amount = [v[@"amount"] intValue];
                        int pow = [niuniu amount2pow: amount];
                        NSString* card = [longhu pow2card: pow];
                        [allRecords[key] addObject: card];
                    }
                }
            }
        }
    }
    NSMutableString* text = [NSMutableString string];
    int allCount = 0;
    int daCount = 0;
    int xiaoCount = 0;
    int danCount = 0;
    int shuangCount = 0;
    int heCount = 0;
    for (NSString* second in allRecords) {
        NSArray* cards = allRecords[second];
        int one_allCount = 0;
        int one_daCount = 0;
        int one_xiaoCount = 0;
        int one_danCount = 0;
        int one_shuangCount = 0;
        int one_heCount = 0;
        for (NSString* card in cards) {
            allCount++;
            one_allCount++;
            if ([card containsString: @"大"]) {
                daCount++;
                one_daCount++;
            }
            if ([card containsString: @"小"]) {
                xiaoCount++;
                one_xiaoCount++;
            }
            if ([card containsString: @"单"]) {
                danCount++;
                one_danCount++;
            }
            if ([card containsString: @"双"]) {
                shuangCount++;
                one_shuangCount++;
            }
            if ([card containsString: @"合"]) {
                heCount++;
                one_heCount++;
            }
        }
        [text appendFormat: @"─────第%@秒────\n", second];
        [text appendFormat: @"总采集红包: %d\n", one_allCount];
        [text appendFormat: @"大概率: %.2f\n", one_daCount/1.0/one_allCount];
        [text appendFormat: @"小概率: %.2f\n", one_xiaoCount/1.0/one_allCount];
        [text appendFormat: @"单概率: %.2f\n", one_danCount/1.0/one_allCount];
        [text appendFormat: @"双概率: %.2f\n", one_shuangCount/1.0/one_allCount];
        [text appendFormat: @"合概率: %.2f\n", one_heCount/1.0/one_allCount];
    }
    [text appendString: @"─────所有────\n"];
    [text appendFormat: @"总采集红包: %d\n", allCount];
    [text appendFormat: @"大概率: %.2f\n", daCount/1.0/allCount];
    [text appendFormat: @"小概率: %.2f\n", xiaoCount/1.0/allCount];
    [text appendFormat: @"单概率: %.2f\n", danCount/1.0/allCount];
    [text appendFormat: @"双概率: %.2f\n", shuangCount/1.0/allCount];
    [text appendFormat: @"合概率: %.2f\n", heCount/1.0/allCount];
    return text;
}

//查输赢排行榜
-(NSString*) newWinOrLoseTop: (BOOL)showTuo onlyPlayer:(BOOL)onlyPlayer {
    NSMutableDictionary* allPlayerWinOrLose = [NSMutableDictionary dictionary];
    int tuoBankerCount = 0;
    int tuoRobUpCount = 0;
    int tuoRobDownCount = 0;
    int tuoNiuniuCount = 0;
    int tuoNiuniuMianyongCount = 0;
    int tuoNiuniuYibiCount = 0;
    int tuoDaxiaoCount = 0;
    int tuoTemaCount = 0;
    int tuoBaijialeCount = 0;
    
    int playerBankerCount = 0;
    int playerRobUpCount = 0;
    int playerRobDownCount = 0;
    int playerNiuniuCount = 0;
    int playerNiuniuMianyongCount = 0;
    int playerNiuniuYibiCount = 0;
    int playerDaxiaoCount = 0;
    int playerTemaCount = 0;
    int playerBaijialeCount = 0;
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        for (NSDictionary* player in dic[@"bankers"]) {
            NSMutableDictionary* values = allPlayerWinOrLose[player[@"userid"]];
            if (!values) {
                values = [NSMutableDictionary dictionary];
                values[@"userid"] = player[@"userid"];
                values[@"allWinOrLose"] = @"0";
                values[@"robScore"] = @"0";
                allPlayerWinOrLose[player[@"userid"]] = values;
            }
            
            BOOL isTuo = [tmanager.mRobot.mTuos isTuo: player[@"userid"]];
            
            int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
            values[@"allWinOrLose"] = deInt2String([values[@"allWinOrLose"] intValue] + winOrLoseFact);
            if (isTuo) {
                tuoBankerCount += winOrLoseFact;
            } else {
                playerBankerCount += winOrLoseFact;
            }
            
            if (player[@"coverRobUp"]) {
                int coverRobUp = [player[@"coverRobUp"] intValue];
                values[@"robScore"] = deInt2String([values[@"robScore"] intValue] + coverRobUp);
                if (isTuo) {
                    tuoRobUpCount += coverRobUp;
                } else {
                    playerRobUpCount += coverRobUp;
                }
            }
        }
        
        for (NSDictionary* player in dic[@"players"]) {
            NSMutableDictionary* values = allPlayerWinOrLose[player[@"userid"]];
            if (!values) {
                values = [NSMutableDictionary dictionary];
                values[@"userid"] = player[@"userid"];
                values[@"allWinOrLose"] = @"0";
                values[@"robScore"] = @"0";
                allPlayerWinOrLose[player[@"userid"]] = values;
            }
            
            BOOL isTuo = [tmanager.mRobot.mTuos isTuo: player[@"userid"]];

            int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
            values[@"allWinOrLose"] = deInt2String([values[@"allWinOrLose"] intValue] + winOrLoseFact);
            
            if ([player[@"betType"] isEqualToString: @"niuniu"]) {
                if (isTuo) {
                    if (player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"]) {
                        tuoNiuniuMianyongCount += winOrLoseFact;
                    } else if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        tuoNiuniuYibiCount += winOrLoseFact;
                    } else {
                        tuoNiuniuCount += winOrLoseFact;
                    }
                } else {
                    if (player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"]) {
                        playerNiuniuMianyongCount += winOrLoseFact;
                    } else if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        playerNiuniuYibiCount += winOrLoseFact;
                    } else {
                        playerNiuniuCount += winOrLoseFact;
                    }
                }
            } else if ([player[@"betType"] isEqualToString: @"tema"]) {
                if (isTuo) {
                    tuoTemaCount += winOrLoseFact;
                } else {
                    playerTemaCount += winOrLoseFact;
                }
            } else if ([player[@"betType"] isEqualToString: @"baijiale"]) {
                if (isTuo) {
                    tuoBaijialeCount += winOrLoseFact;
                } else {
                    playerBaijialeCount += winOrLoseFact;
                }
            } else if ([player[@"betType"] isEqualToString: @"longhu"]) {
                if (isTuo) {
                    tuoDaxiaoCount += winOrLoseFact;
                } else {
                    playerDaxiaoCount += winOrLoseFact;
                }
            }
            
            if (player[@"coverRobUp"]) {
                int coverRobUp = [player[@"coverRobUp"] intValue];
                values[@"robScore"] = deInt2String([values[@"robScore"] intValue] + coverRobUp);
                if (isTuo) {
                    tuoRobUpCount += coverRobUp;
                } else {
                    playerRobUpCount += coverRobUp;
                }
            }
        }
        
        for (NSDictionary* player in dic[@"robs"]) {
            NSMutableDictionary* values = allPlayerWinOrLose[player[@"userid"]];
            if (!values) {
                values = [NSMutableDictionary dictionary];
                values[@"userid"] = player[@"userid"];
                values[@"allWinOrLose"] = @"0";
                values[@"robScore"] = @"0";
                allPlayerWinOrLose[player[@"userid"]] = values;
            }
            
            if (player[@"robDown"]) {
                BOOL isTuo = [tmanager.mRobot.mTuos isTuo: player[@"userid"]];
                int robDown = [player[@"robDown"] intValue];
                values[@"robScore"] = deInt2String([values[@"robScore"] intValue] - robDown);
                if (isTuo) {
                    tuoRobDownCount += robDown;
                } else {
                    playerRobDownCount += robDown;
                }
            }
        }
    }
    
    NSMutableArray* array = [NSMutableArray array];
    [array addObjectsFromArray: [allPlayerWinOrLose allValues]];

    [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        return [a[@"allWinOrLose"] intValue] + [a[@"robScore"] intValue] > [b[@"allWinOrLose"] intValue] + [b[@"robScore"] intValue] ? -1 : 1;
    }];
    
    int playerCount = 0;
    int playerWinOrLose = 0;
    int tuoWinOrLose = 0;
    for (NSDictionary* dic in array) {
        int winOrLose = [dic[@"allWinOrLose"] intValue] + [dic[@"robScore"] intValue];
        if ([tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
            tuoWinOrLose += winOrLose;
        } else {
            playerWinOrLose += winOrLose;
            ++playerCount;
        }
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", tmanager.mRobot.mQueryDate];
    [text appendString: [self addTitle: @"输赢榜"]];
    
    if (onlyPlayer) {
        [text appendFormat: @"总人数: %d\n", playerCount];
        [text appendFormat: @"总输赢: %d\n", playerWinOrLose];
        [text appendFormat: @"开庄输赢: %d\n", playerBankerCount];
        [text appendFormat: @"牛牛输赢: %d\n", playerNiuniuCount];
        [text appendFormat: @"免佣输赢: %d\n", playerNiuniuMianyongCount];
        [text appendFormat: @"一比输赢: %d\n", playerNiuniuYibiCount];
        [text appendFormat: @"大小输赢: %d\n", playerDaxiaoCount];
        [text appendFormat: @"特码输赢: %d\n", playerTemaCount];
        [text appendFormat: @"百家乐输赢: %d\n", playerBaijialeCount];
        [text appendFormat: @"抢包总扣分: %d\n", playerRobDownCount];
        [text appendFormat: @"抢包总补分: %d\n", playerRobUpCount];
    } else {
        if (showTuo) {
            [text appendFormat: @"总人数: %d\n", playerCount];
            [text appendFormat: @"总输赢: %d\n", playerWinOrLose];
            [text appendFormat: @"开庄输赢: %d\n", playerBankerCount];
            [text appendFormat: @"牛牛输赢: %d\n", playerNiuniuCount];
            [text appendFormat: @"免佣输赢: %d\n", playerNiuniuMianyongCount];
            [text appendFormat: @"一比输赢: %d\n", playerNiuniuYibiCount];
            [text appendFormat: @"大小输赢: %d\n", playerDaxiaoCount];
            [text appendFormat: @"特码输赢: %d\n", playerTemaCount];
            [text appendFormat: @"百家乐输赢: %d\n", playerBaijialeCount];
            [text appendFormat: @"抢包总扣分: %d\n", playerRobDownCount];
            [text appendFormat: @"抢包总补分: %d\n", playerRobUpCount];
            [text appendFormat: @"总人数(托): %d\n", (int)[array count]-playerCount];
            [text appendFormat: @"总输赢(托): %d\n", tuoWinOrLose];
            [text appendFormat: @"开庄输赢(托): %d\n", tuoBankerCount];
            [text appendFormat: @"牛牛输赢(托): %d\n", tuoNiuniuCount];
            [text appendFormat: @"免佣输赢(托): %d\n", tuoNiuniuMianyongCount];
            [text appendFormat: @"一比输赢(托): %d\n", tuoNiuniuYibiCount];
            [text appendFormat: @"大小输赢(托): %d\n", tuoDaxiaoCount];
            [text appendFormat: @"特码输赢(托): %d\n", tuoTemaCount];
            [text appendFormat: @"百家乐输赢(托): %d\n", tuoBaijialeCount];
            [text appendFormat: @"抢包总扣分(托): %d\n", tuoRobDownCount];
            [text appendFormat: @"抢包总补分(托): %d\n", tuoRobUpCount];
        } else {
            [text appendFormat: @"总人数: %d\n", (int)[array count]];
            [text appendFormat: @"总输赢: %d\n", tuoWinOrLose+playerWinOrLose];
            [text appendFormat: @"开庄输赢: %d\n", playerBankerCount+tuoBankerCount];
            [text appendFormat: @"牛牛输赢: %d\n", playerNiuniuCount+tuoNiuniuCount];
            [text appendFormat: @"免佣输赢: %d\n", playerNiuniuMianyongCount+tuoNiuniuMianyongCount];
            [text appendFormat: @"一比输赢: %d\n", playerNiuniuYibiCount+tuoNiuniuYibiCount];
            [text appendFormat: @"大小输赢: %d\n", playerDaxiaoCount+tuoDaxiaoCount];
            [text appendFormat: @"特码输赢: %d\n", playerTemaCount+tuoTemaCount];
            [text appendFormat: @"百家乐输赢: %d\n", playerBaijialeCount+tuoBaijialeCount];
            [text appendFormat: @"抢包总扣分: %d\n", playerRobDownCount+tuoRobDownCount];
            [text appendFormat: @"抢包总补分: %d\n", playerRobUpCount+tuoRobUpCount];
        }
    }
    
    [text appendString: @"──────────\n"];
    
    for (NSDictionary* dic in array) {
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"userid"]];
        if (!memData) {
            continue;
        }
        if (onlyPlayer) {
            if (![tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                int winOrLose = [dic[@"allWinOrLose"] intValue] + [dic[@"robScore"] intValue];
                [text appendFormat: @"%@. %@　%d\n",  memData[@"index"], deFillName(memData[@"billName"]), winOrLose];
            }
        } else {
            NSString* tuoStr = @"";
            if (showTuo && [tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
                tuoStr = @"(托)";
            }
            int winOrLose = [dic[@"allWinOrLose"] intValue] + [dic[@"robScore"] intValue];
            [text appendFormat: @"%@. %@　%d%@\n",  memData[@"index"], deFillName(memData[@"billName"]), winOrLose, tuoStr];
        }
    }
    return text;
}

//获取查询日期
-(NSString*) getQueryDate {
    return deString(@"查询日期: %@", tmanager.mRobot.mQueryDate);
}

//设置查询日期
-(NSString*) setQueryDate:(int)date {
    NSString* dateStr = deInt2String(date);
    if (dateStr.length != 8) {
        return @"[设日期]\n格式错误\n正确示范: 设日期20170601";
    }
    int year = date/10000;
    int mon = date/100%100;
    int day = date%100;
    tmanager.mRobot.mQueryDate = deString(@"%04d-%02d-%02d", year, mon, day);
    return deString(@"[设日期]\n查询日期已经调整到: %@", tmanager.mRobot.mQueryDate);
}

//获取查询日期
-(NSString*) getQueryDateForLashou {
    return deString(@"查询日期: %@", tmanager.mRobot.mQueryDateForLashou);
}

//设置查询日期
-(NSString*) setQueryDateForLashou:(int)date {
    NSString* dateStr = deInt2String(date);
    if (dateStr.length != 8) {
        return @"[设拉手日期]\n格式错误\n正确示范: 设拉手日期20170601";
    }
    int year = date/10000;
    int mon = date/100%100;
    int day = date%100;
    tmanager.mRobot.mQueryDateForLashou = deString(@"%04d-%02d-%02d", year, mon, day);
    return deString(@"[设拉手日期]\n查询日期已经调整到: %@", tmanager.mRobot.mQueryDateForLashou);
}

//托自助上下分
-(NSString*) tuoSelfChangeScore:(NSString*)userid name:(NSString*)name value:(int)value {
    NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
    if (!memData) {
        NSString* errMsg = [tmanager.mRobot.mMembers addMember:userid billName: [niuniuRobotMembers formatName: name]];
        if (errMsg) {
            return deString(@"@%@\n会员添加失败(%@)", name, errMsg);
        }
        memData = [tmanager.mRobot.mMembers getMember: userid];
    }
    
    if (!memData) {
        return deString(@"@%@\n不是会员", name);
    }
    
    int oldScore = [memData[@"score"] intValue];
    int tuoAddScoreStart = [tmanager.mRobot.mData.mBaseSetting[@"tuoAddScoreStart"] intValue];
    int tuoAddScoreMin = [tmanager.mRobot.mData.mBaseSetting[@"tuoAddScoreMin"] intValue];
    int tuoAddScoreMax = [tmanager.mRobot.mData.mBaseSetting[@"tuoAddScoreMax"] intValue];
    
    if (value > 0) {//上分
        if (oldScore >= tuoAddScoreStart) {
            return deString(@"@%@\n分数低于%d才能上分, 你当前分数:%d", name, tuoAddScoreStart, oldScore);
        }
        if (value < tuoAddScoreMin || value > tuoAddScoreMax) {
            return deString(@"@%@\n单次上分限制%d~%d", name, tuoAddScoreMin, tuoAddScoreMax);
        }
    } else {
        if (oldScore+value < 0) {
            return deString(@"❌❌❌❌❌❌❌❌❌❌\n⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n@%@\n积分不足, 下分失败!\n⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n❌❌❌❌❌❌❌❌❌❌", name);
        }
    }
    
    if ([tmanager.mRobot.mMembers addScore: userid score: value isSet: NO params: @{
                                                                              @"type":@"tuoSelf",
                                                                              @"fromUserid":userid,
                                                                              @"fromName":name}]) {
        [tmanager.mRobot.mData saveMemberListFile];
        return [self newScoreChangedMsg: oldScore memData: memData from: nil chatroom: nil];
    }
    return deString(@"@%@\n上分或下分失败!", name);
}

//批量添加托
-(NSString*) batchAddTuo:(NSString*)fromUsr {
    NSMutableArray* successPlayers = [NSMutableArray array];
    NSMutableArray* failPlayers = [NSMutableArray array];
    id CContactClass = NSClassFromString(@"CContact");
    NSArray* array = [CContactClass getChatRoomMemberWithoutMyself: fromUsr];
    for (id CContact in array) {
        NSString* userid = [ycFunction getVar:CContact name:@"m_nsUsrName"];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        if (!memData) {
            NSString* name = [ycFunction getVar:CContact name: @"m_nsNickName"];
            NSString* errMsg = [tmanager.mRobot.mMembers addMember:userid billName:[niuniuRobotMembers formatName: name]];
            if (errMsg) {
                [failPlayers addObject: @{
                                          @"name" : name,
                                          @"msg" : errMsg
                                          }];
                continue;
            }
            memData = [tmanager.mRobot.mMembers getMember: userid];
        }
        if ([tmanager.mRobot.mTuos isTuo: userid]) {
            [failPlayers addObject: @{
                                      @"index" : memData[@"index"],
                                      @"billName" : memData[@"billName"],
                                      @"msg" : @"已经是托"
                                      }];
            continue;
        }
        if ([tmanager.mRobot.mAdmins isAdmin: userid]) {
            [failPlayers addObject: @{
                                      @"index" : memData[@"index"],
                                      @"billName" : memData[@"billName"],
                                      @"msg" : @"管理身份"
                                      }];
            continue;
        }
        if ([tmanager.mRobot.mLashous isLashou: userid]) {
            [failPlayers addObject: @{
                                      @"index" : memData[@"index"],
                                      @"billName" : memData[@"billName"],
                                      @"msg" : @"拉手身份"
                                      }];
            continue;
        }
        NSDictionary* dic = [tmanager.mRobot.mLashous getLashouWithPlayer: userid];
        if (dic) {
            [failPlayers addObject: @{
                                      @"index" : memData[@"index"],
                                      @"billName" : memData[@"billName"],
                                      @"msg" : @"拉手成员身份"
                                      }];
            continue;
        }
        [tmanager.mRobot.mTuos addTuoQuick: userid];
        [successPlayers addObject: @{
                                     @"index" : memData[@"index"],
                                     @"billName" : memData[@"billName"]
        }];
    }
    [tmanager.mRobot.mData saveTuoListFile];
    
    
    NSMutableString* text = [NSMutableString string];
    if ([successPlayers count] > 0) {
        [text appendString: [self addTitle: @"添加托"]];
        for (NSDictionary* dic in successPlayers) {
            [text appendFormat: @"%@. %@　添加成功\n", dic[@"index"], deFillName(dic[@"billName"])];
        }
    }
    if ([failPlayers count] > 0) {
        [text appendString: [self addTitle: @"添加失败"]];
        for (NSDictionary* dic in failPlayers) {
            if (dic[@"billName"]) {
                [text appendFormat: @"%@. %@　%@\n", dic[@"index"], deFillName(dic[@"billName"]), dic[@"msg"]];
            } else {
                [text appendFormat: @"%@　%@\n", dic[@"name"], dic[@"msg"]];
            }
        }
    }
    return text;
}

//搜索
-(NSString*) searchPlayer: (NSString*)keyworld sayerUserid:(NSString*)sayerUserid sayerName:(NSString*)sayerName isAdmin: (BOOL)isAdmin {
    NSArray* array = [tmanager.mRobot.mMembers searchMember: keyworld];
    if ([array count] == 0) {
        return deString(@"@%@\n未搜索到有关[%@]的名片", sayerName, keyworld);
    }
    
    BOOL sayerIsLashou = [tmanager.mRobot.mLashous isLashou: sayerUserid];
    BOOL sayerIsLashouHead = [tmanager.mRobot.mLashouHeads isLashouHead: sayerUserid];
    BOOL showFrom = isAdmin ||
    (sayerIsLashou && [tmanager.mRobot.mData.mBaseSetting[@"allowLashouShowFrom"] isEqualToString: @"true"]) ||
    (sayerIsLashouHead && [tmanager.mRobot.mData.mBaseSetting[@"allowLashouHeadShowFrom"] isEqualToString: @"true"]);
    
    if([array count] > 1) {
        NSMutableString* text = [NSMutableString string];
        [text appendFormat: @"@%@\n\n", sayerName];
        [text appendFormat: @"搜[%@]多项结果\n", keyworld];
        for (NSDictionary* memData in array) {
            [text appendString: @"──────────\n"];
            if (isAdmin) {
                [text appendFormat: @"编号: %@\n", memData[@"index"]];
                [text appendFormat: @"身份: %@\n", [tmanager.mRobot getIdentityStr: memData[@"userid"]]];
            } else {
                [text appendFormat: @"编号: %@\n", memData[@"index"]];
            }
            if (showFrom) {
                NSDictionary* lashou = [tmanager.mRobot.mLashous getLashouWithPlayer: memData[@"userid"]];
                if (lashou) {
                    if (lashou[@"billName"]) {
                        [text appendFormat: @"归属拉手: %@#%@\n", lashou[@"index"], lashou[@"billName"]];
                    } else {
                        [text appendFormat: @"归属拉手: %@\n", lashou[@"userid"]];
                    }
                }
                
                if ([tmanager.mRobot.mLashous isLashou: memData[@"userid"]]) {
                    NSDictionary* lashouHead = [tmanager.mRobot.mLashouHeads getLashouHeadWithLashou: memData[@"userid"]];
                    if (lashouHead) {
                        if (lashouHead[@"billName"]) {
                            [text appendFormat: @"归属团长: %@#%@\n", lashouHead[@"index"], lashouHead[@"billName"]];
                        } else {
                            [text appendFormat: @"归属团长: %@\n", lashouHead[@"userid"]];
                        }
                    }
                }
            }
            [text appendFormat: @"昵称: %@\n", memData[@"name"]];
            [text appendFormat: @"单名: %@\n", memData[@"billName"]];
            [text appendFormat: @"总分: %@\n", memData[@"score"]];
        }

        return text;
    }
    
    NSDictionary* memData = array[0];
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"@%@\n", sayerName];
    if (isAdmin) {
        [text appendFormat: @"编号: %@\n", memData[@"index"]];
        [text appendFormat: @"身份: %@\n", [tmanager.mRobot getIdentityStr: memData[@"userid"]]];
    } else {
        [text appendFormat: @"编号: %@\n", memData[@"index"]];
    }
    if (showFrom) {
        NSDictionary* lashou = [tmanager.mRobot.mLashous getLashouWithPlayer: memData[@"userid"]];
        if (lashou) {
            if (lashou[@"billName"]) {
                [text appendFormat: @"归属拉手: %@#%@\n", lashou[@"index"], lashou[@"billName"]];
            } else {
                [text appendFormat: @"归属拉手: %@\n", lashou[@"userid"]];
            }
        }
        
        if ([tmanager.mRobot.mLashous isLashou: memData[@"userid"]]) {
            NSDictionary* lashouHead = [tmanager.mRobot.mLashouHeads getLashouHeadWithLashou: memData[@"userid"]];
            if (lashouHead) {
                if (lashouHead[@"billName"]) {
                    [text appendFormat: @"归属团长: %@#%@\n", lashouHead[@"index"], lashouHead[@"billName"]];
                } else {
                    [text appendFormat: @"归属团长: %@\n", lashouHead[@"userid"]];
                }
            }
        }
    }
    [text appendFormat: @"昵称: %@\n", memData[@"name"]];
    [text appendFormat: @"单名: %@\n", memData[@"billName"]];
    [text appendFormat: @"总分: %@\n", memData[@"score"]];
    mWaitCards[sayerUserid] = @{
                                    @"encodeUserid" : memData[@"userid"],
                                    @"time" : [ycFunction getCurrentTimestamp],
                                    @"by" : @"search"
                                    };
    return text;
}

//查指定局数信息
-(NSString*) lookRound: (int)number {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    
    NSDictionary* findDic = nil;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if ([dic[@"number"] intValue] == number) {
            findDic = dic;
            break;
        }
    }
    if (!findDic) {
        return deString(@"未找到第[%d]局的数据。", number);
    }

    //牛牛
    int upBankerFee = 0;//上庄抽水
    int hongbaoFee = 0;//红包费抽水
    int bonusPoolFee = 0;//奖池费
    int heiFee = 0;//暗扣统计
    float allHongbaoAmount = 0;//红包支出
    int heshuiSubsidyCount = 0;//喝水补贴
    
    int tuoBetCount = 0;
    int tuoBetCountSuoha = 0;
    int tuoBetCountDaxiao = 0;
    int tuoBetCountTema = 0;
    int tuoBetCountBaijiale = 0;
    int tuoRatioTotal = 0;
    int tuoRobUp = 0;
    int tuoRobDown = 0;
    int tuoWinOrLose = 0;
    int tuoBankerRatioCount = 0;
    int tuoEveryPlayerHongbaoFeeCount = 0;
    int tuoBankerWinCount = 0;
    int tuoNiuniuWinCount = 0;
    int tuoNiuniuMianyongWinCount = 0;
    int tuoNiuniuYibiWinCount = 0;
    int tuoDaxiaoWinCount = 0;
    int tuoTemaWinCount = 0;
    int tuoBaijialeWinCount = 0;
    
    int playerBetCount = 0;
    int playerBetCountSuoha = 0;
    int playerBetCountDaxiao = 0;
    int playerBetCountTema = 0;
    int playerBetCountBaijiale = 0;
    int playerRatioTotal = 0;
    int playerEveryPlayerHongbaoFeeCount = 0;
    int playerRobUp = 0;
    int playerRobDown = 0;
    int playerWinOrLose = 0;
    int playerBankerRatioCount = 0;
    int playerBankerWinCount = 0;
    int playerNiuniuWinCount = 0;
    int playerNiuniuMianyongWinCount = 0;
    int playerNiuniuYibiWinCount = 0;
    int playerDaxiaoWinCount = 0;
    int playerTemaWinCount = 0;
    int playerBaijialeWinCount = 0;
    
    int tuoCount = 0;
    int playerCount = 0;
    
    NSDictionary* dic = findDic;
    {
        BOOL bankerIsTuo = YES;
        for (NSDictionary* player in dic[@"bankers"]) {
            if ([player[@"isMain"] isEqualToString: @"true"]) {
                int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
                int robUp = 0;
                if (player[@"coverRobUp"]) {
                    robUp = [player[@"coverRobUp"] intValue];
                }
                BOOL isTuo = [tmanager.mRobot.mTuos isTuo: player[@"userid"]];
                if (isTuo) {
                    tuoRobUp += robUp;
                    tuoWinOrLose += winOrLoseFact;
                    tuoBankerWinCount += winOrLoseFact;
                    tuoCount++;
                } else {
                    playerRobUp += robUp;
                    playerWinOrLose += winOrLoseFact;
                    playerBankerWinCount += winOrLoseFact;
                    playerCount++;
                }
                bankerIsTuo = isTuo;
                break;
            }
        }
        
        for (NSDictionary* player in dic[@"players"]) {
            int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
            int robUp = 0;
            int betNiuniu = 0;
            int betNiuniuSuoha = 0;
            int betDaxiao = 0;
            int betTema = 0;
            int betBaijiale = 0;
            int ratio = 0;
            int everyPlayerHongbaoFee = 0;
            
            if (player[@"coverRobUp"]) {
                robUp = [player[@"coverRobUp"] intValue];
            }
            
            BOOL isTuo = [tmanager.mRobot.mTuos isTuo: player[@"userid"]];
            if ([player[@"betType"] isEqualToString: @"niuniu"]) {
                if (player[@"suoha"] && [player[@"suoha"] isEqualToString: @"true"]) {
                    betNiuniuSuoha = [player[@"num"] intValue];
                } else {
                    int num = [player[@"num"] intValue];
                    if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        num *= [setting[@"niuniuYibiBetTotalRatio"] floatValue];
                    }
                    betNiuniu = num;
                }
                if (isTuo) {
                    if (player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"]) {
                        tuoNiuniuMianyongWinCount += winOrLoseFact;
                    } else if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        tuoNiuniuYibiWinCount += winOrLoseFact;
                    } else {
                        tuoNiuniuWinCount += winOrLoseFact;
                    }
                } else {
                    if (player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"]) {
                        playerNiuniuMianyongWinCount += winOrLoseFact;
                    } else if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                        playerNiuniuYibiWinCount += winOrLoseFact;
                    } else {
                        playerNiuniuWinCount += winOrLoseFact;
                    }
                }
            } else if ([player[@"betType"] isEqualToString: @"tema"]) {
                betTema = [player[@"num"] intValue];
                if (isTuo) {
                    tuoTemaWinCount += winOrLoseFact;
                } else {
                    playerTemaWinCount += winOrLoseFact;
                }
            } else if ([player[@"betType"] isEqualToString: @"baijiale"]) {
                betBaijiale = [player[@"num"] intValue];
                if (isTuo) {
                    tuoBaijialeWinCount += winOrLoseFact;
                } else {
                    playerBaijialeWinCount += winOrLoseFact;
                }
            } else if ([player[@"betType"] isEqualToString: @"longhu"]){
                betDaxiao = [player[@"num"] intValue];
                if (isTuo) {
                    tuoDaxiaoWinCount += winOrLoseFact;
                } else {
                    playerDaxiaoWinCount += winOrLoseFact;
                }
            }
            
            if (player[@"playerRatio"]) {
                ratio = [player[@"playerRatio"] intValue];
            }
            
            if (player[@"everyPlayerHongbaoFee"]) {
                everyPlayerHongbaoFee = [player[@"everyPlayerHongbaoFee"] intValue];
            }
            
            if (isTuo) {
                tuoBetCount += betNiuniu;
                tuoBetCountSuoha += betNiuniuSuoha;
                tuoBetCountDaxiao += betDaxiao;
                tuoBetCountTema += betTema;
                tuoBetCountBaijiale += betBaijiale;
                tuoRatioTotal += ratio;
                tuoRobUp += robUp;
                tuoWinOrLose += winOrLoseFact;
                tuoEveryPlayerHongbaoFeeCount += everyPlayerHongbaoFee;
                tuoCount++;
            } else {
                playerBetCount += betNiuniu;
                playerBetCountSuoha += betNiuniuSuoha;
                playerBetCountDaxiao += betDaxiao;
                playerBetCountTema += betTema;
                playerBetCountBaijiale += betBaijiale;
                playerRatioTotal += ratio;
                playerRobUp += robUp;
                playerWinOrLose += winOrLoseFact;
                playerEveryPlayerHongbaoFeeCount += everyPlayerHongbaoFee;
                playerCount++;
            }
        }
        
        for (NSDictionary* player in dic[@"robs"]) {
            int robDown = 0;
            if (player[@"robDown"]) {
                robDown = [player[@"robDown"] intValue];
            }
            
            BOOL isTuo = [tmanager.mRobot.mTuos isTuo: player[@"userid"]];
            if (isTuo) {
                tuoRobDown += robDown;
            } else {
                playerRobDown += robDown;
            }
        }
        allHongbaoAmount += [dic[@"resultVars"][@"mTotalAmount"] floatValue]/100;
        if (tmanager.mRobot.mEnableNiuniu) {
            if (bankerIsTuo) {
                tuoBankerRatioCount += [dic[@"otherInfo"][@"bankerRatioTotal"] intValue];
            } else {
                playerBankerRatioCount += [dic[@"otherInfo"][@"bankerRatioTotal"] intValue];
            }
            upBankerFee += [dic[@"otherInfo"][@"upBankerFee"] intValue];
            hongbaoFee += [dic[@"otherInfo"][@"hongbaoFee"] intValue];
            bonusPoolFee += [dic[@"otherInfo"][@"bonusPoolFee"] intValue];
            if (dic[@"otherInfo"][@"heiFee"]) {
                heiFee += [dic[@"otherInfo"][@"heiFee"] intValue];
            }
            if (dic[@"otherInfo"][@"heshuiSubsidyCount"]) {
                heshuiSubsidyCount += [dic[@"otherInfo"][@"heshuiSubsidyCount"] intValue];
            }
        }
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", deString(@"第%d局", number)];
    [text appendString: [self addTitle: @"当局统计"]];
    [text appendFormat: @"玩家人数: %d\n", playerCount];
    [text appendFormat: @"托人数: %d\n", tuoCount];
    if(upBankerFee > 0)
    [text appendFormat: @"上庄费用: %d\n", upBankerFee];
    if(hongbaoFee > 0)
    [text appendFormat: @"红包费用: %d\n", hongbaoFee];
    [text appendFormat: @"发包支出: %.2f\n", allHongbaoAmount];
    if(bonusPoolFee > 0)
    [text appendFormat: @"奖池费用: %d\n", bonusPoolFee];
    if (tmanager.mRobot.mEnableNiuniu) {
        if (heiFee > 0) {
            [text appendFormat: @"其他费用: %d\n", heiFee];
        }
        if (heshuiSubsidyCount > 0) {
            [text appendFormat: @"喝水补贴: %d\n", heshuiSubsidyCount];
        }
    }
    [text appendString: [self addTitle: @"玩家"]];
    [text appendFormat: @"总输赢: %d\n", playerWinOrLose];
    if(playerBankerWinCount > 0)
    [text appendFormat: @"开庄输赢: %d\n", playerBankerWinCount];
    if(playerNiuniuWinCount > 0)
    [text appendFormat: @"牛牛输赢: %d\n", playerNiuniuWinCount];
    if(playerNiuniuMianyongWinCount > 0)
    [text appendFormat: @"免佣输赢: %d\n", playerNiuniuMianyongWinCount];
    if(playerNiuniuYibiWinCount > 0)
    [text appendFormat: @"一比输赢: %d\n", playerNiuniuYibiWinCount];
    if(playerDaxiaoWinCount > 0)
    [text appendFormat: @"大小输赢: %d\n", playerDaxiaoWinCount];
    if(playerTemaWinCount > 0)
    [text appendFormat: @"特码输赢: %d\n", playerTemaWinCount];
    if(playerBaijialeWinCount > 0)
    [text appendFormat: @"百家乐输赢: %d\n", playerBaijialeWinCount];
    if(playerBankerRatioCount > 0)
    [text appendFormat: @"庄总抽水: %d\n", playerBankerRatioCount];
    if(playerRatioTotal > 0)
    [text appendFormat: @"闲总抽水: %d\n", playerRatioTotal];
    if(playerEveryPlayerHongbaoFeeCount > 0)
    [text appendFormat: @"闲抽红包: %d\n", playerEveryPlayerHongbaoFeeCount];
    if(playerRobDown > 0)
    [text appendFormat: @"抢包扣分: %d\n", playerRobDown];
    if(playerRobUp > 0)
    [text appendFormat: @"抢包补分: %d\n", playerRobUp];
    if(playerBetCount > 0)
    [text appendFormat: @"牛牛下注: %d\n", playerBetCount];
    if(playerBetCountSuoha > 0)
    [text appendFormat: @"牛牛梭哈: %d\n", playerBetCountSuoha];
    if(playerBetCountDaxiao > 0)
    [text appendFormat: @"大小下注: %d\n", playerBetCountDaxiao];
    if(playerBetCountTema > 0)
    [text appendFormat: @"特码下注: %d\n", playerBetCountTema];
    if(playerBetCountBaijiale > 0)
    [text appendFormat: @"百家下注: %d\n", playerBetCountBaijiale];
    [text appendString: [self addTitle: @"托"]];
    [text appendFormat: @"总输赢: %d\n", tuoWinOrLose];
    if(tuoBankerWinCount > 0)
    [text appendFormat: @"开庄输赢: %d\n", tuoBankerWinCount];
    if(tuoNiuniuWinCount > 0)
    [text appendFormat: @"牛牛输赢: %d\n", tuoNiuniuWinCount];
    if(tuoNiuniuMianyongWinCount > 0)
    [text appendFormat: @"免佣输赢: %d\n", tuoNiuniuMianyongWinCount];
    if(tuoNiuniuYibiWinCount > 0)
    [text appendFormat: @"一比输赢: %d\n", tuoNiuniuYibiWinCount];
    if(tuoDaxiaoWinCount > 0)
    [text appendFormat: @"大小输赢: %d\n", tuoDaxiaoWinCount];
    if(tuoTemaWinCount > 0)
    [text appendFormat: @"特码输赢: %d\n", tuoTemaWinCount];
    if(tuoBaijialeWinCount > 0)
    [text appendFormat: @"百家乐输赢: %d\n", tuoBaijialeWinCount];
    if(tuoBankerRatioCount > 0)
    [text appendFormat: @"庄总抽水: %d\n", tuoBankerRatioCount];
    if(tuoRatioTotal > 0)
    [text appendFormat: @"闲总抽水: %d\n", tuoRatioTotal];
    if(tuoEveryPlayerHongbaoFeeCount > 0)
    [text appendFormat: @"闲抽红包: %d\n", tuoEveryPlayerHongbaoFeeCount];
    if(tuoRobDown > 0)
    [text appendFormat: @"抢包扣分: %d\n", tuoRobDown];
    if(tuoRobUp > 0)
    [text appendFormat: @"抢包补分: %d\n", tuoRobUp];
    if(tuoBetCount > 0)
    [text appendFormat: @"牛牛下注: %d\n", tuoBetCount];
    if(tuoBetCountSuoha > 0)
    [text appendFormat: @"牛牛梭哈: %d\n", tuoBetCountSuoha];
    if(tuoBetCountDaxiao > 0)
    [text appendFormat: @"大小下注: %d\n", tuoBetCountDaxiao];
    if(tuoBetCountTema > 0)
    [text appendFormat: @"特码下注: %d\n", tuoBetCountTema];
    if(tuoBetCountBaijiale > 0)
    [text appendFormat: @"百家下注: %d\n", tuoBetCountBaijiale];
    return text;
}

//最后一句参与玩家奖励分数
-(NSString*) lastRoundPlayerAddScore:(int)value sayerUserid:(NSString*)sayerUserid sayerName:(NSString*)sayerName{
    if ([tmanager.mRobot.mData.mRounds count] < 1) {
        return @"没有上局数据";
    }
    
    NSMutableArray* allPlayer = [NSMutableArray array];
    NSDictionary* dic = [tmanager.mRobot.mData.mRounds lastObject];
    for (NSDictionary* player in dic[@"players"]) {
        [allPlayer addObject: player[@"userid"]];
    }
    
    int allScores = 0;
    for (NSString* userid in allPlayer) {
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        if (memData) {
            allScores += value;
        }
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"第%@局\n", dic[@"number"]];
    [text appendString: [self addTitle: @"参与玩家"]];
    [text appendFormat: @"人数: %d\n", (int)[allPlayer count]];
    [text appendFormat: @"总奖励: %d\n", allScores];
    [text appendString: @"──────────\n"];
    
    for (NSString* userid in allPlayer) {
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        if (memData) {
            [text appendFormat: @"%@. %@　上%d\n", memData[@"index"], deFillName(memData[@"billName"]), value];
            [tmanager.mRobot.mMembers addScore:userid score:value isSet:NO params:@{
                                                                              @"type":@"lastRoundBonus",
                                                                              @"donotAutoSave" : @"true",
                                                                              @"fromUserid":sayerUserid,
                                                                              @"fromName":sayerName}];
        }
    }
    [tmanager.mRobot.mData saveMemberListFile];
    [tmanager.mRobot.mData saveScoreChangedRecordsFile];
    return text;
}

//查所有上下分
-(NSString*) queryAllScoreChanged {
    NSMutableDictionary* allCount = [NSMutableDictionary dictionary];
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        NSString* type = dic[@"type"];
        if (!type) {
            type = @"unknow";
            NSLog(@"###############: %@", dic);
        }
        
        NSMutableDictionary* data = allCount[type];
        if (!data) {
            data = [NSMutableDictionary dictionary];
            allCount[type] = data;

            if (![type isEqualToString: @"command"]) {
                data[@"upScoreCount"] = @"0";
                data[@"downScoreCount"] = @"0";
                data[@"tuo_upScoreCount"] = @"0";
                data[@"tuo_downScoreCount"] = @"0";
            }
        }
        
        if ([type isEqualToString: @"command"]) {
            NSMutableDictionary* allAdmins = data;
            data = allAdmins[dic[@"fromUserid"]];
            if (!data) {
                data = [NSMutableDictionary dictionary];
                data[@"name"] = dic[@"fromName"];
                data[@"upScoreCount"] = @"0";
                data[@"downScoreCount"] = @"0";
                data[@"tuo_upScoreCount"] = @"0";
                data[@"tuo_downScoreCount"] = @"0";
                allAdmins[dic[@"fromUserid"]] = data;
            }
        }
        
        BOOL isTuo = [tmanager.mRobot.mTuos isTuo: dic[@"userid"]];
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        if (change > 0) {
            if (isTuo) {
                data[@"tuo_upScoreCount"] = deInt2String([data[@"tuo_upScoreCount"] intValue]+abs(change));
            } else {
                data[@"upScoreCount"] = deInt2String([data[@"upScoreCount"] intValue]+abs(change));
            }
        } else {
            if (isTuo) {
                data[@"tuo_downScoreCount"] = deInt2String([data[@"tuo_downScoreCount"] intValue]+abs(change));
            } else {
                data[@"downScoreCount"] = deInt2String([data[@"downScoreCount"] intValue]+abs(change));
            }
        }
    }
    
    NSArray* types = @[@"unknow", @"manual", @"tuoBatch", @"tuoSelf", @"bonus", @"playerBack", @"loseBonus",  @"seriesWinBonus", @"lastRoundBonus", @"roundBonus", @"collectBonus"];
    NSArray* typestrs = @[@"未知", @"机器后台", @"托分清零", @"托自助", @"活动奖励", @"反水奖励", @"输分奖励", @"连赢兑奖", @"上局奖励", @"局数奖励", @"集齐奖励"];
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", tmanager.mRobot.mQueryDate];
    [text appendString: [self addTitle: @"特殊上下分"]];
    for (int i = 0; i < [types count]; ++i) {
        NSString* key = types[i];
        int upScoreCount = 0;
        int downScoreCount = 0;
        int tuo_upScoreCount = 0;
        int tuo_downScoreCount = 0;
        NSDictionary* dic = allCount[key];
        if (dic) {
            upScoreCount = [dic[@"upScoreCount"] intValue];
            downScoreCount = [dic[@"downScoreCount"] intValue];
            tuo_upScoreCount = [dic[@"tuo_upScoreCount"] intValue];
            tuo_downScoreCount = [dic[@"tuo_downScoreCount"] intValue];
        }
        if (i > 0) {
            [text appendString: @"──────────\n"];
        }
        [text appendFormat: @"类型: %@\n", typestrs[i]];
        [text appendFormat: @"玩家上分: %d\n", upScoreCount];
        [text appendFormat: @"玩家下分: %d\n", downScoreCount];
        [text appendFormat: @"托上分: %d\n", tuo_upScoreCount];
        [text appendFormat: @"托下分: %d\n", tuo_downScoreCount];
    }
    [text appendString: [self addTitle: @"管理上下分"]];
    if (allCount[@"command"]) {
        BOOL isFirst = YES;
        for (NSString* admin in allCount[@"command"]) {
            if (!isFirst) {
                [text appendString: @"──────────\n"];
            }
            isFirst = NO;
            NSDictionary* dic = allCount[@"command"][admin];
            [text appendFormat: @"昵称: %@\n", dic[@"name"]];
            [text appendFormat: @"微信: %@\n", admin];
            [text appendFormat: @"玩家上分: %@\n", dic[@"upScoreCount"]];
            [text appendFormat: @"玩家下分: %@\n", dic[@"downScoreCount"]];
            [text appendFormat: @"托上分: %@\n", dic[@"tuo_upScoreCount"]];
            [text appendFormat: @"托下分: %@\n", dic[@"tuo_downScoreCount"]];
        }
    }
    return text;
}

//查管理上下分
-(void) queryAdminScoreChanged:(NSDictionary*)memData target: (NSString*)target replyType:(NSString*)replyType {
    NSMutableArray* allCount = [NSMutableArray array];
    int upScoreCount = 0;
    int downScoreCount = 0;
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        if (![dic[@"type"] isEqualToString: @"command"] || ![memData[@"userid"] isEqualToString: dic[@"fromUserid"]]) {
            continue;
        }
        
        [allCount addObject: dic];
        
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        if (change > 0) {
            upScoreCount += abs(change);
        } else {
            downScoreCount += abs(change);
        }
    }
    
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDateFormatter* hourDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [hourDateformat setDateFormat:@"HH:mm"];
    
    if ([replyType isEqualToString: @"text"]) {
        NSMutableString* text = [NSMutableString string];
        [text appendFormat: @"%@\n", tmanager.mRobot.mQueryDate];
        [text appendString: [self addTitle: @"管理上下分"]];
        [text appendFormat: @"昵称: %@\n", memData[@"name"]];
        [text appendFormat: @"微信: %@\n", memData[@"userid"]];
        [text appendFormat: @"给人上分: %d\n", upScoreCount];
        [text appendFormat: @"给人下分: %d\n", downScoreCount];
        [text appendString: @"──────────\n"];
        for (NSDictionary* dic in allCount) {
            int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
            NSDate* date = [objDateformat dateFromString:dic[@"date"]];
            NSString* strHour = [hourDateformat stringFromDate:date];
            [text appendFormat: @"%@　%@　%@%d\n", strHour, deFillName(dic[@"billName"]), change >=0 ? @"+" : @"", change];
        }
        [tmanager.mRobot.mSendMsg sendText: target content:text at:nil title:@""];
    } else if ([replyType isEqualToString: @"file"]){
        NSString* title = deString(@"[%@]%@的上下分.xls", tmanager.mRobot.mQueryDate, memData[@"name"]);
        NSData* data = [niuniuRobotExcelHelper makeAdminScoreChanged:memData allCount:allCount upScoreCount:upScoreCount downScoreCount:downScoreCount];
        [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
    }
}

//添加、删除拉手
-(NSString*) addLashou: (NSDictionary*)memData sayerName:(NSString*)sayerName isRemove: (BOOL)isRemove {
    if (!isRemove && [tmanager.mRobot.mLashous isLashou: memData[@"userid"]]) {
        return deString(@"@%@\n[%@]已经是拉手", sayerName, memData[@"name"]);
    }
    if (isRemove && ![tmanager.mRobot.mLashous isLashou: memData[@"userid"]]) {
        return deString(@"@%@\n[%@]不是拉手", sayerName, memData[@"name"]);
    }
    if (isRemove) {
        [tmanager.mRobot.mLashous delLashou: memData[@"userid"]];
        return deString(@"@%@\n[%@]删除拉手成功", sayerName, memData[@"name"]);
    } else {
        [tmanager.mRobot.mLashous addLashou: memData[@"userid"]];
        return deString(@"@%@\n[%@]添加拉手成功", sayerName, memData[@"name"]);
    }
}

//将名片那个人从原来拉手名下移除。
-(NSString*) delLashouPlayer: (NSDictionary*)memData sayerName:(NSString*)sayerName {
    NSDictionary* dic = [tmanager.mRobot.mLashous getLashouWithPlayer: memData[@"userid"]];
    if (!dic) {
        return deString(@"@%@\n玩家[%@]不属于任何拉手", sayerName, memData[@"billName"]);
    }
    [tmanager.mRobot.mLashous delPlayer:dic[@"userid"] player:memData[@"userid"]];
    return deString(@"@%@\n[删除成功]\n已经将玩家[%@]从拉手[%@]名下移除。", sayerName, memData[@"billName"], dic[@"billName"]);
}

//添加、删除团长
-(NSString*) addLashouHead: (NSDictionary*)memData sayerName:(NSString*)sayerName isRemove: (BOOL)isRemove {
    if (!isRemove && [tmanager.mRobot.mLashouHeads isLashouHead: memData[@"userid"]]) {
        return deString(@"@%@\n[%@]已经是拉手团长", sayerName, memData[@"name"]);
    }
    if (isRemove && ![tmanager.mRobot.mLashouHeads isLashouHead: memData[@"userid"]]) {
        return deString(@"@%@\n[%@]不是拉手团长", sayerName, memData[@"name"]);
    }
    if (isRemove) {
        [tmanager.mRobot.mLashouHeads delLashouHead: memData[@"userid"]];
        return deString(@"@%@\n[%@]删除拉手团长成功", sayerName, memData[@"name"]);
    } else {
        [tmanager.mRobot.mLashouHeads addLashouHead: memData[@"userid"]];
        return deString(@"@%@\n[%@]添加拉手团长成功", sayerName, memData[@"name"]);
    }
}

//将名片那个人从原来团长名下移除。
-(NSString*) delLashouHeadLashou: (NSDictionary*)memData sayerName:(NSString*)sayerName {
    NSDictionary* dic = [tmanager.mRobot.mLashouHeads getLashouHeadWithLashou: memData[@"userid"]];
    if (!dic) {
        return deString(@"@%@\n拉手[%@]不属于任何团长", sayerName, memData[@"billName"]);
    }
    [tmanager.mRobot.mLashouHeads delLashou:dic[@"userid"] lashou:memData[@"userid"]];
    return deString(@"@%@\n[删除成功]\n已经将拉手[%@]从团长[%@]名下移除。", sayerName, memData[@"billName"], dic[@"billName"]);
}

//批量添加团长成员
-(NSString*) batchAddLashouHeadMember:(NSString*)fromUsr memData:(NSDictionary*)memData {
    if (![tmanager.mRobot.mLashouHeads isLashouHead: memData[@"userid"]]) {
        return deString(@"[%@]不是拉手团长身份", memData[@"billName"]);
    }
    NSMutableArray* successPlayers = [NSMutableArray array];
    NSMutableArray* failPlayers = [NSMutableArray array];
    id CContactClass = NSClassFromString(@"CContact");
    NSArray* array = [CContactClass getChatRoomMemberWithoutMyself: fromUsr];
    for (id CContact in array) {
        NSString* userid = [ycFunction getVar:CContact name:@"m_nsUsrName"];
        NSString* errMsg = nil;
        if ([tmanager.mRobot.mAdmins isAdmin: userid]) {
            errMsg = @"管理身份";
        }
        
        NSDictionary* lashouMemData = [tmanager.mRobot.mMembers getMember: userid];
        if (!errMsg) {
            if (!lashouMemData) {
                NSString* name = [ycFunction getVar:CContact name: @"m_nsNickName"];
                errMsg = [tmanager.mRobot.mMembers addMember:userid billName:[niuniuRobotMembers formatName: name]];
                if (!errMsg) {
                    lashouMemData = [tmanager.mRobot.mMembers getMember: userid];
                }
            }
        }
        
        if (!errMsg) {
            errMsg = [tmanager.mRobot.mLashouHeads addLashou:memData[@"userid"] lashou:userid isSave:NO];
        }
        
        if (errMsg) {
            if (lashouMemData) {
                [failPlayers addObject: @{
                                          @"index" : lashouMemData[@"index"],
                                          @"billName" : lashouMemData[@"billName"],
                                          @"msg" : errMsg
                                          }];
            } else {
                NSString* name = [ycFunction getVar:CContact name: @"m_nsNickName"];
                [failPlayers addObject: @{
                                          @"name" : name,
                                          @"msg" : errMsg
                                          }];
            }
        } else {
            if (lashouMemData) {
                [successPlayers addObject: @{
                                             @"index" : lashouMemData[@"index"],
                                             @"billName" : lashouMemData[@"billName"]
                                             }];
            } else {//不大可能发生， 除非拉手档案被删
                NSString* name = [ycFunction getVar:CContact name: @"m_nsNickName"];
                [successPlayers addObject: @{
                                             @"name" : name,
                                             }];
            }
        }
    }
    [tmanager.mRobot.mData saveLashouHeadListFile];
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"团长: %@# %@\n", memData[@"index"], memData[@"billName"]];
    if ([successPlayers count] > 0) {
        [text appendString: [self addTitle: @"添加团长成员"]];
        for (NSDictionary* dic in successPlayers) {
            if (dic[@"billName"]) {
                [text appendFormat: @"%@# %@　添加成功\n", dic[@"index"], deFillName(dic[@"billName"])];
            } else {
                [text appendFormat: @"%@　添加成功\n", dic[@"name"]];
            }
        }
    }
    if ([failPlayers count] > 0) {
        [text appendString: [self addTitle: @"添加失败"]];
        for (NSDictionary* dic in failPlayers) {
            if (dic[@"billName"]) {
                [text appendFormat: @"%@# %@　%@\n─────\n", dic[@"index"], deFillName(dic[@"billName"]), dic[@"msg"]];
            } else {
                [text appendFormat: @"%@　%@\n─────\n", dic[@"name"], dic[@"msg"]];
            }
        }
    }
    return text;
}

//查团长成员
-(NSString*) newLashouHeadTops:(NSString*)userid name:(NSString*)name {
    NSArray* array = [tmanager.mRobot.mLashouHeads getAllLashouHeadMemberDetail: userid sortType: @"count"];
    
    int playerCount = 0;
    for (NSDictionary* dic in array) {
        playerCount += [dic[@"count"] intValue];
    }

    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"团长[%@]\n", name];
    [text appendString: @"──────────\n"];
    [text appendFormat: @"成员: %d 总玩家: %d\n", (int)[array count], playerCount];
    [text appendString: @"──────────\n"];
    
    for (NSDictionary* dic in array) {
        NSString* indexNO = dic[@"index"];
        if (!indexNO) {
            indexNO = @"未知";
        }
        if (dic[@"count"]) {
            [text appendFormat: @"%@. %@　%@人\n",  indexNO, deFillName(dic[@"billName"]), dic[@"count"]];
        } else if(dic[@"name"]) {
            [text appendFormat: @"%@. %@　无会员\n", indexNO, dic[@"name"]];
        } else {
            [text appendFormat: @"%@. %@　无好友\n", indexNO, dic[@"userid"]];
        }
    }
    return text;
}

//查团长流水
-(NSString*) newLashouHeadMembers:(NSString*)userid name:(NSString*)name {
    NSMutableArray* array = [tmanager.mRobot.mLashouHeads getAllLashouHeadMemberDetail:userid sortType:@""];
    for (NSMutableDictionary* dic in array) {
        NSDictionary* allbetInfo = [self getLashouMemberBetDetail: dic[@"userid"] queryDate: tmanager.mRobot.mQueryDateForLashou];
        if (allbetInfo) {
            dic[@"allbetInfo"] = allbetInfo;
        }
    }
    
    [array sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        if (!a[@"allbetInfo"]) {
            return 1;
        }
        if (!b[@"allbetInfo"]) {
            return -1;
        }
        return [a[@"allbetInfo"][@"allBetCount"] intValue]*10+[a[@"allbetInfo"][@"allBetCountSuoha"] intValue]+[a[@"allbetInfo"][@"allBetCountDaxiao"] intValue]+[a[@"allbetInfo"][@"allBetCountTema"] intValue]+[a[@"allbetInfo"][@"allBetCountBaijiale"] intValue] >
        [b[@"allbetInfo"][@"allBetCount"] intValue]*10+[b[@"allbetInfo"][@"allBetCountSuoha"] intValue]+[b[@"allbetInfo"][@"allBetCountDaxiao"] intValue]+[b[@"allbetInfo"][@"allBetCountTema"] intValue]+[b[@"allbetInfo"][@"allBetCountBaijiale"] intValue] ? -1 : 1;
    }];
    
    NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"日期: %@\n", tmanager.mRobot.mQueryDateForLashou];
    if (memData) {
        [text appendFormat: @"团长: %@# %@\n", memData[@"index"], memData[@"billName"]];
    } else {
        [text appendFormat: @"团长: %@\n", name];
    }
    [text appendString: [self addTitle: @"拉手名单"]];
    
    int index = 0;
    for (NSDictionary* dic in array) {
        NSDictionary* allbetInfo = dic[@"allbetInfo"];
        if (!allbetInfo) {
            continue;
        }
        
        if (index++ > 0) {
            [text appendString: @"──────────\n"];
        }
        [text appendFormat: @"%@. %@\n", dic[@"index"], dic[@"billName"]];
        [text appendFormat: @"微信号: %@\n", dic[@"userid"]];
        [text appendFormat: @"人数: %@ 局数: %@\n", dic[@"count"], allbetInfo[@"allRoundCount"]];
        if (tmanager.mRobot.mEnableNiuniu) {
            [text appendFormat: @"牛牛下注: %d\n", [allbetInfo[@"allBetCount"] intValue]];
            [text appendFormat: @"牛牛梭哈: %d\n", [allbetInfo[@"allBetCountSuoha"] intValue]];
        }
        if (tmanager.mRobot.mEnableLonghu) {
            [text appendFormat: @"大小下注: %d\n", [allbetInfo[@"allBetCountDaxiao"] intValue]];
        }
        if (tmanager.mRobot.mEnableTema) {
            [text appendFormat: @"特码下注: %d\n", [allbetInfo[@"allBetCountTema"] intValue]];
        }
        if (tmanager.mRobot.mEnableBaijiale) {
            [text appendFormat: @"百家乐下注: %d\n", [allbetInfo[@"allBetCountBaijiale"] intValue]];
        }
    }
    return text;
}

//查明细
//局数， 单名， 类型， 下注， 点数， 结果， 积分， 操作员， 日期
-(UIImage*) queryPlayerAllDetail:(NSDictionary*)memData {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    
    int upScoreCount = 0;//
    int downScoreCount = 0;//
    int roundCount = 0;//
    int betCount = 0;//
    int betCountSuoha = 0;//
    int betCountDaxiao = 0;//
    int betCountTema = 0;
    int betCountBaijiale = 0;
    int ratioCount = 0;//
    int allWinOrLose = 0;//
    int robCount = 0;//
    int robScore = 0;//
    NSMutableArray* niuniuArr = [NSMutableArray array];
    NSMutableArray* jinniuArr = [NSMutableArray array];
    NSMutableArray* duiziArr = [NSMutableArray array];
    NSMutableArray* shunziArr = [NSMutableArray array];
    NSMutableArray* daoshunArr = [NSMutableArray array];
    NSMutableArray* manniuArr = [NSMutableArray array];
    NSMutableArray* baoziArr = [NSMutableArray array];
    NSMutableDictionary* niuniuDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* jinniuDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* duiziDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* shunziDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* daoshunDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* manniuDic = [NSMutableDictionary dictionary];
    NSMutableDictionary* baoziDic = [NSMutableDictionary dictionary];
    NSMutableArray* allRecords = [NSMutableArray array];

    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        if (!dic[@"timestamp"]) {
            continue;
        }
        
        NSDictionary* player = nil;
        for (NSDictionary* v in dic[@"players"]) {
            if ([v[@"userid"] isEqualToString: memData[@"userid"]]) {
                player = v;
                break;
            }
        }
        
        if (player) {
            BOOL isFuliBanker = NO;
            if (dic[@"betVars"][@"mFuliSetting"] && dic[@"betVars"][@"mFuliSetting"][@"enable"] && [dic[@"betVars"][@"mFuliSetting"][@"enable"] isEqualToString: @"true"]) {
                isFuliBanker = YES;
            }
            NSString* isHighPow = @"false";
            {//查统计
                ++roundCount;
                if ([player[@"betType"] isEqualToString: @"niuniu"]) {
                    if (player[@"suoha"] && [player[@"suoha"] isEqualToString: @"true"]) {
                        betCountSuoha += [player[@"num"] intValue];
                    } else {
                        int num = [player[@"num"] intValue];
                        if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                            num *= [setting[@"niuniuYibiBetTotalRatio"] floatValue];
                        }
                        betCount += num;
                    }
                } else if ([player[@"betType"] isEqualToString: @"tema"]) {
                    betCountTema += [player[@"num"] intValue];
                } else if ([player[@"betType"] isEqualToString: @"baijiale"]) {
                    betCountBaijiale += [player[@"num"] intValue];
                } else if ([player[@"betType"] isEqualToString: @"longhu"]) {
                    betCountDaxiao += [player[@"num"] intValue];
                }
                
                int winOrLoseFact = [player[@"winOrLoseFact"] intValue];
                if (player[@"playerRatio"]) {
                    ratioCount += [player[@"playerRatio"] intValue];
                }
                allWinOrLose += winOrLoseFact;
                if (player[@"coverRobUp"]) {
                    robScore += [player[@"coverRobUp"] intValue];
                }
                BOOL isBankerHead = NO;
                for (NSDictionary* banker in dic[@"bankers"]) {
                    if ([banker[@"isMain"] isEqualToString: @"true"]) {
                        if ([banker[@"resultHandle"] isEqualToString: @"bankerHead"]) {
                            isBankerHead = YES;
                        }
                        break;
                    }
                }
                BOOL bankerHeadNull = isBankerHead && [player[@"betType"] isEqualToString: @"niuniu"];
                if ([player[@"resultHandle"] isEqualToString: @"normal"] && !bankerHeadNull && !isFuliBanker) {//正常情况下才算奖励
                    NSString* amountStr = player[@"amount"];
                    int amount = [player[@"amount"] intValue];
                    int pow = [niuniu amount2pow: amount];
                    if (pow > 10) {
                        isHighPow = @"true";
                    }
                    if (10 == pow) {
                        [niuniuArr addObject: amountStr];
                        niuniuDic[amountStr] = @"true";
                    } else if (11 == pow) {
                        [jinniuArr addObject: amountStr];
                        jinniuDic[amountStr] = @"true";
                    } else if (12 == pow) {
                        [duiziArr addObject: amountStr];
                        duiziDic[amountStr] = @"true";
                    } else if (13 == pow) {
                        [daoshunArr addObject: amountStr];
                        daoshunDic[amountStr] = @"true";
                    } else if (14 == pow) {
                        [shunziArr addObject: amountStr];
                        shunziDic[amountStr] = @"true";
                    } else if (15 == pow) {
                        [manniuArr addObject: amountStr];
                        manniuDic[amountStr] = @"true";
                    } else if (18 == pow) {
                        [baoziArr addObject: amountStr];
                        baoziDic[amountStr] = @"true";
                    }
                }
            }
            NSString* color = @"";
            BOOL isniuniu = [player[@"betType"] isEqualToString:@"niuniu"];
            NSString* amountStr = @"";
            if ([player[@"resultHandle"] isEqualToString: @"normal"] || [player[@"resultHandle"] isEqualToString: @"asLast"]) {
                BOOL isAsLast = [player[@"resultHandle"] isEqualToString: @"asLast"];
                amountStr = deString(@"%.2f(%@)%@", [player[@"amount"] floatValue]/100, player[isniuniu ? @"powFact" : @"powType"], isAsLast ? @"[尾]" : @"");
                if (isAsLast) {
                    color = @"warr";
                }
            }
            else if ([player[@"resultHandle"] isEqualToString: @"overtime"]) {
                amountStr = @"超时";
                color = @"err";
            }
            else if ([player[@"resultHandle"] isEqualToString: @"noWin"]) {
                amountStr = @"无输赢";
                color = @"err";
            }
            
            BOOL suoha = player[@"suoha"] && [player[@"suoha"] isEqualToString: @"true"];
            BOOL mianyong = player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"];
            BOOL yibi = player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"];
            NSString* betStr = isniuniu ? deString(@"%@%@", mianyong ? @"免" : yibi ? @"一比" : suoha ? @"梭" : @"下", player[@"num"]) : player[@"valuesStr"];
            
            [allRecords addObject: @{
                                     @"type" : @"bet",
                                     @"from" : @"闲押注",
                                     @"timestamp" : dic[@"timestamp"],
                                     @"round" : dic[@"number"],
                                     @"bet" : betStr,
                                     @"result" : amountStr,
                                     @"score" : player[@"score"],
                                     @"scoreChange" : player[@"winOrLoseFact"],
                                     @"color" : color,
                                     @"isHighPow" : isHighPow,
                                     @"isFuliBanker" : isFuliBanker ? @"true" : @"isFuliBanker"
                                     }];
            
            if (player[@"coverRobUp"]) {
                [allRecords addObject: @{
                                         @"type" : @"coverRobUp",
                                         @"from" : @"抢包补分",
                                         @"timestamp" : dic[@"timestamp"],
                                         @"round" : dic[@"number"],
                                         @"score" : deInt2String([player[@"score"] intValue]+[player[@"winOrLoseFact"] intValue]),
                                         @"scoreChange" : player[@"coverRobUp"],
                                         }];
            }
        }
        
        player = nil;
        for (NSDictionary* v in dic[@"robs"]) {
            if ([v[@"userid"] isEqualToString: memData[@"userid"]]) {
                player = v;
                break;
            }
        }
        if (player) {
            ++robCount;
            if (player[@"robDown"]) {
                robScore -= [player[@"robDown"] intValue];
                [allRecords addObject: @{
                                         @"type" : @"robDown",
                                         @"from" : @"抢包扣分",
                                         @"timestamp" : dic[@"timestamp"],
                                         @"round" : dic[@"number"],
                                         @"score" : player[@"score"],
                                         @"scoreChange" : deInt2String(-[player[@"robDown"] intValue]),
                                         }];
            }
        }
        
        player = nil;
        for (NSDictionary* v in dic[@"bankers"]) {
            if ([v[@"userid"] isEqualToString: memData[@"userid"]]) {
                player = v;
                break;
            }
        }
        
        if (player) {
            int betCount = [dic[@"betVars"][@"mBetScoreCount"] intValue]*10+[dic[@"betVars"][@"mBetScoreSuohaCount"] intValue]+[dic[@"betVars"][@"mBetScoreLonghuCount"] intValue]+[dic[@"betVars"][@"mBetScoreLonghuHeCount"] intValue]+[dic[@"betVars"][@"mBetScoreTemaCount"] intValue]+[dic[@"betVars"][@"mBetScoreBaijialeCount"] intValue];
            NSString* color = @"";
            NSString* amountStr = @"";
            if ([player[@"resultHandle"] isEqualToString: @"normal"] || [player[@"resultHandle"] isEqualToString: @"asLast"]) {
                BOOL isAsLast = [player[@"resultHandle"] isEqualToString: @"asLast"];
                amountStr = deString(@"%.2f%@", [player[@"amount"] floatValue]/100, isAsLast ? @"[尾]" : @"");
                if (isAsLast) {
                    color = @"warr";
                }
            }
            else if ([player[@"resultHandle"] isEqualToString: @"overtime"]) {
                amountStr = @"超时";
                color = @"err";
            }
            else if ([player[@"resultHandle"] isEqualToString: @"bankerHead"]) {
                amountStr = @"平赔";
                color = @"err";
            }
            [allRecords addObject: @{
                                     @"type" : @"banker",
                                     @"from" : @"开庄",
                                     @"timestamp" : dic[@"timestamp"],
                                     @"round" : dic[@"number"],
                                     @"bet" : deInt2String(betCount),
                                     @"result" : amountStr,
                                     @"score" : player[@"score"],
                                     @"scoreChange" : player[@"winOrLoseFact"],
                                     @"color" : color
                                     }];
            
            if (player[@"coverRobUp"]) {
                [allRecords addObject: @{
                                         @"type" : @"coverRobUp",
                                         @"from" : @"抢包补分",
                                         @"timestamp" : dic[@"timestamp"],
                                         @"round" : dic[@"number"],
                                         @"score" : deInt2String([player[@"score"] intValue]+[player[@"winOrLoseFact"] intValue]),
                                         @"scoreChange" : player[@"coverRobUp"],
                                         }];
            }
        }
    }
    
    finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        if (!dic[@"timestamp"]) {
            continue;
        }
        
        if (![dic[@"userid"] isEqualToString: memData[@"userid"]]) {
            continue;
        }
        
        int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
        if (change > 0) {
            upScoreCount += abs(change);
        } else {
            downScoreCount += abs(change);
        }
        
        NSString* fromName = dic[@"fromName"];
        if (!fromName) {
            fromName = @"无";
        }
        
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
        
        NSString* admin = @"";
        NSString* admin2 = @"";
        if (dic[@"fromUserid"]) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: dic[@"fromUserid"]];
            if (memData) {
                admin = memData[@"name"];
                admin2 = memData[@"billName"];
            }
        }
        
        [allRecords addObject: @{
                                 @"type" : @"scoreChange",
                                 @"timestamp" : dic[@"timestamp"],
                                 @"round" : dic[@"round"],
                                 @"from" : from,
                                 @"admin" : admin,
                                 @"admin2" : admin2,
                                 @"score" : dic[@"oldScore"],
                                 @"scoreChange" : deInt2String(change),
                                 }];
    }
    
    [allRecords sortUsingComparator: ^NSComparisonResult(NSMutableDictionary* a, NSMutableDictionary* b) {
        long long atime = [a[@"timestamp"] longLongValue];
        long long btime = [b[@"timestamp"] longLongValue];
        if (atime > btime) {
            return 1;
        }
        if (atime < btime) {
            return -1;
        }
        if ([a[@"type"] isEqualToString: @"coverRobUp"]) {
            return 1;
        }
        if ([b[@"type"] isEqualToString: @"coverRobUp"]) {
            return -1;
        }
        if ([a[@"type"] isEqualToString: @"robDown"]) {
            return 1;
        }
        if ([b[@"type"] isEqualToString: @"robDown"]) {
            return -1;
        }
        return -1;
    }];
    

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
    int hCount = 0;
    
    [self addLine:view frame:CGRectMake(0, hCount, view.frame.size.width, titleh) color: titleBgColor];
    [self addLabel: view frame:CGRectMake(view.frame.size.width/2-100, hCount, 200, titleh) text:deString(@"[%@]", tmanager.mRobot.mQueryDate) color: titleColor isLeft:NO];
    hCount += titleh;
    
    {
        NSArray* array = @[
                           @[@100, @"编号", memData[@"index"]],
                           @[@150, @"昵称", memData[@"name"]],
                           @[@100, @"单名", memData[@"billName"]],
                           @[@100, @"总上分", deInt2String(upScoreCount)],
                           @[@100, @"总下分", deInt2String(downScoreCount)],
                           @[@100, @"总局数", deInt2String(roundCount)],
                           @[@100, @"总输赢", deInt2String(allWinOrLose+robScore)],
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
        NSArray* array = @[
                           @[@150, @"总下注", deInt2String(betCount*10+betCountSuoha+betCountDaxiao+betCountTema+betCountBaijiale)],
                           @[@100, @"牛牛下注", deInt2String(betCount)],
                           @[@100, @"牛牛梭哈", deInt2String(betCountSuoha)],
                           @[@100, @"大小下注", deInt2String(betCountDaxiao)],
                           @[@100, @"特码下注", deInt2String(betCountTema)],
                           @[@100, @"百家乐下注", deInt2String(betCountBaijiale)],
//                           @[@100, @"抢包次数", deInt2String(robCount)],
                           @[@100, @"抢包盈亏", deInt2String(robScore)],
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
        NSArray* array = @[
                           @[@53, @"牛牛", deInt2String((int)[niuniuArr count])],
                           @[@53, @"金牛", deInt2String((int)[jinniuArr count])],
                           @[@53, @"对子", deInt2String((int)[duiziArr count])],
                           @[@53, @"倒顺", deInt2String((int)[daoshunArr count])],
                           @[@53, @"顺子", deInt2String((int)[shunziArr count])],
                           @[@53, @"满牛", deInt2String((int)[manniuArr count])],
                           @[@53, @"豹子", deInt2String((int)[baoziArr count])],
                           @[@54, @"牛牛^", deInt2String((int)[niuniuDic count])],
                           @[@54, @"金牛^", deInt2String((int)[jinniuDic count])],
                           @[@54, @"对子^", deInt2String((int)[duiziDic count])],
                           @[@54, @"倒顺^", deInt2String((int)[daoshunDic count])],
                           @[@54, @"顺子^", deInt2String((int)[shunziDic count])],
                           @[@54, @"满牛^", deInt2String((int)[manniuDic count])],
                           @[@55, @"豹子^", deInt2String((int)[baoziDic count])],
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
    
    { //局数， 来自， 下注， 点数， 输赢， 积分， 时间
        NSArray* array = @[
                           @[@65, @"时间"],
                           @[@80, @"局数"],
                           @[@115, @"类型"],
                           @[@170, @"下注/管理"],
                           @[@120, @"点数/管理"],
                           @[@100, @"分数变动"],
                           @[@100, @"剩余分数"],
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
        for (NSDictionary* dic in allRecords) {
            UIColor* fromColor = textColor;
            if ([dic[@"type"] isEqualToString: @"scoreChange"]) {
                fromColor = textColorSpecial;
            }
            NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
            [objDateformat setDateFormat:@"HH:mm"];
            NSString* timeStr = [objDateformat stringFromDate: [NSDate dateWithTimeIntervalSince1970: [dic[@"timestamp"] longLongValue]]];
            NSString* newScore = deInt2String([dic[@"score"] intValue]+[dic[@"scoreChange"] intValue]);
            UIColor* resultColor = fromColor;
            if (dic[@"color"]) {
                if ([dic[@"color"] isEqualToString: @"warr"]) {
                    resultColor = textColorWarr;
                } else if ([dic[@"color"] isEqualToString: @"err"]) {
                    resultColor = textColorErr;
                }
            }
            if (dic[@"isHighPow"] && [dic[@"isHighPow"] isEqualToString: @"true"]) {
                resultColor = [UIColor greenColor];
            }
            NSString* scoreChangeStr = dic[@"scoreChange"];
            int scoreChange = [dic[@"scoreChange"] intValue];
            if (scoreChange >= 0) {
                scoreChangeStr = deString(@"+%d", scoreChange);
            }
            NSString* betStr = @"";
            if (dic[@"bet"]) {
                if (dic[@"isFuliBanker"] && [dic[@"isFuliBanker"] isEqualToString: @"true"]) {
                    betStr = deString(@"%@(福)", dic[@"bet"]);
                } else {
                    betStr = dic[@"bet"];
                }
            }
            if (dic[@"admin"]) {
                betStr = dic[@"admin"];
            }
            NSString* resultStr = @"";
            if (dic[@"result"]) {
                resultStr = dic[@"result"];
            }
            if (dic[@"admin2"]) {
                resultStr = dic[@"admin2"];
            }
            NSArray* values = @[
                                @[timeStr],
                                @[dic[@"round"]],
                                @[dic[@"from"], fromColor],
                                @[betStr, fromColor],
                                @[resultStr, resultColor],
                                @[scoreChangeStr, scoreChange >= 0 ? textColor : textColorErr],
                                @[newScore],
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
                UILabel* label = [self addLabel: view frame:CGRectMake(wCnt, hCount, w, titleh) text:value[0] color: color isLeft:NO];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [textColor CGColor];
                wCnt += w;
            }
            hCount += titleh;
            
            ++index;
        }
    }

    //---------------
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


//清理低分
-(NSString*) clearLowScores: (int)minScore {
    int scoreCount = 0;
    NSMutableArray* array = [NSMutableArray array];
    NSArray* datas = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSDictionary* dic in datas) {
        int score = [dic[@"score"] intValue];
        if (score > 0 && score <= minScore) {
            [tmanager.mRobot.mMembers addScore: dic[@"userid"] score:0 isSet:YES params:@{
                                                                                    @"type":@"manual",
                                                                                    @"donotAutoSave" : @"true"
                                                                                    }];
            [array addObject: @{
                                @"index" : dic[@"index"],
                                @"billName" : dic[@"billName"],
                                @"score" : deInt2String(score),
                                }];
            scoreCount += score;
        }
    }
    [tmanager.mRobot.mData saveMemberListFile];
    [tmanager.mRobot.mData saveScoreChangedRecordsFile];
    
    [array sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"score"] intValue] > [b[@"score"] intValue] ? -1 : 1;
    }];
    
    NSMutableString* text = [NSMutableString string];
    [text appendString: [self addTitle: @"清理低分"]];
    [text appendFormat: @"人数: %d\n", (int)[array count]];
    [text appendFormat: @"总分: %d\n", scoreCount];
    [text appendString: @"──────────\n"];
    for (NSDictionary* dic in array) {
        [text appendFormat: @"%@. %@　下%@\n", dic[@"index"], deFillName(dic[@"billName"]), dic[@"score"]];
    }
    return text;
}

//查询所有可用命令
-(NSString*) newAllCommandString {
    NSMutableString* text = [NSMutableString string];
    [text appendString: [self addTitle: @"管理命令"]];
    [text appendString: @"查流水[4位数字]\n"];
    [text appendString: @"(如: '查流水0318', 查询的是3点到18点的流水, 如'查流水'则查询全天流水)\n\n"];
    
    [text appendString: @"导出所有数据\n"];
    [text appendString: @"(将所有玩家下注以及上下分数据生成表格文件导出。)\n\n"];
    
    [text appendString: @"查所有上下分\n"];
    [text appendString: @"(统计所有的上下分)\n\n"];
    
    [text appendString: @"查所有上下分明细\n"];
    [text appendString: @"(查询所有的上下分明细)\n\n"];
    
    [text appendString: @"查所有群上下分\n"];
    [text appendString: @"(统计每个群的上下分)\n\n"];
    
    [text appendString: @"出单\n"];
    [text appendString: @"(积分排行榜)\n\n"];

    [text appendString: @"出单2\n"];
    [text appendString: @"(积分排行榜, 区分托)\n\n"];
    
    [text appendString: @"出单3\n"];
    [text appendString: @"(积分排行榜, 只有玩家)\n\n"];
    
    [text appendString: @"出单4\n"];
    [text appendString: @"(积分排行榜, 只有托)\n\n"];
    
    [text appendString: @"查输赢\n"];
    [text appendString: @"(当日所有玩家输赢排行榜)\n\n"];
    
    [text appendString: @"查输赢2\n"];
    [text appendString: @"(当日所有玩家输赢排行榜，区分托)\n\n"];
    
    [text appendString: @"查输赢3\n"];
    [text appendString: @"(当日所有玩家输赢排行榜，只有玩家)\n\n"];
    
    [text appendString: @"查托名单\n"];
    [text appendString: @"(列出托所有名单)\n\n"];
    
    [text appendString: @"查托点包[2位数字]\n"];
    [text appendString: @"(如: '查托点包80', 查询的是托全天点包, 反百分80)\n\n"];
    
    [text appendString: @"查托点包[6位数字]\n"];
    [text appendString: @"(如：'查托点包750309', 查询的是托3点到9点的点包, 反百分75)\n\n"];
    
    [text appendString: @"托分清零\n"];
    [text appendString: @"(将所有托分清零)\n\n"];

    [text appendString: @"查所有拉手\n"];
    [text appendString: @"(查询所有拉手的流水)\n\n"];
    
    [text appendString: @"查所有拉手名单\n"];
    [text appendString: @"(查询所有拉手的名单)\n\n"];
    
    [text appendString: @"查反水奖励\n"];
    [text appendString: @"(预览所有玩家反水奖励详情, 区分托与玩家)\n\n"];
    
    [text appendString: @"查反水奖励2\n"];
    [text appendString: @"(预览所有玩家反水奖励详情, 不区分托与玩家)\n\n"];
    
    [text appendString: @"执行反水奖励\n"];
    [text appendString: @"(给满足反水奖励的玩家上分)\n\n"];
    
    [text appendString: @"取消反水奖励\n"];
    [text appendString: @"(取消满足反水奖励的玩家上分)\n\n"];
    
    [text appendString: @"查输分奖励\n"];
    [text appendString: @"(预览所有玩家输分奖励详情, 区分托与玩家)\n\n"];
    
    [text appendString: @"查输分奖励2\n"];
    [text appendString: @"(预览所有玩家输分奖励详情, 不区分托与玩家)\n\n"];
    
    [text appendString: @"执行输分奖励\n"];
    [text appendString: @"(给满足输分奖励的玩家上分)\n\n"];
    
    [text appendString: @"取消输分奖励\n"];
    [text appendString: @"(取消满足输分奖励的玩家上分)\n\n"];
    
    [text appendString: @"查集齐奖励\n"];
    [text appendString: @"(预览所有玩家集齐奖励详情, 区分托与玩家)\n\n"];
    
    [text appendString: @"查集齐奖励2\n"];
    [text appendString: @"(预览所有玩家集齐奖励详情, 不区分托与玩家)\n\n"];
    
    [text appendString: @"执行集齐奖励\n"];
    [text appendString: @"(给满足集齐奖励的玩家上分)\n\n"];
    
    [text appendString: @"取消集齐奖励\n"];
    [text appendString: @"(取消满足集齐奖励的玩家上分)\n\n"];
    
    [text appendString: @"查局数奖励\n"];
    [text appendString: @"(预览所有玩家局数奖励详情, 区分托与玩家)\n\n"];
    
    [text appendString: @"查局数奖励2\n"];
    [text appendString: @"(预览所有玩家局数奖励详情, 不区分托与玩家)\n\n"];
    
    [text appendString: @"执行局数奖励\n"];
    [text appendString: @"(给满足局数奖励的玩家上分)\n\n"];
    
    [text appendString: @"取消局数奖励\n"];
    [text appendString: @"(取消满足局数奖励的玩家上分)\n\n"];
    
    [text appendString: @"上局奖励[数字]\n"];
    [text appendString: @"(奖励上局参与玩家指定分数,如: 上局奖励888)\n\n"];
    
    [text appendString: @"查局数[数字]\n"];
    [text appendString: @"(查询指定局数的统计信息, 如: 查局数717)\n\n"];
    
    [text appendString: @"查修改[数字]\n"];
    [text appendString: @"(如‘查修改’，查询的是当前查询日期的修改记录，如‘查修改12’， 查询的是操作人员最近12天的修改记录)\n\n"];
    
    [text appendString: @"查概率\n"];
    [text appendString: @"(根据采集的红包统计概率)\n\n"];
    
    [text appendString: @"查点数\n"];
    [text appendString: @"(根据采集的红包统计点数)\n\n"];
    
    [text appendString: @"查日期\n"];
    [text appendString: @"(查询当前设置的日期)\n\n"];
    
    [text appendString: @"设日期[8位数日期数字]\n"];
    [text appendString: @"(设置查询的日期,如: 设日期20170601)\n\n"];
    
    [text appendString: @"清理档案\n"];
    [text appendString: @"(将清理无用玩家、托、拉手，还能清理拉手名下长期不玩的玩家, 自动解除关系, 清理规则是没有积分，并且从现存的局数和上下分记录里面查找，如果没有一条记录被找到，该档案判定为无用并清理, 建议一个月执行一次，节省空间。)\n\n"];
    
    [text appendString: @"过滤[数字]\n"];
    [text appendString: @"(过滤播报群观战中指定编号的名单)\n\n"];
    
    [text appendString: @"取消过滤[数字]\n"];
    [text appendString: @"(取消过滤播报群观战中指定编号的名单)\n\n"];
    
    [text appendString: @"查过滤\n"];
    [text appendString: @"(查看播报群已过滤的名单)\n\n"];
    
    [text appendString: @"搜[编号、名字、单名]\n"];
    [text appendString: @"(相当于推名片的功能, 只需要输入部分名字, 如: 搜1012)\n\n"];
    
    [text appendString: @"批量添加托\n"];
    [text appendString: @"(将当前群里的所有玩家设置成托，不包括管理、拉手)\n\n"];
    
    [text appendString: @"名片+添加托\n"];
    [text appendString: @"(将名片那个人设置成托)\n\n"];
    
    [text appendString: @"名片+删除托\n"];
    [text appendString: @"(将名片那个人设置成玩家)\n\n"];
    
    [text appendString: @"名片+添加拉手\n"];
    [text appendString: @"(将名片那个人设置成拉手)\n\n"];
    
    [text appendString: @"名片+删除拉手\n"];
    [text appendString: @"(将名片那个人取消拉手)\n\n"];
    
    [text appendString: @"名片+删除拉手成员归属\n"];
    [text appendString: @"(将名片那个人从原来拉手名下移除。)\n\n"];
    
    [text appendString: @"名片+添加团长\n"];
    [text appendString: @"(将名片那个人设置成拉手团长)\n\n"];
    
    [text appendString: @"名片+删除团长\n"];
    [text appendString: @"(将名片那个人取消拉手团长)\n\n"];
    
    [text appendString: @"名片+删除团长成员归属\n"];
    [text appendString: @"(将名片那个人从原来团长名下移除。)\n\n"];
    
    [text appendString: @"名片+批量添加团长成员\n"];
    [text appendString: @"(将当前群所有拉手归属到名片那个团长名下。)\n\n"];
    
    [text appendString: @"名片+查明细\n"];
    [text appendString: @"(查询名片那个人的明细, 图片版)\n\n"];
    
    [text appendString: @"名片+查统计\n"];
    [text appendString: @"(查询名片那个人的统计信息)\n\n"];
    
    [text appendString: @"名片+查领包\n"];
    [text appendString: @"(查询名片那个人的领包记录)\n\n"];
    
    [text appendString: @"名片+查上下分\n"];
    [text appendString: @"(查询名片那个人的上下分记录)\n\n"];
    
    [text appendString: @"名片+查管理上下分\n"];
    [text appendString: @"(查询名片那个管理给别人上下分的记录)\n\n"];
    
    [text appendString: @"名片+查拉手\n"];
    [text appendString: @"(查询名片那个拉手的玩家流水)\n\n"];
    
    [text appendString: @"名片+[大于0的数字]\n"];
    [text appendString: @"(给名片那个玩家上分)\n\n"];
    
    [text appendString: @"名片+[小于0的数字]\n"];
    [text appendString: @"(给名片那个人下分)\n\n"];
    
    [text appendString: @"名片+清零\n"];
    [text appendString: @"(将名片那个玩家分数清零)\n\n"];
    
    [text appendString: @"名片+转移+名片\n"];
    [text appendString: @"(将名片那个玩家分数转移给名片2)\n\n"];
    
    [text appendString: [self addTitle: @"拉手命令"]];
    [text appendString: @"查拉手成员\n"];
    [text appendString: @"(查询该拉手名下所有玩家)\n\n"];
    
    [text appendString: @"查拉手流水\n"];
    [text appendString: @"(查询该拉手所有玩家流水)\n\n"];
    
    [text appendString: @"查拉手日期\n"];
    [text appendString: @"(查询当前设置的日期)\n\n"];
    
    [text appendString: @"设拉手日期[8位数日期数字]\n"];
    [text appendString: @"(设置查询的日期,如:设拉手日期20170601)\n\n"];
    
    [text appendString: @"搜[编号、昵称、单名]\n"];
    [text appendString: @"(相当于推名片的功能, 只需要输入部分名字, 如: 搜1012)\n\n"];
    
    [text appendString: @"名片+添加拉手成员\n"];
    [text appendString: @"(将名片那个人设置成自己的成员)\n\n"];
    
    [text appendString: @"名片+删除拉手成员\n"];
    [text appendString: @"(将名片那个人移出自己的成员列表)\n\n"];
    
    [text appendString: [self addTitle: @"团长命令"]];
    [text appendString: @"查团长成员\n"];
    [text appendString: @"(查询该团长名下所有拉手)\n\n"];
    
    [text appendString: @"查团长流水\n"];
    [text appendString: @"(查询该团长所有拉手流水)\n\n"];
    
    [text appendString: @"查拉手日期\n"];
    [text appendString: @"(查询当前设置的日期)\n\n"];
    
    [text appendString: @"设拉手日期[8位数日期数字]\n"];
    [text appendString: @"(设置查询的日期,如:设拉手日期20170601)\n\n"];
    
    [text appendString: @"搜[编号、昵称、单名]\n"];
    [text appendString: @"(相当于推名片的功能, 只需要输入部分名字, 如: 搜1012)\n\n"];
    
    [text appendString: @"名片+添加团长成员\n"];
    [text appendString: @"(将名片那个拉手设置成自己的成员)\n\n"];
    
    [text appendString: @"名片+删除团长成员\n"];
    [text appendString: @"(将名片那个拉手移出自己的成员列表)\n\n"];
    
    [text appendString: [self addTitle: @"托命令"]];
    [text appendString: @"上分[数字]\n"];
    [text appendString: @"(托自助上分)\n\n"];
    
    [text appendString: @"下分[数字]\n"];
    [text appendString: @"(托自助下分)\n\n"];
    return text;
}

//测试口令
-(NSString*) test {
    NSMutableString* text = [NSMutableString string];
    
    NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [objDateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDateFormatter *hourDateformat = [[[NSDateFormatter alloc] init] autorelease];
    [hourDateformat setDateFormat:@"HH"];
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        [text appendFormat: @"%@局, %@\n", dic[@"number"], dic[@"date"]];
    }
    return text;
}

-(void) countPlayerBackBonus:(NSDictionary*)allPlayerData {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    NSArray* allPlayerDataArr = [allPlayerData allValues];
    for (NSMutableDictionary* dic in allPlayerDataArr) {
        int playerBackBonus = 0;
        float playerBackRadio = 0;
        int totalBet = [dic[@"totalBetForPlayerBack"] intValue]/10;
        for (int i = 1; i <= 5; ++i) {
            NSString* key = deString(@"playerBackRatio%d", i);
            if ([setting[key] isEqualToString: @""]) {
                break;
            }
            NSArray* array = [setting[key] componentsSeparatedByString: @"-"];
            if (totalBet >= [array[0] intValue] && totalBet <= [array[1] intValue]) {
                playerBackRadio = [array[2] floatValue];
                playerBackBonus = totalBet*playerBackRadio;
                break;
            }
        }
        dic[@"playerBackBonus"] = deInt2String(playerBackBonus);
        dic[@"playerBackRadio"] = deString(@"%f", playerBackRadio);
    }
}

//查反水
-(void) queryPlayerBack: (NSString*)target diffTuo:(BOOL)diffTuo {
    if (![tmanager.mRobot.mData.mBaseSetting[@"playerBackEnable"] isEqualToString: @"true"]) {
        [tmanager.mRobot.mSendMsg sendText: target content:@"反水奖励命令未开启, 请联系管理。" at:nil title: @""];
        return;
    }
    NSMutableDictionary* allPlayerData = [self allPlayerData];
    [self countPlayerBackBonus: allPlayerData];
    NSString* title = deString(@"[%@]反水奖励%@.xls", tmanager.mRobot.mQueryDate, diffTuo ? @"(区分)" : @"");
    NSData* data = [niuniuRobotExcelHelper makePlayerBackBonus: allPlayerData diffTuo: diffTuo];
    [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
}

//执行反水
-(NSString*) exePlayerBack:(NSString*)sayerUserid sayerName:(NSString*)sayerName isCancel:(BOOL)isCancel{
    if (![tmanager.mRobot.mData.mBaseSetting[@"playerBackEnable"] isEqualToString: @"true"]) {
        return @"反水奖励命令未开启, 请联系管理。";
    }
    
    NSMutableDictionary* allPlayerData = [self allPlayerData];
    [self countPlayerBackBonus: allPlayerData];
    NSArray* allPlayerDataArr = [allPlayerData allValues];
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
    [players sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"playerBackBonus"] intValue] > [b[@"playerBackBonus"] intValue] ? -1 : 1;
    }];
    [tuos sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"playerBackBonus"] intValue] > [b[@"playerBackBonus"] intValue] ? -1 : 1;
    }];
    
    int playerBonusCount = 0;
    for (NSDictionary* dic in players) {
        playerBonusCount += [dic[@"playerBackBonus"] intValue];
    }
    
    int tuoBonusCount = 0;
    for (NSDictionary* dic in tuos) {
        tuoBonusCount += [dic[@"playerBackBonus"] intValue];
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", tmanager.mRobot.mQueryDate];
    [text appendString: [self addTitle: deString(@"%@反水奖励", isCancel ? @"取消" : @"")]];
    [text appendFormat: @"玩家人数: %d\n", (int)[players count]];
    [text appendFormat: @"总奖励: %d\n", playerBonusCount];
    [text appendString: @"──────────\n"];
    for (NSDictionary* dic in players) {
        NSString* userid = dic[@"userid"];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        [text appendFormat: @"%@. %@　%@%@\n", memData[@"index"], deFillName(memData[@"billName"]), isCancel ? @"下" : @"上", dic[@"playerBackBonus"]];
        [tmanager.mRobot.mMembers addScore:dic[@"userid"] score:[dic[@"playerBackBonus"] intValue] * (isCancel ? -1 : 1) isSet:NO
                              params:@{
                                       @"type":@"playerBack",
                                       @"donotAutoSave" : @"true",
                                       @"fromUserid":sayerUserid,
                                       @"fromName":sayerName
                                       }];
    }
    [text appendString: @"──────────\n"];
    [text appendFormat: @"托人数: %d\n", (int)[tuos count]];
    [text appendFormat: @"总奖励: %d\n", tuoBonusCount];
    [text appendString: @"──────────\n"];
    for (NSDictionary* dic in tuos) {
        NSString* userid = dic[@"userid"];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        [text appendFormat: @"%@. %@　%@%@\n", memData[@"index"], deFillName(memData[@"billName"]), isCancel ? @"下" : @"上", dic[@"playerBackBonus"]];
        [tmanager.mRobot.mMembers addScore:dic[@"userid"] score:[dic[@"playerBackBonus"] intValue] * (isCancel ? -1 : 1) isSet:NO
                              params:@{
                                       @"type":@"playerBack",
                                       @"donotAutoSave" : @"true",
                                       @"fromUserid":sayerUserid,
                                       @"fromName":sayerName
                                       }];
    }
    [tmanager.mRobot.mData saveMemberListFile];
    [tmanager.mRobot.mData saveScoreChangedRecordsFile];
    return text;
}

-(void) countLoseBonus:(NSDictionary*)allPlayerData {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    NSArray* allPlayerDataArr = [allPlayerData allValues];
    for (NSMutableDictionary* dic in allPlayerDataArr) {
        int loseBonus = 0;
        float loseBonusRadio = 0;
        int allWinOrLose = [dic[@"allWinOrLose"] intValue];
        if (allWinOrLose < 0) {
            allWinOrLose = abs(allWinOrLose);
            for (int i = 1; i <= 5; ++i) {
                NSString* key = deString(@"loseBonusRatio%d", i);
                if ([setting[key] isEqualToString: @""]) {
                    break;
                }
                NSArray* array = [setting[key] componentsSeparatedByString: @"-"];
                if (allWinOrLose >= [array[0] intValue] && allWinOrLose <= [array[1] intValue]) {
                    loseBonusRadio = [array[2] floatValue];
                    loseBonus = allWinOrLose*loseBonusRadio;
                    break;
                }
            }
        }
        dic[@"loseBonus"] = deInt2String(loseBonus);
        dic[@"loseBonusRadio"] = deString(@"%f", loseBonusRadio);
    }
}

//输分奖励
-(void) queryLoseBonus: (NSString*)target diffTuo:(BOOL)diffTuo {
    if (![tmanager.mRobot.mData.mBaseSetting[@"loseBonusEnable"] isEqualToString: @"true"]) {
        [tmanager.mRobot.mSendMsg sendText: target content:@"输分奖励命令未开启, 请联系管理。" at:nil title: @""];
        return;
    }
    NSMutableDictionary* allPlayerData = [self allPlayerData];
    [self countLoseBonus: allPlayerData];
    NSString* title = deString(@"[%@]输分奖励%@.xls", tmanager.mRobot.mQueryDate, diffTuo ? @"(区分)" : @"");
    NSData* data = [niuniuRobotExcelHelper makeLoseBonus: allPlayerData diffTuo: diffTuo];
    [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
}

-(NSString*) exeLoseBonus:(NSString*)sayerUserid sayerName:(NSString*)sayerName isCancel:(BOOL)isCancel {
    if (![tmanager.mRobot.mData.mBaseSetting[@"loseBonusEnable"] isEqualToString: @"true"]) {
        return @"输分奖励命令未开启, 请联系管理。";
    }
    
    NSMutableDictionary* allPlayerData = [self allPlayerData];
    [self countLoseBonus: allPlayerData];
    NSArray* allPlayerDataArr = [allPlayerData allValues];
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
    [players sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"loseBonus"] intValue] > [b[@"loseBonus"] intValue] ? -1 : 1;
    }];
    [tuos sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"loseBonus"] intValue] > [b[@"loseBonus"] intValue] ? -1 : 1;
    }];
    
    int playerBonusCount = 0;
    for (NSDictionary* dic in players) {
        playerBonusCount += [dic[@"loseBonus"] intValue];
    }
    
    int tuoBonusCount = 0;
    for (NSDictionary* dic in tuos) {
        tuoBonusCount += [dic[@"loseBonus"] intValue];
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", tmanager.mRobot.mQueryDate];
    [text appendString: [self addTitle: deString(@"%@输分奖励", isCancel ? @"取消" : @"")]];
    [text appendFormat: @"玩家人数: %d\n", (int)[players count]];
    [text appendFormat: @"总奖励: %d\n", playerBonusCount];
    [text appendString: @"──────────\n"];
    for (NSDictionary* dic in players) {
        NSString* userid = dic[@"userid"];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        [text appendFormat: @"%@. %@　%@%@\n", memData[@"index"], deFillName(memData[@"billName"]), isCancel ? @"下" : @"上", dic[@"loseBonus"]];
        [tmanager.mRobot.mMembers addScore:dic[@"userid"] score:[dic[@"loseBonus"] intValue] * (isCancel ? -1 : 1) isSet:NO
                              params:@{
                                       @"type":@"loseBonus",
                                       @"donotAutoSave" : @"true",
                                       @"fromUserid":sayerUserid,
                                       @"fromName":sayerName
                                       }];
    }
    [text appendString: @"──────────\n"];
    [text appendFormat: @"托人数: %d\n", (int)[tuos count]];
    [text appendFormat: @"总奖励: %d\n", tuoBonusCount];
    [text appendString: @"──────────\n"];
    for (NSDictionary* dic in tuos) {
        NSString* userid = dic[@"userid"];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        [text appendFormat: @"%@. %@　%@%@\n", memData[@"index"], deFillName(memData[@"billName"]), isCancel ? @"下" : @"上", dic[@"loseBonus"]];
        [tmanager.mRobot.mMembers addScore:dic[@"userid"] score:[dic[@"loseBonus"] intValue] * (isCancel ? -1 : 1) isSet:NO
                              params:@{
                                       @"type":@"loseBonus",
                                       @"donotAutoSave" : @"true",
                                       @"fromUserid":sayerUserid,
                                       @"fromName":sayerName
                                       }];
    }
    [tmanager.mRobot.mData saveMemberListFile];
    [tmanager.mRobot.mData saveScoreChangedRecordsFile];
    return text;

}


//tmp
-(NSMutableDictionary*) getAllPlayerRounds {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    NSMutableDictionary* allPlayerRounds = [NSMutableDictionary dictionary];
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        for (NSDictionary* player in dic[@"players"]) {
            NSMutableDictionary* values = allPlayerRounds[player[@"userid"]];
            if (!values) {
                values = [NSMutableDictionary dictionary];
                values[@"userid"] = player[@"userid"];
                values[@"rounds"] = @"0";
                values[@"bet"] = [NSMutableArray array];
                allPlayerRounds[player[@"userid"]] = values;
            }
            
            values[@"rounds"] = deInt2String([values[@"rounds"] intValue] + 1);
            
            int bet = 0;
            if (![player[@"betType"] isEqualToString: @"niuniu"] || [player[@"suoha"] isEqualToString: @"true"]) {//龙虎、牛牛梭哈
                int num = [player[@"num"] intValue];
                if (player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"]) {
                    num *= [setting[@"niuniuYibiBetTotalRatio"] floatValue];
                }
                bet = num;
            } else {//牛牛非梭哈
                bet = [player[@"num"] intValue]*10;
            }
            [values[@"bet"] addObject: deInt2String(bet)];
        }
    }
    
    int level1 = [setting[@"huangzu_roundBonus_level1"] intValue];//100以下
    int level2 = [setting[@"huangzu_roundBonus_level2"] intValue];//100~299
    int level3 = [setting[@"huangzu_roundBonus_level3"] intValue];//300~999
    
    int roundMust1 = [setting[@"huangzu_roundBonus_roundMust1"] intValue];
    int roundMust2 = [setting[@"huangzu_roundBonus_roundMust2"] intValue];
    int roundMust3 = [setting[@"huangzu_roundBonus_roundMust3"] intValue];
    int roundMust4 = [setting[@"huangzu_roundBonus_roundMust4"] intValue];
    
    int bonus1_1 = [setting[@"huangzu_roundBonus_bonus1_1"] intValue];
    int bonus1_2 = [setting[@"huangzu_roundBonus_bonus1_2"] intValue];
    int bonus1_3 = [setting[@"huangzu_roundBonus_bonus1_3"] intValue];
    int bonus1_4 = [setting[@"huangzu_roundBonus_bonus1_4"] intValue];
    
    int bonus2_1 = [setting[@"huangzu_roundBonus_bonus2_1"] intValue];
    int bonus2_2 = [setting[@"huangzu_roundBonus_bonus2_2"] intValue];
    int bonus2_3 = [setting[@"huangzu_roundBonus_bonus2_3"] intValue];
    int bonus2_4 = [setting[@"huangzu_roundBonus_bonus2_4"] intValue];
    
    int bonus3_1 = [setting[@"huangzu_roundBonus_bonus3_1"] intValue];
    int bonus3_2 = [setting[@"huangzu_roundBonus_bonus3_2"] intValue];
    int bonus3_3 = [setting[@"huangzu_roundBonus_bonus3_3"] intValue];
    int bonus3_4 = [setting[@"huangzu_roundBonus_bonus3_4"] intValue];
    
    int bonus4_1 = [setting[@"huangzu_roundBonus_bonus4_1"] intValue];
    int bonus4_2 = [setting[@"huangzu_roundBonus_bonus4_2"] intValue];
    int bonus4_3 = [setting[@"huangzu_roundBonus_bonus4_3"] intValue];
    int bonus4_4 = [setting[@"huangzu_roundBonus_bonus4_4"] intValue];
    
    NSMutableArray* needDelete = [NSMutableArray array];
    for (NSString* userid in allPlayerRounds) {
        NSMutableDictionary* dic = allPlayerRounds[userid];
        int count1 = 0;
        int count2 = 0;
        int count3 = 0;
        int count4 = 0;
        for (NSString* betStr in dic[@"bet"]) {
            int bet = [betStr intValue]/10;
            if (bet < level1) {
                count1++;
            }
            else if(bet >= level1 && bet < level2) {
                count2++;
            }
            else if(bet >= level2 && bet < level3) {
                count3++;
            }
            else {
                count4++;
            }
        }
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        if (count1 + count2 + count3 + count4 < roundMust1 || !memData) {
            [needDelete addObject: userid];
            continue;
        }
        
        int bonus1 = 0;
        int bonus2 = 0;
        int bonus3 = 0;
        int bonus4 = 0;
        
        if (count4 >= roundMust4) {
            bonus4 = bonus4_4;
        }
        else if(count4 >= roundMust3) {
            bonus4 = bonus4_3;
        }
        else if(count4 >= roundMust2) {
            bonus4 = bonus4_2;
        }
        else if(count4 >= roundMust1) {
            bonus4 = bonus4_1;
        }
        
        if (count3+count4 >= roundMust4) {
            bonus3 = bonus3_4;
        }
        else if (count3+count4 >= roundMust3) {
            bonus3 = bonus3_3;
        }
        else if(count3+count4 >= roundMust2) {
            bonus3 = bonus3_2;
        }
        else if(count3+count4 >= roundMust1) {
            bonus3 = bonus3_1;
        }
        
        if (count2+count3+count4 >= roundMust4) {
            bonus2 = bonus2_4;
        }
        else if (count2+count3+count4 >= roundMust3) {
            bonus2 = bonus2_3;
        }
        else if(count2+count3+count4 >= roundMust2) {
            bonus2 = bonus2_2;
        }
        else if(count2+count3+count4 >= roundMust1) {
            bonus2 = bonus2_1;
        }
        
        if (count1+count2+count3+count4 >= roundMust4) {
            bonus1 = bonus1_4;
        }
        else if (count1+count2+count3+count4 >= roundMust3) {
            bonus1 = bonus1_3;
        }
        else if(count1+count2+count3+count4 >= roundMust2) {
            bonus1 = bonus1_2;
        }
        else if(count1+count2+count3+count4 >= roundMust1) {
            bonus1 = bonus1_1;
        }
        
        int bonus = MAX(MAX(MAX(bonus1, bonus2), bonus3), bonus4);
        dic[@"count1"] = deInt2String(count1);
        dic[@"count2"] = deInt2String(count2);
        dic[@"count3"] = deInt2String(count3);
        dic[@"count4"] = deInt2String(count4);
        dic[@"bonus"] = deInt2String(bonus);
    }
    
    for (NSString* userid in needDelete) {
        [allPlayerRounds removeObjectForKey: userid];
    }
    
    return allPlayerRounds;
}

//tmp, 皇族活动
-(void) queryRoundBonus: (NSString*)target diffTuo:(BOOL)diffTuo {
    if (![tmanager.mRobot.mData.mBaseSetting[@"huangzu_roundBonus_enable"] isEqualToString: @"true"]) {
        [tmanager.mRobot.mSendMsg sendText: target content:@"局数奖励命令未开启, 请联系管理。" at:nil title:@""];
        return;
    }
    NSMutableDictionary* allPlayerData = [self getAllPlayerRounds];
    NSString* title = deString(@"[%@]局数奖励%@.xls", tmanager.mRobot.mQueryDate, diffTuo ? @"(区分)" : @"");
    NSData* data = [niuniuRobotExcelHelper makeRoundsBonus: allPlayerData diffTuo: diffTuo];
    [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
}

-(NSString*) exeRoundBonus:(NSString*)sayerUserid sayerName:(NSString*)sayerName isCancel:(BOOL)isCancel {
    if (![tmanager.mRobot.mData.mBaseSetting[@"huangzu_roundBonus_enable"] isEqualToString: @"true"]) {
        return @"局数奖励命令未开启, 请联系管理。";
    }
    NSMutableDictionary* allPlayerRounds = [self getAllPlayerRounds];
    NSArray* allPlayerDataArr = [allPlayerRounds allValues];
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
    [players sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"bonus"] intValue] > [b[@"bonus"] intValue] ? -1 : 1;
    }];
    [tuos sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"bonus"] intValue] > [b[@"bonus"] intValue] ? -1 : 1;
    }];
    
    int playerBonusCount = 0;
    for (NSDictionary* dic in players) {
        playerBonusCount += [dic[@"bonus"] intValue];
    }
    
    int tuoBonusCount = 0;
    for (NSDictionary* dic in tuos) {
        tuoBonusCount += [dic[@"bonus"] intValue];
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", tmanager.mRobot.mQueryDate];
    [text appendString: [self addTitle: deString(@"%@局数奖励", isCancel ? @"取消" : @"")]];
    [text appendFormat: @"玩家人数: %d\n", (int)[players count]];
    [text appendFormat: @"总奖励: %d\n", playerBonusCount];
    [text appendString: @"──────────\n"];
    for (NSDictionary* dic in players) {
        NSString* userid = dic[@"userid"];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        [text appendFormat: @"%@. %@　%@%@\n", memData[@"index"], deFillName(memData[@"billName"]), isCancel ? @"下" : @"上", dic[@"bonus"]];
        [tmanager.mRobot.mMembers addScore:dic[@"userid"] score:[dic[@"bonus"] intValue] * (isCancel ? -1 : 1) isSet:NO
                              params:@{
                                       @"type":@"roundBonus",
                                       @"donotAutoSave" : @"true",
                                       @"fromUserid":sayerUserid,
                                       @"fromName":sayerName
                                       }];
    }
    [text appendString: @"──────────\n"];
    [text appendFormat: @"托人数: %d\n", (int)[tuos count]];
    [text appendFormat: @"总奖励: %d\n", tuoBonusCount];
    [text appendString: @"──────────\n"];
    for (NSDictionary* dic in tuos) {
        NSString* userid = dic[@"userid"];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        [text appendFormat: @"%@. %@　%@%@\n", memData[@"index"], deFillName(memData[@"billName"]), isCancel ? @"下" : @"上", dic[@"bonus"]];
        [tmanager.mRobot.mMembers addScore:dic[@"userid"] score:[dic[@"bonus"] intValue] * (isCancel ? -1 : 1) isSet:NO
                              params:@{
                                       @"type":@"roundBonus",
                                       @"donotAutoSave" : @"true",
                                       @"fromUserid":sayerUserid,
                                       @"fromName":sayerName
                                       }];
    }
    [tmanager.mRobot.mData saveMemberListFile];
    [tmanager.mRobot.mData saveScoreChangedRecordsFile];
    return text;
}

//统计集齐奖励
-(void) countCollectBonus:(NSDictionary*)allPlayerData {
    NSMutableArray* configs = [NSMutableArray array];
    NSArray* keys = @[
                      @[@"collectBonusNiuniuNum", @"collectBonusNiuniuMustNotSame", @"niuniuArr", @"niuniuArr2", @"niuniu"],
                      @[@"collectBonusJinniuNum", @"collectBonusJinniuMustNotSame", @"jinniuArr", @"jinniuArr2", @"jinniu"],
                      @[@"collectBonusDuiziNum", @"collectBonusDuiziMustNotSame", @"duiziArr", @"duiziArr2", @"duizi"],
                      @[@"collectBonusShunziNum", @"collectBonusShunziMustNotSame", @"shunziArr", @"shunziArr2", @"shunzi"],
                      @[@"collectBonusDaoshunNum", @"collectBonusDaoshunMustNotSame", @"daoshunArr", @"daoshunArr2", @"daoshun"],
                      @[@"collectBonusManniuNum", @"collectBonusManniuMustNotSame", @"manniuArr", @"manniuArr2", @"manniu"],
                      @[@"collectBonusBaoziNum", @"collectBonusBaoziMustNotSame", @"baoziArr", @"baoziArr2", @"baozi"],
                      ];
    for (NSArray* key in keys) {
        NSString* str = tmanager.mRobot.mData.mBaseSetting[key[0]];
        if (![str isEqualToString: @""]) {
            NSArray* arr = [str componentsSeparatedByString: @"-"];
            NSString* betsKey;
            if ([tmanager.mRobot.mData.mBaseSetting[key[1]] isEqualToString: @"true"]) {
                betsKey = key[3];
            } else {
                betsKey = key[2];
            }
            [configs addObject: @{
                                  @"cardNum" : arr[0],
                                  @"bonusBase" : arr[1],
                                  @"bonusMore" : arr[2],
                                  @"betsKey" : betsKey,
                                  @"type" : key[4]
                                  }];
        }
    }
    
    BOOL collectBonusBetUseAverage = [tmanager.mRobot.mData.mBaseSetting[@"collectBonusBetUseAverage"] isEqualToString: @"true"];
    
    NSArray* players = [allPlayerData allValues];
    for (NSMutableDictionary* player in players) {
        NSMutableDictionary* collectBonusDetails = [NSMutableDictionary dictionary];
        int collectBonus = 0;
        for (NSDictionary* config in configs) {
            NSMutableArray* bets = [NSMutableArray array];
            NSMutableString* betDetailStr = [NSMutableString string];
            NSArray* cardArr = player[config[@"betsKey"]];
            for (NSArray* arr in cardArr) {
                [bets addObject: arr[1]];
                if (betDetailStr.length > 0) {
                    [betDetailStr appendString: @" / "];
                }
                [betDetailStr appendFormat: @"%.2f押%@", [arr[0] floatValue]/100, arr[1]];
            }
            int hasNum = (int)[bets count];
            int needNum = [config[@"cardNum"] intValue];
            if (hasNum >= needNum) {
                int betCount = 0;
                int minBet = -1;
                for (NSString* betStr in bets) {
                    int bet = [betStr intValue];
                    if (-1 == minBet || bet < minBet) {
                        minBet = bet;
                    }
                    betCount += bet;
                }
                int averageBet = betCount/hasNum;
                
                int baseBonus = 0;
                int moreBonus = 0;
                
                baseBonus = [self bet2collectBonus: collectBonusBetUseAverage ? averageBet : minBet sourceBonus: [config[@"bonusBase"] intValue]];
                for (int i = 0; i < (hasNum-needNum); ++i) {
                    moreBonus += [self bet2collectBonus: [bets[i+needNum] intValue] sourceBonus: [config[@"bonusMore"] intValue]];
                }
                
                NSString* cardType = config[@"type"];
                collectBonusDetails[cardType] = @{
                                                  @"hasNum" : deInt2String(hasNum),
                                                  @"minBet" : deInt2String(minBet),
                                                  @"averageBet" : deInt2String(averageBet),
                                                  @"baseBonus" : deInt2String(baseBonus),
                                                  @"moreBonus" : deInt2String(moreBonus),
                                                  @"betDetailStr" : betDetailStr
                                                  };
                collectBonus += baseBonus + moreBonus;
            }
        }
        player[@"collectBonusDetails"] = collectBonusDetails;
        player[@"collectBonus"] = deInt2String(collectBonus);
    }
}

//集齐奖励比例计算
-(int) bet2collectBonus: (int)bet sourceBonus:(int)sourceBonus{
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    for (int i = 1; i <= 5; ++i) {
        NSString* key = deString(@"collectBonusRatio%d", i);
        if ([setting[key] isEqualToString: @""]) {
            break;
        }
        NSArray* array = [setting[key] componentsSeparatedByString: @"-"];
        if (bet >= [array[0] intValue] && bet <= [array[1] intValue]) {
            return sourceBonus*[array[2] floatValue];
        }
    }
    return 0;
}

//查集齐奖励
-(void) queryCollectBonus: (NSString*)target diffTuo:(BOOL)diffTuo{
    if (![tmanager.mRobot.mData.mBaseSetting[@"collectBonusEnable"] isEqualToString: @"true"]) {
        [tmanager.mRobot.mSendMsg sendText: target content:@"集齐奖励命令未开启, 请联系管理。" at:nil title:@""];
        return;
    }
    NSMutableDictionary* allPlayerData = [self allPlayerData];
    [self countCollectBonus: allPlayerData];
    NSString* title = deString(@"[%@]集齐奖励%@.xls", tmanager.mRobot.mQueryDate, diffTuo ? @"(区分)" : @"");
    NSData* data = [niuniuRobotExcelHelper makeCollectBonus: allPlayerData diffTuo: diffTuo];
    [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
}

//执行集齐奖励
-(NSString*) exeCollectBonus:(NSString*)sayerUserid sayerName:(NSString*)sayerName isCancel:(BOOL)isCancel {
    if (![tmanager.mRobot.mData.mBaseSetting[@"collectBonusEnable"] isEqualToString: @"true"]) {
        return @"集齐奖励命令未开启, 请联系管理。";
    }
    
    NSMutableDictionary* allPlayerData = [self allPlayerData];
    [self countCollectBonus: allPlayerData];
    NSArray* allPlayerDataArr = [allPlayerData allValues];
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
    [players sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"collectBonus"] intValue] > [b[@"collectBonus"] intValue] ? -1 : 1;
    }];
    [tuos sortUsingComparator: ^NSComparisonResult(NSDictionary* a, NSDictionary* b) {
        return [a[@"collectBonus"] intValue] > [b[@"collectBonus"] intValue] ? -1 : 1;
    }];
    
    int playerBonusCount = 0;
    for (NSDictionary* dic in players) {
        playerBonusCount += [dic[@"collectBonus"] intValue];
    }
    
    int tuoBonusCount = 0;
    for (NSDictionary* dic in tuos) {
        tuoBonusCount += [dic[@"collectBonus"] intValue];
    }
    
    NSMutableString* text = [NSMutableString string];
    [text appendFormat: @"%@\n", tmanager.mRobot.mQueryDate];
    [text appendString: [self addTitle: deString(@"%@集齐奖励", isCancel ? @"取消" : @"")]];
    [text appendFormat: @"玩家人数: %d\n", (int)[players count]];
    [text appendFormat: @"总奖励: %d\n", playerBonusCount];
    [text appendString: @"──────────\n"];
    for (NSDictionary* dic in players) {
        NSString* userid = dic[@"userid"];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        [text appendFormat: @"%@. %@　%@%@\n", memData[@"index"], deFillName(memData[@"billName"]), isCancel ? @"下" : @"上", dic[@"collectBonus"]];
        [tmanager.mRobot.mMembers addScore:dic[@"userid"] score:[dic[@"collectBonus"] intValue] * (isCancel ? -1 : 1) isSet:NO
                              params:@{
                                       @"type":@"collectBonus",
                                       @"donotAutoSave" : @"true",
                                       @"fromUserid":sayerUserid,
                                       @"fromName":sayerName
                                       }];
    }
    [text appendString: @"──────────\n"];
    [text appendFormat: @"托人数: %d\n", (int)[tuos count]];
    [text appendFormat: @"总奖励: %d\n", tuoBonusCount];
    [text appendString: @"──────────\n"];
    for (NSDictionary* dic in tuos) {
        NSString* userid = dic[@"userid"];
        NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
        [text appendFormat: @"%@. %@　%@%@\n", memData[@"index"], deFillName(memData[@"billName"]), isCancel ? @"下" : @"上", dic[@"collectBonus"]];
        [tmanager.mRobot.mMembers addScore:dic[@"userid"] score:[dic[@"collectBonus"] intValue] * (isCancel ? -1 : 1) isSet:NO
                              params:@{
                                       @"type":@"collectBonus",
                                       @"donotAutoSave" : @"true",
                                       @"fromUserid":sayerUserid,
                                       @"fromName":sayerName
                                       }];
    }
    [tmanager.mRobot.mData saveMemberListFile];
    [tmanager.mRobot.mData saveScoreChangedRecordsFile];
    return text;
}

//查修改
-(void) chaxiugai: (NSString*)target day:(int)day{
    if (0 == day) {
        NSMutableArray* array = [NSMutableArray array];
        BOOL finded = NO;
        for (int i = (int)[tmanager.mRobot.mData.mReworksList count]-1; i >= 0; --i) {
            NSDictionary* dic = tmanager.mRobot.mData.mReworksList[i];
            NSString* timeStr = [ycFunction getFormatTimeStr:[NSDate dateWithTimeIntervalSince1970: [dic[@"time"] longLongValue]] format:@"YYYY-MM-dd"];
            if (![timeStr hasPrefix: tmanager.mRobot.mQueryDate]) {
                if (finded) {
                    break;
                }
                continue;
            }
            finded = YES;
            
            [array addObject: dic];
        }
        NSString* title = deString(@"[%@]操作人员修改操作.xls", tmanager.mRobot.mQueryDate);
        NSData* data = [niuniuRobotExcelHelper makeRobotReworks: array];
        [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
    } else {
        NSDateFormatter* objDateformat = [[[NSDateFormatter alloc] init] autorelease];
        [objDateformat setDateFormat:@"YYYY-MM-dd"];
        NSDate* date = [objDateformat dateFromString: [ycFunction getTodayDate]];
        long long begintime = [date timeIntervalSince1970] - (day-1)*24*60*60;
        NSMutableArray* array = [NSMutableArray array];
        for (int i = (int)[tmanager.mRobot.mData.mReworksList count]-1; i >= 0; --i) {
            NSDictionary* dic = tmanager.mRobot.mData.mReworksList[i];
            if ([dic[@"time"] longLongValue] >= begintime) {
                [array addObject: dic];
            } else {
                break;
            }
        }
        NSString* title = deString(@"操作人员最近%d天修改操作.xls", day);
        NSData* data = [niuniuRobotExcelHelper makeRobotReworks: array];
        [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
    }
}

//查点数
-(void) chadianshu: (NSString*)target {
    NSMutableDictionary* players = [NSMutableDictionary dictionary];
    NSMutableDictionary* tuos = [NSMutableDictionary dictionary];
    NSMutableDictionary* bankers = [NSMutableDictionary dictionary];
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        for (NSDictionary* player in dic[@"bankers"]) {
            if ([player[@"isMain"] isEqualToString: @"true"]) {
                if ([player[@"resultHandle"] isEqualToString: @"normal"]) {
                    NSMutableArray* values = bankers[player[@"userid"]];
                    if (!values) {
                        values = [NSMutableArray array];
                        bankers[player[@"userid"]] = values;
                    }
                    [values addObject: @[player[@"pow"], player[@"amount"], player[@"winOrLoseFact"]]];
                }
            }
        }
        
        for (NSDictionary* player in dic[@"players"]) {
            if ([player[@"resultType"] isEqualToString: @"normal"] || [player[@"resultType"] isEqualToString: @"timeover"]) {
                NSMutableDictionary* saveDic = nil;
                if ([tmanager.mRobot.mTuos isTuo: player[@"userid"]]) {
                    saveDic = tuos;
                } else {
                    saveDic = players;
                }
                
                NSMutableArray* values = saveDic[player[@"userid"]];
                if (!values) {
                    values = [NSMutableArray array];
                    saveDic[player[@"userid"]] = values;
                }
                [values addObject: @[player[@"pow"], player[@"amount"], player[@"winOrLoseFact"]]];
            }
        }
    }
    
    NSString* title = deString(@"[%@]点数统计.xls", tmanager.mRobot.mQueryDate);
    NSData* data = [niuniuRobotExcelHelper makeAmountCount: bankers players:players tuos:tuos];
    [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
}
    
//查庄同点杀概率
-(void) chatongdianzhuangshagailv:(NSString*)target pow:(int)pow {
    NSMutableArray* lists = [NSMutableArray array];
    
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mRounds count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mRounds[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        NSDictionary* banker;
        int bankerAmount;
        int bankerPow = 0;
        for (NSDictionary* player in dic[@"bankers"]) {
            if ([player[@"isMain"] isEqualToString: @"true"]) {
                if ([player[@"resultHandle"] isEqualToString: @"asLast"] || [player[@"resultHandle"] isEqualToString: @"normal"]) {
                    bankerAmount = [player[@"amount"] intValue];
                    bankerPow = [player[@"pow"] intValue];
                    banker = player;
                }
            }
        }
        
        if (bankerPow == 0 || bankerPow > pow) {
            continue;
        }
        
        for (NSDictionary* player in dic[@"players"]) {
            if ([player[@"betType"] isEqualToString: @"niuniu"]) {
                if ([player[@"resultHandle"] isEqualToString: @"asLast"] || [player[@"resultHandle"] isEqualToString: @"normal"]) {
                    if (bankerAmount > [player[@"amount"] intValue]) {
                        continue;
                    }
                    int playerPow = [player[@"pow"] intValue];
                    if (bankerPow == playerPow) {
                        BOOL suoha = player[@"suoha"] && [player[@"suoha"] isEqualToString: @"true"];
                        BOOL mianyong = player[@"mianyong"] && [player[@"mianyong"] isEqualToString: @"true"];
                        BOOL yibi = player[@"yibi"] && [player[@"yibi"] isEqualToString: @"true"];
                        NSString* betStr = deString(@"%@%@", mianyong ? @"免" : yibi ? @"一比" : suoha ? @"梭" : @"下", player[@"num"]);
                        NSString* playerAmount = deString(@"%.2f", [player[@"amount"] intValue]/100.0);
                        int bet = [player[@"num"] intValue];
                        int win = 0;
                        if ([player[@"suoha"] isEqualToString: @"true"]) {
                            win = [banker[@"powFactBankerSuoha"] floatValue]*bet;
                        } else if ([player[@"mianyong"] isEqualToString: @"true"]) {
                            win = [banker[@"powFactBankerMianyong"] floatValue]*bet;
                        } else if ([player[@"yibi"] isEqualToString: @"true"]) {
                            win = [banker[@"powFactBankerYibi"] floatValue]*bet;
                        } else {
                            win = [banker[@"powFactBanker"] floatValue]*bet;
                        }
                        [lists addObject: @{
                                            @"round" : dic[@"number"],
                                            @"bankerUserid" : banker[@"userid"],
                                            @"bankerCard" : [niuniu pow2string: bankerPow],
                                            @"bankerAmount" : deString(@"%.2f", bankerAmount/100.0),
                                            @"playerUserid" : player[@"userid"],
                                            @"playerAmount" : playerAmount,
                                            @"betStr" : betStr,
                                            @"betNum" : deInt2String(suoha ? bet/10 : bet),
                                            @"win" : deInt2String(win),
                                            }];
                    }
                }
            }
        }
    }
    
    
    NSString* title = deString(@"[%@]同点庄杀概率.xls", tmanager.mRobot.mQueryDate);
    NSData* data = [niuniuRobotExcelHelper makeBankerSamePowCount: lists];
    [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
}


//查所有上下分明细
-(void) chasuoyoushangxiafenmingxi: (NSString*)target {
    NSMutableArray* array = [NSMutableArray array];
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        [array addObject: dic];
    }
    NSString* title = deString(@"[%@]所有上下分明细.xls", tmanager.mRobot.mQueryDate);
    NSData* data = [niuniuRobotExcelHelper makeAllScoreChangedDetails: array];
    [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
}

//查所有群上下分
-(void) chasuoyouqunshangxiafen: (NSString*)target {
    NSMutableDictionary* allChatroom = [NSMutableDictionary dictionary];
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: tmanager.mRobot.mQueryDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        if (dic[@"chatroom"]) {
            NSMutableArray* array = allChatroom[dic[@"chatroom"]];
            if (!array) {
                array = [NSMutableArray array];
                allChatroom[dic[@"chatroom"]] = array;
                
            }
            [array addObject: dic];
        }
    }
    NSString* title = deString(@"[%@]所有群上下分.xls", tmanager.mRobot.mQueryDate);
    NSData* data = [niuniuRobotExcelHelper makeAllChatroomScoreChanged: allChatroom];
    [tmanager.mRobot.mSendMsg sendFile: target title: title ext: @"xls" data:data];
}

//清理档案
-(void) qinglidangan:(NSString*)target {
    NSMutableDictionary* whiteList = [NSMutableDictionary dictionary];
    NSMutableDictionary* cleanPlayerList = [NSMutableDictionary dictionary];
    NSMutableDictionary* cleanTuoList = [NSMutableDictionary dictionary];
    NSMutableDictionary* cleanLashouMembersList = [NSMutableDictionary dictionary];
    NSMutableDictionary* cleanLashouList = [NSMutableDictionary dictionary];
    NSMutableDictionary* cleanLashouHeadMemberList = [NSMutableDictionary dictionary];
    NSMutableDictionary* cleanLashouHeadList = [NSMutableDictionary dictionary];
    
    for (NSDictionary* dic in tmanager.mRobot.mData.mRounds) {
        for (NSDictionary* player in dic[@"bankers"]) {
            whiteList[player[@"userid"]] = @"true";
        }
        for (NSDictionary* player in dic[@"players"]) {
            whiteList[player[@"userid"]] = @"true";
        }
    }
    for (NSDictionary* dic in tmanager.mRobot.mData.mScoreChangedRecords) {
        whiteList[dic[@"userid"]] = @"true";
        if (dic[@"fromUserid"]) {
            whiteList[dic[@"fromUserid"]] = @"true";
        }
    }
    for (NSString* userid in tmanager.mRobot.mData.mAdminList) {
        whiteList[userid] = @"true";
    }
    for (NSDictionary* dic in tmanager.mRobot.mData.mReworksList) {
        if (dic[@"userid"]) {
            whiteList[dic[@"userid"]] = @"true";
        }
        if (dic[@"admin"]) {
            whiteList[dic[@"admin"]] = @"true";
        }
    }
    
    long long curTime = [[ycFunction getCurrentTimestamp] longLongValue];
    NSArray* allMembers = [tmanager.mRobot.mData.mMemberList allValues];
    for (NSDictionary* memData in allMembers) {
        if (memData[@"addTime"]) {
            if (llabs(curTime - [memData[@"addTime"] longLongValue]) < 60*60*24*3) {//加会员不到3天
                continue;
            }
        }
        if ([memData[@"score"] intValue] > 0) {
            continue;
        }
        NSString* userid = memData[@"userid"];
        if (whiteList[userid]) {
            continue;
        }
        cleanPlayerList[userid] = @"true";
    }
    
    for (NSString* userid in tmanager.mRobot.mData.mTuoList) {
        if (cleanPlayerList[userid]) {
            cleanTuoList[userid] = @"true";
        }
    }
    
    for (NSString* lashouUserid in tmanager.mRobot.mData.mLashouList) {
        NSDictionary* lashouMembers = tmanager.mRobot.mData.mLashouList[lashouUserid];
        NSMutableDictionary* needCleanList = [NSMutableDictionary dictionary];
        for (NSString* userid in lashouMembers) {
            if (cleanPlayerList[userid]) {
                needCleanList[userid] = @"true";
            }
        }
        if ([needCleanList count] == [lashouMembers count] && cleanPlayerList[lashouUserid]) {
            cleanLashouList[lashouUserid] = @"true";
        } else {
            if ([needCleanList count] > 0) {
                cleanLashouMembersList[lashouUserid] = needCleanList;
            }
        }
    }
    
    for (NSString* lashouHeadUserid in tmanager.mRobot.mData.mLashouHeadList) {
        NSDictionary* lashouHeadMembers = tmanager.mRobot.mData.mLashouHeadList[lashouHeadUserid];
        NSMutableDictionary* needCleanList = [NSMutableDictionary dictionary];
        for (NSString* userid in lashouHeadMembers) {
            if (cleanLashouList[userid]) {
                needCleanList[userid] = @"true";
            }
        }
        if ([needCleanList count] == [lashouHeadMembers count] && cleanPlayerList[lashouHeadUserid]) {
            cleanLashouHeadList[lashouHeadUserid] = @"true";
        } else {
            if ([needCleanList count] > 0) {
                cleanLashouHeadMemberList[lashouHeadUserid] = needCleanList;
            }
        }
    }
    
    int cleanLashouHeadMemberCount = 0;
    int cleanLashouMemberCount = 0;
    {//清理拉手、拉手团长、托
        for (NSString* userid in cleanLashouHeadList) {
            [tmanager.mRobot.mData.mLashouHeadList removeObjectForKey: userid];
        }
        for (NSString* lashouHeadUserid in cleanLashouHeadMemberList) {
            NSDictionary* lashous = cleanLashouHeadMemberList[lashouHeadUserid];
            for (NSString* userid in lashous) {
                [tmanager.mRobot.mData.mLashouHeadList[lashouHeadUserid] removeObjectForKey: userid];
                cleanLashouHeadMemberCount++;
            }
        }
        [tmanager.mRobot.mData saveLashouHeadListFile];
        
        for (NSString* userid in cleanLashouList) {
            [tmanager.mRobot.mData.mLashouList removeObjectForKey: userid];
        }
        for (NSString* lashouUserid in cleanLashouMembersList) {
            NSDictionary* players = cleanLashouMembersList[lashouUserid];
            for (NSString* userid in players) {
                [tmanager.mRobot.mData.mLashouList[lashouUserid] removeObjectForKey: userid];
                cleanLashouMemberCount++;
            }
        }
        [tmanager.mRobot.mData saveLashouListFile];
        
        for (NSString* userid in cleanTuoList) {
            [tmanager.mRobot.mData.mTuoList removeObjectForKey: userid];
        }
        [tmanager.mRobot.mData saveTuoListFile];
    }
    
    {//如果是拉手或拉手团长，会员档案不能删
        for (NSString* lashouUserid in tmanager.mRobot.mData.mLashouHeadList) {
            if (cleanPlayerList[lashouUserid]) {
                [cleanPlayerList removeObjectForKey: lashouUserid];
            }
        }
        
        for (NSString* lashouUserid in tmanager.mRobot.mData.mLashouList) {
            if (cleanPlayerList[lashouUserid]) {
                [cleanPlayerList removeObjectForKey: lashouUserid];
            }
        }
    }
    
    NSMutableString* text = [NSMutableString string];
    
    [text appendString: [self addTitle: @"统计"]];
    [text appendFormat: @"清理团长%d个\n", (int)[cleanLashouHeadList count]];
    [text appendFormat: @"清理团长归属%d个\n", cleanLashouHeadMemberCount];
    [text appendFormat: @"清理拉手%d个\n", (int)[cleanLashouList count]];
    [text appendFormat: @"清理拉手归属%d个\n", cleanLashouMemberCount];
    [text appendFormat: @"清理托%d个\n", (int)[cleanTuoList count]];
    [text appendFormat: @"清理会员%d个\n", (int)[cleanPlayerList count]];
    
    if ([cleanLashouHeadList count] > 0) {
        [text appendString: [self addTitle: @"清理团长"]];
        for (NSString* userid in cleanLashouHeadList) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                [text appendFormat: @"%@. %@\n", memData[@"index"], memData[@"billName"]];
            } else {
                [text appendFormat: @"%@\n", userid];
            }
        }
    }
    
    if (cleanLashouHeadMemberCount > 0) {
        [text appendString: [self addTitle: @"清理团长归属"]];
        for (NSString* userid in cleanLashouHeadMemberList) {
            NSDictionary* lashous = cleanLashouHeadMemberList[userid];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                [text appendFormat: @"%@. %@  %d个\n", memData[@"index"], memData[@"billName"], (int)[lashous count]];
            } else {
                [text appendFormat: @"%@  %d个\n", userid, (int)[lashous count]];
            }
        }
    }
    
    if ([cleanLashouList count] > 0) {
        [text appendString: [self addTitle: @"清理拉手"]];
        for (NSString* userid in cleanLashouList) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                [text appendFormat: @"%@. %@\n", memData[@"index"], memData[@"billName"]];
            } else {
                [text appendFormat: @"%@\n", userid];
            }
        }
    }
    
    if (cleanLashouMemberCount > 0) {
        [text appendString: [self addTitle: @"清理拉手归属"]];
        for (NSString* userid in cleanLashouMembersList) {
            NSDictionary* players = cleanLashouMembersList[userid];
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                [text appendFormat: @"%@. %@  %d个\n", memData[@"index"], memData[@"billName"], (int)[players count]];
            } else {
                [text appendFormat: @"%@  %d个\n", userid, (int)[players count]];
            }
        }
    }
    
    if ([cleanTuoList count] > 0) {
        [text appendString: [self addTitle: @"清理托"]];
        for (NSString* userid in cleanTuoList) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                [text appendFormat: @"%@. %@\n", memData[@"index"], memData[@"billName"]];
            } else {
                [text appendFormat: @"%@\n", userid];
            }
        }
    }
    
    if ([cleanPlayerList count] > 0) {
        [text appendString: [self addTitle: @"清理会员"]];
        for (NSString* userid in cleanPlayerList) {
            NSDictionary* memData = [tmanager.mRobot.mMembers getMember: userid];
            if (memData) {
                [text appendFormat: @"%@. %@\n", memData[@"index"], memData[@"billName"]];
            } else {
                [text appendFormat: @"%@\n", userid];
            }
        }
    }
    
    {//删除会员
        for (NSString* userid in cleanPlayerList) {
            [tmanager.mRobot.mData.mMemberList removeObjectForKey: userid];
        }
        [tmanager.mRobot.mData saveMemberListFile];
    }
    
    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [tmanager.mRobot.mSendMsg addTask:target type: @"txt" title: @"清理档案.txt" content:nil data:data image:nil at:nil];
}

@end
