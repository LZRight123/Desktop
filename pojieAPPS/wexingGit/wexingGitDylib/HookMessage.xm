// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "LZRedPageManager.h"

@class WCStoryReportUtil;
@class WCChatRoomStoryDataVM;
@class RichTextView;
@class MMRichTextCoverView;
@class BadRoomLogicController;

%hook CMessageMgr
- (void)AsyncOnAddMsg:(NSString *)wxid MsgWrap:(CMessageWrap *)wrap {
    %orig;
    NSInteger uiMessageType = [wrap m_uiMessageType];
    if ( 49 == uiMessageType && [LZRedPageManager sharedInstance].isAutoRed){ //红包消息,且开关打开
        NSString *nsFromUsr = [wrap m_nsFromUsr];
        //抢红包
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
        NSDictionary *dic =  [%c(WCBizUtil) dictionaryWithDecodedComponets:subStr separator:@"&"];
        
        LZRedPageModel *model = [[LZRedPageModel alloc] init];
        model.msgType = @"1";
        NSString *sendId = [dic objectForKey:@"sendid"];
        model.sendId = sendId;
        NSString *channelId = [dic objectForKey:@"channelid"];
        model.channelId = channelId;
        CContactMgr *service =  [[%c(MMServiceCenter) defaultCenter] getService:[%c(CContactMgr) class]];
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
        //1.0 存储抢红包时需要的参数
        if (sendId.length > 0)   {
            [[LZRedPageManager sharedInstance] addRedModel:model];
        }
        //2.0 收到红包就拆红包
        NSMutableDictionary *params = [NSMutableDictionary dictionary] ;
        if ([nsFromUsr hasSuffix:@"@chatroom"]){ //群红包
            [params setObject:@"0" forKey:@"inWay"]; //0:群聊，1：单聊
        }else {     //个人红包
            [params setObject:@"1" forKey:@"inWay"]; //0:群聊，1：单聊
        }
        [params setObject:sendId forKey:@"sendId"];
        [params setObject:m_c2cNativeUrl forKey:@"nativeUrl"];
        [params setObject:@"1" forKey:@"msgType"];
        [params setObject:channelId forKey:@"channelId"];
        [params setObject:@"0" forKey:@"agreeDuty"];
        WCRedEnvelopesLogicMgr *redEnvelopesLogicMgr = [[%c(MMServiceCenter) defaultCenter] getService:[%c(WCRedEnvelopesLogicMgr) class]];
        [redEnvelopesLogicMgr ReceiverQueryRedEnvelopesRequest:params];
    }
}
%end

%hook WCRedEnvelopesLogicMgr
- (void)OnWCToHongbaoCommonResponse:(HongBaoRes *)hongBaoRes Request:(HongBaoReq *)hongBaoReq {
    %orig;
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
                    WCRedEnvelopesLogicMgr *redEnvelopesLogicMgr = [[%c(MMServiceCenter) defaultCenter] getService:[%c(WCRedEnvelopesLogicMgr) class]];
                    if (nil != redEnvelopesLogicMgr){
                        [redEnvelopesLogicMgr OpenRedEnvelopesRequest:paramDic];
                    }
                    
                }
                
            }
        }
    }
}
%end



