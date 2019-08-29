//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

#import "UITableViewDataSource-Protocol.h"
#import "UITableViewDelegate-Protocol.h"

@class NSMutableArray, NSString, UIImageView;
@protocol YYPickerViewDataSource, YYPickerViewDelegate;

@interface YYPickerView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    _Bool _soundDisable;
    _Bool _isYuerBlackType;
    _Bool _setuped;
    _Bool _soundOK;
    id <YYPickerViewDelegate> _delegate;
    id <YYPickerViewDataSource> _dataSource;
    NSMutableArray *_selectedIndexes;
    NSMutableArray *_tables;
    NSMutableArray *_showTables;
    NSMutableArray *_cellIdentifies;
    NSMutableArray *_offsetYs;
    UIView *_contentView;
    UIImageView *_showView;
    NSString *_backgroundColorForKey;
}

+ (id)pickerView:(struct CGRect)arg1;
+ (id)pickerView:(struct CGRect)arg1 andBackgroundColorForKey:(id)arg2;
@property(copy, nonatomic) NSString *backgroundColorForKey; // @synthesize backgroundColorForKey=_backgroundColorForKey;
@property(retain, nonatomic) UIImageView *showView; // @synthesize showView=_showView;
@property(retain, nonatomic) UIView *contentView; // @synthesize contentView=_contentView;
@property(retain, nonatomic) NSMutableArray *offsetYs; // @synthesize offsetYs=_offsetYs;
@property(retain, nonatomic) NSMutableArray *cellIdentifies; // @synthesize cellIdentifies=_cellIdentifies;
@property(retain, nonatomic) NSMutableArray *showTables; // @synthesize showTables=_showTables;
@property(retain, nonatomic) NSMutableArray *tables; // @synthesize tables=_tables;
@property(nonatomic) _Bool soundOK; // @synthesize soundOK=_soundOK;
@property(nonatomic, getter=isSetuped) _Bool setuped; // @synthesize setuped=_setuped;
@property(nonatomic) _Bool isYuerBlackType; // @synthesize isYuerBlackType=_isYuerBlackType;
@property(nonatomic) _Bool soundDisable; // @synthesize soundDisable=_soundDisable;
@property(readonly, nonatomic) NSMutableArray *selectedIndexes; // @synthesize selectedIndexes=_selectedIndexes;
@property(nonatomic) __weak id <YYPickerViewDataSource> dataSource; // @synthesize dataSource=_dataSource;
@property(nonatomic) __weak id <YYPickerViewDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
@property(readonly, nonatomic) long long numberOfComponents;
- (void)scrollViewDidEndDecelerating:(id)arg1;
- (void)scrollViewWillBeginDragging:(id)arg1;
- (void)scrollViewDidScroll:(id)arg1;
- (void)scrollViewDidEndDragging:(id)arg1 willDecelerate:(_Bool)arg2;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)selectedRowInComponent:(long long)arg1;
- (void)selectRow:(long long)arg1 inComponent:(long long)arg2 animated:(_Bool)arg3 callDelegate:(_Bool)arg4;
- (void)selectRow:(long long)arg1 inComponent:(long long)arg2 animated:(_Bool)arg3;
- (void)reloadComponent:(long long)arg1 toTop:(_Bool)arg2;
- (void)reloadComponent:(long long)arg1;
- (void)reloadAllComponents;
- (id)viewForRow:(long long)arg1 forComponent:(long long)arg2;
- (struct CGSize)rowSizeForComponent:(long long)arg1;
- (long long)numberOfRowsInComponent:(long long)arg1;
- (int)indexOfSmallestAtArray:(id)arg1;
- (void)playSound;
- (void)checkViewScrollOffset:(id)arg1;
- (void)layoutTables;
- (void)setupPickerView;
- (void)didMoveToSuperview;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
