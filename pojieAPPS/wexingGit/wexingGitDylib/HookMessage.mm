#line 1 "/Users/liangze/Documents/Desktop/pojieAPPS/wexingGit/wexingGitDylib/HookMessage.xm"


#import <UIKit/UIKit.h>
#import "LZRedPageManager.h"

@class WCStoryReportUtil;
@class WCChatRoomStoryDataVM;
@class RichTextView;
@class MMRichTextCoverView;
@class BadRoomLogicController;


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class CContactMgr; @class WCRedEnvelopesLogicMgr; @class WCBizUtil; @class CMessageMgr; @class MMServiceCenter; 
static void (*_logos_orig$_ungrouped$CMessageMgr$AsyncOnAddMsg$MsgWrap$)(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, NSString *, CMessageWrap *); static void _logos_method$_ungrouped$CMessageMgr$AsyncOnAddMsg$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST, SEL, NSString *, CMessageWrap *); static void (*_logos_orig$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$)(_LOGOS_SELF_TYPE_NORMAL WCRedEnvelopesLogicMgr* _LOGOS_SELF_CONST, SEL, HongBaoRes *, HongBaoReq *); static void _logos_method$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$(_LOGOS_SELF_TYPE_NORMAL WCRedEnvelopesLogicMgr* _LOGOS_SELF_CONST, SEL, HongBaoRes *, HongBaoReq *); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$WCBizUtil(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("WCBizUtil"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$WCRedEnvelopesLogicMgr(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("WCRedEnvelopesLogicMgr"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$CContactMgr(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("CContactMgr"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$MMServiceCenter(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("MMServiceCenter"); } return _klass; }
#line 12 "/Users/liangze/Documents/Desktop/pojieAPPS/wexingGit/wexingGitDylib/HookMessage.xm"

static void _logos_method$_ungrouped$CMessageMgr$AsyncOnAddMsg$MsgWrap$(_LOGOS_SELF_TYPE_NORMAL CMessageMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * wxid, CMessageWrap * wrap) {
    _logos_orig$_ungrouped$CMessageMgr$AsyncOnAddMsg$MsgWrap$(self, _cmd, wxid, wrap);
    NSInteger uiMessageType = [wrap m_uiMessageType];
    if ( 49 == uiMessageType && [LZRedPageManager sharedInstance].isAutoRed){ 
        NSString *nsFromUsr = [wrap m_nsFromUsr];
        
        NSLog(@"收到红包消息");
        WCPayInfoItem *payInfoItem = [wrap m_oWCPayInfoItem];
        if (payInfoItem == nil) {
            NSLog(@"payInfoItem is nil");
            return;
        }
        NSString *m_c2cNativeUrl = [payInfoItem m_c2cNativeUrl];
        if (m_c2cNativeUrl == nil) {
            NSLog(@"m_c2cNativeUrl is nil");
            return;
        }
        NSInteger length = [@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?" length];
        NSString *subStr  = [m_c2cNativeUrl substringFromIndex: length];
        NSDictionary *dic =  [_logos_static_class_lookup$WCBizUtil() dictionaryWithDecodedComponets:subStr separator:@"&"];
        
        LZRedPageModel *model = [[LZRedPageModel alloc] init];
        model.msgType = @"1";
        NSString *sendId = [dic objectForKey:@"sendid"];
        model.sendId = sendId;
        NSString *channelId = [dic objectForKey:@"channelid"];
        model.channelId = channelId;
        CContactMgr *service =  [[_logos_static_class_lookup$MMServiceCenter() defaultCenter] getService:[_logos_static_class_lookup$CContactMgr() class]];
        if (service == nil) {
            NSLog(@"service is nil");
            return;
        }
        CContact *contact =  [service getSelfContact];
        NSString *displayName = [contact getContactDisplayName];
        model.nickName = displayName;
        NSString *headerUrl =  [contact m_nsHeadImgUrl];
        model.headImg = headerUrl;
        if (nil != wrap) {
            model.nativeUrl = m_c2cNativeUrl;
        }
        model.sessionUserName = nsFromUsr;
        
        if (sendId.length > 0)   {
            [[LZRedPageManager sharedInstance] addRedModel:model];
        }
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary] ;
        if ([nsFromUsr hasSuffix:@"@chatroom"]){ 
            [params setObject:@"0" forKey:@"inWay"]; 
        }else {     
            [params setObject:@"1" forKey:@"inWay"]; 
        }
        [params setObject:sendId forKey:@"sendId"];
        [params setObject:m_c2cNativeUrl forKey:@"nativeUrl"];
        [params setObject:@"1" forKey:@"msgType"];
        [params setObject:channelId forKey:@"channelId"];
        [params setObject:@"0" forKey:@"agreeDuty"];
        WCRedEnvelopesLogicMgr *redEnvelopesLogicMgr = [[_logos_static_class_lookup$MMServiceCenter() defaultCenter] getService:[_logos_static_class_lookup$WCRedEnvelopesLogicMgr() class]];
        [redEnvelopesLogicMgr ReceiverQueryRedEnvelopesRequest:params];
    }
}



static void _logos_method$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$(_LOGOS_SELF_TYPE_NORMAL WCRedEnvelopesLogicMgr* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, HongBaoRes * hongBaoRes, HongBaoReq * hongBaoReq) {
    _logos_orig$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$(self, _cmd, hongBaoRes, hongBaoReq);
    NSError *err;
    NSDictionary *bufferDic = [NSJSONSerialization JSONObjectWithData:hongBaoRes.retText.buffer options:NSJSONReadingMutableContainers error:&err];
    if (hongBaoRes == nil || bufferDic == nil){
        return;
    }
    
    if (hongBaoRes.cgiCmdid == 3) {
        int receiveStatus = [bufferDic[@"receiveStatus"] intValue];
        int hbStatus = [bufferDic[@"hbStatus"] intValue];
        if (receiveStatus == 0 && hbStatus == 2){
            NSString *timingIdentifier = bufferDic[@"timingIdentifier"];
            NSString *sendId = bufferDic[@"sendId"];
            if (sendId.length > 0 && timingIdentifier.length > 0){
                LZRedPageModel *model = [[LZRedPageManager sharedInstance] getModel:sendId];
                if (model){
                    model.timingIdentifier = timingIdentifier;
                    NSDictionary *paramDic = [model toParams];
                    sleep(1);
                    WCRedEnvelopesLogicMgr *redEnvelopesLogicMgr = [[_logos_static_class_lookup$MMServiceCenter() defaultCenter] getService:[_logos_static_class_lookup$WCRedEnvelopesLogicMgr() class]];
                    if (nil != redEnvelopesLogicMgr){
                        [redEnvelopesLogicMgr OpenRedEnvelopesRequest:paramDic];
                    }
                    
                }
                
            }
        }
    }
}




static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CMessageMgr = objc_getClass("CMessageMgr"); MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(AsyncOnAddMsg:MsgWrap:), (IMP)&_logos_method$_ungrouped$CMessageMgr$AsyncOnAddMsg$MsgWrap$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$AsyncOnAddMsg$MsgWrap$);Class _logos_class$_ungrouped$WCRedEnvelopesLogicMgr = objc_getClass("WCRedEnvelopesLogicMgr"); MSHookMessageEx(_logos_class$_ungrouped$WCRedEnvelopesLogicMgr, @selector(OnWCToHongbaoCommonResponse:Request:), (IMP)&_logos_method$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$, (IMP*)&_logos_orig$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$);} }
#line 112 "/Users/liangze/Documents/Desktop/pojieAPPS/wexingGit/wexingGitDylib/HookMessage.xm"
