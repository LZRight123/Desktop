//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@interface ADBApplicationOnlyFunctionality : NSObject
{
}

+ (long long)statusBarOrientation;
+ (id)getKeyWindow;
+ (void)showAlert:(id)arg1 message:(id)arg2 delegate:(id)arg3 cancelButtonTitle:(id)arg4 confirmButtonTitle:(id)arg5;
+ (void)triggerLocalNotification:(id)arg1;
+ (void)endBackgroundTaskWithIdentifier:(unsigned long long)arg1;
+ (unsigned long long)initializeBackgroundTaskWithHandler:(CDUnknownBlockType)arg1;
+ (void)openURL:(id)arg1;
+ (_Bool)isRunningOnBackground;

@end

