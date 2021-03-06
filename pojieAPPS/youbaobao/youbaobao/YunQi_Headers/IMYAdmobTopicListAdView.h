//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYBaseAdView.h"

@class IMYADCloseView, IMYCapsuleButton, UIImageView, UILabel;

@interface IMYAdmobTopicListAdView : IMYBaseAdView
{
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    UILabel *_userIconLabel;
    UIImageView *_imageView;
    IMYADCloseView *_closeButton;
    UILabel *_subtitleLabel;
    IMYCapsuleButton *_downloadButton;
}

+ (double)heightWithModel:(id)arg1;
@property(retain, nonatomic) IMYCapsuleButton *downloadButton; // @synthesize downloadButton=_downloadButton;
@property(retain, nonatomic) UILabel *subtitleLabel; // @synthesize subtitleLabel=_subtitleLabel;
@property(retain, nonatomic) IMYADCloseView *closeButton; // @synthesize closeButton=_closeButton;
@property(retain, nonatomic) UIImageView *imageView; // @synthesize imageView=_imageView;
@property(retain, nonatomic) UILabel *userIconLabel; // @synthesize userIconLabel=_userIconLabel;
@property(retain, nonatomic) UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
@property(retain, nonatomic) UILabel *nameLabel; // @synthesize nameLabel=_nameLabel;
- (void).cxx_destruct;
- (id)imageViews;
- (id)closeView;
- (id)actionView;
- (void)setupContentSubviews:(long long)arg1;
- (void)setupDownloadSubviews;
- (void)layoutWithModel:(id)arg1;
- (void)setupSubviews;

@end

