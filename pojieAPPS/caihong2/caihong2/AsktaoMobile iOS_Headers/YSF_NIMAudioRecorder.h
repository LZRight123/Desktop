//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "AVAudioRecorderDelegate-Protocol.h"

@class NSString;
@protocol YSF_NIMAudioRecorderDelegate;

@interface YSF_NIMAudioRecorder : NSObject <AVAudioRecorderDelegate>
{
    _Bool _cancelled;
    long long _totalSeconds;
    NSString *_filename;
    NSString *_filepath;
    struct AQRecorder *_recorder;
    id <YSF_NIMAudioRecorderDelegate> _delegate;
}

@property(nonatomic) __weak id <YSF_NIMAudioRecorderDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)initRecordOutputParam:(int)arg1;
- (void)setAutoDeactivateAudioSession:(_Bool)arg1;
- (void)stopRecord;
- (void)completeRecord;
- (void)cancelRecord;
- (_Bool)record:(int)arg1;
- (_Bool)prepareToRecord;
@property(readonly, nonatomic) double currentTime;
@property(readonly, nonatomic) float peakPower;
@property(readonly, nonatomic) float averagePower;
@property(readonly, nonatomic, getter=isRunning) _Bool running;
- (void)dealloc;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

