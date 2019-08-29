//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSDate, NSString;

@interface TBSDKConfiguration : NSObject
{
    int _environment;
    NSString *_wapTTID;
    NSString *_customHost;
    double _timestampOffset;
    unsigned long long _features;
    NSString *_host;
}

+ (id)shareInstance;
@property(retain, nonatomic) NSString *host; // @synthesize host=_host;
@property(readonly, nonatomic) unsigned long long features; // @synthesize features=_features;
@property(nonatomic) double timestampOffset; // @synthesize timestampOffset=_timestampOffset;
@property(retain, nonatomic) NSString *customHost; // @synthesize customHost=_customHost;
@property(retain, nonatomic) NSString *wapTTID; // @synthesize wapTTID=_wapTTID;
@property(nonatomic) int environment; // @synthesize environment=_environment;
- (void).cxx_destruct;
@property(retain, nonatomic) NSString *authCode;
@property(readonly, nonatomic) NSString *appKey;
@property(readonly, nonatomic) NSString *utdid;
@property(readonly, nonatomic) NSDate *serverDate;
- (id)init;

@end
