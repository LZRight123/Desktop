//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "ApptentiveAPIRequestDelegate-Protocol.h"

@class ApptentiveAPIRequest, NSDictionary, NSString;
@protocol ATDeviceUpdaterDelegate;

@interface ApptentiveDeviceUpdater : NSObject <ApptentiveAPIRequestDelegate>
{
    NSObject<ATDeviceUpdaterDelegate> *_delegate;
    NSDictionary *_sentDeviceJSON;
    ApptentiveAPIRequest *_request;
}

+ (void)resetDeviceInfo;
+ (id)lastSavedVersion;
+ (_Bool)shouldUpdate;
+ (void)registerDefaults;
@property(retain, nonatomic) ApptentiveAPIRequest *request; // @synthesize request=_request;
@property(copy, nonatomic) NSDictionary *sentDeviceJSON; // @synthesize sentDeviceJSON=_sentDeviceJSON;
@property(nonatomic) __weak NSObject<ATDeviceUpdaterDelegate> *delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)at_APIRequestDidFail:(id)arg1;
- (void)at_APIRequestDidProgress:(id)arg1;
- (void)at_APIRequestDidFinish:(id)arg1 result:(id)arg2;
- (float)percentageComplete;
- (void)cancel;
- (void)update;
- (void)dealloc;
- (id)initWithDelegate:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

