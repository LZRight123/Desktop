#line 1 "/Users/liangze/Documents/Desktop/pojieAPPS/Zhibo/ZhiboDylib/TweakEmpty.xm"



#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CCHelpTool.h"
#import "JZTDateUtils.h"
#import "NSDictionary+YYAdd.h"
#import <YYKit/YYKit.h>




@interface SRWebSocket : NSObject

@property(nonatomic) long long readyState;

- (void)send:(id)arg1;
@end





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

@class UIAlertView; @class ZPLiveRoomManager; @class NSJSONSerialization; @class JZTDateUtils; @class NSDate; @class ZPWebSocket; @class MAudienceViewController; @class HTTPManager; @class CBFPrivateCheckView; @class User; @class NSMutableDictionary; @class SRWebSocket; @class UIAlertController; 
static void (*_logos_orig$_ungrouped$SRWebSocket$send$)(_LOGOS_SELF_TYPE_NORMAL SRWebSocket* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$SRWebSocket$send$(_LOGOS_SELF_TYPE_NORMAL SRWebSocket* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$ZPWebSocket$send$)(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$ZPWebSocket$send$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$ZPWebSocket$webSocket$didFailWithError$)(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$ZPWebSocket$webSocket$didFailWithError$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$ZPWebSocket$webSocket$didCloseWithCode$reason$wasClean$)(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id, long, id, BOOL); static void _logos_method$_ungrouped$ZPWebSocket$webSocket$didCloseWithCode$reason$wasClean$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id, long, id, BOOL); static void (*_logos_orig$_ungrouped$ZPWebSocket$webSocket$didReceivePong$)(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$ZPWebSocket$webSocket$didReceivePong$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$ZPWebSocket$webSocket$didReceiveMessage$)(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$ZPWebSocket$webSocket$didReceiveMessage$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_orig$_ungrouped$CBFPrivateCheckView$exitAction)(_LOGOS_SELF_TYPE_NORMAL CBFPrivateCheckView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CBFPrivateCheckView$exitAction(_LOGOS_SELF_TYPE_NORMAL CBFPrivateCheckView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$CBFPrivateCheckView$completeAction)(_LOGOS_SELF_TYPE_NORMAL CBFPrivateCheckView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CBFPrivateCheckView$completeAction(_LOGOS_SELF_TYPE_NORMAL CBFPrivateCheckView* _LOGOS_SELF_CONST, SEL); static UIAlertController* (*_logos_meta_orig$_ungrouped$UIAlertController$alertControllerWithTitle$message$preferredStyle$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString *, NSString *, UIAlertControllerStyle); static UIAlertController* _logos_meta_method$_ungrouped$UIAlertController$alertControllerWithTitle$message$preferredStyle$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString *, NSString *, UIAlertControllerStyle); static UIAlertView* (*_logos_orig$_ungrouped$UIAlertView$initWithTitle$message$delegate$cancelButtonTitle$otherButtonTitles$)(_LOGOS_SELF_TYPE_INIT UIAlertView*, SEL,  NSString *,  NSString *,  id,  NSString *,  NSString *) _LOGOS_RETURN_RETAINED; static UIAlertView* _logos_method$_ungrouped$UIAlertView$initWithTitle$message$delegate$cancelButtonTitle$otherButtonTitles$(_LOGOS_SELF_TYPE_INIT UIAlertView*, SEL,  NSString *,  NSString *,  id,  NSString *,  NSString *) _LOGOS_RETURN_RETAINED; static ZPLiveRoomManager* _logos_meta_method$_ungrouped$ZPLiveRoomManager$shareRoomManager(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$deleteRoomManagerWithUserID$userName$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$deleteRoomManagerWithUserID$userName$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$addRoomManagerWithUserID$userName$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$addRoomManagerWithUserID$userName$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$disableMsgWithUserID$userName$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$disableMsgWithUserID$userName$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$kickedLiveRoomWithUserID$userName$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$kickedLiveRoomWithUserID$userName$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userBindUidWithUserID$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userBindUidWithUserID$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userLogoutLiveRoomWithId$residenceTime$pullStramStatus$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, long, unsigned long); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userLogoutLiveRoomWithId$residenceTime$pullStramStatus$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, long, unsigned long); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userLoginLiveRoomWithRoomID$userName$userID$userLevelid$userUcuid$userToken$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id, id, id, id, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userLoginLiveRoomWithRoomID$userName$userID$userLevelid$userUcuid$userToken$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id, id, id, id, id); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$sendContentDict$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$sendContentDict$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userSenLightHeartWithColorIndex$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userSenLightHeartWithColorIndex$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$changeRoomToType$WithUserInfo$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, unsigned long, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$changeRoomToType$WithUserInfo$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, unsigned long, id); static void (*_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userSendPubMsgWithContent$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userSendPubMsgWithContent$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$MAudienceViewController$alertView$clickedButtonAtIndex$)(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST, SEL, id, long long); static void _logos_method$_ungrouped$MAudienceViewController$alertView$clickedButtonAtIndex$(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST, SEL, id, long long); static void (*_logos_orig$_ungrouped$MAudienceViewController$editingToolbarSendMessage$isBarrage$)(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void _logos_method$_ungrouped$MAudienceViewController$editingToolbarSendMessage$isBarrage$(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST, SEL, id, _Bool); static void _logos_method$_ungrouped$MAudienceViewController$sendMsg$(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST, SEL, NSString *); static NSString * _logos_method$_ungrouped$MAudienceViewController$currentTime(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$HTTPManager$GetWithUrl$Params$successHander$failHander$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString *, id, void (^)(id response), id); static id _logos_meta_method$_ungrouped$HTTPManager$GetWithUrl$Params$successHander$failHander$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSString *, id, void (^)(id response), id); static id (*_logos_meta_orig$_ungrouped$HTTPManager$PostWithUrl$Params$successHander$failHander$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id, void (^)(id response), id); static id _logos_meta_method$_ungrouped$HTTPManager$PostWithUrl$Params$successHander$failHander$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id, void (^)(id response), id); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$NSJSONSerialization(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("NSJSONSerialization"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$JZTDateUtils(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("JZTDateUtils"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$User(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("User"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$ZPLiveRoomManager(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("ZPLiveRoomManager"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$ZPWebSocket(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("ZPWebSocket"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$NSDate(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("NSDate"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$NSMutableDictionary(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("NSMutableDictionary"); } return _klass; }
#line 24 "/Users/liangze/Documents/Desktop/pojieAPPS/Zhibo/ZhiboDylib/TweakEmpty.xm"

static void _logos_method$_ungrouped$SRWebSocket$send$(_LOGOS_SELF_TYPE_NORMAL SRWebSocket* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    HBLogDebug(@"-[<SRWebSocket: %p> send:%@]", self, arg1);
    _logos_orig$_ungrouped$SRWebSocket$send$(self, _cmd, arg1);
}


@interface ZPWebSocket : NSObject

@property(retain, nonatomic) SRWebSocket *webSocket;

+ (id) shareZPWebSocket;

- (void) send:(id)arg1;

- (void) webSocket:(id)arg1 didFailWithError:(id)arg2;
- (void) webSocket:(id)arg1 didCloseWithCode:(long)arg2 reason:(id)arg3 wasClean:(BOOL)arg4;
- (void) webSocket:(id)arg1 didReceivePong:(id)arg2;
- (void) webSocket:(id)arg1 didReceiveMessage:(id)arg2;

@end







static void _logos_method$_ungrouped$ZPWebSocket$send$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    
    _logos_orig$_ungrouped$ZPWebSocket$send$(self, _cmd, arg1);
    
    
}

static void _logos_method$_ungrouped$ZPWebSocket$webSocket$didFailWithError$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    HBLogDebug(@"-[<ZPWebSocket: %p> webSocket:%@ didFailWithError:%@]", self, arg1, arg2);
    _logos_orig$_ungrouped$ZPWebSocket$webSocket$didFailWithError$(self, _cmd, arg1, arg2);
}
static void _logos_method$_ungrouped$ZPWebSocket$webSocket$didCloseWithCode$reason$wasClean$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, long arg2, id arg3, BOOL arg4){
    HBLogDebug(@"-[<ZPWebSocket: %p> webSocket:%@ didCloseWithCode:%ld reason:%@ wasClean:%d]", self, arg1, arg2, arg3, arg4);
    _logos_orig$_ungrouped$ZPWebSocket$webSocket$didCloseWithCode$reason$wasClean$(self, _cmd, arg1, arg2, arg3, arg4);
}
static void _logos_method$_ungrouped$ZPWebSocket$webSocket$didReceivePong$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    HBLogDebug(@"-[<ZPWebSocket: %p> webSocket:%@ didReceivePong:%@]", self, arg1, arg2);
    _logos_orig$_ungrouped$ZPWebSocket$webSocket$didReceivePong$(self, _cmd, arg1, arg2);
}
static void _logos_method$_ungrouped$ZPWebSocket$webSocket$didReceiveMessage$(_LOGOS_SELF_TYPE_NORMAL ZPWebSocket* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    
    NSData *data = [arg2 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * jsonDict = [_logos_static_class_lookup$NSJSONSerialization() JSONObjectWithData:data
                                                                  options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"Socket收到的消息是:%@",jsonDict);
    _logos_orig$_ungrouped$ZPWebSocket$webSocket$didReceiveMessage$(self, _cmd, arg1, arg2);
}








@interface CBFPrivateCheckView : NSObject


- (void)exitAction;

- (void)completeAction;
@end




@interface UserModel : NSObject

@property(copy, nonatomic) NSString *curroomnum; 

@end




@interface UserInfoModel : NSObject


@property(retain, nonatomic) NSDictionary *limitDic; 
@property(nonatomic) _Bool is_legend; 
@property(nonatomic) _Bool is_single_conversation; 
@property(copy, nonatomic) NSString *im_app_key; 
@property(copy, nonatomic) NSString *pull_url; 
@property(copy, nonatomic) NSString *drawer_id; 
@property(copy, nonatomic) NSString *gameType; 
@property(copy, nonatomic) NSString *wxunionid; 
@property(copy, nonatomic) NSString *approveid; 
@property(copy, nonatomic) NSString *province; 
@property(copy, nonatomic) NSString *professional; 
@property(nonatomic) _Bool toy_status; 
@property(copy, nonatomic) NSString *isHit; 
@property(copy, nonatomic) NSString *emotion; 
@property(copy, nonatomic) NSString *birthday; 
@property(copy, nonatomic) NSString *playBackCount; 
@property(copy, nonatomic) NSString *level; 
@property(nonatomic) _Bool attention; 
@property(nonatomic) double spendcoin; 
@property(copy, nonatomic) NSString *followees_cnt; 
@property(copy, nonatomic) NSString *followers_cnt; 
@property(copy, nonatomic) NSString *avatar; 
@property(retain, nonatomic) NSArray *contribute; 
@property(copy, nonatomic) NSString *name_card; 
@property(nonatomic) double anchorBalance; 
@property(nonatomic) double chipbalance; 
@property(nonatomic) double beanorignal; 
@property(nonatomic) double beanbalance; 
@property(nonatomic) double coinbalance; 
@property(copy, nonatomic) NSString *peerage_id; 
@property(copy, nonatomic) NSString *broadcasting; 
@property(copy, nonatomic) NSString *vip; 
@property(copy, nonatomic) NSString *curroomnum; 
@property(copy, nonatomic) NSString *snap; 
@property(copy, nonatomic) NSString *city; 
@property(copy, nonatomic) NSString *username; 
@property(copy, nonatomic) NSString *nickname; 
@property(copy, nonatomic) NSString *intro; 
@property(copy, nonatomic) NSString *sex; 
@property(nonatomic) _Bool isFriend; 
@property(copy, nonatomic) NSString *id; 


@property (nonatomic) double pointbalance;
@property(copy, nonatomic) NSString *ucuid;
@property(copy, nonatomic) NSString *avatartime;




@end




@interface User : NSObject

+ (id)sharedManager;

@property(retain, nonatomic) UserInfoModel *user;

@end







static void _logos_method$_ungrouped$CBFPrivateCheckView$exitAction(_LOGOS_SELF_TYPE_NORMAL CBFPrivateCheckView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    UIViewController *r = (UIViewController *)self;
    [r dismissViewControllerAnimated:true completion:nil];
    [r.view removeFromSuperview];
    [r removeFromParentViewController];
}


static void _logos_method$_ungrouped$CBFPrivateCheckView$completeAction(_LOGOS_SELF_TYPE_NORMAL CBFPrivateCheckView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    HBLogDebug(@"-[<CBFPrivateCheckView: %p> completeAction]", self);
    _logos_orig$_ungrouped$CBFPrivateCheckView$completeAction(self, _cmd);
    [self exitAction];
}









static UIAlertController* _logos_meta_method$_ungrouped$UIAlertController$alertControllerWithTitle$message$preferredStyle$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * title, NSString * message, UIAlertControllerStyle preferredStyle) {
    HBLogDebug(@"+[<UIAlertController: %p> alertControllerWithTitle:%@ message:%@ preferredStyle:0x%x]", self, title, message, (unsigned int)preferredStyle);
    return _logos_meta_orig$_ungrouped$UIAlertController$alertControllerWithTitle$message$preferredStyle$(self, _cmd, title, message, preferredStyle);
}






static UIAlertView* _logos_method$_ungrouped$UIAlertView$initWithTitle$message$delegate$cancelButtonTitle$otherButtonTitles$(_LOGOS_SELF_TYPE_INIT UIAlertView* __unused self, SEL __unused _cmd,  NSString * title,  NSString * message,  id delegate,  NSString * cancelButtonTitle,  NSString * otherButtonTitles) _LOGOS_RETURN_RETAINED {
    HBLogDebug(@"-[<UIAlertView: %p> initWithTitle:%@ message:%@ delegate:%@ cancelButtonTitle:%@ otherButtonTitles:%@]", self, title, message, delegate, cancelButtonTitle, otherButtonTitles);
    return _logos_orig$_ungrouped$UIAlertView$initWithTitle$message$delegate$cancelButtonTitle$otherButtonTitles$(self, _cmd, title, message, delegate, cancelButtonTitle, otherButtonTitles);
}



@interface ZPLiveRoomManager : NSObject

+ (instancetype)shareRoomManager;

@property(nonatomic, copy) NSString *userId;


@end







static ZPLiveRoomManager* _logos_meta_method$_ungrouped$ZPLiveRoomManager$shareRoomManager(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    static ZPLiveRoomManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[_logos_static_class_lookup$ZPLiveRoomManager() alloc] init];
    });
    
    return manager;
}



static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$deleteRoomManagerWithUserID$userName$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> deleteRoomManagerWithUserID:%@ userName:%@]", self, arg1, arg2);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$deleteRoomManagerWithUserID$userName$(self, _cmd, arg1, arg2);
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$addRoomManagerWithUserID$userName$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> addRoomManagerWithUserID:%@ userName:%@]", self, arg1, arg2);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$addRoomManagerWithUserID$userName$(self, _cmd, arg1, arg2);
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$disableMsgWithUserID$userName$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> disableMsgWithUserID:%@ userName:%@]", self, arg1, arg2);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$disableMsgWithUserID$userName$(self, _cmd, arg1, arg2);
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$kickedLiveRoomWithUserID$userName$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> kickedLiveRoomWithUserID:%@ userName:%@]", self, arg1, arg2);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$kickedLiveRoomWithUserID$userName$(self, _cmd, arg1, arg2);
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userBindUidWithUserID$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> userBindUidWithUserID:%@]", self, arg1);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$userBindUidWithUserID$(self, _cmd, arg1);
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userLogoutLiveRoomWithId$residenceTime$pullStramStatus$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, long arg2, unsigned long arg3){
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> userLogoutLiveRoomWithId:%@ residenceTime:%ld pullStramStatus:%lu]", self, arg1, arg2, arg3);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$userLogoutLiveRoomWithId$residenceTime$pullStramStatus$(self, _cmd, arg1, arg2, arg3);
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userLoginLiveRoomWithRoomID$userName$userID$userLevelid$userUcuid$userToken$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3, id arg4, id arg5, id arg6){
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> userLoginLiveRoomWithRoomID:%@ userName:%@ userID:%@ userLevelid:%@ userUcuid:%@ userToken:%@]", self, arg1, arg2, arg3, arg4, arg5, arg6);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$userLoginLiveRoomWithRoomID$userName$userID$userLevelid$userUcuid$userToken$(self, _cmd, arg1, arg2, arg3, arg4, arg5, arg6);
    ZPLiveRoomManager *manager = [_logos_static_class_lookup$ZPLiveRoomManager() shareRoomManager];
    manager.userId = arg3;
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$sendContentDict$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> sendContentDict:%@]", self, arg1);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$sendContentDict$(self, _cmd, arg1);
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userSenLightHeartWithColorIndex$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> userSenLightHeartWithColorIndex:%@]", self, arg1);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$userSenLightHeartWithColorIndex$(self, _cmd, arg1);
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$changeRoomToType$WithUserInfo$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, unsigned long arg1, id arg2){
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> changeRoomToType:%lu WithUserInfo:%@]", self, arg1, arg2);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$changeRoomToType$WithUserInfo$(self, _cmd, arg1, arg2);
}
static void _logos_meta_method$_ungrouped$ZPLiveRoomManager$userSendPubMsgWithContent$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    HBLogDebug(@"+[<ZPLiveRoomManager: %p> userSendPubMsgWithContent:%@]", self, arg1);
    _logos_meta_orig$_ungrouped$ZPLiveRoomManager$userSendPubMsgWithContent$(self, _cmd, arg1);
}


__attribute__((used)) static NSString * _logos_method$_ungrouped$ZPLiveRoomManager$userId(ZPLiveRoomManager * __unused self, SEL __unused _cmd) { return (NSString *)objc_getAssociatedObject(self, (void *)_logos_method$_ungrouped$ZPLiveRoomManager$userId); }; __attribute__((used)) static void _logos_method$_ungrouped$ZPLiveRoomManager$setUserId(ZPLiveRoomManager * __unused self, SEL __unused _cmd, NSString * rawValue) { objc_setAssociatedObject(self, (void *)_logos_method$_ungrouped$ZPLiveRoomManager$userId, rawValue, OBJC_ASSOCIATION_COPY_NONATOMIC); }











@interface MAudienceViewController : NSObject
- (UserModel *)anchorInfoData;
- (void)sendMsg:(NSString *)msg;
- (NSString *)currentTime;
@end










static void _logos_method$_ungrouped$MAudienceViewController$alertView$clickedButtonAtIndex$(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, long long arg2) {
    _logos_orig$_ungrouped$MAudienceViewController$alertView$clickedButtonAtIndex$(self, _cmd, arg1,arg2);
}




static void _logos_method$_ungrouped$MAudienceViewController$editingToolbarSendMessage$isBarrage$(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, _Bool arg2) {
    _logos_orig$_ungrouped$MAudienceViewController$editingToolbarSendMessage$isBarrage$(self, _cmd, arg1,YES);
    [self sendMsg:arg1];
}





static void _logos_method$_ungrouped$MAudienceViewController$sendMsg$(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * msg) {
    NSString *roomID = [self anchorInfoData].curroomnum;
    NSLog(@"%@",roomID);
    
    User *temp = [_logos_static_class_lookup$User() sharedManager];
    
    UserInfoModel *infoModel = temp.user;
    
    NSDictionary *baseDic = @{@"vip":@"0",
                              @"type":@"SendPubMsg",
                              @"fly":@"",
                              @"from_user_role":@"viewer",
                              @"avatar":@"/style/images/default_v5.png",
                              @"from_user_peerage_id":@"0"
                              };
    
    
    NSMutableDictionary *mDic = [_logos_static_class_lookup$NSMutableDictionary() dictionaryWithDictionary:baseDic];
    [mDic setObject:roomID forKey:@"room_id"];
    [mDic setObject:[self currentTime] forKey:@"time"];
    [mDic setObject:@"11" forKey:@"levelid"];
    [mDic setObject:@"3590547" forKey:@"from_user_id"];
    [mDic setObject:infoModel.nickname forKey:@"from_client_name"];
    [mDic setObject:msg forKey:@"content"];
    
    NSString *json = [mDic performSelector:@selector(mj_JSONString)];
    
    NSLog(@"当前发出去的消息:%@",json);
    
    
    [[_logos_static_class_lookup$ZPWebSocket() shareZPWebSocket] send:json];
}





static NSString * _logos_method$_ungrouped$MAudienceViewController$currentTime(_LOGOS_SELF_TYPE_NORMAL MAudienceViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    NSTimeInterval timeIntervar = [[_logos_static_class_lookup$NSDate() date] timeIntervalSince1970];
    return [_logos_static_class_lookup$JZTDateUtils() stringWithTime5:timeIntervar];
    
}









static id _logos_meta_method$_ungrouped$HTTPManager$GetWithUrl$Params$successHander$failHander$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * path, id arg2, void (^arg3)(id response), id arg4) {
    
    void (^newBlock)(NSDictionary *response) = ^(NSDictionary *response) {
        
        NSLog(@"当前接口地址是:%@\n",path);
        NSLog(@"当前接口参数是:%@\n",[[arg2 modelToJSONObject] jsonPrettyStringEncoded]);
        NSLog(@"当前接口返回是:%@\n",[[response modelToJSONObject] jsonPrettyStringEncoded]);
        
        if ([path containsString:@"Private/checkPrivateCharge"]){
            NSDictionary *tempDic = @{
                                      @"msg" : @"ok",
                                      @"data" : @{
                                              @"anchor":@{
                                                      }
                                              },
                                      @"code":@"0"
                                      };
            arg3(tempDic);
        } else if([path containsString:@"/gift/sendBarrage"]) {
            
            NSDictionary *tempDic = @{@"msg" : @"ok",
                                      @"data" : @{@"coinbalance":@"9999"},@"code":@"0"};
            arg3(tempDic);
        }else {
            arg3(response);
        }
        
    };
    
    id ret = _logos_meta_orig$_ungrouped$HTTPManager$GetWithUrl$Params$successHander$failHander$(self, _cmd, path,arg2,newBlock,arg4);
    return ret;
}



static id _logos_meta_method$_ungrouped$HTTPManager$PostWithUrl$Params$successHander$failHander$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, void (^arg3)(id response), id arg4) {
    
    void (^newBlock)(NSDictionary *response) = ^(NSDictionary *response) {
        
        NSLog(@"当前接口地址是:%@/n",arg1);
        NSLog(@"当前接口参数是:%@/n",[[arg2 modelToJSONObject] jsonPrettyStringEncoded]);
        NSLog(@"当前接口返回是:%@/n",[[response modelToJSONObject] jsonPrettyStringEncoded]);
        if(arg3) {
            arg3(response);
        }
    };
    
    id ret = _logos_meta_orig$_ungrouped$HTTPManager$PostWithUrl$Params$successHander$failHander$(self, _cmd, arg1,arg2,newBlock,arg4);
    return ret;
    
}






























static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SRWebSocket = objc_getClass("SRWebSocket"); MSHookMessageEx(_logos_class$_ungrouped$SRWebSocket, @selector(send:), (IMP)&_logos_method$_ungrouped$SRWebSocket$send$, (IMP*)&_logos_orig$_ungrouped$SRWebSocket$send$);Class _logos_class$_ungrouped$ZPWebSocket = objc_getClass("ZPWebSocket"); MSHookMessageEx(_logos_class$_ungrouped$ZPWebSocket, @selector(send:), (IMP)&_logos_method$_ungrouped$ZPWebSocket$send$, (IMP*)&_logos_orig$_ungrouped$ZPWebSocket$send$);MSHookMessageEx(_logos_class$_ungrouped$ZPWebSocket, @selector(webSocket:didFailWithError:), (IMP)&_logos_method$_ungrouped$ZPWebSocket$webSocket$didFailWithError$, (IMP*)&_logos_orig$_ungrouped$ZPWebSocket$webSocket$didFailWithError$);MSHookMessageEx(_logos_class$_ungrouped$ZPWebSocket, @selector(webSocket:didCloseWithCode:reason:wasClean:), (IMP)&_logos_method$_ungrouped$ZPWebSocket$webSocket$didCloseWithCode$reason$wasClean$, (IMP*)&_logos_orig$_ungrouped$ZPWebSocket$webSocket$didCloseWithCode$reason$wasClean$);MSHookMessageEx(_logos_class$_ungrouped$ZPWebSocket, @selector(webSocket:didReceivePong:), (IMP)&_logos_method$_ungrouped$ZPWebSocket$webSocket$didReceivePong$, (IMP*)&_logos_orig$_ungrouped$ZPWebSocket$webSocket$didReceivePong$);MSHookMessageEx(_logos_class$_ungrouped$ZPWebSocket, @selector(webSocket:didReceiveMessage:), (IMP)&_logos_method$_ungrouped$ZPWebSocket$webSocket$didReceiveMessage$, (IMP*)&_logos_orig$_ungrouped$ZPWebSocket$webSocket$didReceiveMessage$);Class _logos_class$_ungrouped$CBFPrivateCheckView = objc_getClass("CBFPrivateCheckView"); MSHookMessageEx(_logos_class$_ungrouped$CBFPrivateCheckView, @selector(exitAction), (IMP)&_logos_method$_ungrouped$CBFPrivateCheckView$exitAction, (IMP*)&_logos_orig$_ungrouped$CBFPrivateCheckView$exitAction);MSHookMessageEx(_logos_class$_ungrouped$CBFPrivateCheckView, @selector(completeAction), (IMP)&_logos_method$_ungrouped$CBFPrivateCheckView$completeAction, (IMP*)&_logos_orig$_ungrouped$CBFPrivateCheckView$completeAction);Class _logos_class$_ungrouped$UIAlertController = objc_getClass("UIAlertController"); Class _logos_metaclass$_ungrouped$UIAlertController = object_getClass(_logos_class$_ungrouped$UIAlertController); MSHookMessageEx(_logos_metaclass$_ungrouped$UIAlertController, @selector(alertControllerWithTitle:message:preferredStyle:), (IMP)&_logos_meta_method$_ungrouped$UIAlertController$alertControllerWithTitle$message$preferredStyle$, (IMP*)&_logos_meta_orig$_ungrouped$UIAlertController$alertControllerWithTitle$message$preferredStyle$);Class _logos_class$_ungrouped$UIAlertView = objc_getClass("UIAlertView"); MSHookMessageEx(_logos_class$_ungrouped$UIAlertView, @selector(initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:), (IMP)&_logos_method$_ungrouped$UIAlertView$initWithTitle$message$delegate$cancelButtonTitle$otherButtonTitles$, (IMP*)&_logos_orig$_ungrouped$UIAlertView$initWithTitle$message$delegate$cancelButtonTitle$otherButtonTitles$);Class _logos_class$_ungrouped$ZPLiveRoomManager = objc_getClass("ZPLiveRoomManager"); Class _logos_metaclass$_ungrouped$ZPLiveRoomManager = object_getClass(_logos_class$_ungrouped$ZPLiveRoomManager); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(shareRoomManager), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$shareRoomManager, _typeEncoding); }MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(deleteRoomManagerWithUserID:userName:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$deleteRoomManagerWithUserID$userName$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$deleteRoomManagerWithUserID$userName$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(addRoomManagerWithUserID:userName:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$addRoomManagerWithUserID$userName$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$addRoomManagerWithUserID$userName$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(disableMsgWithUserID:userName:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$disableMsgWithUserID$userName$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$disableMsgWithUserID$userName$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(kickedLiveRoomWithUserID:userName:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$kickedLiveRoomWithUserID$userName$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$kickedLiveRoomWithUserID$userName$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(userBindUidWithUserID:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$userBindUidWithUserID$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userBindUidWithUserID$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(userLogoutLiveRoomWithId:residenceTime:pullStramStatus:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$userLogoutLiveRoomWithId$residenceTime$pullStramStatus$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userLogoutLiveRoomWithId$residenceTime$pullStramStatus$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(userLoginLiveRoomWithRoomID:userName:userID:userLevelid:userUcuid:userToken:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$userLoginLiveRoomWithRoomID$userName$userID$userLevelid$userUcuid$userToken$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userLoginLiveRoomWithRoomID$userName$userID$userLevelid$userUcuid$userToken$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(sendContentDict:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$sendContentDict$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$sendContentDict$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(userSenLightHeartWithColorIndex:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$userSenLightHeartWithColorIndex$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userSenLightHeartWithColorIndex$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(changeRoomToType:WithUserInfo:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$changeRoomToType$WithUserInfo$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$changeRoomToType$WithUserInfo$);MSHookMessageEx(_logos_metaclass$_ungrouped$ZPLiveRoomManager, @selector(userSendPubMsgWithContent:), (IMP)&_logos_meta_method$_ungrouped$ZPLiveRoomManager$userSendPubMsgWithContent$, (IMP*)&_logos_meta_orig$_ungrouped$ZPLiveRoomManager$userSendPubMsgWithContent$);{ char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(NSString *)); class_addMethod(_logos_class$_ungrouped$ZPLiveRoomManager, @selector(userId), (IMP)&_logos_method$_ungrouped$ZPLiveRoomManager$userId, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(NSString *)); class_addMethod(_logos_class$_ungrouped$ZPLiveRoomManager, @selector(setUserId:), (IMP)&_logos_method$_ungrouped$ZPLiveRoomManager$setUserId, _typeEncoding); } Class _logos_class$_ungrouped$MAudienceViewController = objc_getClass("MAudienceViewController"); MSHookMessageEx(_logos_class$_ungrouped$MAudienceViewController, @selector(alertView:clickedButtonAtIndex:), (IMP)&_logos_method$_ungrouped$MAudienceViewController$alertView$clickedButtonAtIndex$, (IMP*)&_logos_orig$_ungrouped$MAudienceViewController$alertView$clickedButtonAtIndex$);MSHookMessageEx(_logos_class$_ungrouped$MAudienceViewController, @selector(editingToolbarSendMessage:isBarrage:), (IMP)&_logos_method$_ungrouped$MAudienceViewController$editingToolbarSendMessage$isBarrage$, (IMP*)&_logos_orig$_ungrouped$MAudienceViewController$editingToolbarSendMessage$isBarrage$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$MAudienceViewController, @selector(sendMsg:), (IMP)&_logos_method$_ungrouped$MAudienceViewController$sendMsg$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$MAudienceViewController, @selector(currentTime), (IMP)&_logos_method$_ungrouped$MAudienceViewController$currentTime, _typeEncoding); }Class _logos_class$_ungrouped$HTTPManager = objc_getClass("HTTPManager"); Class _logos_metaclass$_ungrouped$HTTPManager = object_getClass(_logos_class$_ungrouped$HTTPManager); MSHookMessageEx(_logos_metaclass$_ungrouped$HTTPManager, @selector(GetWithUrl:Params:successHander:failHander:), (IMP)&_logos_meta_method$_ungrouped$HTTPManager$GetWithUrl$Params$successHander$failHander$, (IMP*)&_logos_meta_orig$_ungrouped$HTTPManager$GetWithUrl$Params$successHander$failHander$);MSHookMessageEx(_logos_metaclass$_ungrouped$HTTPManager, @selector(PostWithUrl:Params:successHander:failHander:), (IMP)&_logos_meta_method$_ungrouped$HTTPManager$PostWithUrl$Params$successHander$failHander$, (IMP*)&_logos_meta_orig$_ungrouped$HTTPManager$PostWithUrl$Params$successHander$failHander$);} }
#line 469 "/Users/liangze/Documents/Desktop/pojieAPPS/Zhibo/ZhiboDylib/TweakEmpty.xm"
