//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@interface SYPushHandle : NSObject
{
}

+ (_Bool)isNeedLogin:(int)arg1;
+ (void)pushWithType:(int)arg1 withId:(long long)arg2 text:(id)arg3 nav:(id)arg4 path:(id)arg5;
+ (void)pushWithType:(int)arg1 withId:(long long)arg2 text:(id)arg3 nav:(id)arg4;
+ (void)pushWithType:(int)arg1 withId:(long long)arg2 text:(id)arg3 path:(id)arg4;
+ (void)pushWithType:(int)arg1 withId:(long long)arg2 text:(id)arg3;
+ (void)pushWithType:(int)arg1;

@end

