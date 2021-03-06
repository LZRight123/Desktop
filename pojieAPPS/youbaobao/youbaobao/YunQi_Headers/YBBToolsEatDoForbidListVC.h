//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYPublicBaseViewController.h"

#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"
#import "UITextFieldDelegate-Protocol.h"

@class IMYCaptionView, NSMutableArray, NSMutableDictionary, NSMutableString, NSString, UIButton, UILabel, UITableView, YYBToolsEatDoTopSeaResTitleV;

@interface YBBToolsEatDoForbidListVC : IMYPublicBaseViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    _Bool _isAct;
    _Bool _isSearch;
    _Bool _hasMore;
    _Bool _didNextVCHidenNavBar;
    _Bool _isSearching;
    _Bool _needShowKeyboard;
    long long _categoryId;
    NSMutableDictionary *_paramList;
    NSString *_cacheName;
    NSMutableArray *_dataList;
    NSString *_path;
    NSString *_requestWord;
    CDUnknownBlockType _feedBackBlock;
    UITableView *_tableView;
    IMYCaptionView *_captionView;
    unsigned long long _posID;
    long long _from;
    YYBToolsEatDoTopSeaResTitleV *_searchView;
    NSString *_oldTitle;
    UILabel *_loadMoreLabel;
    UIButton *_feedbackBtn;
    unsigned long long _indexOfSearchFromType;
    unsigned long long _idOfSearchFromType;
    unsigned long long _searchFromType;
    NSString *_searchKey;
    UITableView *_associateTableView;
    NSMutableArray *_associateDatas;
    NSMutableString *_associateDatasTitles;
    NSString *_lastAssociateSearchWord;
    unsigned long long _WordsType;
    long long _location;
}

@property(nonatomic) long long location; // @synthesize location=_location;
@property(nonatomic) unsigned long long WordsType; // @synthesize WordsType=_WordsType;
@property(retain, nonatomic) NSString *lastAssociateSearchWord; // @synthesize lastAssociateSearchWord=_lastAssociateSearchWord;
@property(retain, nonatomic) NSMutableString *associateDatasTitles; // @synthesize associateDatasTitles=_associateDatasTitles;
@property(retain, nonatomic) NSMutableArray *associateDatas; // @synthesize associateDatas=_associateDatas;
@property(retain, nonatomic) UITableView *associateTableView; // @synthesize associateTableView=_associateTableView;
@property(copy, nonatomic) NSString *searchKey; // @synthesize searchKey=_searchKey;
@property(nonatomic) unsigned long long searchFromType; // @synthesize searchFromType=_searchFromType;
@property(nonatomic) _Bool needShowKeyboard; // @synthesize needShowKeyboard=_needShowKeyboard;
@property(nonatomic) unsigned long long idOfSearchFromType; // @synthesize idOfSearchFromType=_idOfSearchFromType;
@property(nonatomic) unsigned long long indexOfSearchFromType; // @synthesize indexOfSearchFromType=_indexOfSearchFromType;
@property(nonatomic) _Bool isSearching; // @synthesize isSearching=_isSearching;
@property(nonatomic) _Bool didNextVCHidenNavBar; // @synthesize didNextVCHidenNavBar=_didNextVCHidenNavBar;
@property(retain, nonatomic) UIButton *feedbackBtn; // @synthesize feedbackBtn=_feedbackBtn;
@property(retain, nonatomic) UILabel *loadMoreLabel; // @synthesize loadMoreLabel=_loadMoreLabel;
@property(nonatomic) _Bool hasMore; // @synthesize hasMore=_hasMore;
@property(copy, nonatomic) NSString *oldTitle; // @synthesize oldTitle=_oldTitle;
@property(retain, nonatomic) YYBToolsEatDoTopSeaResTitleV *searchView; // @synthesize searchView=_searchView;
@property(nonatomic) long long from; // @synthesize from=_from;
@property(nonatomic) unsigned long long posID; // @synthesize posID=_posID;
@property(retain, nonatomic) IMYCaptionView *captionView; // @synthesize captionView=_captionView;
@property(retain, nonatomic) UITableView *tableView; // @synthesize tableView=_tableView;
@property(copy, nonatomic) CDUnknownBlockType feedBackBlock; // @synthesize feedBackBlock=_feedBackBlock;
@property(copy, nonatomic) NSString *requestWord; // @synthesize requestWord=_requestWord;
@property(nonatomic) _Bool isSearch; // @synthesize isSearch=_isSearch;
@property(nonatomic) _Bool isAct; // @synthesize isAct=_isAct;
@property(copy, nonatomic) NSString *path; // @synthesize path=_path;
@property(retain, nonatomic) NSMutableArray *dataList; // @synthesize dataList=_dataList;
@property(copy, nonatomic) NSString *cacheName; // @synthesize cacheName=_cacheName;
@property(retain, nonatomic) NSMutableDictionary *paramList; // @synthesize paramList=_paramList;
@property(nonatomic) long long categoryId; // @synthesize categoryId=_categoryId;
- (void).cxx_destruct;
- (void)requestSearchAssociateKeyWord:(id)arg1;
- (void)textFiledEditChanged:(id)arg1;
- (void)hideKeyboard;
- (void)requestWithWord:(id)arg1;
- (_Bool)textFieldShouldClear:(id)arg1;
- (void)textFieldTextChange:(id)arg1;
- (void)searchEventTrack;
- (void)trackClickRow:(long long)arg1;
- (void)trackSearchResultWithDataArray:(id)arg1;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (void)scrollViewDidEndDecelerating:(id)arg1;
- (void)scrollViewWillBeginDragging:(id)arg1;
- (void)textFieldDidEndEditing:(id)arg1;
- (_Bool)textFieldShouldReturn:(id)arg1;
- (_Bool)textFieldShouldBeginEditing:(id)arg1;
- (void)hideCancelButton;
- (void)showCancelButton;
- (void)searchCancelAction:(id)arg1;
- (void)cancelSearchForbid;
- (void)searchForbids;
- (void)buildAssociateTableView;
- (void)buildSearchBar;
- (void)feedbackBtnClick;
- (void)buildXiaoYouZi;
- (void)drawTableView;
- (void)refreshFinish:(id)arg1;
- (void)loadMoreDataList;
- (_Bool)isNeedReflashCurrentUI:(id)arg1;
- (void)refreshDataList;
- (_Bool)getDataListCache;
- (void)getDataList;
- (void)dealloc;
- (void)didReceiveMemoryWarning;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (id)initWithTitle:(id)arg1 AndCid:(long long)arg2;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

