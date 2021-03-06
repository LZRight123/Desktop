//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYVKWebViewController.h"

@class NSString, UIImageView;

@interface IMYNewsADVC : IMYVKWebViewController
{
    _Bool _entered;
    _Bool _preload;
    NSString *_imageURL;
    CDUnknownBlockType _closeBlock;
    UIImageView *_adImageView;
}

@property(retain, nonatomic) UIImageView *adImageView; // @synthesize adImageView=_adImageView;
@property(copy, nonatomic) CDUnknownBlockType closeBlock; // @synthesize closeBlock=_closeBlock;
@property _Bool preload; // @synthesize preload=_preload;
@property _Bool entered; // @synthesize entered=_entered;
@property(copy, nonatomic) NSString *imageURL; // @synthesize imageURL=_imageURL;
- (void).cxx_destruct;
- (_Bool)webView:(id)arg1 shouldStartLoadWithRequest:(id)arg2 navigationType:(long long)arg3;
- (void)reset;
- (void)close;
- (void)enter;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)didReceiveMemoryWarning;
- (void)viewDidLoad;

@end

