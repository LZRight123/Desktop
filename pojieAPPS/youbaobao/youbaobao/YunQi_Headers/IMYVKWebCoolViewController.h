//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYVKWebViewController.h"

#import "UIScrollViewDelegate-Protocol.h"

@class NSString, UIButton, UIImageView, UILabel;

@interface IMYVKWebCoolViewController : IMYVKWebViewController <UIScrollViewDelegate>
{
    _Bool _navbarIsHide;
    UIImageView *_navBar;
    UILabel *_navBarTitle;
    UIButton *_navLeftButton;
    UIButton *_navRightButton;
    UIImageView *_navLeftButtonDot;
    UIImageView *_navRightButtonDot;
    id _webScrollViewDelegate;
}

@property(nonatomic) __weak id webScrollViewDelegate; // @synthesize webScrollViewDelegate=_webScrollViewDelegate;
@property(retain, nonatomic) UIImageView *navRightButtonDot; // @synthesize navRightButtonDot=_navRightButtonDot;
@property(retain, nonatomic) UIImageView *navLeftButtonDot; // @synthesize navLeftButtonDot=_navLeftButtonDot;
@property(retain, nonatomic) UIButton *navRightButton; // @synthesize navRightButton=_navRightButton;
@property(retain, nonatomic) UIButton *navLeftButton; // @synthesize navLeftButton=_navLeftButton;
@property(retain, nonatomic) UILabel *navBarTitle; // @synthesize navBarTitle=_navBarTitle;
@property(retain, nonatomic) UIImageView *navBar; // @synthesize navBar=_navBar;
@property(nonatomic) _Bool navbarIsHide; // @synthesize navbarIsHide=_navbarIsHide;
- (void).cxx_destruct;
- (void)scrollViewDidScroll:(id)arg1;
- (void)webView:(id)arg1 didFailLoadWithError:(id)arg2;
- (void)webViewDidFinishLoad:(id)arg1;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)setStatusBarStyle:(long long)arg1;
- (void)checkShouldHideBarViews;
- (void)viewDidLoad;
- (id)imy_getURIPath;
- (void)setShowShareButton:(_Bool)arg1;
- (_Bool)showShareButton;
- (void)imy_themeChanged;
- (void)setupNavigationBar;
- (void)loadView;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

