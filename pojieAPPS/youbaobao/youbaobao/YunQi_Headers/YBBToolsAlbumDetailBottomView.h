//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class UIButton, UILabel, YBBToolsAlbumProgressView;

@interface YBBToolsAlbumDetailBottomView : UIView
{
    _Bool _isPlaying;
    _Bool _isTiming;
    UILabel *_playTimeLabel;
    YBBToolsAlbumProgressView *_progressView;
    UILabel *_durationTimeLabel;
    long long _repeatMode;
    CDUnknownBlockType _clockAction;
    CDUnknownBlockType _listloopAction;
    CDUnknownBlockType _moreAction;
    CDUnknownBlockType _previousAction;
    CDUnknownBlockType _nextAction;
    CDUnknownBlockType _playOrPauseAction;
    CDUnknownBlockType _panProgress;
    CDUnknownBlockType _warnAction;
    UIButton *_clockButton;
    UIButton *_listloopButton;
    UIButton *_moreButton;
    UIButton *_previousButton;
    UIButton *_playOrPauseButton;
    UIButton *_nextButton;
}

@property(retain, nonatomic) UIButton *nextButton; // @synthesize nextButton=_nextButton;
@property(retain, nonatomic) UIButton *playOrPauseButton; // @synthesize playOrPauseButton=_playOrPauseButton;
@property(retain, nonatomic) UIButton *previousButton; // @synthesize previousButton=_previousButton;
@property(retain, nonatomic) UIButton *moreButton; // @synthesize moreButton=_moreButton;
@property(retain, nonatomic) UIButton *listloopButton; // @synthesize listloopButton=_listloopButton;
@property(retain, nonatomic) UIButton *clockButton; // @synthesize clockButton=_clockButton;
@property(copy, nonatomic) CDUnknownBlockType warnAction; // @synthesize warnAction=_warnAction;
@property(copy, nonatomic) CDUnknownBlockType panProgress; // @synthesize panProgress=_panProgress;
@property(copy, nonatomic) CDUnknownBlockType playOrPauseAction; // @synthesize playOrPauseAction=_playOrPauseAction;
@property(copy, nonatomic) CDUnknownBlockType nextAction; // @synthesize nextAction=_nextAction;
@property(copy, nonatomic) CDUnknownBlockType previousAction; // @synthesize previousAction=_previousAction;
@property(copy, nonatomic) CDUnknownBlockType moreAction; // @synthesize moreAction=_moreAction;
@property(copy, nonatomic) CDUnknownBlockType listloopAction; // @synthesize listloopAction=_listloopAction;
@property(copy, nonatomic) CDUnknownBlockType clockAction; // @synthesize clockAction=_clockAction;
@property(nonatomic) long long repeatMode; // @synthesize repeatMode=_repeatMode;
@property(nonatomic) _Bool isTiming; // @synthesize isTiming=_isTiming;
@property(nonatomic) _Bool isPlaying; // @synthesize isPlaying=_isPlaying;
@property(retain, nonatomic) UILabel *durationTimeLabel; // @synthesize durationTimeLabel=_durationTimeLabel;
@property(retain, nonatomic) YBBToolsAlbumProgressView *progressView; // @synthesize progressView=_progressView;
@property(retain, nonatomic) UILabel *playTimeLabel; // @synthesize playTimeLabel=_playTimeLabel;
- (void).cxx_destruct;
- (void)updatePregress:(id)arg1;
- (void)nextButtonClick:(id)arg1;
- (void)playOrPauseButtonClick:(id)arg1;
- (void)previousButtonClick:(id)arg1;
- (void)moreButtonClick:(id)arg1;
- (void)listloopButtonClick:(id)arg1;
- (void)clockButtonClick:(id)arg1;
- (void)layoutSubviews;
- (void)initUI;
- (id)init;

@end
