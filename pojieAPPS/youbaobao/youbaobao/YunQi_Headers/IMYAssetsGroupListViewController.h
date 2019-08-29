//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYPublicBaseViewController.h"

#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"

@class IMYCaptionView, NSMutableArray, NSString, UITableView;

@interface IMYAssetsGroupListViewController : IMYPublicBaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    unsigned long long _styleType;
    CDUnknownBlockType _selectedAssetsGroupBlock;
    NSMutableArray *_assetsGroupArray;
    IMYCaptionView *_captionView;
    UITableView *_tableView;
}

@property(retain, nonatomic) UITableView *tableView; // @synthesize tableView=_tableView;
@property(retain, nonatomic) IMYCaptionView *captionView; // @synthesize captionView=_captionView;
@property(retain, nonatomic) NSMutableArray *assetsGroupArray; // @synthesize assetsGroupArray=_assetsGroupArray;
@property(copy, nonatomic) CDUnknownBlockType selectedAssetsGroupBlock; // @synthesize selectedAssetsGroupBlock=_selectedAssetsGroupBlock;
@property(nonatomic) unsigned long long styleType; // @synthesize styleType=_styleType;
- (void).cxx_destruct;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (void)setupUI;
- (void)viewDidLoad;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
