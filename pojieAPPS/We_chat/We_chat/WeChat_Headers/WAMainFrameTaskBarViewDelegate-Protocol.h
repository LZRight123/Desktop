//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class UIView, WAAppItemData, WAMainFrameTaskBarView;

@protocol WAMainFrameTaskBarViewDelegate <NSObject>

@optional
- (UIView *)getRightBarButton;
- (void)taskBarDidDragUpToClose:(WAMainFrameTaskBarView *)arg1;
- (void)taskBarViewOnEnterForeground:(WAMainFrameTaskBarView *)arg1;
- (double)getFullScreenHeight;
- (void)taskBarView:(WAMainFrameTaskBarView *)arg1 notifyOnTranslationYChanged:(double)arg2;
- (void)taskBarViewDidTapOnSearchButton:(WAMainFrameTaskBarView *)arg1;
- (void)taskBarViewDidTapOnFakeRightMenuButton:(WAMainFrameTaskBarView *)arg1;
- (void)taskBarViewDidTapOnFoldButton:(WAMainFrameTaskBarView *)arg1;
- (void)taskBarView:(WAMainFrameTaskBarView *)arg1 onStarNodeShowStatusDidChangedTo:(_Bool)arg2;
- (void)taskBarView:(WAMainFrameTaskBarView *)arg1 didRotateToInterfaceOrientation:(long long)arg2;
- (void)taskBarViewDidSelectStarMore:(WAMainFrameTaskBarView *)arg1;
- (void)taskBarViewDidSelectTaskMore:(WAMainFrameTaskBarView *)arg1;
- (void)taskBarView:(WAMainFrameTaskBarView *)arg1 heightDidChangeTo:(double)arg2;
- (void)taskBarViewDidSelectMore:(WAMainFrameTaskBarView *)arg1;
- (void)taskBarView:(WAMainFrameTaskBarView *)arg1 didSelectStarItem:(WAAppItemData *)arg2 onPosition:(unsigned long long)arg3;
- (void)taskBarView:(WAMainFrameTaskBarView *)arg1 didSelectTaskItem:(WAAppItemData *)arg2 onPosition:(unsigned long long)arg3;
- (void)taskBarViewStarDidEndDragging:(WAMainFrameTaskBarView *)arg1;
- (void)taskBarViewTaskDidEndDragging:(WAMainFrameTaskBarView *)arg1;
@end
