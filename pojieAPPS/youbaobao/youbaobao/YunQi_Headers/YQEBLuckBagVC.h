//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYEBGoodPregnancyVC.h"

#import "UIScrollViewDelegate-Protocol.h"

@class NSString, SYBagHeaderView, UIView, YQEBLuckySelectView;

@interface YQEBLuckBagVC : IMYEBGoodPregnancyVC <UIScrollViewDelegate>
{
    long long _addYoubi;
    UIView *_headerViewTable;
    SYBagHeaderView *_headerView;
    YQEBLuckySelectView *_selectView;
}

@property(retain, nonatomic) YQEBLuckySelectView *selectView; // @synthesize selectView=_selectView;
@property(retain, nonatomic) SYBagHeaderView *headerView; // @synthesize headerView=_headerView;
@property(retain, nonatomic) UIView *headerViewTable; // @synthesize headerViewTable=_headerViewTable;
@property(nonatomic) long long addYoubi; // @synthesize addYoubi=_addYoubi;
- (void).cxx_destruct;
- (void)animateAddGoodPregnancyView;
- (void)initAllView;
- (void)didReceiveMemoryWarning;
- (void)viewDidLoad;
- (void)viewWillAppear:(_Bool)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

