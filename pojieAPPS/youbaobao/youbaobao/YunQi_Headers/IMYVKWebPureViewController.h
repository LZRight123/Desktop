//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYVKWebViewController.h"

@class IMYCaptionView, UIButton;

@interface IMYVKWebPureViewController : IMYVKWebViewController
{
    _Bool _simple;
    unsigned long long _orientation;
    IMYCaptionView *_pureLoadingView;
    UIButton *_backButton;
}

@property(retain, nonatomic) UIButton *backButton; // @synthesize backButton=_backButton;
@property(retain, nonatomic) IMYCaptionView *pureLoadingView; // @synthesize pureLoadingView=_pureLoadingView;
@property(nonatomic) _Bool simple; // @synthesize simple=_simple;
@property(nonatomic) unsigned long long orientation; // @synthesize orientation=_orientation;
- (void).cxx_destruct;
- (long long)preferredInterfaceOrientationForPresentation;
- (unsigned long long)supportedInterfaceOrientations;
- (_Bool)shouldAutorotate;
- (void)imy_topLeftButtonTouchupInside;
- (void)webView:(id)arg1 didFailLoadWithError:(id)arg2;
- (void)viewDidLoad;
- (void)setCaptionView:(id)arg1;

@end

