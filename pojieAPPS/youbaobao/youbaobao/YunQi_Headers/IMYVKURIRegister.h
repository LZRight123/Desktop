//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@interface IMYVKURIRegister : NSObject
{
}

+ (void)image:(id)arg1 didFinishSavingWithError:(id)arg2 contextInfo:(void *)arg3;
+ (void)resetSavePhotoStatus;
+ (void)saveImageCallBack:(id)arg1 object:(id)arg2;
+ (void)registerImageURI;
+ (void)registerUserAddress;
+ (void)registerViewConfig;
+ (void)registerTopbarAction;
+ (void)registerNavgationAction;
+ (void)registerWebJumpAction;
+ (id)getURLWithActionObject:(id)arg1;
+ (id)currentNetowrkState;
+ (_Bool)addAuthToParams:(id)arg1;
+ (void)registerInfoAction;
+ (void)registerMapAction;
+ (id)resolverCode:(long long)arg1 data:(id)arg2 message:(id)arg3;
+ (void)registerMobclickAction;
+ (void)registerShareAction;
+ (void)shareDoWithActionObject:(id)arg1;
+ (void)shareWithSheetType:(unsigned long long)arg1 actionObject:(id)arg2;
+ (void)shareWithType:(long long)arg1 actionObject:(id)arg2;
+ (id)fullURLWithWebURL:(id)arg1 baseURL:(id)arg2;
+ (void)setHasShowShareSheetBox:(_Bool)arg1;
+ (id)getURIUserDefault;
+ (void)saveURIUserDefault;
+ (void)registerDefaultURIActions;
+ (id)sharedInstace;
+ (void)load;

@end

