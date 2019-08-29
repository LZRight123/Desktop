//
//  wechatHook.m
//  wechatHook
//
//  Created by antion on 16/11/11.
//  Copyright (c) 2016年 __MyCompanyName__. All rights reserved.
//

#import "CaptainHook.h"
#import <UIKit/UIKit.h>
#import "toolManager.h"
#import "ycFunction.h"
#import "wxFunction.h"
#import "JSON.h"
#import "wechatHeaders.h"
#import "ForgeIdentifier.h"

static bool startHookBundleID = false;

#pragma mark- CMessageMgr

CHDeclareClass(CMessageMgr);

CHMethod(4, void, CMessageMgr, AddAppMsg, id, arg1, MsgWrap, id, arg2, Data, id, arg3, Scene, unsigned int, arg4) {
//    NSLog(@"################### CMessageMgr -> AddAppMsg: %@, %@, %@, %d", arg1, arg2, arg3, arg4);
    CHSuper4(CMessageMgr, AddAppMsg, arg1, MsgWrap, arg2, Data, arg3, Scene, arg4);
}

CHMethod(2, void, CMessageMgr, AsyncOnAddMsg, id, arg1, MsgWrap, id, arg2)
{
//    NSLog(@"############# CMessageMgr AsyncOnAddMsg: %@, %@", arg1, arg2);
//护群--------------------------------------------------------------------------------
    NSString* fromUsr = [ycFunction getVar:arg2 name: @"m_nsFromUsr"];
    if ([fromUsr containsString: @"@chatroom"] && ![tmanager.mRobot isBackroundRoom: fromUsr]) {
        int m_uiMessageType = [ycFunction getVarInt: arg2 name: @"m_uiMessageType"];
        if (1 == m_uiMessageType || 49 == m_uiMessageType) {
            NSString* m_nsContent = [ycFunction getVar: arg2 name: @"m_nsContent"];
            if ([m_nsContent length] > 200 && 1 == m_uiMessageType) {
                [ycFunction setVarInt:arg2 name:@"m_uiMessageType" value:1];
                [ycFunction setVar:arg2 name:@"m_nsContent" value:@"❌机器自动屏蔽过长字符❌"];
            } else {
                BOOL containsSpecialStr = [ycFunction containsSpecialStr: m_nsContent];
                if (containsSpecialStr) {
                    [ycFunction setVarInt:arg2 name:@"m_uiMessageType" value:1];
                    [ycFunction setVar:arg2 name:@"m_nsContent" value:@"❌机器自动屏蔽特殊字符❌"];
                }
            }
        }
//        else {
//            NSLog(@"######### %d, %@", m_uiMessageType, m_nsContent);
//        }
    }
//护群--------------------------------------------------------------------------------

    CHSuper(2, CMessageMgr, AsyncOnAddMsg, arg1, MsgWrap, arg2);
    
    [tmanager asyncOnAddMsg:arg1 arg2:arg2];
}

CHOptimizedMethod(1, self, void, CMessageMgr, onRevokeMsg, id, arg1) {
//    NSLog(@"############# CMessageMgr onRevokeMsg: %@", arg1);
    
    CHSuper(1, CMessageMgr, onRevokeMsg, arg1);
    
    [tmanager onRevokeMsg: arg1];
}

CHMethod(2, void, CMessageMgr, AddMsg, id, arg1, MsgWrap, id, arg2)
{
    NSLog(@"############# CMessageMgr AddMsg: %@, %@", arg1, arg2);
    
    CHSuper(2, CMessageMgr, AddMsg, arg1, MsgWrap, arg2);
}

#pragma mark- BaseMsgContentLogicController

CHDeclareClass(BaseMsgContentLogicController);

CHMethod(1, void, BaseMsgContentLogicController, SendTextMessage, id, arg1)
{
    CHSuper(1, BaseMsgContentLogicController, SendTextMessage, arg1);
}

#pragma mark- MicroMessengerAppDelegate

CHDeclareClass(MicroMessengerAppDelegate);

CHOptimizedMethod2(self, void, MicroMessengerAppDelegate, application, UIApplication *, application, didFinishLaunchingWithOptions, NSDictionary *, options) {
    NSLog(@"appcation lauching 哈哈哈啊哈哈😄😄");
    
    CHSuper2(MicroMessengerAppDelegate, application, application, didFinishLaunchingWithOptions, options);
    startHookBundleID = true;
}

//#pragma mark- ManualAuthAesReqData
//
//CHDeclareClass(ManualAuthAesReqData);
//
//CHMethod(1, void, ManualAuthAesReqData, setBundleId, NSString*, args1) {
//    NSLog(@"ManualAuthAesReqData - setBundleId(): %@", args1);
//
//    CHSuper(1, ManualAuthAesReqData, setBundleId, @"com.tencent.xin");
//}

#pragma mark- NSBundle

CHDeclareClass(NSBundle);

//CHMethod(0, NSString*, NSBundle, bundleIdentifier) {
//    //    NSLog(@"NSBundle - bundleIdentifier");
//    
//    NSString* bundleId = CHSuper(0, NSBundle, bundleIdentifier);
//    if ([bundleId hasPrefix: @"com.antion.wechatEx"] && startHookBundleID) {
//        return @"com.tencent.xin";
//    }
//    return bundleId;
//}

CHMethod(0, NSDictionary*, NSBundle, infoDictionary) {
//    NSLog(@"NSBundle - infoDictionary");
    NSDictionary* infoDic = CHSuper(0, NSBundle, infoDictionary);
    NSMutableDictionary* dic = [[infoDic mutableCopy] autorelease];
    if (dic[@"CFBundleIdentifier"] && [dic[@"CFBundleIdentifier"] hasPrefix:@"com.antion.wechatEx"] && startHookBundleID) {
        dic[@"CFBundleIdentifier"] = @"com.tencent.xin";
    }
    return dic;
}

#pragma mark- WCRedEnvelopesLogicMgr

CHDeclareClass(WCRedEnvelopesLogicMgr);

CHMethod(1, void, WCRedEnvelopesLogicMgr, QueryRedEnvelopesDetailRequest, id, arg1)
{
    CHSuper(1, WCRedEnvelopesLogicMgr, QueryRedEnvelopesDetailRequest, arg1);
    
    NSLog(@"############# QueryRedEnvelopesDetailRequest: %@", arg1);
}

CHMethod(1, void, WCRedEnvelopesLogicMgr, ReceiverQueryRedEnvelopesRequest, id, arg1)
{
    CHSuper(1, WCRedEnvelopesLogicMgr, ReceiverQueryRedEnvelopesRequest, arg1);
    
//    NSLog(@"############# ReceiverQueryRedEnvelopesRequest: %@", arg1);
}

CHMethod(3, void, WCRedEnvelopesLogicMgr, GetHongbaoBusinessRequest, id, arg1, CMDID, unsigned int, arg2, OutputType, unsigned int, arg3)
{
//        NSLog(@"############# GetHongbaoBusinessRequest, %@, %d, %d", arg1, arg2, arg3);
    
    CHSuper(3, WCRedEnvelopesLogicMgr, GetHongbaoBusinessRequest, arg1, CMDID, arg2, OutputType, arg3);
}

CHMethod(2, void, WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, id, arg1, Request, id, arg2)
{
//    NSLog(@"############# OnWCToHongbaoCommonResponse, %@, %@", arg1, arg2);
//
    HongBaoRes* hongbaores = arg1;
    if (tmanager.mRobot && [tmanager.mRobot.mData.mBaseSetting[@"forceOpenHongbao"] isEqualToString: @"true"] && 3 == hongbaores.cgiCmdid) {
        NSDictionary* testDic = @{
                                  @"sendNick":@"",
                                  @"statusMess":@"",
                                  @"wishing":@"#过封号强制点包#",
                                  @"retcode":@0,
                                  @"retmsg":@"ok",
                                  @"sendId":@"",
                                  @"sendHeadImg":@"",
                                  @"isSender":@1,
                                  @"receiveStatus":@0,
                                  @"hbStatus":@2,
                                  @"hbType":@1,
                                  @"watermark":@"",
                                  @"timingIdentifier":@""
                                  };
        NSString* testStr = [testDic JSONFragment];
        NSData* testData = [testStr dataUsingEncoding: NSUTF8StringEncoding];
        SKBuiltinBuffer_t* buffer = hongbaores.retText;
        buffer.buffer = testData;
        buffer.iLen = (int)[testData length];
        hongbaores.errorMsg = @"ok";
        hongbaores.errorType = 0;
    }
    CHSuper(2, WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, arg1, Request, arg2);
}


#pragma mark- WCRedEnvelopesControlMgr

CHDeclareClass(WCRedEnvelopesControlMgr);

CHMethod(2, unsigned int, WCRedEnvelopesControlMgr, startSendEnvelopesReceivedListLogic, id, arg1, Data, id, arg2)
{
//    NSLog(@"############# startSendEnvelopesReceivedListLogic: %@, %@", arg1, arg2);
    
    return CHSuper(2, WCRedEnvelopesControlMgr, startSendEnvelopesReceivedListLogic, arg1, Data, arg2);
}

CHMethod(2, unsigned int, WCRedEnvelopesControlMgr, startOpenRedEnvelopesDetail, id, arg1, sendId, id, arg2)
{
//    NSLog(@"############# startOpenRedEnvelopesDetail: %@, %@", arg1, arg2);
    
    return CHSuper(2, WCRedEnvelopesControlMgr, startOpenRedEnvelopesDetail, arg1, sendId, arg2);
}

CHMethod(2, unsigned int, WCRedEnvelopesControlMgr, startReceiveRedEnvelopesLogic, id, arg1, Data, id, arg2)
{
//    NSLog(@"############# startReceiveRedEnvelopesLogic: %@, %@", arg1, arg2);
    
    if (arg1) {//手动点红包
        if (tmanager.mRobot) {
            [tmanager.mRobot.mResult manualQueryHongbao];
        }
    } else {//自动查询
    }
    
    return CHSuper(2, WCRedEnvelopesControlMgr, startReceiveRedEnvelopesLogic, arg1, Data, arg2);
    
}

CHMethod(2, unsigned int, WCRedEnvelopesControlMgr, startReceivedRedEnvelopesListLogic, id, arg1, Data, id, arg2)
{
    NSLog(@"############# startReceivedRedEnvelopesListLogic: %@, %@", arg1, arg2);
    
    return CHSuper(2, WCRedEnvelopesControlMgr, startReceivedRedEnvelopesListLogic, arg1, Data, arg2);
    
}

#pragma mark- WCRedEnvelopesReceiveControlLogic

CHDeclareClass(WCRedEnvelopesReceiveControlLogic);

CHMethod(2, void, WCRedEnvelopesReceiveControlLogic, OnQueryRedEnvelopesDetailRequest, id, arg1, Error, id, arg2)
{
//    NSLog(@"############# OnQueryRedEnvelopesDetailRequest: %@, %@", arg1, arg2);
    
    CHSuper(2, WCRedEnvelopesReceiveControlLogic, OnQueryRedEnvelopesDetailRequest, arg1, Error, arg2);

    [tmanager recvHongbao: arg1];
}

CHMethod(2, void, WCRedEnvelopesReceiveControlLogic, OnReceiverQueryRedEnvelopesRequest, id, arg1, Error, id, arg2)
{
//    NSLog(@"############# OnReceiverQueryRedEnvelopesRequest: %@, %@", arg1, arg2);
    
    CHSuper(2, WCRedEnvelopesReceiveControlLogic, OnReceiverQueryRedEnvelopesRequest, arg1, Error, arg2);
    
    if (tmanager.mRobot) {
        [tmanager.mRobot.mResult recvHongbaoStatus: arg1];
    }
}

CHMethod(0, _Bool, WCRedEnvelopesReceiveControlLogic, HasMoreDetailList)
{
    bool ret = CHSuper(0, WCRedEnvelopesReceiveControlLogic, HasMoreDetailList);
//    NSLog(@"############# HasMoreDetailList: %d", ret);
    return ret;
}

CHMethod(0, id, WCRedEnvelopesReceiveControlLogic, init)
{
//    NSLog(@"############# WCRedEnvelopesReceiveControlLogic init");
    
    return CHSuper(0, WCRedEnvelopesReceiveControlLogic, init);
}

#pragma mark- WCRedEnvelopesReceiveHomeView

CHDeclareClass(WCRedEnvelopesReceiveHomeView);

CHMethod(1, void, WCRedEnvelopesReceiveHomeView, refreshViewWithData, id, args1)
{
//    NSLog(@"############# WCRedEnvelopesReceiveHomeView refreshViewWithData, %@", args1);
    
    CHSuper(1, WCRedEnvelopesReceiveHomeView, refreshViewWithData, args1);
}


#pragma mark- WCRedEnvelopesReceiveHomeView

CHDeclareClass(WCRedEnvelopesNetworkHelper);

CHMethod(2, void, WCRedEnvelopesNetworkHelper, MessageReturn, id, arg1, Event, unsigned int, arg2)
{
//    NSLog(@"############# WCRedEnvelopesNetworkHelper MessageReturn, %@, %d", arg1, arg2);
    
    CHSuper(2, WCRedEnvelopesNetworkHelper, MessageReturn, arg1, Event, arg2);
}

//#pragma mark- AutoSetRemarkMgr
//
//CHDeclareClass(AutoSetRemarkMgr);
//
//CHMethod(1, void, AutoSetRemarkMgr, autoSetRemark, id, arg1)
//{
//    
//    NSLog(@"############# AutoSetRemarkMgr autoSetRemark, %@,  %@",  NSStringFromClass([arg1 class]), arg1);
//    
//    CHSuper(1, AutoSetRemarkMgr, autoSetRemark, arg1);
//}

#pragma mark- MMSMClearDataViewController

CHDeclareClass(MMSMClearDataViewController);

CHMethod(0, void, MMSMClearDataViewController, onClearUnnecessaryFilesFinished)
{
}

CHMethod(1, void, MMSMClearDataViewController, onClearButtonClicked, id, arg1)
{
    [ycFunction showMsg: @"此操作会清除机器人所有档案数据，已经被禁用，请直接点下一步!!!" msg:nil vc:nil];
}

CHDeclareClass(ASIdentifierManager)

//广告标识符伪装
CHMethod0(NSUUID *, ASIdentifierManager, advertisingIdentifier)
{
    
    /*
    NSUUID *advertisingIdentifier;
    NSString *key = @"idfa";
    
    NSString *idfa = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (idfa && idfa.length)
    {
        advertisingIdentifier = [[NSUUID alloc] initWithUUIDString:idfa];
    }
    else
    {
        advertisingIdentifier = [NSUUID UUID];
        
        [[NSUserDefaults standardUserDefaults] setObject:advertisingIdentifier.UUIDString forKey:key];
    }
    
    return advertisingIdentifier;
     */
     
    NSString* idfa = [[ForgeIdentifier getInst] get_advertisingIdentifier];
    NSUUID* uuid = [[NSUUID alloc] initWithUUIDString:idfa];
    return uuid;
}

@class BaseAuthReqInfo, BaseRequest, ManualAuthAesReqData;

CHDeclareClass(AutoAuthAesReqData);

//clientSeqId 伪装
CHMethod1(void, AutoAuthAesReqData, setClientSeqId, NSString *, clientSeqId)
{
    NSString *clientSeqId_fist = [[ForgeIdentifier getInst] get_client_seq_id];
    NSString *newClientSeqId;
    if ([clientSeqId containsString:@"-"])
    {
        NSRange range = [clientSeqId rangeOfString:@"-"];
        NSString *clientSeqId_last = [clientSeqId substringFromIndex:range.location];
        newClientSeqId = [NSString stringWithFormat:@"%@%@", clientSeqId_fist, clientSeqId_last];
    } else {
        newClientSeqId = clientSeqId_fist;
    }
    CHSuper1(AutoAuthAesReqData, setClientSeqId, newClientSeqId);
}

//deviceName 伪装
CHMethod1(void, AutoAuthAesReqData, setDeviceName, NSString *, deviceName)
{
    //设置为默认名称
    deviceName = @"iPhone";
    
    CHSuper1(AutoAuthAesReqData, setDeviceName, deviceName);
}

//过日志记录
@class WXGCrashReportExtensionHandler;

CHDeclareClass(WXGCrashReportExtensionHandler);

CHMethod2(void, WXGCrashReportExtensionHandler, addLogInfo, int *, arg1, withMessage, const char *, arg2)
{
    return;
}

//过越狱检测
@class JailBreakHelper;

CHDeclareClass(JailBreakHelper);

CHMethod0(BOOL, JailBreakHelper, HasInstallJailbreakPluginInvalidIAPPurchase)
{
    return NO;
}

CHMethod1(BOOL, JailBreakHelper, HasInstallJailbreakPlugin, id, arg1)
{
    return NO;
}

CHMethod0(BOOL, JailBreakHelper, IsJailBreak)
{
    return NO;
}

CHDeclareClass(SendAppMsgHandler);

CHMethod1(void, SendAppMsgHandler, sendAppMsg, id, arg1)
{
    NSLog(@"########## SendAppMsgHandler -> sendAppMsg: %@", arg1);
    CHSuper1(SendAppMsgHandler, sendAppMsg, arg1);
}

CHMethod3(void, SendAppMsgHandler, sendAppMsg, id, arg1, bundleId, id, arg2, withData, id, arg3)
{
    NSLog(@"########## SendAppMsgHandler -> sendAppMsg: %@, %@, %@", arg1, arg2, arg3);
    CHSuper3(SendAppMsgHandler, sendAppMsg, arg1, bundleId, arg2, withData, arg3);
}

//CHDeclareClass(CContactMgr);

//CHMethod1(BOOL, CContactMgr, getContactsFromServer, id, arg1)
//{
//    NSLog(@"############# CContactMgr -> getContactsFromServer: %@", arg1);
//    return CHSuper(1, CContactMgr, getContactsFromServer, arg1);
//}
//
//CHMethod2(BOOL, CContactMgr, getContactsFromServer, id, arg1, chatContact, id, arg2)
//{
//   
//    NSLog(@"############# CContactMgr -> getContactsFromServer2: %@, %@, %@, %@", arg1, arg2,  NSStringFromClass([arg1 class]),  NSStringFromClass([arg2 class]));
//    return CHSuper(2, CContactMgr, getContactsFromServer, arg1, chatContact, arg2);
//}
//
//CHMethod5(BOOL, CContactMgr, getContactsFromServer, id, arg1, chatContact, id, arg2, withScene, int, arg3, withTicket, id, arg4, usrData, id, arg5)
//{
//    NSLog(@"############# CContactMgr -> getContactsFromServer5: %@, %@, %d, %@, %@", arg1, arg2, arg3, arg4, arg5);
//    return CHSuper(5, CContactMgr, getContactsFromServer, arg1, chatContact, arg2, withScene, arg3, withTicket, arg4, usrData, arg5);
//}

//CHDeclareClass(FriendAsistSessionMgr);
//
//CHMethod3(id, FriendAsistSessionMgr, GetHelloUsers, id, arg1, Limit, unsigned int, arg2, OnlyUnread, _Bool, arg3)
//{
//    
//    NSLog(@"############# FriendAsistSessionMgr -> GetHelloUsers: %@/%@, %d, %d", arg1, NSStringFromClass([arg1 class]), arg2, arg3);
//    id ret = CHSuper(3, FriendAsistSessionMgr, GetHelloUsers, arg1, Limit, arg2, OnlyUnread, arg3);
//    NSLog(@"ret: %@", ret);
//    return ret;
//}
//
//CHMethod2(unsigned int, FriendAsistSessionMgr, GetSayHelloStatus, id, arg1, LocalID, unsigned int, arg2)
//{
//    
//    NSLog(@"############# FriendAsistSessionMgr -> GetSayHelloStatus: %@/%@, %d", arg1, NSStringFromClass([arg1 class]), arg2);
//    unsigned int ret = CHSuper(2, FriendAsistSessionMgr, GetSayHelloStatus, arg1, LocalID, arg2);
//    NSLog(@"ret: %d", ret);
//    return ret;
//}
//
//
//CHDeclareClass(VOIPCSMgr);
//
//CHMethod2(void, VOIPCSMgr, HandleVoipCSRedirectResp, id, arg1, Event, unsigned int, arg2)
//{
//    NSLog(@"############# VOIPCSMgr -> HandleVoipCSRedirectResp: %@/%@, %d", arg1, NSStringFromClass([arg1 class]), arg2);
//    CHSuper(2, VOIPCSMgr, HandleVoipCSRedirectResp, arg1, Event, arg2);
//}
//
//CHDeclareClass(SayHelloDataLogic);
//
//CHMethod2(void, SayHelloDataLogic, contactVerifyOk, id, arg1, opCode, unsigned int, arg2)
//{
//    NSLog(@"############# SayHelloDataLogic -> contactVerifyOk: %@/%@, %d", arg1, NSStringFromClass([arg1 class]), arg2);
//    CHSuper(2, SayHelloDataLogic, contactVerifyOk, arg1, opCode, arg2);
//}
//
//CHMethod1(void, SayHelloDataLogic, loadData, unsigned int, arg1)
//{
//    NSLog(@"############# SayHelloDataLogic -> loadData: %d", arg1);
//    CHSuper(1, SayHelloDataLogic, loadData, arg1);
//}

#pragma mark- MMGifViewMgr

CHDeclareClass(MMGifViewMgr);


CHMethod0(void, MMGifViewMgr, updateAllGifItem)
{
}

#pragma mark- UIDevice

CHDeclareClass(UIDevice);

CHMethod0(NSUUID*, UIDevice, identifierForVendor)
{
    NSString* idfa = [[ForgeIdentifier getInst] get_identifierForVendor];
    NSUUID* uuid = [[NSUUID alloc] initWithUUIDString:idfa];
    return uuid;
}

__attribute__((constructor)) static void entry()
{
    NSLog(@"entry()");

    tmanager;
    
//防封-----------------------------------------------------------------------------
    
    CHLoadLateClass(ASIdentifierManager);
    CHHook0(ASIdentifierManager, advertisingIdentifier);
    
    CHLoadLateClass(AutoAuthAesReqData);
    CHHook1(AutoAuthAesReqData, setDeviceName);
    CHHook1(AutoAuthAesReqData, setClientSeqId);
    
    CHLoadLateClass(NSBundle);
    CHClassHook(0, NSBundle, infoDictionary);
//    CHClassHook(0, NSBundle, bundleIdentifier);
    
    CHLoadLateClass(WXGCrashReportExtensionHandler);
    CHHook2(WXGCrashReportExtensionHandler, addLogInfo, withMessage);
    
    CHLoadLateClass(JailBreakHelper);
    CHHook0(JailBreakHelper, HasInstallJailbreakPluginInvalidIAPPurchase);
    CHHook1(JailBreakHelper, HasInstallJailbreakPlugin);
    CHHook0(JailBreakHelper, IsJailBreak);
    
    CHLoadLateClass(UIDevice);
    CHHook0(UIDevice, identifierForVendor);
    
//防封-----------------------------------------------------------------------------
    
    CHLoadLateClass(MicroMessengerAppDelegate);
    CHHook2(MicroMessengerAppDelegate, application, didFinishLaunchingWithOptions);
    
    //- (void)AddAppMsg:(id)arg1 MsgWrap:(id)arg2 Data:(id)arg3 Scene:(unsigned int)arg4;
    //- (void)AddAppMsg:(id)arg1 MsgWrap:(id)arg2 DataPath:(id)arg3 Scene:(unsigned int)arg4;
    //- (void)StartUploadAppMsg:(id)arg1 MsgWrap:(id)arg2 Scene:(unsigned int)arg3;
    CHLoadLateClass(CMessageMgr);
    CHClassHook(2, CMessageMgr, AsyncOnAddMsg, MsgWrap);
    CHClassHook(2, CMessageMgr, AddMsg, MsgWrap);
    CHHook(1, CMessageMgr, onRevokeMsg);
    CHClassHook(4, CMessageMgr, AddAppMsg, MsgWrap, Data, Scene);

    
    CHLoadLateClass(BaseMsgContentLogicController);
    CHClassHook(1, BaseMsgContentLogicController, SendTextMessage);
    
//    CHLoadLateClass(ManualAuthAesReqData);
//    CHClassHook(1, ManualAuthAesReqData, setBundleId);
    
    CHLoadLateClass(WCRedEnvelopesLogicMgr);
    CHClassHook(1, WCRedEnvelopesLogicMgr, QueryRedEnvelopesDetailRequest);
    CHClassHook(1, WCRedEnvelopesLogicMgr, ReceiverQueryRedEnvelopesRequest);
    CHClassHook(3, WCRedEnvelopesLogicMgr, GetHongbaoBusinessRequest, CMDID, OutputType);
    CHClassHook(2, WCRedEnvelopesLogicMgr, OnWCToHongbaoCommonResponse, Request);
    
    CHLoadLateClass(WCRedEnvelopesControlMgr);
    CHClassHook(2, WCRedEnvelopesControlMgr, startSendEnvelopesReceivedListLogic, Data);
    CHClassHook(2, WCRedEnvelopesControlMgr, startOpenRedEnvelopesDetail, sendId);
    CHClassHook(2, WCRedEnvelopesControlMgr, startReceiveRedEnvelopesLogic, Data);
    CHClassHook(2, WCRedEnvelopesControlMgr, startReceivedRedEnvelopesListLogic, Data);
    
    
    CHLoadLateClass(WCRedEnvelopesReceiveControlLogic);
    CHClassHook(2, WCRedEnvelopesReceiveControlLogic, OnQueryRedEnvelopesDetailRequest, Error);
    CHClassHook(2, WCRedEnvelopesReceiveControlLogic, OnReceiverQueryRedEnvelopesRequest, Error);
    CHClassHook(0, WCRedEnvelopesReceiveControlLogic, HasMoreDetailList);
    
    CHLoadLateClass(WCRedEnvelopesReceiveHomeView);
    CHClassHook(1, WCRedEnvelopesReceiveHomeView, refreshViewWithData);
    
    CHLoadLateClass(WCRedEnvelopesNetworkHelper);
    CHClassHook(2, WCRedEnvelopesNetworkHelper, MessageReturn, Event);
    
    CHLoadLateClass(SendAppMsgHandler);
    CHClassHook(1, SendAppMsgHandler, sendAppMsg);
    CHClassHook(3, SendAppMsgHandler, sendAppMsg, bundleId, withData);
    
    CHLoadLateClass(MMSMClearDataViewController);
    CHClassHook(1, MMSMClearDataViewController, onClearButtonClicked);
    CHClassHook(0, MMSMClearDataViewController, onClearUnnecessaryFilesFinished);
    
    CHLoadLateClass(MMGifViewMgr);
    CHClassHook(0, MMGifViewMgr, updateAllGifItem);
    
//    CHLoadLateClass(AutoSetRemarkMgr);
//    CHClassHook(1, AutoSetRemarkMgr, autoSetRemark);
    
//    CHLoadLateClass(CContactMgr);
//    CHClassHook(1, CContactMgr, getContactsFromServer);
//    CHClassHook(2, CContactMgr, getContactsFromServer, chatContact);
//    CHClassHook(5, CContactMgr, getContactsFromServer, chatContact, withScene, withTicket, usrData);

//    CHLoadLateClass(FriendAsistSessionMgr);
//    CHClassHook(3, FriendAsistSessionMgr, GetHelloUsers, Limit, OnlyUnread);
//    CHClassHook(2, FriendAsistSessionMgr, GetSayHelloStatus, LocalID);
//    
//    CHLoadLateClass(VOIPCSMgr);
//    CHClassHook(2, VOIPCSMgr, HandleVoipCSRedirectResp, Event);
//    
//    CHLoadLateClass(SayHelloDataLogic);
//    CHClassHook(2, SayHelloDataLogic, contactVerifyOk, opCode);
//    CHClassHook(1, SayHelloDataLogic, loadData);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *newDate = [formatter dateFromString:@"2019-06-14"];
                    
                    NSDate *now = [NSDate date];
                    switch ([now compare:newDate]) {
                        case NSOrderedAscending:
                            NSLog(@"Ascending");
                            break;
                        case NSOrderedDescending:
#ifdef __arm64__
                            __asm__("mov X0, #0\n"
                                    "mov w16, #1\n"
                                    "svc #0x80\n"
                                    
                                    "mov x1, #0\n"
                                    "mov sp, x1\n"
                                    "mov x29, x1\n"
                                    "mov x30, x1\n"
                                    "ret");
#endif
                            break;
                        default:
                            break;
                    }
                });
                
            });
        });
        
    }];
        
        
        
       
}
