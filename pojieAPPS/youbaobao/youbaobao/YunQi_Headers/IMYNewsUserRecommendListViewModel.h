//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface IMYNewsUserRecommendListViewModel : NSObject
{
    _Bool _is_mp_vip;
    NSString *_avatar;
    unsigned long long _user_id;
    NSString *_user_name;
    unsigned long long _fans;
    unsigned long long _isvip;
    unsigned long long _isfollow;
    unsigned long long _user_type;
    NSString *_userDescription;
    NSString *_uri;
}

+ (void)initialize;
@property(retain, nonatomic) NSString *uri; // @synthesize uri=_uri;
@property(retain, nonatomic) NSString *userDescription; // @synthesize userDescription=_userDescription;
@property(nonatomic) unsigned long long user_type; // @synthesize user_type=_user_type;
@property(nonatomic) unsigned long long isfollow; // @synthesize isfollow=_isfollow;
@property(nonatomic) _Bool is_mp_vip; // @synthesize is_mp_vip=_is_mp_vip;
@property(nonatomic) unsigned long long isvip; // @synthesize isvip=_isvip;
@property(nonatomic) unsigned long long fans; // @synthesize fans=_fans;
@property(retain, nonatomic) NSString *user_name; // @synthesize user_name=_user_name;
@property(nonatomic) unsigned long long user_id; // @synthesize user_id=_user_id;
@property(retain, nonatomic) NSString *avatar; // @synthesize avatar=_avatar;
- (void).cxx_destruct;
- (id)fansString;

@end
