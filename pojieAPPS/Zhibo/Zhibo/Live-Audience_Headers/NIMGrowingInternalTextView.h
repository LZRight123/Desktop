//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITextView.h>

@class NSAttributedString;

@interface NIMGrowingInternalTextView : UITextView
{
    _Bool _displayPlaceholder;
    NSAttributedString *_placeholderAttributedText;
}

@property(nonatomic) _Bool displayPlaceholder; // @synthesize displayPlaceholder=_displayPlaceholder;
@property(retain, nonatomic) NSAttributedString *placeholderAttributedText; // @synthesize placeholderAttributedText=_placeholderAttributedText;
- (void).cxx_destruct;
- (void)drawRect:(struct CGRect)arg1;
- (void)textDidChangeNotification:(id)arg1;
- (void)updatePlaceholder;
- (void)layoutSubviews;
- (_Bool)canPerformAction:(SEL)arg1 withSender:(id)arg2;
- (void)setText:(id)arg1;
- (void)dealloc;
- (id)initWithFrame:(struct CGRect)arg1 textContainer:(id)arg2;

@end

