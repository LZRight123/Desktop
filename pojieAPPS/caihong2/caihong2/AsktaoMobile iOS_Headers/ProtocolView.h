//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "LTBaseView.h"

@class NSString, UIWebView;

@interface ProtocolView : LTBaseView
{
    NSString *_frontView;
    UIWebView *_web;
}

@property(retain, nonatomic) UIWebView *web; // @synthesize web=_web;
@property(copy, nonatomic) NSString *frontView; // @synthesize frontView=_frontView;
- (void).cxx_destruct;
- (id)initweb;
- (void)interfacePortrait;
- (void)createViews;
- (id)initWithFrame:(struct CGRect)arg1;

@end

