//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class FLAnimatedImageView, UILabel;

@interface YBBOldHomeSignButton : UIView
{
    int _status;
    UILabel *_titleLabel;
    FLAnimatedImageView *_imageView;
}

@property(retain, nonatomic) FLAnimatedImageView *imageView; // @synthesize imageView=_imageView;
@property(retain, nonatomic) UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
@property(nonatomic) int status; // @synthesize status=_status;
- (void).cxx_destruct;
- (void)refresh;
- (void)languageChange;
- (void)applyTheme;
- (void)bt_pressed:(id)arg1;
- (id)init;

@end
