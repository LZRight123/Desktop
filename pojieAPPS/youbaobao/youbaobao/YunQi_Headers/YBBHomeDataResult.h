//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSMutableDictionary, YBBHomeDataConfig, YBBHomeGroupConfig;

@interface YBBHomeDataResult : NSObject
{
    _Bool _isCache;
    long long _day;
    long long _adOffset;
    YBBHomeDataConfig *_config;
    YBBHomeGroupConfig *_newsConfig;
    NSMutableDictionary *_resultDic;
}

@property(retain) NSMutableDictionary *resultDic; // @synthesize resultDic=_resultDic;
@property(retain, nonatomic) YBBHomeGroupConfig *newsConfig; // @synthesize newsConfig=_newsConfig;
@property(retain, nonatomic) YBBHomeDataConfig *config; // @synthesize config=_config;
@property(nonatomic) long long adOffset; // @synthesize adOffset=_adOffset;
@property(nonatomic) long long day; // @synthesize day=_day;
@property(nonatomic) _Bool isCache; // @synthesize isCache=_isCache;
- (void).cxx_destruct;
- (void)setSectionResultWithType:(unsigned long long)arg1 sectionResult:(id)arg2;
- (id)sectionResultWithType:(unsigned long long)arg1;
- (id)init;

@end

