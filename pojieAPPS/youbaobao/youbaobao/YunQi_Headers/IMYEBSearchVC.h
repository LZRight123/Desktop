//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYEBBaseViewController.h"

#import "IMYEBSearchBarDelegate-Protocol.h"
#import "UICollectionViewDataSource-Protocol.h"
#import "UICollectionViewDelegate-Protocol.h"
#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"
#import "UITextFieldDelegate-Protocol.h"

@class IMYEBSearchModel, IMYEBSearchNewBar, IMYEBSearchViewModel, NSMutableArray, NSMutableDictionary, NSString, UICollectionView, UITableView;

@interface IMYEBSearchVC : IMYEBBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, IMYEBSearchBarDelegate, UITextFieldDelegate>
{
    _Bool _isSearchResultReturn;
    NSString *_defaultKeyword;
    NSString *_keyword;
    NSString *_placeholderWord;
    NSString *_displayKeyword;
    IMYEBSearchNewBar *_searchBar;
    UICollectionView *_collectionView;
    IMYEBSearchViewModel *_searchVM;
    NSMutableArray *_searchHistoryArr;
    NSMutableDictionary *_keyWidthDict;
    IMYEBSearchModel *_searchModel;
    UITableView *_searchTableView;
    NSString *_lastKeyword;
    NSString *_videoUrl;
    double _videoHeight;
}

@property(nonatomic) double videoHeight; // @synthesize videoHeight=_videoHeight;
@property(copy, nonatomic) NSString *videoUrl; // @synthesize videoUrl=_videoUrl;
@property(copy, nonatomic) NSString *lastKeyword; // @synthesize lastKeyword=_lastKeyword;
@property(retain, nonatomic) UITableView *searchTableView; // @synthesize searchTableView=_searchTableView;
@property(retain, nonatomic) IMYEBSearchModel *searchModel; // @synthesize searchModel=_searchModel;
@property(retain, nonatomic) NSMutableDictionary *keyWidthDict; // @synthesize keyWidthDict=_keyWidthDict;
@property(retain, nonatomic) NSMutableArray *searchHistoryArr; // @synthesize searchHistoryArr=_searchHistoryArr;
@property(retain, nonatomic) IMYEBSearchViewModel *searchVM; // @synthesize searchVM=_searchVM;
@property(retain, nonatomic) UICollectionView *collectionView; // @synthesize collectionView=_collectionView;
@property(retain, nonatomic) IMYEBSearchNewBar *searchBar; // @synthesize searchBar=_searchBar;
@property(nonatomic) _Bool isSearchResultReturn; // @synthesize isSearchResultReturn=_isSearchResultReturn;
@property(copy, nonatomic) NSString *displayKeyword; // @synthesize displayKeyword=_displayKeyword;
@property(copy, nonatomic) NSString *placeholderWord; // @synthesize placeholderWord=_placeholderWord;
@property(copy, nonatomic) NSString *keyword; // @synthesize keyword=_keyword;
@property(copy, nonatomic) NSString *defaultKeyword; // @synthesize defaultKeyword=_defaultKeyword;
- (void).cxx_destruct;
- (void)requestFinishedWithResult:(id)arg1 shareType:(long long)arg2;
- (void)requestFinishedWithPageInfo:(id)arg1;
- (void)shareVideoWithType:(unsigned long long)arg1;
- (double)calculateMarketAreaHeightWith:(id)arg1;
- (void)keyboardWillHideNotification:(id)arg1;
- (void)keyboardWillShowNotification:(id)arg1;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (void)dustbinButtonClick;
- (void)jumpToSearchResultsPageWith:(id)arg1;
- (void)saveSearchKey:(id)arg1;
- (void)scrollViewWillBeginDragging:(id)arg1;
- (void)collectionView:(id)arg1 didSelectItemAtIndexPath:(id)arg2;
- (struct CGSize)collectionView:(id)arg1 layout:(id)arg2 sizeForItemAtIndexPath:(id)arg3;
- (id)collectionView:(id)arg1 viewForSupplementaryElementOfKind:(id)arg2 atIndexPath:(id)arg3;
- (struct UIEdgeInsets)collectionView:(id)arg1 layout:(id)arg2 insetForSectionAtIndex:(long long)arg3;
- (struct CGSize)collectionView:(id)arg1 layout:(id)arg2 referenceSizeForHeaderInSection:(long long)arg3;
- (void)configCell:(id)arg1 atIndexPath:(id)arg2;
- (id)collectionView:(id)arg1 cellForItemAtIndexPath:(id)arg2;
- (long long)collectionView:(id)arg1 numberOfItemsInSection:(long long)arg2;
- (long long)numberOfSectionsInCollectionView:(id)arg1;
- (void)searchEditingChanged:(id)arg1;
- (void)searchWithStr:(id)arg1;
- (void)onSearchClick:(id)arg1;
- (void)calculateKeyWidthWith:(id)arg1 Session:(long long)arg2;
- (void)addSearchTabView;
- (void)addCollectionView;
- (void)cancel;
- (void)setupUI;
- (void)didReceiveMemoryWarning;
- (void)viewDidDisappear:(_Bool)arg1;
- (_Bool)ifShouldPlayVideoWithModel:(id)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (_Bool)enableFullPopGestureRecognizer;
- (void)dealloc;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

