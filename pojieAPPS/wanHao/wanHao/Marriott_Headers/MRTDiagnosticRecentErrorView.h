//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class NSError, UILabel;

@interface MRTDiagnosticRecentErrorView : UIView
{
    NSError *_error;
    UILabel *_domainLabel;
    UILabel *_codeLabel;
    UILabel *_descriptionLabel;
}

@property(retain, nonatomic) UILabel *descriptionLabel; // @synthesize descriptionLabel=_descriptionLabel;
@property(retain, nonatomic) UILabel *codeLabel; // @synthesize codeLabel=_codeLabel;
@property(retain, nonatomic) UILabel *domainLabel; // @synthesize domainLabel=_domainLabel;
@property(retain, nonatomic) NSError *error; // @synthesize error=_error;
- (void).cxx_destruct;

@end
