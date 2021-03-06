//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSDate, NSDictionary, NSTimer;

@interface WatchTransaction : NSObject
{
    NSDictionary *_userInfo;
    CDUnknownBlockType _completion;
    unsigned long long _identifier;
    NSDate *_watchRequestTime;
    NSDate *_requestTime;
    NSDate *_replyTime;
    NSDate *_bumpTime;
    unsigned long long _bumpedIdentifier;
    NSDate *_reapTime;
    NSDate *_completionTime;
    CDUnknownBlockType _reply;
    NSTimer *_executionReaper;
}

+ (id)watchAnalyticsHelper;
+ (id)transactionLog;
+ (id)watchTransactionWithUserInfo:(id)arg1;
+ (id)watchTransactionWithUserInfo:(id)arg1 reply:(CDUnknownBlockType)arg2;
+ (void)addTransaction:(id)arg1;
+ (void)executeTransaction:(id)arg1;
+ (id)transactionInProgressForClass:(Class)arg1;
+ (double)transactionAgeLimit;
+ (_Bool)supportsParallelTransactions;
+ (void)executeTransactionWithUserInfo:(id)arg1 reply:(CDUnknownBlockType)arg2;
@property(retain, nonatomic) NSTimer *executionReaper; // @synthesize executionReaper=_executionReaper;
@property(copy, nonatomic) CDUnknownBlockType reply; // @synthesize reply=_reply;
@property(retain, nonatomic) NSDate *completionTime; // @synthesize completionTime=_completionTime;
@property(retain, nonatomic) NSDate *reapTime; // @synthesize reapTime=_reapTime;
@property(nonatomic) unsigned long long bumpedIdentifier; // @synthesize bumpedIdentifier=_bumpedIdentifier;
@property(retain, nonatomic) NSDate *bumpTime; // @synthesize bumpTime=_bumpTime;
@property(retain, nonatomic) NSDate *replyTime; // @synthesize replyTime=_replyTime;
@property(retain, nonatomic) NSDate *requestTime; // @synthesize requestTime=_requestTime;
@property(retain, nonatomic) NSDate *watchRequestTime; // @synthesize watchRequestTime=_watchRequestTime;
@property(nonatomic) unsigned long long identifier; // @synthesize identifier=_identifier;
@property(copy, nonatomic) CDUnknownBlockType completion; // @synthesize completion=_completion;
@property(retain, nonatomic) NSDictionary *userInfo; // @synthesize userInfo=_userInfo;
- (void).cxx_destruct;
- (id)watchAnalyticsHelper;
- (id)description;
- (id)transactionInfo;
- (id)logKeys;
- (void)logTransaction;
- (void)addTransactionLogInfo:(id)arg1;
- (void)completeWatchTransactionWithError:(id)arg1;
- (_Bool)isSignedIn;
- (id)initWithUserInfo:(id)arg1;
- (void)limitExecutionToSeconds:(double)arg1;
- (void)reapSlowTransaction;
- (id)execute;
- (void)_invokeWatchKitReplyWithInfo:(id)arg1;
- (void)_execute;
- (void)_completeTransaction;
- (void)dealloc;

@end

