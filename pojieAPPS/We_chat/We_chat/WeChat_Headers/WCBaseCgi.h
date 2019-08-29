//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MMObject.h"

#import "PBCoding-Protocol.h"
#import "PBMessageObserverDelegate-Protocol.h"

@class NSString, WXPBGeneratedMessage;
@protocol WCBaseCgiDelegate;

@interface WCBaseCgi : MMObject <PBMessageObserverDelegate, PBCoding>
{
    _Bool isNeedNotify;
    _Bool isAutoLifeCycle;
    unsigned int cgiNumber;
    unsigned int retryCount;
    unsigned int eventID;
    NSString *debugModuleName;
    WXPBGeneratedMessage *request;
    unsigned long long cgiStatus;
    unsigned long long cacheType;
    unsigned long long cacheDuration;
    unsigned long long cacheExpiredDate;
    double _serverProcessCost;
    double _totalTimeout;
    id <WCBaseCgiDelegate> _delegate;
    Class _cacheResponseClass;
    WXPBGeneratedMessage *_cacheResponse;
}

+ (void)initialize;
@property(retain, nonatomic) WXPBGeneratedMessage *cacheResponse; // @synthesize cacheResponse=_cacheResponse;
@property(nonatomic) Class cacheResponseClass; // @synthesize cacheResponseClass=_cacheResponseClass;
@property(nonatomic) __weak id <WCBaseCgiDelegate> delegate; // @synthesize delegate=_delegate;
@property(nonatomic) double totalTimeout; // @synthesize totalTimeout=_totalTimeout;
@property(nonatomic) double serverProcessCost; // @synthesize serverProcessCost=_serverProcessCost;
@property(nonatomic) unsigned int eventID; // @synthesize eventID;
@property(nonatomic) unsigned long long cacheExpiredDate; // @synthesize cacheExpiredDate;
@property(nonatomic) unsigned long long cacheDuration; // @synthesize cacheDuration;
@property(nonatomic) unsigned long long cacheType; // @synthesize cacheType;
@property(nonatomic) unsigned long long cgiStatus; // @synthesize cgiStatus;
@property(nonatomic) _Bool isAutoLifeCycle; // @synthesize isAutoLifeCycle;
@property(nonatomic) _Bool isNeedNotify; // @synthesize isNeedNotify;
@property(nonatomic) unsigned int retryCount; // @synthesize retryCount;
@property(retain, nonatomic) WXPBGeneratedMessage *request; // @synthesize request;
@property(nonatomic) unsigned int cgiNumber; // @synthesize cgiNumber;
@property(copy, nonatomic) NSString *debugModuleName; // @synthesize debugModuleName;
- (void).cxx_destruct;
- (void)MessageReturn:(id)arg1 Event:(unsigned int)arg2;
- (void)didFailWithError:(id)arg1 reponse:(id)arg2;
- (void)didGetResponse:(id)arg1;
- (void)cacheResponse:(id)arg1;
- (id)cacheResponseKey;
- (id)expiredDateKey;
- (void)loadCacheImmediately;
- (_Bool)loadCache;
- (void)failWithNetworking:(int)arg1 response:(id)arg2;
- (void)startWithoutCache;
- (_Bool)prepareStart;
- (void)clearResponseCache;
- (void)start;
- (void)dealloc;
- (id)init;
- (const map_f8690629 *)getValueTagIndexMap;
- (id)getValueTypeTable;
@property(retain, nonatomic) id ftsUserData; // @dynamic ftsUserData;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
