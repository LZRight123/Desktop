//
//  wxFunction.h
//  wechatHook
//
//  Created by antion on 16/11/20.
//
//

#import <UIKit/UIKit.h>

#define hongbaoMark @"wxpay://c2cbizmessagehandler/hongbao"
#define hongbaoParamsMark @"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?"

@interface wxFunction : NSObject

//获取管理器
+(id) getMgr:(NSString*)className;

//解析红包参数
+(NSDictionary*) parseHongbaoParams:(id)msg;

//获取其他人的资料
+(id) getContact:(id)userid;

//判断是否是好友
+(BOOL) isFriend: (id)CBaseContact;

//判断是否是好友
+(BOOL) isFriendWithUserid:(id)userid;

//获取全部好友
+(NSArray*) getAllFriend;

//设置备注
+(void) setRemark: (id)CBaseContact remark:(NSString*)remark;

//获取自己的资料
/*
 {m_nsUsrName=wxi*712~19, m_nsEncodeUserName=(null), alias=zpz*520~12, m_nsNickName=石一坚, m_uiType=3, m_uiConType=0, m_nsRemark=(null),  m_nsCountry= m_nsProvince= m_nsCity= m_nsSignature= 	 m_uiSex=0 m_uiCerFlag=0 m_nsCer= scene=0 }
 */
+(id) getSelfContact;

//获取自己微信号
+(id) getSelfUserid;

//检测自己是否在群里
+(BOOL) checkIsInChatroom:(NSString*)room;

//关闭红包界面
+(id) findWCRedEnvelopesReceiveHomeView: (UIView*)view;

//获取头像
+(UIImage*) getHead:(NSString*)userid;

@end
