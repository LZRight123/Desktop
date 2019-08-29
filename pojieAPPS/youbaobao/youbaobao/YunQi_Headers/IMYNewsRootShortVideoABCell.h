//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYNewsRootBaseABCell.h"

#import "IMYNewsRootShortVideoItemViewDelegate-Protocol.h"
#import "UIScrollViewDelegate-Protocol.h"

@class IMYRecommendShortVideoModel, NSString, UIImageView, UILabel, UIScrollView;
@protocol IMYNewsRootShortVideoCellDelegate;

@interface IMYNewsRootShortVideoABCell : IMYNewsRootBaseABCell <UIScrollViewDelegate, IMYNewsRootShortVideoItemViewDelegate>
{
    id <IMYNewsRootShortVideoCellDelegate> _shoreVideoDelegate;
    IMYRecommendShortVideoModel *_shortVideoModel;
    UIScrollView *_scrollView;
    long long _floor;
    NSString *_cardID;
    long long _currentIndex;
    UIImageView *_moreArrowImgView;
    UILabel *_moreTipLabel;
    long long _refreshState;
}

+ (double)cellHeight;
@property(nonatomic) long long refreshState; // @synthesize refreshState=_refreshState;
@property(retain, nonatomic) UILabel *moreTipLabel; // @synthesize moreTipLabel=_moreTipLabel;
@property(retain, nonatomic) UIImageView *moreArrowImgView; // @synthesize moreArrowImgView=_moreArrowImgView;
@property(nonatomic) long long currentIndex; // @synthesize currentIndex=_currentIndex;
@property(copy, nonatomic) NSString *cardID; // @synthesize cardID=_cardID;
@property(nonatomic) long long floor; // @synthesize floor=_floor;
@property(retain, nonatomic) UIScrollView *scrollView; // @synthesize scrollView=_scrollView;
@property(retain, nonatomic) IMYRecommendShortVideoModel *shortVideoModel; // @synthesize shortVideoModel=_shortVideoModel;
@property(nonatomic) __weak id <IMYNewsRootShortVideoCellDelegate> shoreVideoDelegate; // @synthesize shoreVideoDelegate=_shoreVideoDelegate;
- (void).cxx_destruct;
- (void)scrollViewDidScroll:(id)arg1;
- (void)clickBiInformationForEntirety;
- (void)clickBiInformation:(long long)arg1;
- (void)postBiInfomationWithIndex:(long long)arg1;
- (void)postBIInformationwithCardId:(id)arg1 floor:(long long)arg2;
- (void)IMYNewsRootShortVideoItemViewClickedAtIndex:(long long)arg1 corverImage:(id)arg2 itemFrame:(struct CGRect)arg3;
- (void)scrollToItemViewByIndex:(long long)arg1;
- (id)getShortVideoItemViewByIndex:(long long)arg1;
- (void)setCellModel:(id)arg1;
- (void)prepareUI;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
