//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "WCSessionDelegate-Protocol.h"

@class NSString;

@interface MRTWatchAgent : NSObject <WCSessionDelegate>
{
}

+ (void)handleActivity:(id)arg1;
+ (_Bool)canHandleActivity:(id)arg1;
+ (void)activate;
+ (id)sharedAgent;
- (void)_viewReservationHandoff:(id)arg1;
- (void)_rewardsLoginHandoff:(id)arg1;
- (void)sessionDidDeactivate:(id)arg1;
- (void)sessionDidBecomeInactive:(id)arg1;
- (void)session:(id)arg1 activationDidCompleteWithState:(long long)arg2 error:(id)arg3;
- (void)session:(id)arg1 didReceiveMessage:(id)arg2;
- (void)session:(id)arg1 didReceiveMessage:(id)arg2 replyHandler:(CDUnknownBlockType)arg3;
- (void)dispatchFetchCommonDataOnce;
- (void)activateWCSession;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

