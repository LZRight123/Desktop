//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class MMVoidStringCallback, NSString;

@protocol MMIPlatformUtil <NSObject>
- (NSString *)getPlatformString:(NSString *)arg1;
- (_Bool)getExptBoolValue:(NSString *)arg1;
- (float)getBottomSafeAreaHeight;
- (float)getNavigationBarHeight;
- (float)getStatusBarHeight;
- (float)getLoigcalResolutionHeight;
- (float)getLoigcalResolutionWidth;
- (float)getPx:(float)arg1;
- (long long)iOSDevice;
- (long long)androidDpiLevel;
- (NSString *)iOSVersion;
- (int)androidAPILevel;
- (void)setLanguageChangeCallbackImpl:(MMVoidStringCallback *)arg1;
- (NSString *)currentLanguageCode;
- (long long)currentPlatform;
@end

