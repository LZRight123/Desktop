//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "TTQTableViewCell.h"

@class CAShapeLayer, UILabel, UIView;

@interface TTQPublishMovableInsertTipCell : TTQTableViewCell
{
    UILabel *_tipLabel;
    UIView *_bgView;
    CAShapeLayer *_borderLayer;
}

+ (double)movableH;
@property(retain, nonatomic) CAShapeLayer *borderLayer; // @synthesize borderLayer=_borderLayer;
@property(retain, nonatomic) UIView *bgView; // @synthesize bgView=_bgView;
@property(retain, nonatomic) UILabel *tipLabel; // @synthesize tipLabel=_tipLabel;
- (void).cxx_destruct;
- (void)setupTip:(id)arg1;
- (void)updateBorderLayer;
- (void)commonInit;

@end

