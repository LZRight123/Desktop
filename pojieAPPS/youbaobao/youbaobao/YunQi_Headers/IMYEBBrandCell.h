//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableViewCell.h>

@class IMYCapsuleButton, IMYEBBrandDetailModel, NSLayoutConstraint, UIImageView, UILabel;

@interface IMYEBBrandCell : UITableViewCell
{
    UILabel *_discountLabel;
    UILabel *_titleLabel;
    UILabel *_rightTitleLabel;
    UIImageView *_firstImageView;
    UIImageView *_secondImageView;
    UIImageView *_thirdImageView;
    IMYCapsuleButton *_firstButton;
    IMYCapsuleButton *_secondButton;
    IMYCapsuleButton *_thirdButton;
    NSLayoutConstraint *_titleLeftLayoutConstraint;
    IMYEBBrandDetailModel *_displayModel;
}

+ (double)cellHeight;
@property(retain, nonatomic) IMYEBBrandDetailModel *displayModel; // @synthesize displayModel=_displayModel;
@property(nonatomic) __weak NSLayoutConstraint *titleLeftLayoutConstraint; // @synthesize titleLeftLayoutConstraint=_titleLeftLayoutConstraint;
@property(nonatomic) __weak IMYCapsuleButton *thirdButton; // @synthesize thirdButton=_thirdButton;
@property(nonatomic) __weak IMYCapsuleButton *secondButton; // @synthesize secondButton=_secondButton;
@property(nonatomic) __weak IMYCapsuleButton *firstButton; // @synthesize firstButton=_firstButton;
@property(nonatomic) __weak UIImageView *thirdImageView; // @synthesize thirdImageView=_thirdImageView;
@property(nonatomic) __weak UIImageView *secondImageView; // @synthesize secondImageView=_secondImageView;
@property(nonatomic) __weak UIImageView *firstImageView; // @synthesize firstImageView=_firstImageView;
@property(nonatomic) __weak UILabel *rightTitleLabel; // @synthesize rightTitleLabel=_rightTitleLabel;
@property(nonatomic) __weak UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
@property(nonatomic) __weak UILabel *discountLabel; // @synthesize discountLabel=_discountLabel;
- (void).cxx_destruct;
- (void)layoutWithModel:(id)arg1;
- (void)setFrame:(struct CGRect)arg1;
- (void)awakeFromNib;

@end
