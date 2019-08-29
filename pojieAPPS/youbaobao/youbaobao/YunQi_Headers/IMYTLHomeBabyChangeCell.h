//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableViewCell.h>

@class IMYButton, IMYTLHomeBabyChangeVM, IMYTLHomeDateView, UIImageView, UILabel, UIView;

@interface IMYTLHomeBabyChangeCell : UITableViewCell
{
    IMYTLHomeDateView *_dateView;
    UIImageView *_dotView;
    UIView *_lineView;
    UIImageView *_quotesImgView;
    UILabel *_label;
    IMYButton *_moreBtn;
    CDUnknownBlockType _tapBlock;
    IMYTLHomeBabyChangeVM *_vm;
}

@property(retain, nonatomic) IMYTLHomeBabyChangeVM *vm; // @synthesize vm=_vm;
@property(copy, nonatomic) CDUnknownBlockType tapBlock; // @synthesize tapBlock=_tapBlock;
@property(retain, nonatomic) IMYButton *moreBtn; // @synthesize moreBtn=_moreBtn;
@property(retain, nonatomic) UILabel *label; // @synthesize label=_label;
@property(retain, nonatomic) UIImageView *quotesImgView; // @synthesize quotesImgView=_quotesImgView;
@property(retain, nonatomic) UIView *lineView; // @synthesize lineView=_lineView;
@property(retain, nonatomic) UIImageView *dotView; // @synthesize dotView=_dotView;
@property(retain, nonatomic) IMYTLHomeDateView *dateView; // @synthesize dateView=_dateView;
- (void).cxx_destruct;
- (void)setSelected:(_Bool)arg1 animated:(_Bool)arg2;
- (void)awakeFromNib;

@end
