//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class IMYEBCountDownView, IMYEBSessionDetailModel, IMYRoundButton, NSLayoutConstraint, UIButton, UIImageView, UILabel;

@interface IMYEBSessionCell2_0 : UIView
{
    _Bool _soldOut;
    _Bool _selectedToEdit;
    _Bool _editing;
    _Bool _showSoldout;
    _Bool _isNewStyle;
    UIImageView *_goodImageView;
    UIImageView *_tagImageView;
    UILabel *_titleLabel;
    UILabel *_currentPriceLabel;
    UILabel *_originalPriceLabel;
    UILabel *_customTagLabel;
    UIView *_customTagBG;
    UIImageView *_tmall_icon;
    UIImageView *_taobao_icon;
    UIImageView *_discountImageView;
    IMYRoundButton *_rightTagButton;
    UIButton *_deleteButton;
    IMYEBCountDownView *_countDownView;
    UIImageView *_promotiontypeImage;
    UILabel *_promotiontypeLabel;
    UILabel *_subTitleLabel;
    CDUnknownBlockType _selectBlock;
    UIView *_tagView;
    UILabel *_priceTextLabel;
    NSLayoutConstraint *_titleLabelTopConstraint;
    IMYEBSessionDetailModel *_model;
    double _cellWidth;
    double _cellHeight;
    UIView *_backAdView;
}

+ (struct CGSize)cellSize;
@property(retain, nonatomic) UIView *backAdView; // @synthesize backAdView=_backAdView;
@property(nonatomic) double cellHeight; // @synthesize cellHeight=_cellHeight;
@property(nonatomic) double cellWidth; // @synthesize cellWidth=_cellWidth;
@property(retain, nonatomic) IMYEBSessionDetailModel *model; // @synthesize model=_model;
@property(nonatomic) NSLayoutConstraint *titleLabelTopConstraint; // @synthesize titleLabelTopConstraint=_titleLabelTopConstraint;
@property(retain, nonatomic) UILabel *priceTextLabel; // @synthesize priceTextLabel=_priceTextLabel;
@property(retain, nonatomic) UIView *tagView; // @synthesize tagView=_tagView;
@property(nonatomic) _Bool isNewStyle; // @synthesize isNewStyle=_isNewStyle;
@property(nonatomic) _Bool showSoldout; // @synthesize showSoldout=_showSoldout;
@property(copy, nonatomic) CDUnknownBlockType selectBlock; // @synthesize selectBlock=_selectBlock;
@property(nonatomic) _Bool editing; // @synthesize editing=_editing;
@property(nonatomic) _Bool selectedToEdit; // @synthesize selectedToEdit=_selectedToEdit;
@property(nonatomic) _Bool soldOut; // @synthesize soldOut=_soldOut;
@property(retain, nonatomic) UILabel *subTitleLabel; // @synthesize subTitleLabel=_subTitleLabel;
@property(retain, nonatomic) UILabel *promotiontypeLabel; // @synthesize promotiontypeLabel=_promotiontypeLabel;
@property(retain, nonatomic) UIImageView *promotiontypeImage; // @synthesize promotiontypeImage=_promotiontypeImage;
@property(retain, nonatomic) IMYEBCountDownView *countDownView; // @synthesize countDownView=_countDownView;
@property(retain, nonatomic) UIButton *deleteButton; // @synthesize deleteButton=_deleteButton;
@property(retain, nonatomic) IMYRoundButton *rightTagButton; // @synthesize rightTagButton=_rightTagButton;
@property(retain, nonatomic) UIImageView *discountImageView; // @synthesize discountImageView=_discountImageView;
@property(retain, nonatomic) UIImageView *taobao_icon; // @synthesize taobao_icon=_taobao_icon;
@property(retain, nonatomic) UIImageView *tmall_icon; // @synthesize tmall_icon=_tmall_icon;
@property(retain, nonatomic) UIView *customTagBG; // @synthesize customTagBG=_customTagBG;
@property(retain, nonatomic) UILabel *customTagLabel; // @synthesize customTagLabel=_customTagLabel;
@property(retain, nonatomic) UILabel *originalPriceLabel; // @synthesize originalPriceLabel=_originalPriceLabel;
@property(retain, nonatomic) UILabel *currentPriceLabel; // @synthesize currentPriceLabel=_currentPriceLabel;
@property(retain, nonatomic) UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
@property(retain, nonatomic) UIImageView *tagImageView; // @synthesize tagImageView=_tagImageView;
@property(retain, nonatomic) UIImageView *goodImageView; // @synthesize goodImageView=_goodImageView;
- (void).cxx_destruct;
- (void)setupBackAdViewWithImageStr:(id)arg1;
- (void)layoutWithChannelModel:(id)arg1;
- (void)setupUI;
- (id)initWithFrame:(struct CGRect)arg1;

@end
