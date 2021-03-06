//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UICollectionViewCell.h>

#import "UIScrollViewDelegate-Protocol.h"

@class NSArray, NSString, NSTimer, UIImage, UIImageView, UIPageControl, UIScrollView;

@interface SDAdScrollView : UICollectionViewCell <UIScrollViewDelegate>
{
    NSArray *_bannerModelArray;
    long long _currentPage;
    double _animationDuration;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    UIImage *_placeHolderImage;
    CDUnknownBlockType _tapActionBlock;
    UIScrollView *_scrollView;
    UIImageView *_currentImageView;
    UIImageView *_leftImageView;
    UIImageView *_rightImageView;
    struct UIEdgeInsets _scrollViewEdge;
}

@property(retain, nonatomic) UIImageView *rightImageView; // @synthesize rightImageView=_rightImageView;
@property(retain, nonatomic) UIImageView *leftImageView; // @synthesize leftImageView=_leftImageView;
@property(retain, nonatomic) UIImageView *currentImageView; // @synthesize currentImageView=_currentImageView;
@property(retain, nonatomic) UIScrollView *scrollView; // @synthesize scrollView=_scrollView;
@property(copy, nonatomic) CDUnknownBlockType tapActionBlock; // @synthesize tapActionBlock=_tapActionBlock;
@property(nonatomic) struct UIEdgeInsets scrollViewEdge; // @synthesize scrollViewEdge=_scrollViewEdge;
@property(retain, nonatomic) UIImage *placeHolderImage; // @synthesize placeHolderImage=_placeHolderImage;
@property(retain, nonatomic) NSTimer *timer; // @synthesize timer=_timer;
@property(retain, nonatomic) UIPageControl *pageControl; // @synthesize pageControl=_pageControl;
@property(nonatomic) double animationDuration; // @synthesize animationDuration=_animationDuration;
@property(readonly, nonatomic) long long currentPage; // @synthesize currentPage=_currentPage;
@property(retain, nonatomic) NSArray *bannerModelArray; // @synthesize bannerModelArray=_bannerModelArray;
- (void).cxx_destruct;
- (void)scrollViewDidEndScrollingAnimation:(id)arg1;
- (void)scrollViewDidEndDecelerating:(id)arg1;
- (void)scrollViewWillBeginDragging:(id)arg1;
- (void)refreshCurrentPage;
- (void)formatImageView:(id)arg1 imageData:(id)arg2;
- (void)refreshImageView;
- (void)onGesture:(id)arg1;
- (void)onTimer:(id)arg1;
- (void)layoutSubviews;
- (id)initWithFrame:(struct CGRect)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

