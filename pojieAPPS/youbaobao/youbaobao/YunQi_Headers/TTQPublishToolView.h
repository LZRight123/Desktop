//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class NSArray;

@interface TTQPublishToolView : UIView
{
    long long _publishToolState;
    NSArray *_items;
    UIView *_topLineView;
    NSArray *_itemBtns;
}

+ (id)publishToolView;
@property(retain, nonatomic) NSArray *itemBtns; // @synthesize itemBtns=_itemBtns;
@property(retain, nonatomic) UIView *topLineView; // @synthesize topLineView=_topLineView;
@property(retain, nonatomic) NSArray *items; // @synthesize items=_items;
@property(nonatomic) long long publishToolState; // @synthesize publishToolState=_publishToolState;
- (void).cxx_destruct;
- (void)setEmotionBtnStatus:(_Bool)arg1;
- (void)updateViewForPackUP;
- (void)updateViewForVote;
- (void)updateViewForNormalWithOnlyImage;
- (void)updateViewForNormal;
- (void)setupAllBtnForTextAndImage;
- (void)setupAllBtnForOnlyImage;
- (void)setupView;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithCoder:(id)arg1;
- (id)init;

@end

