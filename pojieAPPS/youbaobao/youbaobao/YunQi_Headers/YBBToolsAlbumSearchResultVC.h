//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYPublicBaseViewController.h"

#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"

@class IMYCaptionView, IMYVKWebViewController, NSDictionary, NSMutableArray, NSString, RACDisposable, UIButton, UILabel, UITableView, UIView;

@interface YBBToolsAlbumSearchResultVC : IMYPublicBaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    _Bool _hasMore;
    _Bool _hasGetXMUrl;
    UITableView *_tableView;
    IMYCaptionView *_captionView;
    CDUnknownBlockType _webSearch;
    NSString *_type;
    CDUnknownBlockType _selectTableviewRowBlock;
    CDUnknownBlockType _showTableviewRowBlock;
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    UIView *_lineView;
    UIButton *_selectBtn;
    UIView *_topMenuView;
    NSMutableArray *_albumArray;
    NSMutableArray *_contentArray;
    RACDisposable *_requestDisposable;
    long long _pageIndex;
    UILabel *_notMoreDataLable;
    UIView *_headerView;
    NSString *_searchString;
    IMYVKWebViewController *_webVC;
    long long _current_tab;
    long long _wordsType;
    NSDictionary *_biParams;
    NSMutableArray *_rankList;
    long long _albumNumb;
    long long _musicNumb;
}

@property(nonatomic) long long musicNumb; // @synthesize musicNumb=_musicNumb;
@property(nonatomic) long long albumNumb; // @synthesize albumNumb=_albumNumb;
@property(nonatomic) _Bool hasGetXMUrl; // @synthesize hasGetXMUrl=_hasGetXMUrl;
@property(retain, nonatomic) NSMutableArray *rankList; // @synthesize rankList=_rankList;
@property(copy, nonatomic) NSDictionary *biParams; // @synthesize biParams=_biParams;
@property(nonatomic) long long wordsType; // @synthesize wordsType=_wordsType;
@property(nonatomic) long long current_tab; // @synthesize current_tab=_current_tab;
@property(retain, nonatomic) IMYVKWebViewController *webVC; // @synthesize webVC=_webVC;
@property(nonatomic) _Bool hasMore; // @synthesize hasMore=_hasMore;
@property(copy, nonatomic) NSString *searchString; // @synthesize searchString=_searchString;
@property(retain, nonatomic) UIView *headerView; // @synthesize headerView=_headerView;
@property(retain, nonatomic) UILabel *notMoreDataLable; // @synthesize notMoreDataLable=_notMoreDataLable;
@property(nonatomic) long long pageIndex; // @synthesize pageIndex=_pageIndex;
@property(nonatomic) __weak RACDisposable *requestDisposable; // @synthesize requestDisposable=_requestDisposable;
@property(retain, nonatomic) NSMutableArray *contentArray; // @synthesize contentArray=_contentArray;
@property(retain, nonatomic) NSMutableArray *albumArray; // @synthesize albumArray=_albumArray;
@property(retain, nonatomic) UIView *topMenuView; // @synthesize topMenuView=_topMenuView;
@property(retain, nonatomic) UIButton *selectBtn; // @synthesize selectBtn=_selectBtn;
@property(retain, nonatomic) UIView *lineView; // @synthesize lineView=_lineView;
@property(retain, nonatomic) UIButton *rightBtn; // @synthesize rightBtn=_rightBtn;
@property(retain, nonatomic) UIButton *leftBtn; // @synthesize leftBtn=_leftBtn;
@property(copy, nonatomic) CDUnknownBlockType showTableviewRowBlock; // @synthesize showTableviewRowBlock=_showTableviewRowBlock;
@property(copy, nonatomic) CDUnknownBlockType selectTableviewRowBlock; // @synthesize selectTableviewRowBlock=_selectTableviewRowBlock;
@property(copy, nonatomic) NSString *type; // @synthesize type=_type;
@property(copy, nonatomic) CDUnknownBlockType webSearch; // @synthesize webSearch=_webSearch;
@property(retain, nonatomic) IMYCaptionView *captionView; // @synthesize captionView=_captionView;
@property(retain, nonatomic) UITableView *tableView; // @synthesize tableView=_tableView;
- (void).cxx_destruct;
- (void)playAlbum:(long long)arg1;
- (void)queryXMUrl:(long long)arg1;
- (void)selectSingle:(long long)arg1;
- (void)selectAlbum:(long long)arg1;
- (_Bool)singleOrAlbum:(long long)arg1;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (void)scrollViewDidScroll:(id)arg1;
- (void)searchEventTrack:(id)arg1 index:(long long)arg2 type:(unsigned long long)arg3;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2;
- (double)tableView:(id)arg1 heightForHeaderInSection:(long long)arg2;
- (id)getGlobalSearchWithKeyword:(id)arg1 andPage:(long long)arg2 success:(CDUnknownBlockType)arg3 failure:(CDUnknownBlockType)arg4;
- (void)getMoreData;
- (void)requestWithSearchWord:(id)arg1 andWords_type:(long long)arg2 biParams:(id)arg3;
- (void)rightDo;
- (void)rightBtnDidClick;
- (void)leftDo;
- (void)leftBtnDidClick;
- (void)addFooterRefreshing;
- (void)webHandler;
- (id)urlString;
- (void)setupCaptionView;
- (void)setupWebView;
- (void)setupTableView;
- (void)addTopMenuView;
- (void)viewDidLoad;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
