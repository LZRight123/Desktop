//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYEBBaseViewController.h"

#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"

@class IMYCaptionView, IMYEBAddCartVC, IMYEBRecommentModel, IMYEBRecommentVM, IMYEBScrollToTopButton, NSMutableDictionary, NSString, UIButton, UITableView, UITableViewCell, UIView, zhPopupController;

@interface IMYEBRecommentDetailVC : IMYEBBaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    long long _item_id;
    UITableView *_tableView;
    UITableViewCell *_bannerCell;
    UITableViewCell *_itemInfoCell;
    UITableViewCell *_descriptionCell;
    IMYEBRecommentModel *_recommentModel;
    IMYEBRecommentVM *_recommentVM;
    UIView *_bottomSuspendView;
    UIButton *_cartButton;
    UIButton *_addCartButton;
    UIButton *_goToBuyButton;
    zhPopupController *_popUpController;
    NSMutableDictionary *_heightDic;
    IMYCaptionView *_captionView;
    double _contentCellHeight;
    IMYEBAddCartVC *_addCartVc;
    IMYEBScrollToTopButton *_scrollToUpButton;
}

@property(retain, nonatomic) IMYEBScrollToTopButton *scrollToUpButton; // @synthesize scrollToUpButton=_scrollToUpButton;
@property(retain, nonatomic) IMYEBAddCartVC *addCartVc; // @synthesize addCartVc=_addCartVc;
@property(nonatomic) double contentCellHeight; // @synthesize contentCellHeight=_contentCellHeight;
@property(retain, nonatomic) IMYCaptionView *captionView; // @synthesize captionView=_captionView;
@property(retain, nonatomic) NSMutableDictionary *heightDic; // @synthesize heightDic=_heightDic;
@property(retain, nonatomic) zhPopupController *popUpController; // @synthesize popUpController=_popUpController;
@property(retain, nonatomic) UIButton *goToBuyButton; // @synthesize goToBuyButton=_goToBuyButton;
@property(retain, nonatomic) UIButton *addCartButton; // @synthesize addCartButton=_addCartButton;
@property(retain, nonatomic) UIButton *cartButton; // @synthesize cartButton=_cartButton;
@property(retain, nonatomic) UIView *bottomSuspendView; // @synthesize bottomSuspendView=_bottomSuspendView;
@property(retain, nonatomic) IMYEBRecommentVM *recommentVM; // @synthesize recommentVM=_recommentVM;
@property(retain, nonatomic) IMYEBRecommentModel *recommentModel; // @synthesize recommentModel=_recommentModel;
@property(retain, nonatomic) UITableViewCell *descriptionCell; // @synthesize descriptionCell=_descriptionCell;
@property(retain, nonatomic) UITableViewCell *itemInfoCell; // @synthesize itemInfoCell=_itemInfoCell;
@property(retain, nonatomic) UITableViewCell *bannerCell; // @synthesize bannerCell=_bannerCell;
@property(retain, nonatomic) UITableView *tableView; // @synthesize tableView=_tableView;
@property(nonatomic) long long item_id; // @synthesize item_id=_item_id;
- (void).cxx_destruct;
- (void)centerImageAndTitleWithButton:(id)arg1 space:(float)arg2;
- (void)cellHeightWith:(id)arg1;
- (void)topRightShareButtonTouchUpAction:(id)arg1;
- (void)closeWebView;
- (id)imytae_closeButtonTopbarItems;
- (void)initBannerData;
- (id)getShareParams;
- (id)getShareType;
- (id)imy_getURIPath;
- (void)initViewModel;
- (void)reloadShowData;
- (id)descriptionCellWithTableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (id)recommentContentCellWithTableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForHeaderInSection:(long long)arg2;
- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (void)addCartButtonClick;
- (void)goToBuyButtonClick;
- (void)cartButtonClick;
- (void)didReceiveMemoryWarning;
- (void)viewDidLoad;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

