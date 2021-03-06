//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class UIImage, UIImageView;
@protocol IMYYunqiHomeTopAnimationViewProtocal;

@interface IMYYunqiHomeTopAnimationView : UIView
{
    UIImage *_image;
    id <IMYYunqiHomeTopAnimationViewProtocal> _delegate;
    UIImageView *_backgroundImage;
    UIImageView *_iconImage;
}

@property(retain, nonatomic) UIImageView *iconImage; // @synthesize iconImage=_iconImage;
@property(retain, nonatomic) UIImageView *backgroundImage; // @synthesize backgroundImage=_backgroundImage;
@property(nonatomic) __weak id <IMYYunqiHomeTopAnimationViewProtocal> delegate; // @synthesize delegate=_delegate;
@property(retain, nonatomic) UIImage *image; // @synthesize image=_image;
- (void).cxx_destruct;
- (void)setupUI;
- (void)tapAction:(id)arg1;
- (void)tapGestureRecognizer;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)init;

@end

