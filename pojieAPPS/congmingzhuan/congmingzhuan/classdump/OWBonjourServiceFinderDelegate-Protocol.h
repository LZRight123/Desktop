//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <OfferWallBase/NSObject-Protocol.h>

@class NSDictionary, NSNetService, OWBonjourServiceFinder;

@protocol OWBonjourServiceFinderDelegate <NSObject>
- (void)serviceFinderDidStop:(OWBonjourServiceFinder *)arg1;
- (void)serviceFinder:(OWBonjourServiceFinder *)arg1 didNotFind:(NSDictionary *)arg2;
- (void)serviceFinder:(OWBonjourServiceFinder *)arg1 didFindService:(NSNetService *)arg2;
@end
