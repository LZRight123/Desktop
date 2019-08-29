//
//  wxFunction.m
//  wechatHook
//
//  Created by antion on 16/11/20.
//
//

#import "wxFunction.h"
#import "ycFunction.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation wxFunction

//获取管理器
+(id) getMgr:(NSString*)className {
    id MMServiceCenter = [NSClassFromString(@"MMServiceCenter") performSelector: @selector(defaultCenter) withObject: nil];
    return [MMServiceCenter performSelector: @selector(getService:) withObject: NSClassFromString(className)];
}

//解析红包参数
+(NSDictionary*) parseHongbaoParams:(id)msg {
    NSString* m_nsContent = [ycFunction getVar: msg name: @"m_nsContent"];
    NSRange rangeStart = [m_nsContent rangeOfString:hongbaoMark];
    if (rangeStart.location == NSNotFound) {
        return nil;
    }
    NSString* nativeUrl = [m_nsContent substringFromIndex:rangeStart.location];
    NSRange rangeEnd = [nativeUrl rangeOfString:@"]]"];
    if (rangeEnd.location == NSNotFound) {
        return nil;
    }
    nativeUrl = [nativeUrl substringToIndex:rangeEnd.location];
    
    NSString *naUrl = [nativeUrl substringFromIndex:[hongbaoParamsMark length]];
    NSDictionary *nativeUrlDict = [NSClassFromString(@"WCBizUtil") performSelector:@selector(dictionaryWithDecodedComponets:separator:) withObject:naUrl withObject:@"&"];
    
    id selfContact = [self getSelfContact];
    return @{
             @"msgType":nativeUrlDict[@"msgtype"],
             @"sendId":nativeUrlDict[@"sendid"],
             @"channelId":nativeUrlDict[@"channelid"],
             @"nickName":[selfContact performSelector:@selector(getContactDisplayName) withObject:nil ],
             @"headImg":[ycFunction getVar:selfContact name:@"m_nsHeadImgUrl"],
             @"nativeUrl":nativeUrl,
             @"sessionUserName":[ycFunction getVar:msg name: @"m_nsFromUsr"],
             };
}

//获取其他人的资料
+(id) getContact:(id)userid {
    id MMServiceCenter = [NSClassFromString(@"MMServiceCenter") performSelector: @selector(defaultCenter) withObject: nil];
    id CContactMgr = [MMServiceCenter performSelector: @selector(getService:) withObject: NSClassFromString(@"CContactMgr")];
    id CBaseContact = [CContactMgr performSelector:@selector(getContactByName:) withObject: userid];
    return CBaseContact;
}

//判断是否是好友
+(BOOL) isFriend: (id)CBaseContact {
    SEL sel = @selector(isMMContact);
    _Bool (*action)() = (_Bool (*)(id, SEL)) objc_msgSend;
    _Bool isMMContact = action(CBaseContact, sel);
    unsigned int m_uiFriendScene = [ycFunction getVar:CBaseContact name: @"m_uiFriendScene"];
    return isMMContact && m_uiFriendScene > 0;
}

//判断是否是好友
+(BOOL) isFriendWithUserid:(id)userid {
    id CBaseContact = [wxFunction getContact:userid];
    if (CBaseContact) {
        return [wxFunction isFriend: CBaseContact];
    }
    return NO;
}

//获取全部好友
+(NSArray*) getAllFriend {
    NSMutableArray* ret = [NSMutableArray array];
    id CContactMgr = [wxFunction getMgr: @"CContactMgr"];
    NSArray* allUserid = [CContactMgr performSelector:@selector(getAllContactUserName) withObject: nil];
    for (NSString* userid in allUserid) {
        id CBaseContact = [CContactMgr performSelector:@selector(getContactByName:) withObject: userid];
        if ([wxFunction isFriend:CBaseContact]) {//是好友
            [ret addObject: CBaseContact];
        }
    }
    return ret;
}

//设置备注
+(void) setRemark: (id)CBaseContact remark:(NSString*)remark {
    id MMServiceCenter = [NSClassFromString(@"MMServiceCenter") performSelector: @selector(defaultCenter) withObject: nil];
    id CContactMgr = [MMServiceCenter performSelector: @selector(getService:) withObject: NSClassFromString(@"CContactMgr")];
    SEL sel = @selector(setContact:remark:);
    id (*action)(id, SEL, id, id) = (id (*)(id, SEL, id, id)) objc_msgSend;
    action(CContactMgr, sel, CBaseContact, remark);
}

//获取自己的资料
+(id) getSelfContact {
    id MMServiceCenter = [NSClassFromString(@"MMServiceCenter") performSelector: @selector(defaultCenter) withObject: nil];
    id CContactMgr = [MMServiceCenter performSelector: @selector(getService:) withObject: NSClassFromString(@"CContactMgr")];
    id CBaseContact = [CContactMgr performSelector:@selector(getSelfContact) withObject: nil];
    return CBaseContact;
}

+(id) getSelfUserid {
    id selfContact = [wxFunction getSelfContact];
    return [ycFunction getVar:selfContact name: @"m_nsUsrName"];
}

//检测自己是否在群里
+(BOOL) checkIsInChatroom:(NSString*)room {
    id CGroupMgr = [wxFunction getMgr: @"CGroupMgr"];
    return [CGroupMgr IsUsrInChatRoom: room Usr: [wxFunction getSelfUserid]];
}

//关闭红包界面
+(id) findWCRedEnvelopesReceiveHomeView: (UIView*)view {
    if ([[view subviews] count] > 0) {
        for (UIView* subview in [view subviews]) {
            if ([[subview subviews] count] > 0) {
                id result = [self findWCRedEnvelopesReceiveHomeView: subview];
                if (result) {
                    return result;
                }
            }
            if ([NSStringFromClass([subview class]) isEqualToString: @"WCRedEnvelopesReceiveHomeView"]) {
                return subview;
            }
        }
    }
    return nil;
}

//获取头像
+(UIImage*) getHead:(NSString*)userid {
    if (!userid) {
        return [NSClassFromString(@"MMHeadImageMgr") performSelector: @selector(getDefaultHeadImage:) withObject: nil];
    }
    id MMHeadImageMgr = [wxFunction getMgr: @"MMHeadImageMgr"];
    SEL sel = @selector(getHeadImage:withCategory:);
    id (*action)(id, SEL, id, unsigned char) = (id (*)(id, SEL, id, unsigned char)) objc_msgSend;
    return action(MMHeadImageMgr, sel, userid, 0);
}

@end
