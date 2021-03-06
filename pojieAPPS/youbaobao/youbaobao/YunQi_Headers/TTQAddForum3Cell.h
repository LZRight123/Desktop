//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "TTQTableViewCell.h"

#import "IMY_ThemeChangeProtocol-Protocol.h"

@class NSString, UIImageView, UILabel;

@interface TTQAddForum3Cell : TTQTableViewCell <IMY_ThemeChangeProtocol>
{
    UIImageView *_circleImageView;
    UILabel *_recommendLable;
    UILabel *_moreLable;
    UIImageView *_rightarrowImageView;
}

@property(nonatomic) __weak UIImageView *rightarrowImageView; // @synthesize rightarrowImageView=_rightarrowImageView;
@property(nonatomic) __weak UILabel *moreLable; // @synthesize moreLable=_moreLable;
@property(nonatomic) __weak UILabel *recommendLable; // @synthesize recommendLable=_recommendLable;
@property(nonatomic) __weak UIImageView *circleImageView; // @synthesize circleImageView=_circleImageView;
- (void).cxx_destruct;
- (double)bindModel:(id)arg1 heightForRowAtIndexPath:(id)arg2 viewModel:(id)arg3;
- (id)bindModel:(id)arg1 cellForRowAtIndexPath:(id)arg2 viewModel:(id)arg3;
- (void)imy_themeChanged;
- (void)commonInit;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

