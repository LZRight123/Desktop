//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@interface JCommonActiveUserController : NSObject
{
    double _appLaunchTime;
    double _appTerminateTime;
}

@property(nonatomic) double appTerminateTime; // @synthesize appTerminateTime=_appTerminateTime;
@property(nonatomic) double appLaunchTime; // @synthesize appLaunchTime=_appLaunchTime;
- (void)reportAppActivityDuration:(double)arg1 closeTime:(double)arg2;
- (void)reportAppLaunch;
- (void)appWillTerminate:(id)arg1;
- (id)appTerminateReportInfo:(double)arg1 closetTime:(double)arg2;
- (id)appLauchReportInfo;
- (id)sessionID:(long long)arg1;

@end

