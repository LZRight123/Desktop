//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MyCamGPUFilter.h"

@interface LensFlareFilter : MyCamGPUFilter
{
    int _uSamples;
    float _uDispersal;
    float _uHaloWidth;
    float _uDistortion;
}

- (void)newFrameReadyAtTime:(CDStruct_1b6d18a9)arg1 atIndex:(long long)arg2;
- (void)setParam:(int)arg1 anduDispersal:(float)arg2 anduHaloWidth:(float)arg3 anduDistortion:(float)arg4 andPX:(float)arg5 andPY:(float)arg6;
- (id)init;
- (id)init:(int)arg1 anduDispersal:(float)arg2 anduHaloWidth:(float)arg3 anduDistortion:(float)arg4 andPX:(float)arg5 andPY:(float)arg6;

@end
