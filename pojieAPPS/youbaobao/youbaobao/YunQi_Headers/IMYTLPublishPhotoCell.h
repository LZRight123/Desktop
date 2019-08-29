//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UICollectionViewCell.h>

@class UIImageView, UILabel, UIView;

@interface IMYTLPublishPhotoCell : UICollectionViewCell
{
    UIImageView *_imageView;
    UILabel *_imageNumLabel;
    UIView *_moreView;
    UILabel *_addMoreLabel;
}

@property(nonatomic) __weak UILabel *addMoreLabel; // @synthesize addMoreLabel=_addMoreLabel;
@property(nonatomic) __weak UIView *moreView; // @synthesize moreView=_moreView;
@property(nonatomic) __weak UILabel *imageNumLabel; // @synthesize imageNumLabel=_imageNumLabel;
@property(retain, nonatomic) UIImageView *imageView; // @synthesize imageView=_imageView;
- (void).cxx_destruct;
- (id)getMoreAttString:(id)arg1 font:(id)arg2;
- (void)configPublishPhotoCell:(id)arg1 indexPath:(id)arg2;
- (id)createImageView;
- (void)configPublishAllPhotoListCell:(id)arg1 indexPath:(id)arg2;
- (void)layoutSubviews;
- (void)awakeFromNib;

@end
