//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface IMYAccountConfigService : NSObject
{
    _Bool _enableUnionLogin;
    _Bool _enableCaptcha;
    _Bool _enableCMOneKey;
    long long _style;
    unsigned long long _findAccountTimes;
    NSString *_privacyURL;
    NSString *_disclaimerURL;
}

+ (void)load;
+ (id)defaults;
+ (id)defaultConfig;
@property(nonatomic) _Bool enableCMOneKey; // @synthesize enableCMOneKey=_enableCMOneKey;
@property(nonatomic) _Bool enableCaptcha; // @synthesize enableCaptcha=_enableCaptcha;
@property(nonatomic) _Bool enableUnionLogin; // @synthesize enableUnionLogin=_enableUnionLogin;
@property(retain, nonatomic) NSString *disclaimerURL; // @synthesize disclaimerURL=_disclaimerURL;
@property(retain, nonatomic) NSString *privacyURL; // @synthesize privacyURL=_privacyURL;
@property(nonatomic) unsigned long long findAccountTimes; // @synthesize findAccountTimes=_findAccountTimes;
@property(nonatomic) long long style; // @synthesize style=_style;
- (void).cxx_destruct;
- (void)customInit;
- (id)init;

@end
