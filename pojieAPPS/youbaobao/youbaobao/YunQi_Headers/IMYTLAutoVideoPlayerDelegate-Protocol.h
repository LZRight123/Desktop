//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class IMYTLAutoPlayModel, IMYTLAutoVideoPlayer;

@protocol IMYTLAutoVideoPlayerDelegate <NSObject>

@optional
- (void)videoPlayer:(IMYTLAutoVideoPlayer *)arg1 netChange:(IMYTLAutoPlayModel *)arg2;
- (void)videoPlayer:(IMYTLAutoVideoPlayer *)arg1 videoLoadTimeOut:(IMYTLAutoPlayModel *)arg2;
- (void)videoPlayer:(IMYTLAutoVideoPlayer *)arg1 playError:(IMYTLAutoPlayModel *)arg2;
- (void)videoPlayer:(IMYTLAutoVideoPlayer *)arg1 videoDidFinishPlay:(IMYTLAutoPlayModel *)arg2;
- (void)videoPlayer:(IMYTLAutoVideoPlayer *)arg1 didPlayFrame:(IMYTLAutoPlayModel *)arg2;
- (void)videoPlayer:(IMYTLAutoVideoPlayer *)arg1 didPlay:(IMYTLAutoPlayModel *)arg2;
@end

