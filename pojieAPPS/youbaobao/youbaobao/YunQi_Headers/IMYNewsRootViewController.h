//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYPublicBaseViewController.h"

#import "CLLocationManagerDelegate-Protocol.h"
#import "IMYNewsRootContainerViewDelegate-Protocol.h"
#import "IMYNewsSegmentedViewDataSource-Protocol.h"
#import "IMYNewsSegmentedViewDelegate-Protocol.h"
#import "IMYPageViewControllerDataSource-Protocol.h"
#import "IMYPageViewControllerDelegate-Protocol.h"
#import "IMYThemeChangedProtocol-Protocol.h"
#import "IMYTimerRuningProtocol-Protocol.h"
#import "MXScrollViewDelegate-Protocol.h"
#import "UIViewControllerTransitioningDelegate-Protocol.h"

@class CLLocationManager, IMYButton, IMYNewsCategoryModel, IMYNewsFloatMsgButton, IMYNewsHomeHeaderView, IMYNewsRootContainerViewController, IMYNewsRootDoubleFlowViewController, IMYNewsRootScrollView, IMYNewsSegmentedView, IMYNewsToolModel, IMYNewsToolView, IMYPageViewController, IMYTimerHelper, IMYTouchEXButton, IMYURI, MXParallaxHeader, NSMutableArray, NSString, UIImageView, UILabel, UIScrollView, UIView, UIViewController;
@protocol IMYIAdManager;

@interface IMYNewsRootViewController : IMYPublicBaseViewController <IMYPageViewControllerDelegate, IMYPageViewControllerDataSource, IMYNewsSegmentedViewDelegate, IMYNewsSegmentedViewDataSource, IMYNewsRootContainerViewDelegate, MXScrollViewDelegate, CLLocationManagerDelegate, IMYThemeChangedProtocol, IMYTimerRuningProtocol, UIViewControllerTransitioningDelegate>
{
    _Bool _showNewNavigationStyle;
    _Bool _canUpdateCategory;
    _Bool _isNewsDoubleFlow;
    _Bool _navigationBarAnimate;
    _Bool _hideTopSubView;
    _Bool _showPullDownView;
    _Bool _showSearch;
    _Bool _refreshViewCanPullDown;
    _Bool _scrollToEnableTag;
    _Bool _videoFeeds;
    _Bool _is_double_row;
    int _locationAuthorizationStatus;
    UIView *_categoryView;
    UIView *_toolContainerView;
    MXParallaxHeader *_headerContainerView;
    UIView *_topView;
    UILabel *_titleLabel;
    IMYTouchEXButton *_pullDownBtn;
    IMYTouchEXButton *_addItemBtn;
    UIImageView *_hasNewItemImageView;
    IMYNewsHomeHeaderView *_newHomeHeaderView;
    UIView *_bottomBannerView;
    double _bottomBannerHeight;
    IMYTouchEXButton *_searchBtn;
    IMYButton *_returnBtn;
    IMYNewsRootScrollView *_scrollView;
    IMYPageViewController *_pageViewController;
    IMYNewsToolView *_toolView;
    IMYNewsSegmentedView *_segmentView;
    IMYNewsFloatMsgButton *_floatMsgBtn;
    NSMutableArray *_categoryArray;
    IMYNewsCategoryModel *_defaultCategory;
    IMYNewsRootContainerViewController *_defaultViewController;
    IMYNewsRootDoubleFlowViewController *_newsDoubleFlowVC;
    NSString *_toolResult;
    NSString *_lastVirtualToken;
    unsigned long long _feedsType;
    long long _imageType;
    CLLocationManager *_locationManager;
    UIScrollView *_pageScrollView;
    IMYNewsToolModel *_toolModel;
    unsigned long long _tabNoticeType;
    long long _countdownTime;
    unsigned long long _tabNoticeInterval;
    long long _tabNoticeNumber;
    long long _lastTabNoticeInterval;
    IMYURI *_homeToolURI;
    IMYTimerHelper *_timerHelper;
    unsigned long long _ttq_ReddotInterval;
    NSMutableArray *_redDotModels;
    UIViewController *_doubleFlowVC;
    id <IMYIAdManager> _chapingAd;
}

+ (void)resetNoticeView;
@property(nonatomic) _Bool is_double_row; // @synthesize is_double_row=_is_double_row;
@property(nonatomic) _Bool videoFeeds; // @synthesize videoFeeds=_videoFeeds;
@property(retain, nonatomic) id <IMYIAdManager> chapingAd; // @synthesize chapingAd=_chapingAd;
@property(retain, nonatomic) UIViewController *doubleFlowVC; // @synthesize doubleFlowVC=_doubleFlowVC;
@property(retain, nonatomic) NSMutableArray *redDotModels; // @synthesize redDotModels=_redDotModels;
@property(nonatomic) unsigned long long ttq_ReddotInterval; // @synthesize ttq_ReddotInterval=_ttq_ReddotInterval;
@property(retain, nonatomic) IMYTimerHelper *timerHelper; // @synthesize timerHelper=_timerHelper;
@property(retain, nonatomic) IMYURI *homeToolURI; // @synthesize homeToolURI=_homeToolURI;
@property(nonatomic) long long lastTabNoticeInterval; // @synthesize lastTabNoticeInterval=_lastTabNoticeInterval;
@property(nonatomic) long long tabNoticeNumber; // @synthesize tabNoticeNumber=_tabNoticeNumber;
@property(nonatomic) unsigned long long tabNoticeInterval; // @synthesize tabNoticeInterval=_tabNoticeInterval;
@property(nonatomic) long long countdownTime; // @synthesize countdownTime=_countdownTime;
@property(nonatomic) unsigned long long tabNoticeType; // @synthesize tabNoticeType=_tabNoticeType;
@property(retain, nonatomic) IMYNewsToolModel *toolModel; // @synthesize toolModel=_toolModel;
@property(nonatomic) _Bool scrollToEnableTag; // @synthesize scrollToEnableTag=_scrollToEnableTag;
@property(nonatomic) __weak UIScrollView *pageScrollView; // @synthesize pageScrollView=_pageScrollView;
@property(nonatomic) _Bool refreshViewCanPullDown; // @synthesize refreshViewCanPullDown=_refreshViewCanPullDown;
@property(nonatomic) _Bool showSearch; // @synthesize showSearch=_showSearch;
@property(nonatomic) _Bool showPullDownView; // @synthesize showPullDownView=_showPullDownView;
@property(nonatomic) _Bool hideTopSubView; // @synthesize hideTopSubView=_hideTopSubView;
@property(nonatomic) _Bool navigationBarAnimate; // @synthesize navigationBarAnimate=_navigationBarAnimate;
@property(nonatomic) int locationAuthorizationStatus; // @synthesize locationAuthorizationStatus=_locationAuthorizationStatus;
@property(retain, nonatomic) CLLocationManager *locationManager; // @synthesize locationManager=_locationManager;
@property(nonatomic) long long imageType; // @synthesize imageType=_imageType;
@property(nonatomic) unsigned long long feedsType; // @synthesize feedsType=_feedsType;
@property(nonatomic) _Bool isNewsDoubleFlow; // @synthesize isNewsDoubleFlow=_isNewsDoubleFlow;
@property(nonatomic) _Bool canUpdateCategory; // @synthesize canUpdateCategory=_canUpdateCategory;
@property(copy, nonatomic) NSString *lastVirtualToken; // @synthesize lastVirtualToken=_lastVirtualToken;
@property(copy, nonatomic) NSString *toolResult; // @synthesize toolResult=_toolResult;
@property(retain, nonatomic) IMYNewsRootDoubleFlowViewController *newsDoubleFlowVC; // @synthesize newsDoubleFlowVC=_newsDoubleFlowVC;
@property(retain, nonatomic) IMYNewsRootContainerViewController *defaultViewController; // @synthesize defaultViewController=_defaultViewController;
@property(retain, nonatomic) IMYNewsCategoryModel *defaultCategory; // @synthesize defaultCategory=_defaultCategory;
@property(retain, nonatomic) NSMutableArray *categoryArray; // @synthesize categoryArray=_categoryArray;
@property(retain, nonatomic) IMYNewsFloatMsgButton *floatMsgBtn; // @synthesize floatMsgBtn=_floatMsgBtn;
@property(retain, nonatomic) IMYNewsSegmentedView *segmentView; // @synthesize segmentView=_segmentView;
@property(retain, nonatomic) IMYNewsToolView *toolView; // @synthesize toolView=_toolView;
@property(retain, nonatomic) IMYPageViewController *pageViewController; // @synthesize pageViewController=_pageViewController;
@property(retain, nonatomic) IMYNewsRootScrollView *scrollView; // @synthesize scrollView=_scrollView;
@property(retain, nonatomic) IMYButton *returnBtn; // @synthesize returnBtn=_returnBtn;
@property(retain, nonatomic) IMYTouchEXButton *searchBtn; // @synthesize searchBtn=_searchBtn;
@property(nonatomic) double bottomBannerHeight; // @synthesize bottomBannerHeight=_bottomBannerHeight;
@property(retain, nonatomic) UIView *bottomBannerView; // @synthesize bottomBannerView=_bottomBannerView;
@property(retain, nonatomic) IMYNewsHomeHeaderView *newHomeHeaderView; // @synthesize newHomeHeaderView=_newHomeHeaderView;
@property(retain, nonatomic) UIImageView *hasNewItemImageView; // @synthesize hasNewItemImageView=_hasNewItemImageView;
@property(retain, nonatomic) IMYTouchEXButton *addItemBtn; // @synthesize addItemBtn=_addItemBtn;
@property(retain, nonatomic) IMYTouchEXButton *pullDownBtn; // @synthesize pullDownBtn=_pullDownBtn;
@property(retain, nonatomic) UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
@property(retain, nonatomic) UIView *topView; // @synthesize topView=_topView;
@property(nonatomic) _Bool showNewNavigationStyle; // @synthesize showNewNavigationStyle=_showNewNavigationStyle;
@property(retain, nonatomic) MXParallaxHeader *headerContainerView; // @synthesize headerContainerView=_headerContainerView;
@property(retain, nonatomic) UIView *toolContainerView; // @synthesize toolContainerView=_toolContainerView;
@property(retain, nonatomic) UIView *categoryView; // @synthesize categoryView=_categoryView;
- (void).cxx_destruct;
- (long long)getUserModeForAd;
- (void)setBiWeiboEndType:(long long)arg1;
- (void)resetBottomBannerViewHeight:(double)arg1;
- (void)refreshToolBannerView:(id)arg1;
- (id)animationControllerForDismissedController:(id)arg1;
- (id)animationControllerForPresentedController:(id)arg1 presentingController:(id)arg2 sourceController:(id)arg3;
- (long long)allRedDotModels:(id)arg1;
- (void)creatTimerHelp;
- (void)focuseRedDotWith:(id)arg1;
- (id)creatFocuseRedDocModel:(long long)arg1 catId:(long long)arg2 identifer:(id)arg3;
- (id)creatTTQRedDocModel:(long long)arg1 catId:(long long)arg2 identifer:(id)arg3;
- (void)hidenAndRemoveAllRedDot;
- (void)removeAllRedDotModels;
- (void)hidenAllRedDotView;
- (void)removeRedDotViewAt:(long long)arg1;
- (void)removeRedDotViewWith:(id)arg1;
- (id)redDotModelWithCatId:(long long)arg1;
- (id)redDotModelWith:(long long)arg1;
- (void)addRedDotModel:(id)arg1;
- (void)tabStopRefresh;
- (void)tabStartRefresh;
- (void)postForBI:(id)arg1;
- (void)loadCacheAction;
- (void)cacheCategory:(id)arg1;
- (void)locationManager:(id)arg1 didChangeAuthorizationStatus:(int)arg2;
- (void)locationManager:(id)arg1 didUpdateLocations:(id)arg2;
- (void)checkLocationResult:(id)arg1;
- (void)beginLocationAction;
- (void)pageViewController:(id)arg1 didTransitionFromIndex:(unsigned long long)arg2 toIndex:(unsigned long long)arg3;
- (unsigned long long)numberOfControllersInPageViewController:(id)arg1;
- (id)pageViewController:(id)arg1 controllerAtIndex:(unsigned long long)arg2;
- (unsigned long long)indexOfContainerViewController:(id)arg1;
- (double)segmentedViewWidth:(id)arg1 index:(unsigned long long)arg2;
- (id)titleForSegmentedView:(id)arg1 index:(unsigned long long)arg2;
- (unsigned long long)numberOfSegmentedViews:(id)arg1;
- (void)IMYNewsSegmentedViewDidSelect:(id)arg1 index:(unsigned long long)arg2;
- (void)biIMYNewsRootContainerViewSetToolInfo:(id)arg1;
- (void)IMYNewsRootContainerViewSetToolInfo:(id)arg1;
- (long long)IMYNewsRootContainerViewGetUserModeForAd;
- (void)IMYNewsRootContainerViewSendLocalMessage:(id)arg1;
- (void)IMYNewsRootContainerView:(id)arg1 adBannerRefresh:(id)arg2 isClose:(_Bool)arg3;
- (void)IMYNewsRootContainerViewCheckScroll:(id)arg1;
- (_Bool)IMYNewsRootContainerViewCanShowScrollTopBtn;
- (unsigned long long)IMYNewsRootContainerViewCategoryIndex:(unsigned long long)arg1;
- (void)IMYNewsRootContainerViewDidRequestCategory:(id)arg1 categorys:(id)arg2;
- (void)checkScrollViewScrollStatus:(id)arg1;
- (void)setDoubleFlowVCScrollEnbled:(_Bool)arg1;
- (void)checkDoubleFlowScrollStatus:(id)arg1;
- (void)setOffset:(double)arg1;
- (void)scrollViewDidEndDecelerating:(id)arg1;
- (void)scrollViewDidEndDragging:(id)arg1 willDecelerate:(_Bool)arg2;
- (void)setScrollViewScrollEnable:(_Bool)arg1 animated:(_Bool)arg2;
- (void)scrollViewDidScroll:(id)arg1;
- (_Bool)scrollView:(id)arg1 shouldScrollWithSubView:(id)arg2;
- (void)scrollViewWillBeginDragging:(id)arg1;
- (void)imy_themeChanged;
- (void)currentMessageAction:(id)arg1;
- (void)scrollToTopByBackBtn:(_Bool)arg1;
- (void)showToolContainerView:(_Bool)arg1;
- (void)showFloatMessageBtn:(_Bool)arg1;
- (void)showHasNewItem:(_Bool)arg1;
- (void)addItemAction:(id)arg1;
- (void)searchAction:(id)arg1;
- (void)showPullDownViewAction;
- (void)reloadSegmentViewAndMoveToCagegory:(unsigned long long)arg1;
- (void)reloadSegmentView:(id)arg1;
- (id)createContainerViewController:(id)arg1;
- (id)createDoubleFlowViewController;
- (id)containerViewController:(id)arg1;
- (void)moveToCategory:(unsigned long long)arg1 Forward:(_Bool)arg2 animated:(_Bool)arg3;
- (void)checkStatusBarStyle;
- (void)setCategoryID:(unsigned long long)arg1 animate:(_Bool)arg2;
- (void)startBadgesTimer;
- (void)handleBadge;
- (void)imy_timerRuning;
- (id)rightTopView;
- (id)midTopView;
- (id)leftTopView;
- (id)newHomeHeaderRightButton;
- (_Bool)showDoubleFlowRow;
- (id)ga_pageName;
- (id)toolBannerView:(_Bool)arg1;
- (id)bannerView;
- (_Bool)showTopCategoryView;
- (void)segmentViewShowRedDotAtIndex:(long long)arg1;
- (double)segmentViewHeight;
- (double)toolContainerViewHeight;
- (double)headerViewHeight;
- (id)visibleContainerViewController;
- (id)newStyleSubTitle;
- (void)setupNewNavigationBar;
- (void)prepareData;
- (void)prepareUI;
- (void)viewDidLayoutSubviews;
- (void)viewDidAppear:(_Bool)arg1;
- (void)initChaPingAdmanager:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewDidLoad;
- (void)presentViewController:(id)arg1 animated:(_Bool)arg2 completion:(CDUnknownBlockType)arg3;
- (id)initWithNibName:(id)arg1 bundle:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

