//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface YSF_NIMWifiInfoProvider : NSObject
{
    NSString *_bssid;
    NSString *_ssid;
}

@property(copy, nonatomic) NSString *ssid; // @synthesize ssid=_ssid;
@property(copy, nonatomic) NSString *bssid; // @synthesize bssid=_bssid;
- (void).cxx_destruct;
- (id)toJsonDict;
- (void)commonInit;
- (id)init;

@end

