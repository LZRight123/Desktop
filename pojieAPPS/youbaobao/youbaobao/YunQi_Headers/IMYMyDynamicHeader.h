//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class CAGradientLayer, IMYAvatarImageView, UIImageView;

@interface IMYMyDynamicHeader : UIView
{
    CDUnknownBlockType _clickBannerBlock;
    CDUnknownBlockType _clickIconBlock;
    UIImageView *_bannerImageView;
    IMYAvatarImageView *_iconImageView;
    UIImageView *_userTageImageView;
    CAGradientLayer *_gradientLayer;
    CAGradientLayer *_gradientBottomLayer;
}

@property(retain, nonatomic) CAGradientLayer *gradientBottomLayer; // @synthesize gradientBottomLayer=_gradientBottomLayer;
@property(retain, nonatomic) CAGradientLayer *gradientLayer; // @synthesize gradientLayer=_gradientLayer;
@property(retain, nonatomic) UIImageView *userTageImageView; // @synthesize userTageImageView=_userTageImageView;
@property(retain, nonatomic) IMYAvatarImageView *iconImageView; // @synthesize iconImageView=_iconImageView;
@property(retain, nonatomic) UIImageView *bannerImageView; // @synthesize bannerImageView=_bannerImageView;
@property(copy, nonatomic) CDUnknownBlockType clickIconBlock; // @synthesize clickIconBlock=_clickIconBlock;
@property(copy, nonatomic) CDUnknownBlockType clickBannerBlock; // @synthesize clickBannerBlock=_clickBannerBlock;
- (void).cxx_destruct;
- (void)setBanner:(id)arg1;
- (void)prepareUI;
- (id)initWithFrame:(struct CGRect)arg1;

@end

