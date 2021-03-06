//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class IMYEBSelectButton, UIButton;

@interface IMYEBSearchResultsTopSelectBar : UIView
{
    _Bool _switchOn;
    long long _style_type;
    IMYEBSelectButton *_defaultBtn;
    IMYEBSelectButton *_couponBtn;
    IMYEBSelectButton *_salesBtn;
    UIButton *_switchBtn;
    unsigned long long _selectedType;
    CDUnknownBlockType _didSelectType;
}

@property(copy, nonatomic) CDUnknownBlockType didSelectType; // @synthesize didSelectType=_didSelectType;
@property(nonatomic) unsigned long long selectedType; // @synthesize selectedType=_selectedType;
@property(retain, nonatomic) UIButton *switchBtn; // @synthesize switchBtn=_switchBtn;
@property(retain, nonatomic) IMYEBSelectButton *salesBtn; // @synthesize salesBtn=_salesBtn;
@property(retain, nonatomic) IMYEBSelectButton *couponBtn; // @synthesize couponBtn=_couponBtn;
@property(retain, nonatomic) IMYEBSelectButton *defaultBtn; // @synthesize defaultBtn=_defaultBtn;
@property(nonatomic) long long style_type; // @synthesize style_type=_style_type;
@property(nonatomic) _Bool switchOn; // @synthesize switchOn=_switchOn;
- (void).cxx_destruct;
- (void)layoutSubviews;
- (void)reloadFilterView;
- (void)touchSwitch;
- (id)initWithFrame:(struct CGRect)arg1;

@end

