//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class UIButton, UILabel, UIView, UIWindow;

@interface IMYStatus : NSObject
{
    _Bool isIphoneX;
    float kMarqueeWidth;
    _Bool _bfirstButton;
    CDUnknownBlockType _tapBlock;
    UIWindow *_statusWindow;
    UIView *_backgroundView;
    UIButton *_firstButton;
    UIButton *_secondButton;
    UILabel *_marqueeLabel1;
    UILabel *_marqueeLabel2;
}

+ (void)tempHide:(_Bool)arg1;
+ (void)dismiss;
+ (void)showMessage:(id)arg1 whenTap:(CDUnknownBlockType)arg2;
+ (void)showMessage:(id)arg1 hideAfterDelay:(double)arg2 whenTap:(CDUnknownBlockType)arg3;
+ (void)showMessage:(id)arg1 hideAfterDelay:(double)arg2;
+ (void)showMessage:(id)arg1;
+ (id)sharedIMYStatus;
@property(retain, nonatomic) UILabel *marqueeLabel2; // @synthesize marqueeLabel2=_marqueeLabel2;
@property(retain, nonatomic) UILabel *marqueeLabel1; // @synthesize marqueeLabel1=_marqueeLabel1;
@property(nonatomic) _Bool bfirstButton; // @synthesize bfirstButton=_bfirstButton;
@property(retain, nonatomic) UIButton *secondButton; // @synthesize secondButton=_secondButton;
@property(retain, nonatomic) UIButton *firstButton; // @synthesize firstButton=_firstButton;
@property(retain, nonatomic) UIView *backgroundView; // @synthesize backgroundView=_backgroundView;
@property(retain, nonatomic) UIWindow *statusWindow; // @synthesize statusWindow=_statusWindow;
@property(copy, nonatomic) CDUnknownBlockType tapBlock; // @synthesize tapBlock=_tapBlock;
- (void).cxx_destruct;
- (void)tempHide:(_Bool)arg1;
- (void)hide;
- (_Bool)allowShow;
- (void)showMessage:(id)arg1 hideAfterDelay:(double)arg2 whenTap:(CDUnknownBlockType)arg3;
- (void)showMessage:(id)arg1 hideAfterDelay:(double)arg2;
- (void)tap:(id)arg1;
- (void)setup;

@end

