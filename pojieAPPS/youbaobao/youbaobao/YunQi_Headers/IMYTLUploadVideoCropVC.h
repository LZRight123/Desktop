//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYTLViewController.h"

#import "IMYTLCropBottomViewProtocol-Protocol.h"

@class IMYTLCropBottomView, IMYTLCropNavView, IMYTLUploadCropVM, IMYTLUploadViewPlayView, NSArray, NSMutableArray, NSString, UIView;

@interface IMYTLUploadVideoCropVC : IMYTLViewController <IMYTLCropBottomViewProtocol>
{
    _Bool _uploadedBackToTLHomeTab;
    _Bool _cropForPublish;
    _Bool _willDragIsPlay;
    _Bool _willEnterPublish;
    _Bool _allowShowLoadFromCloudHud;
    _Bool _firstLoadNewAsset;
    NSArray *_assets;
    CDUnknownBlockType _cropCompleted;
    NSArray *_otherPublishModels;
    IMYTLCropNavView *_cropNavView;
    IMYTLUploadViewPlayView *_playerView;
    IMYTLCropBottomView *_bottomView;
    IMYTLUploadCropVM *_vm;
    double _lastStartTime;
    double _lastEndTime;
    UIView *_loadContentView;
    long long _currentIndex;
    NSMutableArray *_cropResults;
}

@property(nonatomic) _Bool firstLoadNewAsset; // @synthesize firstLoadNewAsset=_firstLoadNewAsset;
@property(retain, nonatomic) NSMutableArray *cropResults; // @synthesize cropResults=_cropResults;
@property(nonatomic) long long currentIndex; // @synthesize currentIndex=_currentIndex;
@property(nonatomic) _Bool allowShowLoadFromCloudHud; // @synthesize allowShowLoadFromCloudHud=_allowShowLoadFromCloudHud;
@property(retain, nonatomic) UIView *loadContentView; // @synthesize loadContentView=_loadContentView;
@property(nonatomic) _Bool willEnterPublish; // @synthesize willEnterPublish=_willEnterPublish;
@property(nonatomic) _Bool willDragIsPlay; // @synthesize willDragIsPlay=_willDragIsPlay;
@property(nonatomic) double lastEndTime; // @synthesize lastEndTime=_lastEndTime;
@property(nonatomic) double lastStartTime; // @synthesize lastStartTime=_lastStartTime;
@property(retain, nonatomic) IMYTLUploadCropVM *vm; // @synthesize vm=_vm;
@property(retain, nonatomic) IMYTLCropBottomView *bottomView; // @synthesize bottomView=_bottomView;
@property(retain, nonatomic) IMYTLUploadViewPlayView *playerView; // @synthesize playerView=_playerView;
@property(retain, nonatomic) IMYTLCropNavView *cropNavView; // @synthesize cropNavView=_cropNavView;
@property(retain, nonatomic) NSArray *otherPublishModels; // @synthesize otherPublishModels=_otherPublishModels;
@property(nonatomic) _Bool cropForPublish; // @synthesize cropForPublish=_cropForPublish;
@property(copy, nonatomic) CDUnknownBlockType cropCompleted; // @synthesize cropCompleted=_cropCompleted;
@property(nonatomic) _Bool uploadedBackToTLHomeTab; // @synthesize uploadedBackToTLHomeTab=_uploadedBackToTLHomeTab;
@property(retain, nonatomic) NSArray *assets; // @synthesize assets=_assets;
- (void).cxx_destruct;
- (void)didReceiveMemoryWarning;
- (void)dealloc;
- (id)getTLAssetFromPHAsset:(id)arg1;
- (void)enterPublishAction;
- (void)showLoadingHUD;
- (void)showLoadingCloudHUD;
- (void)hideHUD;
- (void)didEndDragBottomView:(id)arg1 isDragLeft:(_Bool)arg2;
- (void)willBeginDragBottomView:(id)arg1 isDragLeft:(_Bool)arg2;
- (void)dragBottomView:(id)arg1 toStart:(double)arg2 toend:(double)arg3 isDragLeft:(_Bool)arg4;
- (double)totalTimesForCropBottomView:(id)arg1;
- (struct CGSize)sizeForCropBottomView:(id)arg1;
- (id)imagesForCropBottomView:(id)arg1;
- (void)setVideoPlayer;
- (void)navCompletedAction;
- (void)navBackAction;
- (void)viewDidLayoutSubviews;
- (void)setupLoadContentView;
- (void)setupCropNav;
- (void)setupBottomView;
- (void)setupUI;
- (void)imy_topLeftButtonTouchupInside;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)saveCurrentCropParams;
- (void)changeToIndex:(long long)arg1;
- (void)viewDidLoad;
- (id)initWithPHAssets:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

