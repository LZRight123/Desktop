// See http://iphonedevwiki.net/index.php/Logos

#import <UIKit/UIKit.h>
#import "CCHelpTool.h"
@class CBFPrivateCheckView;



@interface UserModel : NSObject
+ (void)getUserInfoWithUserID:(id)arg1 Completion:(id/*block*/)arg2;
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
//@property(copy, nonatomic) NSString *id; // @synthesize id=_id;

@end


typedef NS_ENUM(NSUInteger, AFSSLPinningMode) {
    AFSSLPinningModeNone,
    AFSSLPinningModePublicKey,
    AFSSLPinningModeCertificate,
};
@interface AFSecurityPolicy : NSObject
//@property (readonly, nonatomic, assign) NSInteger SSLPinningMode;
@property (nonatomic, strong, ) NSSet <NSData *> *pinnedCertificates;

@property (nonatomic, assign) BOOL allowInvalidCertificates;
@property (nonatomic, assign) BOOL validatesDomainName;
+ (NSSet <NSData *> *)certificatesInBundle:(NSBundle *)bundle;
+ (instancetype)defaultPolicy;
+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode;
+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode withPinnedCertificates:(NSSet <NSData *> *)pinnedCertificates;
- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:( NSString *)domain;
@end


%hook AFSecurityPolicy
+ (instancetype)policyWithPinningMode:(NSUInteger)pinningMode withPinnedCertificates:(NSSet *)pinnedCertificates {
    AFSecurityPolicy *securityPolicy = %orig(0, pinnedCertificates);
    securityPolicy.allowInvalidCertificates = true;
    securityPolicy.validatesDomainName = false;
    return securityPolicy;
}
%end




%hook UIAlertController

+ (instancetype)alertControllerWithTitle:( NSString *)title message:( NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle{
    return %orig;
}

- (void)addAction:(UIAlertAction *)action{
    %orig;
}

%end



//MAudienceViewController 弹出 CBFPrivateCheckView
%hook MAudienceViewController
- (id)initWithUserType:(unsigned long long)arg1{
    ;
    //0010014EDBC bind_logic
    return %orig;
}
%end


%hook CBFPrivateCheckView
- (id)init{
//    frame #1: 0x0000000102bbf1cc Live-Audience`-[LiveRoomGuard pwdView] + 88
//    frame #2: 0x0000000102bbbec0 Live-Audience`-[LiveRoomGuard showPrivateCheckView] + 40
//    * frame #3: 0x0000000102bbd068 Live-Audience`__40-[LiveRoomGuard pulishToPreViewTimeRoom]_block_invoke_2 + 36
    ;
    return %orig;
}
- (void)exitAction{
    UIViewController *r = (UIViewController *)self;
    [r dismissViewControllerAnimated:true completion:nil];
    [r.view removeFromSuperview];
    [r removeFromParentViewController];
}
%end



//AFSecurityPolicy *policy = [AFSecurityPolicy defaultPolicy];




%hook AFHTTPSessionManager

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
URLString:(NSString *)URLString
parameters:(id)parameters
uploadProgress:(void (^)(NSProgress *uploadProgress)) uploadProgress
downloadProgress:(void (^)(NSProgress *downloadProgress)) downloadProgress
success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    void (^new_success)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject){
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"========>发起的请求是 %@\n响应是:%@",task.currentRequest.URL.absoluteString, obj);
        success(task, responseObject);
    };
    
    void (^new_failure)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"========>发起的请求是，失败了: %@", task.currentRequest.URL.absoluteString);
        failure(task, error);
    };
    NSURLSessionDataTask *task = %orig(method, URLString, parameters, uploadProgress, downloadProgress, new_success, new_failure);
    return task;
}

%end

%hook EncryptionTools
+ (id)desDecryptString:(id)arg1 keyString:(id)arg2 iv:(id)arg3 { %log; id r = %orig; return r; }
+ (id)desEncryptString:(id)arg1 keyString:(id)arg2 iv:(id)arg3 { %log; id r = %orig; return r; }
+ (id)aesDecryptString:(id)arg1 keyString:(id)arg2 iv:(id)arg3 decryptDataAddtionHandle:(id)arg4 { %log; id r = %orig; return r; }
+ (id)aesEncryptString:(id)arg1 keyString:(id)arg2 iv:(id)arg3 { %log; id r = %orig; return r; }
%end

%hook HTTPManager
+ (void)getWithUrl:(NSString *)path success:(id)arg2 fail:(id)arg3 {
//    generateHTTPSessionManager
//     01000807FC _tiger_generateHeaderButter
//    0100217DD0  _tiger_encrypt  加密 +[EncryptionTools aesEncryptString:keyString:@"7#0apwZ0zg*a932y" iv:[@"6v2cOih#uL2rmBj^" dataUsingEncoding:4]]
    
    %log;
    if ([path isEqualToString:@"/private/getPrivateLimit"]){
        NSLog(@"");
    }
    %orig;
}
+ (void)successCode:(id)arg1 { %log; %orig; }
+ (void)handleError:(id)arg1 failHander:(id)arg2 { %log; %orig; }
+ (void)handleSuccessWithTask:(id)arg1 responseObject:(id)arg2 successHander:(id)arg3 failHander:(id)arg4 { %log; %orig; }
+ (id)appendParams:(id)arg1 { %log; id r = %orig; return r; }
+ (id)handleUrl:(id)arg1 { %log; id r = %orig; return r; }
+ (id)UploadWithUrl:(id)arg1 Params:(id)arg2 uploadData:(id)arg3 successHander:(id)arg4 failHander:(id)arg5 { %log; id r = %orig; return r; }
+ (id)PostWithUrl:(id)arg1 Params:(id)arg2 successHander:(id)arg3 failHander:(id)arg4 { %log; id r = %orig; return r; }

//+ (id)GetWithUrl:(NSString *)path Params:(id)arg2 successHander:(void(^)(NSDictionary *))arg3 failHander:(void(^)(NSError *))arg4 {
//    if ([path isEqualToString:@"/private/getPrivateLimit"]){
//        NSLog(@"");
//    }
//    id r = %orig(path, arg2, arg3, arg4);
//    return r;
//    
//}
%end

%hook HttpClient
- (id)init { %log; id r = %orig; return r; }
- (void)close { %log; %orig; }
- (void)httpclient_set_property_l:(char *)arg1 value:(char *)arg2 { %log; %orig; }
- (void)httpclient_set_opt_l:(int)arg1 value:(void *)arg2 { %log; %orig; }
- (void)httpclient_set_callback_l:(id)arg1 cb_handle:(void *)arg2 { %log; %orig; }
- (int)httpclient_send_request_l:(id)arg1 { %log; int r = %orig; return r; }
%end



%hook LiveRoomGuard
+ (id)startRoomRouteFlowWithUserModel:(id)arg1 animation:(_Bool)arg2 { %log; id r = %orig; return r; }
+ (id)startRoomRouteFlowWithUserID:(id)arg1 animation:(_Bool)arg2 { %log; id r = %orig; return r; }
- (void)setAnimation:(_Bool )animation { %log; %orig; }
- (_Bool )animation { %log; _Bool  r = %orig; return r; }
- (void)setTryWatching:(_Bool )tryWatching { %log; %orig; }
- (_Bool )tryWatching { %log; _Bool  r = %orig; return r; }
- (void)setWaperedBlock:(id )waperedBlock { %log; %orig; }
- (id )waperedBlock { %log; id  r = %orig; return r; }
- (void)setPullUrl:(NSString *)pullUrl { %log; %orig; }
- (NSString *)pullUrl { %log; NSString * r = %orig; return r; }
- (void)setLimitDic:(NSDictionary *)limitDic { %log; %orig; }
- (NSDictionary *)limitDic { %log; NSDictionary * r = %orig; return r; }
- (void)setUserID:(NSString *)userID { %log; %orig; }
- (NSString *)userID { %log; NSString * r = %orig; return r; }
- (void)setModel:(UserModel *)model { %log; %orig; }
- (UserModel *)model { %log; UserModel * r = %orig; return r; }
- (void)setPwdView:(CBFPrivateCheckView *)pwdView { %log; %orig; }
- (CBFPrivateCheckView *)pwdView { %log; CBFPrivateCheckView * r = %orig; return r; }
- (void)setToController:(MAudienceViewController *)toController { %log; %orig; }
- (MAudienceViewController *)toController { %log; MAudienceViewController * r = %orig; return r; }
- (void)setDidPushToWatchVc:(id /*block*/ )didPushToWatchVc { %log; %orig; }
- (id /*block*/ )didPushToWatchVc { %log; id /*block*/  r = %orig; return r; }
- (void)setIsAdminSendNamecard:(_Bool )isAdminSendNamecard { %log; %orig; }
- (_Bool )isAdminSendNamecard { %log; _Bool  r = %orig; return r; }
- (void)setRole:(NSString *)role { %log; %orig; }
- (NSString *)role { %log; NSString * r = %orig; return r; }
- (void)checkVideoMoney { %log; %orig; }
- (void)checkUserMoney { %log; %orig; }
- (void)checkLevel { %log; %orig; }
- (void)checkTicketReq { %log; %orig; }
- (void)checkPassword:(id)arg1 { %log; %orig; }
- (void)checkVideoPoint { %log; %orig; }
- (void)checkUserPoint { %log; %orig; }
- (void)removePrivateView { %log; %orig; }
- (void)pulishToPreViewTimeRoom { %log; %orig; }
- (void)previewPrivateRoom { %log; %orig; }
- (void)pushAnchorBalanceVC { %log; %orig; }
- (void)pushToShareVC { %log; %orig; }
- (void)checkPrivate:(id)arg1 { %log; %orig; }
- (void)previewLiveRoom { %log; %orig; }
- (void)showPrivateCheckView { %log; %orig; }
- (void)closeRoomWithAlert:(id)arg1 { %log; %orig; }
- (void)pushToLiveRoom { %log; %orig; }
- (void)startLimitActionFlow { %log; %orig; }
- (id)getRoomType { %log; id r = %orig; return r; }
- (void)fetchRoomData { %log; %orig; }
- (void)bindLogic { %log; %orig; }
%end
