//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableViewCell.h>

@class UIButton, UIImageView, UILabel;

@interface YBBToolsChildbirthBagAddCell : UITableViewCell
{
    UILabel *_nameLable;
    UIImageView *_typeImageView;
    UILabel *_numLable;
    UILabel *_describeLable;
    UIButton *_addButton;
    UILabel *_addLabel;
}

@property(nonatomic) __weak UILabel *addLabel; // @synthesize addLabel=_addLabel;
@property(nonatomic) __weak UIButton *addButton; // @synthesize addButton=_addButton;
@property(nonatomic) __weak UILabel *describeLable; // @synthesize describeLable=_describeLable;
@property(nonatomic) __weak UILabel *numLable; // @synthesize numLable=_numLable;
@property(nonatomic) __weak UIImageView *typeImageView; // @synthesize typeImageView=_typeImageView;
@property(nonatomic) __weak UILabel *nameLable; // @synthesize nameLable=_nameLable;
- (void).cxx_destruct;
- (void)setCellWithModel:(id)arg1;
- (void)setSelected:(_Bool)arg1 animated:(_Bool)arg2;
- (void)awakeFromNib;

@end

