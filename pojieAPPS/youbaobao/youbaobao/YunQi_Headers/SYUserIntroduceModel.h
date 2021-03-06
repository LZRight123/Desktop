//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSArray, NSString, SYAvatarModel, SYUserThumbDynamicModel;
@protocol SYUserTitle;

@interface SYUserIntroduceModel : NSObject
{
    int _fuid;
    int _is_married;
    int _isfollow;
    NSString *_avatar;
    NSString *_screen_name;
    NSString *_modename;
    NSString *_city;
    NSString *_hospital;
    NSString *_constellation;
    SYUserThumbDynamicModel *_content;
    NSArray<SYUserTitle> *_forumtitle;
    SYUserThumbDynamicModel *_topics;
    SYAvatarModel *_avatars;
    NSString *_reason;
    NSString *_comefrom;
    unsigned long long _isfake;
    NSString *_appname;
    NSString *_appurl;
    NSString *_appstart;
    long long _beenblack;
    long long _userrank;
}

@property(nonatomic) long long userrank; // @synthesize userrank=_userrank;
@property(nonatomic) long long beenblack; // @synthesize beenblack=_beenblack;
@property(copy, nonatomic) NSString *appstart; // @synthesize appstart=_appstart;
@property(copy, nonatomic) NSString *appurl; // @synthesize appurl=_appurl;
@property(copy, nonatomic) NSString *appname; // @synthesize appname=_appname;
@property(nonatomic) unsigned long long isfake; // @synthesize isfake=_isfake;
@property(copy, nonatomic) NSString *comefrom; // @synthesize comefrom=_comefrom;
@property(copy, nonatomic) NSString *reason; // @synthesize reason=_reason;
@property(retain, nonatomic) SYAvatarModel *avatars; // @synthesize avatars=_avatars;
@property(retain, nonatomic) SYUserThumbDynamicModel *topics; // @synthesize topics=_topics;
@property(nonatomic) int isfollow; // @synthesize isfollow=_isfollow;
@property(retain, nonatomic) NSArray<SYUserTitle> *forumtitle; // @synthesize forumtitle=_forumtitle;
@property(retain, nonatomic) SYUserThumbDynamicModel *content; // @synthesize content=_content;
@property(copy, nonatomic) NSString *constellation; // @synthesize constellation=_constellation;
@property(nonatomic) int is_married; // @synthesize is_married=_is_married;
@property(copy, nonatomic) NSString *hospital; // @synthesize hospital=_hospital;
@property(copy, nonatomic) NSString *city; // @synthesize city=_city;
@property(copy, nonatomic) NSString *modename; // @synthesize modename=_modename;
@property(copy, nonatomic) NSString *screen_name; // @synthesize screen_name=_screen_name;
@property(copy, nonatomic) NSString *avatar; // @synthesize avatar=_avatar;
@property(nonatomic) int fuid; // @synthesize fuid=_fuid;
- (void).cxx_destruct;
- (id)init;

@end

