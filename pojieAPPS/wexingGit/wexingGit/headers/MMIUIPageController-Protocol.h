//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class MMITransmitKvData, MMIUIPage;

@protocol MMIUIPageController <NSObject>
- (void)startModalPageUI:(MMIUIPage *)arg1 transitionStyle:(long long)arg2 extraData:(MMITransmitKvData *)arg3;
- (void)startPageUI:(MMIUIPage *)arg1 extraData:(MMITransmitKvData *)arg2;
@end
