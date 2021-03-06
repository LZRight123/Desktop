//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYPublicBaseViewController.h"

#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"

@class IMYCaptionView, NSMutableArray, NSString, UITableView, YBBToolsHomeContaintMode;
@protocol IMYITableViewAdManager;

@interface YBBToolsHomeVC : IMYPublicBaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    unsigned long long _toolSource;
    unsigned long long _trackSource;
    UITableView *_tableview;
    IMYCaptionView *_caption;
    NSMutableArray *_data;
    id <IMYITableViewAdManager> _adManager;
    long long _currentModule;
    NSMutableArray *_recentlyUseTools;
    YBBToolsHomeContaintMode *_recentlyUseModel;
    NSString *_trackString;
}

@property(retain, nonatomic) NSString *trackString; // @synthesize trackString=_trackString;
@property(retain, nonatomic) YBBToolsHomeContaintMode *recentlyUseModel; // @synthesize recentlyUseModel=_recentlyUseModel;
@property(retain, nonatomic) NSMutableArray *recentlyUseTools; // @synthesize recentlyUseTools=_recentlyUseTools;
@property(nonatomic) long long currentModule; // @synthesize currentModule=_currentModule;
@property(retain, nonatomic) id <IMYITableViewAdManager> adManager; // @synthesize adManager=_adManager;
@property(retain, nonatomic) NSMutableArray *data; // @synthesize data=_data;
@property(retain, nonatomic) IMYCaptionView *caption; // @synthesize caption=_caption;
@property(retain, nonatomic) UITableView *tableview; // @synthesize tableview=_tableview;
@property(nonatomic) unsigned long long trackSource; // @synthesize trackSource=_trackSource;
@property(nonatomic) unsigned long long toolSource; // @synthesize toolSource=_toolSource;
- (void).cxx_destruct;
- (void)uploadToolCount:(id)arg1;
- (void)trackForGA:(id)arg1;
- (void)scrollToTopAndReloadData;
- (id)getLocalRecentlyUseToolIds;
- (void)saveRecentUsedTolocalToolIds:(id)arg1;
- (id)createRecentModelWithArray:(id)arg1;
- (id)getRecentlyUsedToolsModels;
- (void)recentlyUseToolsChangeModeHandle;
- (_Bool)isToolsModelInArray:(id)arg1 array:(id)arg2;
- (void)updateRecentlyUsedTools:(id)arg1;
- (id)cacheKey;
- (void)checkModels:(id)arg1;
- (void)requestNewTools;
- (id)tableView:(id)arg1 viewForFooterInSection:(long long)arg2;
- (double)tableView:(id)arg1 heightForFooterInSection:(long long)arg2;
- (id)tableView:(id)arg1 viewForHeaderInSection:(long long)arg2;
- (double)tableView:(id)arg1 heightForHeaderInSection:(long long)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (void)initDatas;
- (void)exitEvent;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)requestAD;
- (void)viewDidLoad;
- (void)dealloc;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

