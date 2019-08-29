//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class IMYMDItemsView;

@interface IMYMDItemsBoard : UIView
{
    IMYMDItemsView *_moodsView;
    IMYMDItemsView *_itemsView;
    CDUnknownBlockType _onSelectedFlag;
    CDUnknownBlockType _onChangedSelected;
    CDUnknownBlockType _onBtKeyBoardTouchDown;
}

+ (void)deallocItemsBoard;
+ (id)shareItemsBoard;
@property(copy, nonatomic) CDUnknownBlockType onBtKeyBoardTouchDown; // @synthesize onBtKeyBoardTouchDown=_onBtKeyBoardTouchDown;
@property(copy, nonatomic) CDUnknownBlockType onChangedSelected; // @synthesize onChangedSelected=_onChangedSelected;
@property(copy, nonatomic) CDUnknownBlockType onSelectedFlag; // @synthesize onSelectedFlag=_onSelectedFlag;
@property(retain, nonatomic) IMYMDItemsView *itemsView; // @synthesize itemsView=_itemsView;
@property(retain, nonatomic) IMYMDItemsView *moodsView; // @synthesize moodsView=_moodsView;
- (void).cxx_destruct;
- (void)removeFromSuperviewAndCallback;
- (void)bt_keyboard_pressed:(id)arg1;
- (id)initWithFrame:(struct CGRect)arg1;

@end
