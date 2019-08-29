// See http://iphonedevwiki.net/index.php/Logos


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CCHelpTool.h"
#import "JZTDateUtils.h"
#import "NSDictionary+YYAdd.h"
#import <YYKit/YYKit.h>
//_shortMethodDescription



@interface SRWebSocket : NSObject

@property(nonatomic) long long readyState;

- (void)send:(id)arg1;
@end




%hook SRWebSocket
- (void)send:(id)arg1 {
    %log;
    %orig;
}
%end

@interface ZPWebSocket : NSObject

@property(retain, nonatomic) SRWebSocket *webSocket;

+ (id) shareZPWebSocket;

- (void) send:(id)arg1;

- (void) webSocket:(id)arg1 didFailWithError:(id)arg2;
- (void) webSocket:(id)arg1 didCloseWithCode:(long)arg2 reason:(id)arg3 wasClean:(BOOL)arg4;
- (void) webSocket:(id)arg1 didReceivePong:(id)arg2;
- (void) webSocket:(id)arg1 didReceiveMessage:(id)arg2;

@end




%hook ZPWebSocket


- (void) send:(id)arg1 {
    
    %orig;
    
    
}

- (void) webSocket:(id)arg1 didFailWithError:(id)arg2{
    %log;
    %orig;
}
- (void) webSocket:(id)arg1 didCloseWithCode:(long)arg2 reason:(id)arg3 wasClean:(BOOL)arg4{
    %log;
    %orig;
}
- (void) webSocket:(id)arg1 didReceivePong:(id)arg2{
    %log;
    %orig;
}
- (void) webSocket:(id)arg1 didReceiveMessage:(id)arg2{
    
    NSData *data = [arg2 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * jsonDict = [%c(NSJSONSerialization) JSONObjectWithData:data
                                                                  options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"Socket收到的消息是:%@",jsonDict);
    %orig;
}



%end




@interface CBFPrivateCheckView : NSObject


- (void)exitAction;

- (void)completeAction;
@end




@interface UserModel : NSObject

@property(copy, nonatomic) NSString *curroomnum; // @synthesize curroomnum=_curroomnum;

@end




@interface UserInfoModel : NSObject


@property(retain, nonatomic) NSDictionary *limitDic; // @synthesize limitDic=_limitDic;
@property(nonatomic) _Bool is_legend; // @synthesize is_legend=_is_legend;
@property(nonatomic) _Bool is_single_conversation; // @synthesize is_single_conversation=_is_single_conversation;
@property(copy, nonatomic) NSString *im_app_key; // @synthesize im_app_key=_im_app_key;
@property(copy, nonatomic) NSString *pull_url; // @synthesize pull_url=_pull_url;
@property(copy, nonatomic) NSString *drawer_id; // @synthesize drawer_id=_drawer_id;
@property(copy, nonatomic) NSString *gameType; // @synthesize gameType=_gameType;
@property(copy, nonatomic) NSString *wxunionid; // @synthesize wxunionid=_wxunionid;
@property(copy, nonatomic) NSString *approveid; // @synthesize approveid=_approveid;
@property(copy, nonatomic) NSString *province; // @synthesize province=_province;
@property(copy, nonatomic) NSString *professional; // @synthesize professional=_professional;
@property(nonatomic) _Bool toy_status; // @synthesize toy_status=_toy_status;
@property(copy, nonatomic) NSString *isHit; // @synthesize isHit=_isHit;
@property(copy, nonatomic) NSString *emotion; // @synthesize emotion=_emotion;
@property(copy, nonatomic) NSString *birthday; // @synthesize birthday=_birthday;
@property(copy, nonatomic) NSString *playBackCount; // @synthesize playBackCount=_playBackCount;
@property(copy, nonatomic) NSString *level; // @synthesize level=_level;
@property(nonatomic) _Bool attention; // @synthesize attention=_attention;
@property(nonatomic) double spendcoin; // @synthesize spendcoin=_spendcoin;
@property(copy, nonatomic) NSString *followees_cnt; // @synthesize followees_cnt=_followees_cnt;
@property(copy, nonatomic) NSString *followers_cnt; // @synthesize followers_cnt=_followers_cnt;
@property(copy, nonatomic) NSString *avatar; // @synthesize avatar=_avatar;
@property(retain, nonatomic) NSArray *contribute; // @synthesize contribute=_contribute;
@property(copy, nonatomic) NSString *name_card; // @synthesize name_card=_name_card;
@property(nonatomic) double anchorBalance; // @synthesize anchorBalance=_anchorBalance;
@property(nonatomic) double chipbalance; // @synthesize chipbalance=_chipbalance;
@property(nonatomic) double beanorignal; // @synthesize beanorignal=_beanorignal;
@property(nonatomic) double beanbalance; // @synthesize beanbalance=_beanbalance;
@property(nonatomic) double coinbalance; // @synthesize coinbalance=_coinbalance;
@property(copy, nonatomic) NSString *peerage_id; // @synthesize peerage_id=_peerage_id;
@property(copy, nonatomic) NSString *broadcasting; // @synthesize broadcasting=_broadcasting;
@property(copy, nonatomic) NSString *vip; // @synthesize vip=_vip;
@property(copy, nonatomic) NSString *curroomnum; // @synthesize curroomnum=_curroomnum;
@property(copy, nonatomic) NSString *snap; // @synthesize snap=_snap;
@property(copy, nonatomic) NSString *city; // @synthesize city=_city;
@property(copy, nonatomic) NSString *username; // @synthesize username=_username;
@property(copy, nonatomic) NSString *nickname; // @synthesize nickname=_nickname;
@property(copy, nonatomic) NSString *intro; // @synthesize intro=_intro;
@property(copy, nonatomic) NSString *sex; // @synthesize sex=_sex;
@property(nonatomic) _Bool isFriend; // @synthesize isFriend=_isFriend;
@property(copy, nonatomic) NSString *id; // @synthesize id=_id;


@property (nonatomic) double pointbalance;
@property(copy, nonatomic) NSString *ucuid;
@property(copy, nonatomic) NSString *avatartime;




@end




@interface User : NSObject

+ (id)sharedManager;

@property(retain, nonatomic) UserInfoModel *user;

@end





%hook CBFPrivateCheckView

- (void)exitAction {
    UIViewController *r = (UIViewController *)self;
    [r dismissViewControllerAnimated:true completion:nil];
    [r.view removeFromSuperview];
    [r removeFromParentViewController];
}


- (void)completeAction {
    %log;
    %orig;
    [self exitAction];
}



%end



%hook UIAlertController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    %log;
    return %orig;
}

%end


%hook UIAlertView

- (instancetype)initWithTitle:( NSString *)title message:( NSString *)message delegate:( id)delegate cancelButtonTitle:( NSString *)cancelButtonTitle otherButtonTitles:( NSString *)otherButtonTitles {
    %log;
    return %orig;
}

%end

@interface ZPLiveRoomManager : NSObject

+ (instancetype)shareRoomManager;

@property(nonatomic, copy) NSString *userId;


@end



%hook ZPLiveRoomManager


%new
+ (instancetype)shareRoomManager {
    static ZPLiveRoomManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[%c(ZPLiveRoomManager) alloc] init];
    });
    
    return manager;
}



+ (void) deleteRoomManagerWithUserID:(id)arg1 userName:(id)arg2 {
    %log;
    %orig;
}
+ (void) addRoomManagerWithUserID:(id)arg1 userName:(id)arg2 {
    %log;
    %orig;
}
+ (void) disableMsgWithUserID:(id)arg1 userName:(id)arg2{
    %log;
    %orig;
}
+ (void) kickedLiveRoomWithUserID:(id)arg1 userName:(id)arg2{
    %log;
    %orig;
}
+ (void) userBindUidWithUserID:(id)arg1{
    %log;
    %orig;
}
+ (void) userLogoutLiveRoomWithId:(id)arg1 residenceTime:(long)arg2 pullStramStatus:(unsigned long)arg3{
    %log;
    %orig;
}
+ (void) userLoginLiveRoomWithRoomID:(id)arg1 userName:(id)arg2 userID:(id)arg3 userLevelid:(id)arg4 userUcuid:(id)arg5 userToken:(id)arg6{
    %log;
    %orig;
    ZPLiveRoomManager *manager = [%c(ZPLiveRoomManager) shareRoomManager];
    manager.userId = arg3;
}
+ (void) sendContentDict:(id)arg1{
    %log;
    %orig;
}
+ (void) userSenLightHeartWithColorIndex:(id)arg1{
    %log;
    %orig;
}
+ (void) changeRoomToType:(unsigned long)arg1 WithUserInfo:(id)arg2{
    %log;
    %orig;
}
+ (void) userSendPubMsgWithContent:(id)arg1{
    %log;
    %orig;
}


%property(nonatomic, copy) NSString *userId;




%end






@interface MAudienceViewController : NSObject
- (UserModel *)anchorInfoData;
- (void)sendMsg:(NSString *)msg;
- (NSString *)currentTime;
@end





%hook MAudienceViewController




- (void)alertView:(id)arg1 clickedButtonAtIndex:(long long)arg2 {
    %orig(arg1,arg2);
}




- (void)editingToolbarSendMessage:(id)arg1 isBarrage:(_Bool)arg2 {
    %orig(arg1,YES);
    [self sendMsg:arg1];
}




%new
- (void)sendMsg:(NSString *)msg {
    NSString *roomID = [self anchorInfoData].curroomnum;
    NSLog(@"%@",roomID);
    
    User *temp = [%c(User) sharedManager];
    
    UserInfoModel *infoModel = temp.user;
    
    NSDictionary *baseDic = @{@"vip":@"0",
                              @"type":@"SendPubMsg",
                              @"fly":@"",
                              @"from_user_role":@"viewer",
                              @"avatar":@"/style/images/default_v5.png",
                              @"from_user_peerage_id":@"0"
                              };
    
    
    NSMutableDictionary *mDic = [%c(NSMutableDictionary) dictionaryWithDictionary:baseDic];
    [mDic setObject:roomID forKey:@"room_id"];
    [mDic setObject:[self currentTime] forKey:@"time"];
    [mDic setObject:@"11" forKey:@"levelid"];
    [mDic setObject:@"3590547" forKey:@"from_user_id"];
    [mDic setObject:infoModel.nickname forKey:@"from_client_name"];
    [mDic setObject:msg forKey:@"content"];
    
    NSString *json = [mDic performSelector:@selector(mj_JSONString)];
    
    NSLog(@"当前发出去的消息:%@",json);
    
    
    [[%c(ZPWebSocket) shareZPWebSocket] send:json];
}




%new
- (NSString *)currentTime {
    NSTimeInterval timeIntervar = [[%c(NSDate) date] timeIntervalSince1970];
    return [%c(JZTDateUtils) stringWithTime5:timeIntervar];
    
}



%end




%hook HTTPManager
+ (id) GetWithUrl:(NSString *)path Params:(id)arg2 successHander:(void (^)(id response))arg3 failHander:(id)arg4 {
    
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
    
    id ret = %orig(path,arg2,newBlock,arg4);
    return ret;
}



+ (id)PostWithUrl:(id)arg1 Params:(id)arg2 successHander:(void (^)(id response))arg3 failHander:(id)arg4 {
    
    void (^newBlock)(NSDictionary *response) = ^(NSDictionary *response) {
        
        NSLog(@"当前接口地址是:%@/n",arg1);
        NSLog(@"当前接口参数是:%@/n",[[arg2 modelToJSONObject] jsonPrettyStringEncoded]);
        NSLog(@"当前接口返回是:%@/n",[[response modelToJSONObject] jsonPrettyStringEncoded]);
        if(arg3) {
            arg3(response);
        }
    };
    
    id ret = %orig(arg1,arg2,newBlock,arg4);
    return ret;
    
}

%end




//@interface LiveRoomGuard : NSObject
//
//- (void) checkPrivate:(id)arg1 ;
//
//- (void) pushToLiveRoom;
//
//- (void) pulishToPreViewTimeRoom;
//@end
//
//%hook LiveRoomGuard
//
//- (void) checkPrivate:(id)arg1 {
//    [self pulishToPreViewTimeRoom];
//}
//
//
//- (void) pulishToPreViewTimeRoom {
//    %orig;
//}
//
//%end



