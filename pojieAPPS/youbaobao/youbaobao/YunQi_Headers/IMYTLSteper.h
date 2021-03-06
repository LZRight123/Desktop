//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYTLView.h"

@class IMYButton, UILabel;

@interface IMYTLSteper : IMYTLView
{
    IMYButton *_leftBtn;
    IMYButton *_rightBtn;
    UILabel *_midLabel;
    long long _value;
    long long _maxValue;
    long long _minValue;
    unsigned long long _step;
    CDUnknownBlockType _valueChange;
}

+ (id)getSteper;
@property(copy, nonatomic) CDUnknownBlockType valueChange; // @synthesize valueChange=_valueChange;
@property(nonatomic) unsigned long long step; // @synthesize step=_step;
@property(nonatomic) long long minValue; // @synthesize minValue=_minValue;
@property(nonatomic) long long maxValue; // @synthesize maxValue=_maxValue;
@property(nonatomic) long long value; // @synthesize value=_value;
@property(retain, nonatomic) UILabel *midLabel; // @synthesize midLabel=_midLabel;
@property(retain, nonatomic) IMYButton *rightBtn; // @synthesize rightBtn=_rightBtn;
@property(retain, nonatomic) IMYButton *leftBtn; // @synthesize leftBtn=_leftBtn;
- (void).cxx_destruct;
- (void)plusAction:(id)arg1;
- (void)minusAction:(id)arg1;
- (void)setupSubviews;
- (id)initWithFrame:(struct CGRect)arg1;

@end

