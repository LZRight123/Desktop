//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableViewCell.h>

@class UIImageView, UILabel;

@interface IMYCityCell : UITableViewCell
{
    UILabel *_l_title;
    UIImageView *_iv_rightArrow;
    UILabel *_l_index;
}

@property(nonatomic) __weak UILabel *l_index; // @synthesize l_index=_l_index;
@property(nonatomic) __weak UIImageView *iv_rightArrow; // @synthesize iv_rightArrow=_iv_rightArrow;
@property(nonatomic) __weak UILabel *l_title; // @synthesize l_title=_l_title;
- (void).cxx_destruct;
- (void)awakeFromNib;
- (void)layoutSubviews;
- (void)showCellLineAtIndexPath:(id)arg1 rowCount:(unsigned long long)arg2;

@end

