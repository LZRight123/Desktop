//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@interface IMYAssetHelper : NSObject
{
}

+ (id)getModuleStorageDirectory;
+ (id)getPOSReader:(id)arg1 completionQueue:(id)arg2;
+ (id)getLowLevelReader:(id)arg1;
+ (void)convertImage:(id)arg1 toQuality:(long long)arg2 completion:(CDUnknownBlockType)arg3;
+ (double)getFactorByQuality:(long long)arg1;

@end

