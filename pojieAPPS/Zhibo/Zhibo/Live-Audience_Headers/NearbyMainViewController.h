//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "BaseViewController.h"

#import "DZNEmptyDataSetDelegate-Protocol.h"
#import "DZNEmptyDataSetSource-Protocol.h"
#import "UICollectionViewDataSource-Protocol.h"
#import "UICollectionViewDelegate-Protocol.h"
#import "UICollectionViewDelegateFlowLayout-Protocol.h"
#import "ZPFlowLabelViewDelegate-Protocol.h"

@class NSArray, NSMutableArray, NSMutableDictionary, NSString, UICollectionView;

@interface NearbyMainViewController : BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, ZPFlowLabelViewDelegate, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    _Bool didUpdateLocation;
    int _pape;
    double latitude;
    double longitude;
    double headerViewHeight;
    _Bool noMoreData;
    _Bool loading;
    long long renderedRowNumber;
    NSMutableDictionary *adDictionary;
    NSString *_boxID;
    UICollectionView *_collectionView;
    NSMutableArray *_dataSource;
    NSMutableArray *_huatiArray;
    NSArray *_bannerModelArray;
    unsigned long long _module;
}

@property(nonatomic) unsigned long long module; // @synthesize module=_module;
@property(retain, nonatomic) NSArray *bannerModelArray; // @synthesize bannerModelArray=_bannerModelArray;
@property(retain, nonatomic) NSMutableArray *huatiArray; // @synthesize huatiArray=_huatiArray;
@property(retain, nonatomic) NSMutableArray *dataSource; // @synthesize dataSource=_dataSource;
@property(retain, nonatomic) UICollectionView *collectionView; // @synthesize collectionView=_collectionView;
@property(copy, nonatomic) NSString *boxID; // @synthesize boxID=_boxID;
- (void).cxx_destruct;
- (double)headerViewH:(id)arg1;
- (void)ZPFlowLabelViewclickOpenTopicAnchorList:(id)arg1;
- (id)topicSignal;
- (void)query:(id)arg1 key:(long long)arg2 array:(id)arg3;
- (id)fetchRoomList:(id)arg1;
- (id)fetchBoxRoomList:(id)arg1;
- (_Bool)emptyDataSetShouldAllowScroll:(id)arg1;
- (_Bool)emptyDataSetShouldDisplay:(id)arg1;
- (id)titleForEmptyDataSet:(id)arg1;
- (id)getFlowLabelViewWithIndexPath:(id)arg1;
- (id)getAdScrollViewWithIndexPath:(id)arg1;
- (id)collectionView:(id)arg1 viewForSupplementaryElementOfKind:(id)arg2 atIndexPath:(id)arg3;
- (struct CGSize)collectionView:(id)arg1 layout:(id)arg2 referenceSizeForFooterInSection:(long long)arg3;
- (struct CGSize)collectionView:(id)arg1 layout:(id)arg2 referenceSizeForHeaderInSection:(long long)arg3;
- (struct CGSize)collectionView:(id)arg1 layout:(id)arg2 sizeForItemAtIndexPath:(id)arg3;
- (void)collectionView:(id)arg1 didSelectItemAtIndexPath:(id)arg2;
- (id)collectionView:(id)arg1 cellForItemAtIndexPath:(id)arg2;
- (long long)collectionView:(id)arg1 numberOfItemsInSection:(long long)arg2;
- (long long)numberOfSectionsInCollectionView:(id)arg1;
- (void)fetchBoxData;
- (void)fetchNewData;
- (void)fetchChargeData;
- (void)fetchNearbyData;
- (void)startNearbyDataFlow;
- (void)setupLoadMoreFooter;
- (void)setupRefreshHeader;
- (id)getLoadMoreMoudleSignal;
- (void)startFresh;
- (void)setupUI;
- (void)registerClass;
- (void)viewDidLoad;
- (id)initWithModle:(unsigned long long)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

