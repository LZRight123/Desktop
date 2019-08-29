//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYNewsTableViewController.h"

#import "IMYDynamicListCellDelegate-Protocol.h"

@class NSString;
@protocol IMYDynamicViewDelegate;

@interface IMYDynamicViewController : IMYNewsTableViewController <IMYDynamicListCellDelegate>
{
    _Bool _is_mp_vip;
    _Bool _is_user_type;
    unsigned long long _userId;
    id <IMYDynamicViewDelegate> _delegete;
    long long _user_type;
}

@property(nonatomic) _Bool is_user_type; // @synthesize is_user_type=_is_user_type;
@property(nonatomic) _Bool is_mp_vip; // @synthesize is_mp_vip=_is_mp_vip;
@property(nonatomic) long long user_type; // @synthesize user_type=_user_type;
@property(nonatomic) __weak id <IMYDynamicViewDelegate> delegete; // @synthesize delegete=_delegete;
@property(nonatomic) unsigned long long userId; // @synthesize userId=_userId;
- (void).cxx_destruct;
- (void)biEventWithActionType:(long long)arg1 model:(id)arg2;
- (void)gaDynamicForNews:(id)arg1 floor:(long long)arg2 type:(long long)arg3;
- (void)reportAction:(id)arg1;
- (void)collectDynamicAction:(id)arg1;
- (void)deleteDynamicAtIndexPath:(id)arg1;
- (void)praiseRequestAction:(id)arg1 block:(CDUnknownBlockType)arg2;
- (void)loadLocalDynamic:(id)arg1;
- (void)requestDataAction:(id)arg1;
- (_Bool)isMyDynamic;
- (void)didSelectAction:(id)arg1 comment:(_Bool)arg2;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (void)scrollViewDidScroll:(id)arg1;
- (void)IMYDynamicListDidClickComment:(id)arg1;
- (void)IMYDynamicListDidClickIcon:(id)arg1;
- (void)IMYDynamicListDidClickMore:(id)arg1;
- (void)IMYDynamicListDidClickShareInfoView:(id)arg1;
- (void)IMYDynamicListDidClickPraise:(id)arg1 btn:(id)arg2;
- (void)removeDataSource:(id)arg1;
- (void)addHeaderRefresh;
- (void)refreshAction;
- (id)cellModel:(id)arg1;
- (id)modelForCell:(id)arg1;
- (_Bool)isMe;
- (void)autoLoadMoreAction;
- (void)prepareData;
- (void)prepareUI;
- (void)setVipShow:(_Bool)arg1 userTypeShow:(_Bool)arg2;
- (void)didReceiveMemoryWarning;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
