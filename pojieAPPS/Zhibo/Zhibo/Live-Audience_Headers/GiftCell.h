//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UICollectionViewCell.h>

@class DDGiftListModel, PropsCellView, UIImageView;

@interface GiftCell : UICollectionViewCell
{
    _Bool _isSelected;
    UIImageView *_tickIocn;
    UIImageView *_continueTag;
    UIImageView *_toyTag;
    DDGiftListModel *_giftModel;
    PropsCellView *_propsCellView;
}

@property(retain, nonatomic) PropsCellView *propsCellView; // @synthesize propsCellView=_propsCellView;
@property(retain, nonatomic) DDGiftListModel *giftModel; // @synthesize giftModel=_giftModel;
@property(retain, nonatomic) UIImageView *toyTag; // @synthesize toyTag=_toyTag;
@property(retain, nonatomic) UIImageView *continueTag; // @synthesize continueTag=_continueTag;
@property(retain, nonatomic) UIImageView *tickIocn; // @synthesize tickIocn=_tickIocn;
@property(nonatomic) _Bool isSelected; // @synthesize isSelected=_isSelected;
- (void).cxx_destruct;
- (id)initWithFrame:(struct CGRect)arg1;

@end

