//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "KSYGPUFilter.h"

#import "KSYTransition-Protocol.h"

@class NSString;

@interface KSYTransitionFlashFilter : KSYGPUFilter <KSYTransition>
{
    int _frameIdxUniform;
    int _bgColorUniform;
    int _frameIdx;
    int _duration;
}

@property(nonatomic) int frameIdx; // @synthesize frameIdx=_frameIdx;
@property(nonatomic) int duration; // @synthesize duration=_duration;
- (void)setBackgroundColorRed:(float)arg1 green:(float)arg2 blue:(float)arg3 alpha:(float)arg4;
- (void)newFrameReadyAtTime:(CDStruct_1b6d18a9)arg1 atIndex:(long long)arg2;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
