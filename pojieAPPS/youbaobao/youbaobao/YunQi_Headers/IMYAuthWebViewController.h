//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIViewController.h>

#import "UIWebViewDelegate-Protocol.h"

@class MBProgressHUD, NSString, UIView, UIWebView;
@protocol IMYIAuthOptions;

@interface IMYAuthWebViewController : UIViewController <UIWebViewDelegate>
{
    long long _shareType;
    NSString *_appKey;
    NSString *_appSecret;
    NSString *_redirectURI;
    id <IMYIAuthOptions> _authOptions;
    CDUnknownBlockType _completion;
    UIWebView *_webView;
    MBProgressHUD *_hud;
    UIView *_captionView;
}

+ (id)errorWithCode:(long long)arg1 description:(id)arg2;
+ (id)URLEncodedString:(id)arg1;
+ (id)stringFromDictionary:(id)arg1;
+ (id)serializeURL:(id)arg1 params:(id)arg2 httpMethod:(id)arg3;
+ (id)parseCodeFromURLString:(id)arg1;
@property(retain, nonatomic) UIView *captionView; // @synthesize captionView=_captionView;
@property(retain, nonatomic) MBProgressHUD *hud; // @synthesize hud=_hud;
@property(retain, nonatomic) UIWebView *webView; // @synthesize webView=_webView;
@property(copy, nonatomic) CDUnknownBlockType completion; // @synthesize completion=_completion;
@property(retain, nonatomic) id <IMYIAuthOptions> authOptions; // @synthesize authOptions=_authOptions;
@property(retain, nonatomic) NSString *redirectURI; // @synthesize redirectURI=_redirectURI;
@property(retain, nonatomic) NSString *appSecret; // @synthesize appSecret=_appSecret;
@property(retain, nonatomic) NSString *appKey; // @synthesize appKey=_appKey;
@property(nonatomic) long long shareType; // @synthesize shareType=_shareType;
- (void).cxx_destruct;
- (void)webView:(id)arg1 didFailLoadWithError:(id)arg2;
- (void)webViewDidFinishLoad:(id)arg1;
- (void)webViewDidStartLoad:(id)arg1;
- (_Bool)webView:(id)arg1 shouldStartLoadWithRequest:(id)arg2 navigationType:(long long)arg3;
- (void)hideLoadingView;
- (void)showLoadingViewWithText:(id)arg1;
- (void)handleGotWeiboAuthorizeCode:(id)arg1;
- (void)loadRequest;
- (void)viewDidAppear:(_Bool)arg1;
- (void)cancelAction;
- (void)didReceiveMemoryWarning;
- (void)viewDidLoad;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

