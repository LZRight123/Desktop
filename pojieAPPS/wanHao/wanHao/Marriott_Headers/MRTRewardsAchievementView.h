//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class MRTGradientView, MRTStyledLabel, NSString, UIStackView, _TtC8Marriott30RewardsAchievementConfettiView;

@interface MRTRewardsAchievementView : UIView
{
    // Error parsing type: , name: gradientView
    // Error parsing type: , name: stackView
    // Error parsing type: , name: titleLabel
    // Error parsing type: , name: subtitleLabel
    // Error parsing type: , name: confettiView
    // Error parsing type: , name: labelsFadeInDuration
    // Error parsing type: , name: labelsFadeOutDuration
    // Error parsing type: , name: confettiAnimationDuration
    // Error parsing type: , name: confettiFadeOutDuration
    // Error parsing type: , name: selfFadeInDuration
    // Error parsing type: , name: selfFadeOutDuration
    // Error parsing type: , name: animationCompletion
}

- (CDUnknownBlockType).cxx_destruct;
- (id)initWithCoder:(id)arg1;
- (id)initWithFrame:(struct CGRect)arg1;
@property(nonatomic) _Bool isAccessibilityElement;
@property(nonatomic, copy) NSString *accessibilityLabel;
- (void)startAnimation;
- (void)configureForConsumer:(id)arg1;
- (void)awakeFromNib;
@property(nonatomic, copy) CDUnknownBlockType animationCompletion; // @synthesize animationCompletion;
@property(nonatomic) __weak _TtC8Marriott30RewardsAchievementConfettiView *confettiView; // @synthesize confettiView;
@property(nonatomic) __weak MRTStyledLabel *subtitleLabel; // @synthesize subtitleLabel;
@property(nonatomic) __weak MRTStyledLabel *titleLabel; // @synthesize titleLabel;
@property(nonatomic) __weak UIStackView *stackView; // @synthesize stackView;
@property(nonatomic) __weak MRTGradientView *gradientView; // @synthesize gradientView;

@end

