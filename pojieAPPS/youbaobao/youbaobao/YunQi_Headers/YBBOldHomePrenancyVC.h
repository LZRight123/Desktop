//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "YBBOldHomeBaseVC.h"

#import "UIScrollViewDelegate-Protocol.h"
#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"
#import "YBBOldHomeCellActionPerformer-Protocol.h"

@class NSArray, NSDateFormatter, NSString, YBBHomeEducationCell, YBBOldHomeBabyModul, YBBOldHomePrenancyPageDataSource;

@interface YBBOldHomePrenancyVC : YBBOldHomeBaseVC <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, YBBOldHomeCellActionPerformer>
{
    NSArray *_dataList;
    YBBOldHomeBabyModul *_headerData;
    long long _todayIndex;
    long long _week;
    YBBOldHomePrenancyPageDataSource *_dataSource;
    long long _oldPageIndex;
    NSDateFormatter *_dateFormatter;
    NSArray *_weeksArray;
    YBBHomeEducationCell *_educationCell4_5;
}

+ (id)userInfoChangeNotificationName;
@property(retain, nonatomic) YBBHomeEducationCell *educationCell4_5; // @synthesize educationCell4_5=_educationCell4_5;
@property(retain, nonatomic) NSArray *weeksArray; // @synthesize weeksArray=_weeksArray;
@property(retain, nonatomic) NSDateFormatter *dateFormatter; // @synthesize dateFormatter=_dateFormatter;
@property(nonatomic) long long oldPageIndex; // @synthesize oldPageIndex=_oldPageIndex;
@property(retain, nonatomic) YBBOldHomePrenancyPageDataSource *dataSource; // @synthesize dataSource=_dataSource;
@property(nonatomic) long long week; // @synthesize week=_week;
@property(nonatomic) long long todayIndex; // @synthesize todayIndex=_todayIndex;
@property(retain, nonatomic) YBBOldHomeBabyModul *headerData; // @synthesize headerData=_headerData;
- (void)setDataList:(id)arg1;
- (id)dataList;
- (void).cxx_destruct;
- (void)backToToday;
- (void)updateNavButtonsAtIndex:(long long)arg1;
- (void)scrollToLeft:(_Bool)arg1;
- (void)checkNeedShowMasking;
- (void)check36week;
- (void)homeCell:(id)arg1 reloadTabelView:(_Bool)arg2 targetHandling:(id)arg3 info:(id)arg4;
- (double)tableView:(id)arg1 heightForFooterInSection:(long long)arg2;
- (id)tableView:(id)arg1 viewForFooterInSection:(long long)arg2;
- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2;
- (double)tableView:(id)arg1 heightForHeaderInSection:(long long)arg2;
- (void)tableView:(id)arg1 didEndDisplayingCell:(id)arg2 forRowAtIndexPath:(id)arg3;
- (void)prefetchContentDataWithModel:(id)arg1;
- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (void)_requestPageDataWithReload:(_Bool)arg1 pageIndex:(long long)arg2 source:(unsigned long long)arg3;
- (void)requestPageDataWithReload:(_Bool)arg1 pageIndex:(long long)arg2 source:(unsigned long long)arg3;
- (void)backTodayWithReload:(_Bool)arg1;
- (id)path;
- (void)requestData;
- (void)_scrollToTopAndReloadData;
- (void)scrollToTopAndReloadData;
- (_Bool)isToday;
- (long long)day;
- (void)startWave;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)addNotificationObsearves;
- (void)initMainView;
- (id)dateWithPageIndex:(long long)arg1;
- (void)dealloc;
- (void)viewDidLoad;
- (id)initWithDataSource:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

