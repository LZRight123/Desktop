//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYBaseAdvertiserManager.h"

@class IMYRecordAdPosition, IMYRecordAnimateAdView, NSArray;

@interface IMYRecordAdManager : IMYBaseAdvertiserManager
{
    NSArray *_recordAdPositions;
    IMYRecordAnimateAdView *_animateAdView;
    IMYRecordAdPosition *_showAdPosition;
}

@property(retain, nonatomic) IMYRecordAdPosition *showAdPosition; // @synthesize showAdPosition=_showAdPosition;
@property(retain, nonatomic) IMYRecordAnimateAdView *animateAdView; // @synthesize animateAdView=_animateAdView;
@property(retain, nonatomic) NSArray *recordAdPositions; // @synthesize recordAdPositions=_recordAdPositions;
- (void).cxx_destruct;
- (void)dealloc;
- (void)setShowAdCount:(long long)arg1 position:(long long)arg2;
- (long long)showAdCountPosition:(long long)arg1;
- (id)getRecordShowAdCountMap;
- (void)showMenalgiaAnimateLevel:(long long)arg1 day:(id)arg2 close:(_Bool)arg3;
- (void)menalgiaLevel:(long long)arg1 position:(long long)arg2;
- (void)makeManType:(long long)arg1;
- (void)recordAction:(id)arg1;
- (void)setSignalBlock;
- (id)recordAdPositionForAdModel:(id)arg1;
- (void)adIsUpdate;
- (id)createServicesWithRawModels:(id)arg1;
- (void)setupServicesWithRawModels:(id)arg1;
- (void)appendServicesWithRawModels:(id)arg1 isFilter:(_Bool)arg2;
- (void)removeAllAppendServices;
- (id)initWithADInfo:(id)arg1;

@end

