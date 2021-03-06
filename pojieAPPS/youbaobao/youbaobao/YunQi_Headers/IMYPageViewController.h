//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIViewController.h>

#import "IMYPageViewControllerDataSource-Protocol.h"
#import "NSCacheDelegate-Protocol.h"
#import "UIScrollViewDelegate-Protocol.h"

@class NSArray, NSCache, NSMutableDictionary, NSString, UIScrollView;
@protocol IMYPageViewControllerDataSource, IMYPageViewControllerDelegate, UIScrollViewDelegate;

@interface IMYPageViewController : UIViewController <NSCacheDelegate, UIScrollViewDelegate, IMYPageViewControllerDataSource>
{
    _Bool _firstWillAppear;
    _Bool _firstDidAppear;
    _Bool _firstDidLayoutSubViews;
    _Bool _isDecelerating;
    _Bool _isDisappearing;
    _Bool _isCleaningCache;
    id <UIScrollViewDelegate> _scrollViewForwardDelegate;
    id <IMYPageViewControllerDelegate> _delegate;
    id <IMYPageViewControllerDataSource> _dataSource;
    unsigned long long _currentPageIndex;
    unsigned long long _cachePageCount;
    UIScrollView *_scrollView;
    double _originOffsetX;
    unsigned long long _guessToIndex;
    unsigned long long _lastSelectedIndex;
    unsigned long long _totalPageCount;
    NSCache *_pagesCache;
    NSMutableDictionary *_cachedPagesDic;
    NSMutableDictionary *_cleaningPagesDic;
    NSMutableDictionary *_pageClassByIdentifier;
    NSMutableDictionary *_reusablePagesByIdentifier;
}

@property(retain, nonatomic) NSMutableDictionary *reusablePagesByIdentifier; // @synthesize reusablePagesByIdentifier=_reusablePagesByIdentifier;
@property(retain, nonatomic) NSMutableDictionary *pageClassByIdentifier; // @synthesize pageClassByIdentifier=_pageClassByIdentifier;
@property(retain, nonatomic) NSMutableDictionary *cleaningPagesDic; // @synthesize cleaningPagesDic=_cleaningPagesDic;
@property(retain, nonatomic) NSMutableDictionary *cachedPagesDic; // @synthesize cachedPagesDic=_cachedPagesDic;
@property(retain, nonatomic) NSCache *pagesCache; // @synthesize pagesCache=_pagesCache;
@property(nonatomic) _Bool isCleaningCache; // @synthesize isCleaningCache=_isCleaningCache;
@property(nonatomic) _Bool isDisappearing; // @synthesize isDisappearing=_isDisappearing;
@property(nonatomic) _Bool isDecelerating; // @synthesize isDecelerating=_isDecelerating;
@property(nonatomic) _Bool firstDidLayoutSubViews; // @synthesize firstDidLayoutSubViews=_firstDidLayoutSubViews;
@property(nonatomic) _Bool firstDidAppear; // @synthesize firstDidAppear=_firstDidAppear;
@property(nonatomic) _Bool firstWillAppear; // @synthesize firstWillAppear=_firstWillAppear;
@property(nonatomic) unsigned long long totalPageCount; // @synthesize totalPageCount=_totalPageCount;
@property(nonatomic) unsigned long long lastSelectedIndex; // @synthesize lastSelectedIndex=_lastSelectedIndex;
@property(nonatomic) unsigned long long guessToIndex; // @synthesize guessToIndex=_guessToIndex;
@property(nonatomic) double originOffsetX; // @synthesize originOffsetX=_originOffsetX;
@property(retain, nonatomic) UIScrollView *scrollView; // @synthesize scrollView=_scrollView;
@property(nonatomic) unsigned long long cachePageCount; // @synthesize cachePageCount=_cachePageCount;
@property(nonatomic) unsigned long long currentPageIndex; // @synthesize currentPageIndex=_currentPageIndex;
@property(nonatomic) __weak id <IMYPageViewControllerDataSource> dataSource; // @synthesize dataSource=_dataSource;
@property(nonatomic) __weak id <IMYPageViewControllerDelegate> delegate; // @synthesize delegate=_delegate;
@property(nonatomic) __weak id <UIScrollViewDelegate> scrollViewForwardDelegate; // @synthesize scrollViewForwardDelegate=_scrollViewForwardDelegate;
- (void).cxx_destruct;
@property(readonly, copy, nonatomic) NSArray *viewControllers;
- (unsigned long long)calculateIndexWithOffset:(double)arg1 width:(double)arg2;
- (struct CGPoint)calculateOffsetWithIndex:(unsigned long long)arg1 width:(double)arg2 maxWidth:(double)arg3;
- (id)controllerAtIndex:(unsigned long long)arg1;
- (void)setScrollViewContentOffset;
- (void)updateScrollViewContentSizeAfterVCLayout;
- (struct CGRect)calculateVisibleViewControllerFrameWithIndex:(unsigned long long)arg1;
- (void)cleanCacheToClean;
- (void)addEvictionVCToPendingCleanSet:(id)arg1;
- (void)_cache:(id)arg1 willEvictObject:(id)arg2;
- (void)cache:(id)arg1 willEvictObject:(id)arg2;
- (id)pageViewController:(id)arg1 controllerAtIndex:(unsigned long long)arg2;
- (unsigned long long)numberOfControllersInPageViewController:(id)arg1;
- (void)scrollViewDidScrollToTop:(id)arg1;
- (_Bool)scrollViewShouldScrollToTop:(id)arg1;
- (void)scrollViewDidEndZooming:(id)arg1 withView:(id)arg2 atScale:(double)arg3;
- (void)scrollViewWillBeginZooming:(id)arg1 withView:(id)arg2;
- (id)viewForZoomingInScrollView:(id)arg1;
- (void)scrollViewDidEndScrollingAnimation:(id)arg1;
- (void)scrollViewDidZoom:(id)arg1;
- (void)scrollViewDidEndDragging:(id)arg1 willDecelerate:(_Bool)arg2;
- (void)updatePageViewAfterTragging:(id)arg1;
- (void)scrollViewWillEndDragging:(id)arg1 withVelocity:(struct CGPoint)arg2 targetContentOffset:(inout struct CGPoint *)arg3;
- (void)scrollViewWillBeginDragging:(id)arg1;
- (void)scrollViewDidEndDecelerating:(id)arg1;
- (void)scrollViewWillBeginDecelerating:(id)arg1;
- (void)scrollViewDidScroll:(id)arg1;
- (void)moveBackToOriginPositionIfNeeded:(id)arg1 index:(unsigned long long)arg2;
- (void)showPageAnimationWithOldLastSelectedIndex:(unsigned long long)arg1;
- (void)nonInterativeDidScrollWithAnimation:(_Bool)arg1;
- (void)nonInterativeWillScrollWithAnimation:(_Bool)arg1;
- (void)setViewControllerAtIndex:(unsigned long long)arg1 animated:(_Bool)arg2;
- (void)reloadData;
- (id)visibleViewControllers;
- (void)recyclePage:(id)arg1 atIndex:(unsigned long long)arg2;
- (id)dequeueReusablePageWithIdentifier:(id)arg1 forIndex:(unsigned long long)arg2;
- (void)registerClass:(Class)arg1 forPageReuseIdentifier:(id)arg2;
- (void)cacheChildVC:(id)arg1 atIndex:(unsigned long long)arg2;
- (void)prepareForSidePageAtIndex:(unsigned long long)arg1 direction:(long long)arg2;
- (id)createChildViewControllersAtIndex:(unsigned long long)arg1 direction:(long long)arg2 prepareSidePage:(_Bool)arg3;
- (void)didReceiveMemoryWarning;
- (_Bool)shouldAutomaticallyForwardAppearanceMethods;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewDidLayoutSubviews;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)configUI;
- (void)initialData;
- (void)viewDidLoad;
- (id)initWithCoder:(id)arg1;
- (id)init;
- (void)dealloc;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

