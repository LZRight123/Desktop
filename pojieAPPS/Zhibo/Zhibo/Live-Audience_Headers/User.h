//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString, UserInfoModel;

@interface User : NSObject
{
    _Bool _isLogin;
    _Bool _jPushLoginSuccess;
    UserInfoModel *_user;
    NSString *_token;
}

+ (void)getUserMoneyCompletion:(CDUnknownBlockType)arg1;
+ (id)sharedManager;
@property(nonatomic) _Bool jPushLoginSuccess; // @synthesize jPushLoginSuccess=_jPushLoginSuccess;
@property(nonatomic) _Bool isLogin; // @synthesize isLogin=_isLogin;
@property(copy, nonatomic) NSString *token; // @synthesize token=_token;
@property(retain, nonatomic) UserInfoModel *user; // @synthesize user=_user;
- (void).cxx_destruct;
- (void)clearLoginStatus;

@end
