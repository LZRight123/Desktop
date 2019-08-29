//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYTableViewAdManager.h"

@class NSArray;

@interface IMYFeedsAdManager : IMYTableViewAdManager
{
    _Bool _willRefresh;
    NSArray *_prepareAdPositions;
    long long _sectionNumber;
    double _postRefreshDelay;
}

@property(nonatomic) _Bool willRefresh; // @synthesize willRefresh=_willRefresh;
@property(nonatomic) double postRefreshDelay; // @synthesize postRefreshDelay=_postRefreshDelay;
@property(nonatomic) long long sectionNumber; // @synthesize sectionNumber=_sectionNumber;
@property(retain, nonatomic) NSArray *prepareAdPositions; // @synthesize prepareAdPositions=_prepareAdPositions;
- (void).cxx_destruct;
- (void)setupAdPositionsWithSectionNumber:(long long)arg1;
- (void)aopTableUtils:(id)arg1 numberOfSection:(long long)arg2;
- (void)beginRefreshView;
- (id)prepareAdPositionForAdModel:(id)arg1;
- (void)refreshView;
- (void)poolFinishFreshView:(id)arg1;
- (void)postRefreshView:(id)arg1;
- (id)seriveKeyWithModel:(id)arg1 seriveMap:(id)arg2;
- (void)perfectAdInfo:(id)arg1;
- (id)createServicesWithRawModels:(id)arg1;
- (id)createServicesWithRawModels:(id)arg1 isLoadMore:(_Bool)arg2;
- (void)updateServicesWithRawModels:(id)arg1;
- (void)setupServicesWithRawModels:(id)arg1;
- (void)appendServicesWithRawModels:(id)arg1 isFilter:(_Bool)arg2;
- (void)removeAllAppendServices;
- (id)initWithADInfo:(id)arg1;
- (long long)realRawCountWithSection:(long long)arg1;

@end
