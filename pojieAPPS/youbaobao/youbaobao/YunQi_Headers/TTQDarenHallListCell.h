//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UITableViewCell.h>

#import "ReactiveTableViewCell-Protocol.h"

@class NSString, TTQCheckInButton, UIImageView, UILabel, UIView;

@interface TTQDarenHallListCell : UITableViewCell <ReactiveTableViewCell>
{
    UILabel *_nicknameLable;
    UILabel *_headCall;
    UILabel *_contributionLabel;
    UIImageView *_rankChangeIV;
    UIView *_honorHeaderView;
    UIView *_infoVIew;
    UIView *_auto_116_view;
    UILabel *_l_huati;
    UILabel *_l_qiandao;
    UILabel *_l_jinghua;
    UILabel *_l_tuijian;
    TTQCheckInButton *_bt_focus;
    UIImageView *_iv_arrow;
}

@property(retain, nonatomic) UIImageView *iv_arrow; // @synthesize iv_arrow=_iv_arrow;
@property(retain, nonatomic) TTQCheckInButton *bt_focus; // @synthesize bt_focus=_bt_focus;
@property(retain, nonatomic) UILabel *l_tuijian; // @synthesize l_tuijian=_l_tuijian;
@property(retain, nonatomic) UILabel *l_jinghua; // @synthesize l_jinghua=_l_jinghua;
@property(retain, nonatomic) UILabel *l_qiandao; // @synthesize l_qiandao=_l_qiandao;
@property(retain, nonatomic) UILabel *l_huati; // @synthesize l_huati=_l_huati;
@property(nonatomic) __weak UIView *auto_116_view; // @synthesize auto_116_view=_auto_116_view;
@property(nonatomic) __weak UIView *infoVIew; // @synthesize infoVIew=_infoVIew;
@property(nonatomic) __weak UIView *honorHeaderView; // @synthesize honorHeaderView=_honorHeaderView;
@property(retain, nonatomic) UIImageView *rankChangeIV; // @synthesize rankChangeIV=_rankChangeIV;
@property(retain, nonatomic) UILabel *contributionLabel; // @synthesize contributionLabel=_contributionLabel;
@property(retain, nonatomic) UILabel *headCall; // @synthesize headCall=_headCall;
@property(retain, nonatomic) UILabel *nicknameLable; // @synthesize nicknameLable=_nicknameLable;
- (void).cxx_destruct;
- (double)bindModel:(id)arg1 heightForRowAtIndexPath:(id)arg2 viewModel:(id)arg3;
- (id)bindModel:(id)arg1 cellForRowAtIndexPath:(id)arg2 viewModel:(id)arg3;
- (void)awakeFromNib;
- (void)updateUIWithType:(long long)arg1;
- (void)setCellValues:(id)arg1 withType:(long long)arg2;
- (void)setCellValues:(id)arg1;
- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

