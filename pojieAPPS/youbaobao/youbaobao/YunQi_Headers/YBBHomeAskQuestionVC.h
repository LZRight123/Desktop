//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYPublicBaseViewController.h"

#import "IMYVKWebViewDelegate-Protocol.h"
#import "UITextFieldDelegate-Protocol.h"

@class IMYVKWebView, IMYVKWebViewController, NJKWebViewProgressView, NSString, YBBHomeKnowledgePageNavView;

@interface YBBHomeAskQuestionVC : IMYPublicBaseViewController <UITextFieldDelegate, IMYVKWebViewDelegate>
{
    NSString *_urlString;
    YBBHomeKnowledgePageNavView *_searchView;
    IMYVKWebView *_webView;
    NJKWebViewProgressView *_progressView;
    double _showProgressValue;
    IMYVKWebViewController *_webVC;
}

+ (id)webWithURLString:(id)arg1;
@property(retain, nonatomic) IMYVKWebViewController *webVC; // @synthesize webVC=_webVC;
@property(nonatomic) double showProgressValue; // @synthesize showProgressValue=_showProgressValue;
@property(retain, nonatomic) NJKWebViewProgressView *progressView; // @synthesize progressView=_progressView;
@property(retain, nonatomic) IMYVKWebView *webView; // @synthesize webView=_webView;
@property(retain, nonatomic) YBBHomeKnowledgePageNavView *searchView; // @synthesize searchView=_searchView;
@property(readonly, nonatomic) NSString *urlString; // @synthesize urlString=_urlString;
- (void).cxx_destruct;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewWillLayoutSubviews;
- (void)viewDidLoad;
- (_Bool)isNavigationBarHidden;
- (id)initWithUrlString:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

