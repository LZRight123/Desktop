//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "YSF_NIMManager.h"

@class NSMutableDictionary, NSRecursiveLock, YSF_NIMKeyValueStore;

@interface YSF_NIMInfoManager : YSF_NIMManager
{
    NSMutableDictionary *_infos;
    YSF_NIMKeyValueStore *_store;
    NSRecursiveLock *_lock;
}

@property(retain, nonatomic) NSRecursiveLock *lock; // @synthesize lock=_lock;
@property(retain, nonatomic) YSF_NIMKeyValueStore *store; // @synthesize store=_store;
@property(retain, nonatomic) NSMutableDictionary *infos; // @synthesize infos=_infos;
- (void).cxx_destruct;
- (id)keyByMessage:(id)arg1;
- (id)nameByKey:(id)arg1;
- (void)saveSenderName:(id)arg1 forMessage:(id)arg2;
- (id)senderNameByMessage:(id)arg1;
- (id)init;

@end

