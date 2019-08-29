//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MMUIView.h"

@class RecommendedMusicInfo, UIActivityIndicatorView, UIImageView, UILabel, WCFlowLyricsView, WCStoryMusicAnimateView;

@interface MMMusicPickerContentView : MMUIView
{
    _Bool _isFromBgmSearch;
    UIImageView *_musicLogoView;
    WCStoryMusicAnimateView *_soundShapeView;
    WCFlowLyricsView *_flowLyricsView;
    UIActivityIndicatorView *_loadingView;
    UILabel *_songNameAndSingerNameView;
    RecommendedMusicInfo *_musicInfo;
}

@property(nonatomic) _Bool isFromBgmSearch; // @synthesize isFromBgmSearch=_isFromBgmSearch;
@property(retain, nonatomic) RecommendedMusicInfo *musicInfo; // @synthesize musicInfo=_musicInfo;
@property(retain, nonatomic) UILabel *songNameAndSingerNameView; // @synthesize songNameAndSingerNameView=_songNameAndSingerNameView;
@property(retain, nonatomic) UIActivityIndicatorView *loadingView; // @synthesize loadingView=_loadingView;
@property(retain, nonatomic) WCFlowLyricsView *flowLyricsView; // @synthesize flowLyricsView=_flowLyricsView;
@property(retain, nonatomic) WCStoryMusicAnimateView *soundShapeView; // @synthesize soundShapeView=_soundShapeView;
@property(retain, nonatomic) UIImageView *musicLogoView; // @synthesize musicLogoView=_musicLogoView;
- (void).cxx_destruct;
- (void)setContentViewData:(id)arg1 withFromeBgmSearch:(_Bool)arg2;
- (_Bool)isAnimating;
- (void)startLoading;
- (void)replayFromFlowInMs:(unsigned long long)arg1;
- (void)replay;
- (void)readyToPlay;
- (id)getHitKeys;
- (void)setSelectState:(_Bool)arg1;
- (void)stopLoading;
- (void)addSongNameAndSingerNameView;
- (void)addFlowLyricsView;
- (void)addSoundShapeView;
- (void)addMusicLogo;
- (void)initViews;
- (id)initWithFrame:(struct CGRect)arg1;

@end
