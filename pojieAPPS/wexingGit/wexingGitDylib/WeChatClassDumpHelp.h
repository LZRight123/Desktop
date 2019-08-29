//
//  WeChatClassDumpHelp.h
//  wexingGitDylib
//
//  Created by 梁泽 on 2019/5/23.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCBizUtil
+ (id)dictionaryWithDecodedComponets:(id)arg1 separator:(id)arg2;
@end

@interface WCPayInfoItem
@property(copy, nonatomic) NSString *m_c2cNativeUrl;
@end

@interface CMessageWrap
@property(retain, nonatomic) NSString *m_nsEmoticonMD5; // @dynamic m_nsEmoticonMD5;
@property(nonatomic) unsigned int m_uiGameContent; 
@property(nonatomic) unsigned int m_uiGameType;
@property(retain, nonatomic) WCPayInfoItem *m_oWCPayInfoItem;
@property(nonatomic) unsigned int m_uiMessageType; // @synthesize m_uiMessageType;
@property(retain, nonatomic) NSString *m_nsMsgSource; // @synthesize m_nsMsgSource;
@property(retain, nonatomic) NSString *m_nsBizChatId; // @synthesize m_nsBizChatId;
@property(retain, nonatomic) NSString *m_nsBizClientMsgID; // @synthesize m_nsBizClientMsgID;
@property(retain, nonatomic) NSString *m_nsContent; // @synthesize m_nsContent;
@property(retain, nonatomic) NSString *m_nsToUsr; // @synthesize m_nsToUsr;
@property(retain, nonatomic) NSString *m_nsFromUsr; // @synthesize m_nsFromUsr;
@property(retain, nonatomic) NSString *m_nsAtUserList; // @synthesize m_nsAtUserList;
@property(retain, nonatomic) NSString *m_nsKFWorkerOpenID; // @synthesize m_nsKFWorkerOpenID;
@property(retain, nonatomic) NSString *m_nsDisplayName; // @synthesize m_nsDisplayName;
@property(retain, nonatomic) NSString *m_nsPattern; // @synthesize m_nsPattern;
@property(retain, nonatomic) NSString *m_nsRealChatUsr; // @synthesize m_nsRealChatUsr;
@property(retain, nonatomic) NSString *m_nsPushContent; // @synthesize m_nsPushContent;
@end

@interface WCRedEnvelopesControlData
@property(retain, nonatomic) CMessageWrap *m_oSelectedMessageWrap;
@property(retain, nonatomic) NSDictionary *m_structDicRedEnvelopesBaseInfo;
@end

@interface MMServiceCenter
+ (id)defaultCenter;
- (id)getService:(Class)arg1;
@end

@interface CContactMgr
- (id)getSelfContact;
@end

@interface CContact
@property(copy, nonatomic) NSString *m_nsHeadImgUrl;
@property(copy, nonatomic) NSString *m_nsUsrName;
- (NSString *)getContactDisplayName;
@end

@interface MMMsgLogicManager
- (id)GetCurrentLogicController;
@end

@interface WeixinContentLogicController
@property(strong, nonatomic) id m_contact;
@end

@interface WCPayLogicMgr
- (void)setRealnameReportScene:(unsigned int)arg1;
@end

@interface WCRedEnvelopesLogicMgr
- (void)OpenRedEnvelopesRequest:(id)arg1;
- (void)ReceiverQueryRedEnvelopesRequest:(NSDictionary *)dic;
@end



//拆红包相关
@interface SKBuiltinBuffer_t
@property(retain, nonatomic) NSData *buffer;
@property(nonatomic) unsigned int iLen;
@end

@interface HongBaoReq
@property(nonatomic) unsigned int cgiCmd;
@property(nonatomic) unsigned int outPutType;
@property(retain, nonatomic) SKBuiltinBuffer_t *reqText;
@end



@interface HongBaoRes
@property(nonatomic) int cgiCmdid; // @dynamic cgiCmdid;
@property(retain, nonatomic) NSString *errorMsg; // @dynamic errorMsg;
@property(nonatomic) int errorType; // @dynamic errorType;
@property(retain, nonatomic) NSString *platMsg; // @dynamic platMsg;
@property(nonatomic) int platRet; // @dynamic platRet;
@property(retain, nonatomic) SKBuiltinBuffer_t *retText; // @dynamic retText;
@end

//设置cell相关
@interface WCTableViewManager
- (void)insertSection:(id)arg1 At:(unsigned int)arg2;
@end

@interface WCTableViewSectionManager
+ (id)sectionInfoDefaut;
- (void)addCell:(id)arg1;
@end
@interface WCTableView
- (void)reloadData;
@end
@interface WCTableViewCellManager
+ (id)switchCellForSel:(SEL)arg1 target:(id)arg2 title:(id)arg3 on:(_Bool)arg4;
@end
@interface NewSettingViewController
@end


@interface EmojiInfoObj
@property(retain, nonatomic) NSString *authkey; // @synthesize authkey=_authkey;
@property(retain, nonatomic) NSString *tpUrlString; // @synthesize tpUrlString=_tpUrlString;
@property(nonatomic) _Bool disableExtern; // @synthesize disableExtern=_disableExtern;
@property(retain, nonatomic) NSString *lensId; // @synthesize lensId;
@property(retain, nonatomic) NSString *attachedTextColor; // @synthesize attachedTextColor;
@property(retain, nonatomic) NSString *activityId; // @synthesize activityId;
@property(retain, nonatomic) NSString *externMd5; // @synthesize externMd5;
@property(retain, nonatomic) NSString *attachedText; // @synthesize attachedText;
@property(retain, nonatomic) NSString *externUrl; // @synthesize externUrl;
@property(retain, nonatomic) NSString *productId; // @synthesize productId;
@property(retain, nonatomic) NSString *aesKey; // @synthesize aesKey;
@property(retain, nonatomic) NSString *encryptUrl; // @synthesize encryptUrl;
@property(retain, nonatomic) NSString *designerId; // @synthesize designerId;
@property(retain, nonatomic) NSString *thumbUrl; // @synthesize thumbUrl;
@property(retain, nonatomic) NSString *url; // @synthesize url;
@property(retain, nonatomic) NSString *md5;
@end

@interface CEmoticonWrap : NSObject
@property(retain, nonatomic) EmojiInfoObj *m_emojiInfo; // @synthesize m_emojiInfo;
@property(nonatomic) _Bool m_isAsyncUpload; // @synthesize m_isAsyncUpload;
@property(nonatomic) unsigned int m_extFlag; // @synthesize m_extFlag;
@property(retain, nonatomic) NSData *m_imageData; // @synthesize m_imageData;
@property(retain, nonatomic) NSString *m_nsThumbImgUrl; // @synthesize m_nsThumbImgUrl;
@property(nonatomic) unsigned int m_lastUsedTime; // @synthesize m_lastUsedTime;
@property(retain, nonatomic) NSString *m_nsThumbImgPath; // @synthesize m_nsThumbImgPath;
@property(retain, nonatomic) NSString *m_nsAppID; // @synthesize m_nsAppID;
@property(nonatomic) unsigned int m_uiGameType; // @synthesize m_uiGameType;
@property(nonatomic) _Bool m_bCanDelete; // @synthesize m_bCanDelete;
@property(nonatomic) unsigned int m_uiType; // @synthesize m_uiType;
@end
