//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "RCTViewManager.h"

#import "RCTUIManagerObserver-Protocol.h"

@class NSHashTable, NSString;

@interface RCTNavigatorManager : RCTViewManager <RCTUIManagerObserver>
{
    NSHashTable *_viewRegistry;
}

+ (const struct RCTMethodInfo *)__rct_export__580;
+ (id)propConfig_interactivePopGestureEnabled;
+ (id)propConfig_onNavigationComplete;
+ (id)propConfig_onNavigationProgress;
+ (id)propConfig_requestedTopOfStack;
+ (void)load;
+ (id)moduleName;
- (void).cxx_destruct;
- (void)uiManagerDidPerformMounting:(id)arg1;
- (void)requestSchedulingJavaScriptNavigation:(id)arg1 callback:(CDUnknownBlockType)arg2;
- (id)view;
- (void)invalidate;
- (void)setBridge:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
