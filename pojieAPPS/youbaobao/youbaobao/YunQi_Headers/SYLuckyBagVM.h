//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "SYBaseViewModel.h"

@class NSArray;

@interface SYLuckyBagVM : SYBaseViewModel
{
    NSArray *_tableViewDatas;
}

+ (_Bool)isCurUserSendLuckyBagMsg;
+ (void)setCurUserSendLuckyBagMsg;
+ (void)childbrithSendMessage;
@property(retain, nonatomic) NSArray *tableViewDatas; // @synthesize tableViewDatas=_tableViewDatas;
- (void).cxx_destruct;
- (id)getContent;
- (void)saveToUserHelper;
- (id)getShowStringByType:(unsigned long long)arg1 bTemp:(_Bool)arg2;
- (id)luckyBagEditInfo;
- (id)getLuckyBagEditInfoCache;
- (void)setLuckyBagEditInfoCache;
- (id)isCheckValueOK;
- (id)rowsForWeight:(id)arg1;
- (id)weightString:(id)arg1;
- (void)initData;
- (id)init;

@end

