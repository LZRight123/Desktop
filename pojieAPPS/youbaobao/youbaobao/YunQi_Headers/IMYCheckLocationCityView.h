//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class IMYButton, NSString, UILabel;

@interface IMYCheckLocationCityView : UIView
{
    NSString *_imylocationPosition;
    NSString *_imyOldPosition;
    CDUnknownBlockType _selectCityBlock;
    UIView *_backView;
    UILabel *_imyTitleLabel;
    IMYButton *_imyNewPositionButton;
    IMYButton *_imyOldPositionButton;
}

@property(retain, nonatomic) IMYButton *imyOldPositionButton; // @synthesize imyOldPositionButton=_imyOldPositionButton;
@property(retain, nonatomic) IMYButton *imyNewPositionButton; // @synthesize imyNewPositionButton=_imyNewPositionButton;
@property(retain, nonatomic) UILabel *imyTitleLabel; // @synthesize imyTitleLabel=_imyTitleLabel;
@property(retain, nonatomic) UIView *backView; // @synthesize backView=_backView;
@property(copy, nonatomic) CDUnknownBlockType selectCityBlock; // @synthesize selectCityBlock=_selectCityBlock;
@property(retain, nonatomic) NSString *imyOldPosition; // @synthesize imyOldPosition=_imyOldPosition;
@property(retain, nonatomic) NSString *imylocationPosition; // @synthesize imylocationPosition=_imylocationPosition;
- (void).cxx_destruct;
- (void)buttonAction:(id)arg1;
- (void)dismiss;
- (void)show;
- (void)prepareUI;
- (id)init;

@end

