//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <OfferWallBase/NSObject-Protocol.h>

@class NSDictionary, NSError, OpeninstallData;

@protocol OpenInstallDelegate <NSObject>

@optional
- (void)getWakeUpParams:(OpeninstallData *)arg1;
- (void)getWakeUpParamsFromOpenInstall:(NSDictionary *)arg1 withError:(NSError *)arg2;
- (void)getInstallParamsFromOpenInstall:(NSDictionary *)arg1 withError:(NSError *)arg2;
@end

