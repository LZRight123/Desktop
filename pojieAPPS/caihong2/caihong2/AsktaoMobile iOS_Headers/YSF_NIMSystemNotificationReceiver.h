//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSMutableArray;

@interface YSF_NIMSystemNotificationReceiver : NSObject
{
    _Bool _onlineNotification;
    NSMutableArray *_sysNotifications;
}

@property(retain, nonatomic) NSMutableArray *sysNotifications; // @synthesize sysNotifications=_sysNotifications;
@property(nonatomic) _Bool onlineNotification; // @synthesize onlineNotification=_onlineNotification;
- (void).cxx_destruct;
- (void)fireSystemNotifications;
- (void)handleSystemNotification:(const struct Property *)arg1 type:(long long)arg2;
- (void)handleCustomnSystemNotification:(const struct Property *)arg1 online:(_Bool)arg2;
- (_Bool)typeCanBeHandled:(long long)arg1;
- (void)receiveNotifications:(vector_ff4a3b41 *)arg1 online:(_Bool)arg2;
- (id)init;

@end
