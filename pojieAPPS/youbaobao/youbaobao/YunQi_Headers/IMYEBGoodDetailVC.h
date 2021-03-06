//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYEBBaseViewController.h"

#import "IMYEBCouponViewControllerDelegate-Protocol.h"
#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"

@class IMYButton, IMYCaptionView, IMYEBCouponViewController, IMYEBDetailDropView, IMYEBGoodDescribeCell, IMYEBGoodDetailModel, IMYEBGoodDetailVM, IMYEBScrollToTopButton, IMYTouchEXButton, NSDictionary, NSString, UIButton, UILabel, UITableView, UIView;

@interface IMYEBGoodDetailVC : IMYEBBaseViewController <UITableViewDelegate, UITableViewDataSource, IMYEBCouponViewControllerDelegate>
{
    _Bool _isFromCollection;
    _Bool _tabClicked;
    NSString *_item_id;
    NSString *_pid;
    NSString *_adzone_id;
    NSString *_brand_area_id;
    NSDictionary *_otherParams;
    UITableView *_tableView;
    IMYEBGoodDescribeCell *_goodCell;
    IMYEBGoodDetailVM *_viewModel;
    IMYCaptionView *_captionView;
    IMYEBGoodDetailModel *_showModel;
    UIView *_customNavigationView;
    IMYEBDetailDropView *_dropMenu;
    UILabel *_titleLabel;
    UIButton *_button;
    UIButton *_orgPriceButton;
    UILabel *_fromLabel;
    IMYEBScrollToTopButton *_scrollToUpButton;
    IMYEBCouponViewController *_couponViewController;
    double _promptViewHeight;
    UILabel *_footerLabel;
    UILabel *_headerLabel;
    double _detailSectionY;
    IMYButton *_bottomLeftButton;
    IMYButton *_bottomRightButton;
    double _bottomButtonWidth;
    double _bottomButtonFont;
    IMYTouchEXButton *_topLeftButton;
    IMYTouchEXButton *_topRightButton;
    double _navAlpha;
    struct CGRect _bgViewFrame;
}

@property(nonatomic) double navAlpha; // @synthesize navAlpha=_navAlpha;
@property(retain, nonatomic) IMYTouchEXButton *topRightButton; // @synthesize topRightButton=_topRightButton;
@property(retain, nonatomic) IMYTouchEXButton *topLeftButton; // @synthesize topLeftButton=_topLeftButton;
@property(nonatomic) double bottomButtonFont; // @synthesize bottomButtonFont=_bottomButtonFont;
@property(nonatomic) double bottomButtonWidth; // @synthesize bottomButtonWidth=_bottomButtonWidth;
@property(nonatomic) struct CGRect bgViewFrame; // @synthesize bgViewFrame=_bgViewFrame;
@property(retain, nonatomic) IMYButton *bottomRightButton; // @synthesize bottomRightButton=_bottomRightButton;
@property(retain, nonatomic) IMYButton *bottomLeftButton; // @synthesize bottomLeftButton=_bottomLeftButton;
@property(nonatomic) double detailSectionY; // @synthesize detailSectionY=_detailSectionY;
@property(retain, nonatomic) UILabel *headerLabel; // @synthesize headerLabel=_headerLabel;
@property(retain, nonatomic) UILabel *footerLabel; // @synthesize footerLabel=_footerLabel;
@property(nonatomic) _Bool tabClicked; // @synthesize tabClicked=_tabClicked;
@property(nonatomic) double promptViewHeight; // @synthesize promptViewHeight=_promptViewHeight;
@property(retain, nonatomic) IMYEBCouponViewController *couponViewController; // @synthesize couponViewController=_couponViewController;
@property(retain, nonatomic) IMYEBScrollToTopButton *scrollToUpButton; // @synthesize scrollToUpButton=_scrollToUpButton;
@property(retain, nonatomic) UILabel *fromLabel; // @synthesize fromLabel=_fromLabel;
@property(retain, nonatomic) UIButton *orgPriceButton; // @synthesize orgPriceButton=_orgPriceButton;
@property(retain, nonatomic) UIButton *button; // @synthesize button=_button;
@property(retain, nonatomic) UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
@property(retain, nonatomic) IMYEBDetailDropView *dropMenu; // @synthesize dropMenu=_dropMenu;
@property(retain, nonatomic) UIView *customNavigationView; // @synthesize customNavigationView=_customNavigationView;
@property(retain, nonatomic) IMYEBGoodDetailModel *showModel; // @synthesize showModel=_showModel;
@property(retain, nonatomic) IMYCaptionView *captionView; // @synthesize captionView=_captionView;
@property(retain, nonatomic) IMYEBGoodDetailVM *viewModel; // @synthesize viewModel=_viewModel;
@property(retain, nonatomic) IMYEBGoodDescribeCell *goodCell; // @synthesize goodCell=_goodCell;
@property(retain, nonatomic) UITableView *tableView; // @synthesize tableView=_tableView;
@property(retain, nonatomic) NSDictionary *otherParams; // @synthesize otherParams=_otherParams;
@property(nonatomic) _Bool isFromCollection; // @synthesize isFromCollection=_isFromCollection;
@property(copy, nonatomic) NSString *brand_area_id; // @synthesize brand_area_id=_brand_area_id;
@property(copy, nonatomic) NSString *adzone_id; // @synthesize adzone_id=_adzone_id;
@property(copy, nonatomic) NSString *pid; // @synthesize pid=_pid;
@property(copy, nonatomic) NSString *item_id; // @synthesize item_id=_item_id;
- (void).cxx_destruct;
- (void)bottomRightAction;
- (void)leftBottomButtonImageWithType:(long long)arg1 isLeft:(_Bool)arg2;
- (void)rightTopButtonBlackImageWithType:(long long)arg1 isLeft:(_Bool)arg2;
- (void)rightTopButtonWhiteImageWithType:(long long)arg1 isLeft:(_Bool)arg2;
- (void)rightTopButtonActionWithType:(long long)arg1 isLeft:(_Bool)arg2;
- (void)leftBottomButtonActionWithType:(long long)arg1 isLeft:(_Bool)arg2;
- (void)refreshDetailVCTabAndNavButtonsImage;
- (void)setNavigationBarColor:(double)arg1;
- (void)couponViewControllerButtonClicked:(id)arg1;
- (id)getShareParams;
- (id)getShareType;
- (id)imy_getURIPath;
- (void)shareButtonAction:(_Bool)arg1;
- (void)imyPopVCAction;
- (void)didSelectRowAtIndex:(long long)arg1 Title:(id)arg2 Image:(id)arg3;
- (void)initCustomNavigaiontView;
- (double)calculatePromptHeightWithModel:(id)arg1;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForFooterInSection:(long long)arg2;
- (id)tableView:(id)arg1 viewForFooterInSection:(long long)arg2;
- (double)tableView:(id)arg1 heightForHeaderInSection:(long long)arg2;
- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 willDisplayHeaderView:(id)arg2 forSection:(long long)arg3;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (double)detailHeightWithIndex:(long long)arg1;
- (double)detailHeight;
- (void)setupNavigationBarBackgroundViewWithAlpha:(double)arg1;
- (void)scrollViewDidScroll:(id)arg1;
- (void)initViewModel;
- (void)didReceiveMemoryWarning;
- (void)onButtonClick:(id)arg1;
- (void)gotoTaobao;
- (void)refresh;
- (void)viewWillAppear:(_Bool)arg1;
- (_Bool)fullPopGestureRecognizerShouldBegin:(id)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)addToMyCollect;
- (void)setButton:(id)arg1 title:(id)arg2 subtitle:(id)arg3 color:(id)arg4;
- (void)createBuyButton;
- (void)viewDidLayoutSubviews;
- (void)dealloc;
- (void)receiveMemoryWarning;
- (void)viewDidLoad;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

