//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

#import "UIScrollViewDelegate-Protocol.h"

@class NSArray, NSString, NSTimer, UIPageControl, UIScrollView;

@interface IMYTLHomeYunGuideImgView : UIView <UIScrollViewDelegate>
{
    NSArray *_images;
    NSArray *_urls;
    CDUnknownBlockType _tapImageBlock;
    UIPageControl *_pageCtr;
    UIScrollView *_scroll;
    NSTimer *_timer;
    long long _currentIndex;
}

@property(nonatomic) long long currentIndex; // @synthesize currentIndex=_currentIndex;
@property(retain, nonatomic) NSTimer *timer; // @synthesize timer=_timer;
@property(retain, nonatomic) UIScrollView *scroll; // @synthesize scroll=_scroll;
@property(retain, nonatomic) UIPageControl *pageCtr; // @synthesize pageCtr=_pageCtr;
@property(copy, nonatomic) CDUnknownBlockType tapImageBlock; // @synthesize tapImageBlock=_tapImageBlock;
@property(retain, nonatomic) NSArray *urls; // @synthesize urls=_urls;
@property(retain, nonatomic) NSArray *images; // @synthesize images=_images;
- (void).cxx_destruct;
- (void)stopAutoShowAnimtaion;
- (void)startAutoShowAnimation;
- (void)dealloc;
- (void)updateSuviews:(struct CGRect)arg1;
- (void)scrollViewDidEndDecelerating:(id)arg1;
- (void)scrollViewWillBeginDragging:(id)arg1;
- (void)changeImage;
- (void)imageTapAction;
- (id)initWithFrame:(struct CGRect)arg1 images:(id)arg2 imageUrls:(id)arg3;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

