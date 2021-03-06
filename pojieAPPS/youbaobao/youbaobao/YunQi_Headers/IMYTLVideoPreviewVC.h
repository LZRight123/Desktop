//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYTLViewController.h"

#import "IMYVideoViewDelegate-Protocol.h"

@class HLVideoPlayerView, IMYTLHomeListCache, IMYTLRecordModel, IMYTLVideoNavView, IMYTLVideoPreviewLocalModel, IMYVideoModel, IMYVideoView, NSString, PHAsset, UIView;

@interface IMYTLVideoPreviewVC : IMYTLViewController <IMYVideoViewDelegate>
{
    _Bool _lastFullScreentShow;
    _Bool _shouldAutoPlay;
    _Bool _isSeekLeadToPlay;
    _Bool _forceShowNav;
    _Bool _isFirstPlay;
    IMYTLVideoPreviewLocalModel *_localModel;
    IMYTLRecordModel *_model;
    unsigned long long _type;
    CDUnknownBlockType _deleteBtnPress;
    CDUnknownBlockType _customBackTranstionBlock;
    CDUnknownBlockType _didFinishPlay;
    IMYVideoView *_videoView;
    IMYVideoModel *_videoModel;
    IMYTLVideoNavView *_customNavView;
    IMYTLHomeListCache *_event;
    HLVideoPlayerView *_videoHL;
    double _userSeekTime;
    double _lastFrameTime;
    double _popBackGesWidth;
    UIView *_loadingLocalSourceHud;
    PHAsset *_localPhasset;
}

@property(retain, nonatomic) PHAsset *localPhasset; // @synthesize localPhasset=_localPhasset;
@property(retain, nonatomic) UIView *loadingLocalSourceHud; // @synthesize loadingLocalSourceHud=_loadingLocalSourceHud;
@property(nonatomic) _Bool isFirstPlay; // @synthesize isFirstPlay=_isFirstPlay;
@property(nonatomic) double popBackGesWidth; // @synthesize popBackGesWidth=_popBackGesWidth;
@property(nonatomic) _Bool forceShowNav; // @synthesize forceShowNav=_forceShowNav;
@property(nonatomic) double lastFrameTime; // @synthesize lastFrameTime=_lastFrameTime;
@property(nonatomic) double userSeekTime; // @synthesize userSeekTime=_userSeekTime;
@property(nonatomic) _Bool isSeekLeadToPlay; // @synthesize isSeekLeadToPlay=_isSeekLeadToPlay;
@property(nonatomic) _Bool shouldAutoPlay; // @synthesize shouldAutoPlay=_shouldAutoPlay;
@property(nonatomic) _Bool lastFullScreentShow; // @synthesize lastFullScreentShow=_lastFullScreentShow;
@property(retain, nonatomic) HLVideoPlayerView *videoHL; // @synthesize videoHL=_videoHL;
@property(retain, nonatomic) IMYTLHomeListCache *event; // @synthesize event=_event;
@property(retain, nonatomic) IMYTLVideoNavView *customNavView; // @synthesize customNavView=_customNavView;
@property(retain, nonatomic) IMYVideoModel *videoModel; // @synthesize videoModel=_videoModel;
@property(retain, nonatomic) IMYVideoView *videoView; // @synthesize videoView=_videoView;
@property(copy, nonatomic) CDUnknownBlockType didFinishPlay; // @synthesize didFinishPlay=_didFinishPlay;
@property(copy, nonatomic) CDUnknownBlockType customBackTranstionBlock; // @synthesize customBackTranstionBlock=_customBackTranstionBlock;
@property(copy, nonatomic) CDUnknownBlockType deleteBtnPress; // @synthesize deleteBtnPress=_deleteBtnPress;
@property(nonatomic) unsigned long long type; // @synthesize type=_type;
@property(retain, nonatomic) IMYTLRecordModel *model; // @synthesize model=_model;
@property(retain, nonatomic) IMYTLVideoPreviewLocalModel *localModel; // @synthesize localModel=_localModel;
- (void).cxx_destruct;
- (void)didReceiveMemoryWarning;
- (void)dealloc;
- (void)checkPlayerEndTime:(double)arg1;
- (void)customViewPlayerControllsUI;
- (void)updateVideoPlayerBottomProgress:(double)arg1;
- (void)updateVideoPlayerBottomTotalTime;
- (void)autoHideControls;
- (void)playerView:(id)arg1 didFailWithError:(id)arg2;
- (void)playerView:(id)arg1 willChangeToOrientation:(long long)arg2;
- (void)playerView:(id)arg1 didControlByEvent:(long long)arg2;
- (void)playerView:(id)arg1 didPlayFrame:(double)arg2;
- (void)playerView:(id)arg1 durationDidLoad:(id)arg2;
- (void)playerViewDidFinishPlaying:(id)arg1;
- (void)playerView:(id)arg1 didChangeStateFrom:(long long)arg2;
- (void)playerViewDidStartPlaying:(id)arg1;
- (void)playerViewWillStartPlaying:(id)arg1;
- (void)shareModuleWithType:(long long)arg1 shortURL:(id)arg2 imageURL:(id)arg3 moduleId:(long long)arg4 shareTitle:(id)arg5 shareContent:(id)arg6;
- (void)shareEventAction:(long long)arg1 videoUrl:(id)arg2 moduleId:(long long)arg3 shareTitle:(id)arg4 shareContent:(id)arg5;
- (id)shareVideoUrl:(id)arg1;
- (void)shareVideoAction:(long long)arg1;
- (_Bool)allowDeleteVideo;
- (void)showMoreActionDeleteWarning;
- (void)moreAction;
- (void)customNavRightTopBtnAction:(id)arg1;
- (void)customNavLeftTopBtnAction:(id)arg1;
- (void)setupCustomNavView;
- (void)hideLoadingLocalSourceHud;
- (void)showLoadingLocalSourceHud;
- (void)setupVideoView;
- (void)getVideoAVAssetCompletion:(CDUnknownBlockType)arg1;
- (void)loadLocalVideo;
- (void)navPopBackGestureEnable:(_Bool)arg1;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (id)initWithVideoModel:(id)arg1;
- (id)initWithLocalVideoModel:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

