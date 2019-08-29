//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYPublicBaseViewController.h"

#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"

@class NSArray, NSString, UIButton, UIImageView, UITableView, UIView;

@interface IMYSymptomsRecordsViewController : IMYPublicBaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    _Bool _baby;
    UIView *_navHeader;
    UIButton *_btn_left;
    UIButton *_bt_right;
    UIButton *_bt_center;
    UIImageView *_lineTab;
    UITableView *_tableView;
    UIView *_viewForHeaderInSection;
    NSArray *_allDaysData;
    NSArray *_halfYearData;
    NSArray *_allData;
    NSArray *_currentData;
}

+ (id)showDateFormatter;
@property(retain, nonatomic) NSArray *currentData; // @synthesize currentData=_currentData;
@property(retain, nonatomic) NSArray *allData; // @synthesize allData=_allData;
@property(retain, nonatomic) NSArray *halfYearData; // @synthesize halfYearData=_halfYearData;
@property(retain, nonatomic) NSArray *allDaysData; // @synthesize allDaysData=_allDaysData;
@property(retain, nonatomic) UIView *viewForHeaderInSection; // @synthesize viewForHeaderInSection=_viewForHeaderInSection;
@property(retain, nonatomic) UITableView *tableView; // @synthesize tableView=_tableView;
@property(retain, nonatomic) UIImageView *lineTab; // @synthesize lineTab=_lineTab;
@property(retain, nonatomic) UIButton *bt_center; // @synthesize bt_center=_bt_center;
@property(retain, nonatomic) UIButton *bt_right; // @synthesize bt_right=_bt_right;
@property(retain, nonatomic) UIButton *btn_left; // @synthesize btn_left=_btn_left;
@property(retain, nonatomic) UIView *navHeader; // @synthesize navHeader=_navHeader;
@property(nonatomic) _Bool baby; // @synthesize baby=_baby;
- (void).cxx_destruct;
- (void)touchAction:(id)arg1;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2;
- (id)sectionlabel;
- (id)babysRecords;
- (void)loadMoreData:(id)arg1;
- (id)firstLoadAllDayData;
- (void)didReceiveMemoryWarning;
- (void)viewDidLoad;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
