//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "HLVBaseView.h"

@class YBBToolsACUnlockView;

@interface YBBToolsBaseMaskView : HLVBaseView
{
    YBBToolsACUnlockView *_unlockView;
}

@property(retain, nonatomic) YBBToolsACUnlockView *unlockView; // @synthesize unlockView=_unlockView;
- (void).cxx_destruct;
- (id)layerAnimationOpacityKey;
- (void)stopAnimation;
- (void)startAnimation;
- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2;
- (void)touchesEnded:(id)arg1 withEvent:(id)arg2;
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2;
- (void)hideUnlockView;
- (void)performHideUnlockViewAction;

@end

