//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableViewCell.h>

@class UIImageView, UILabel, UIView, YBBToolsAlbumSearchModel;

@interface YBBToolsAlbumSearchTableViewCell : UITableViewCell
{
    UIImageView *_iconImgView;
    UILabel *_nameLabel;
    UILabel *_typeLabel;
    UIImageView *_playImgView;
    UILabel *_numbLabel;
    UILabel *_albumLabel;
    UIView *_botLineView;
    YBBToolsAlbumSearchModel *_model;
}

@property(retain, nonatomic) YBBToolsAlbumSearchModel *model; // @synthesize model=_model;
@property(nonatomic) __weak UIView *botLineView; // @synthesize botLineView=_botLineView;
@property(nonatomic) __weak UILabel *albumLabel; // @synthesize albumLabel=_albumLabel;
@property(nonatomic) __weak UILabel *numbLabel; // @synthesize numbLabel=_numbLabel;
@property(nonatomic) __weak UIImageView *playImgView; // @synthesize playImgView=_playImgView;
@property(nonatomic) __weak UILabel *typeLabel; // @synthesize typeLabel=_typeLabel;
@property(nonatomic) __weak UILabel *nameLabel; // @synthesize nameLabel=_nameLabel;
@property(nonatomic) __weak UIImageView *iconImgView; // @synthesize iconImgView=_iconImgView;
- (void).cxx_destruct;
- (id)attrFromString:(id)arg1;
- (void)setSelected:(_Bool)arg1 animated:(_Bool)arg2;
- (void)awakeFromNib;

@end
