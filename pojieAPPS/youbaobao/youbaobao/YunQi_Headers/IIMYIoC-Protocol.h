//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IIMYServiceLocator-Protocol.h"

@class NSString, Protocol;

@protocol IIMYIoC <IIMYServiceLocator>
- (void)simpleIocRequiresInjection:(id)arg1;
- (void)unRegisterInstance:(NSString *)arg1 key:(NSString *)arg2;
- (void)unRegisterInstance:(NSString *)arg1 instance:(id)arg2;
- (void)unRegisterInstance:(NSString *)arg1;
- (void)reset;
- (void)registerInstance:(Class)arg1 factory:(id (^)(NSString *, NSArray *))arg2 key:(NSString *)arg3 createInstanceImmediately:(_Bool)arg4;
- (void)registerInstance:(Class)arg1 factory:(id (^)(NSString *, NSArray *))arg2 key:(NSString *)arg3;
- (void)registerInstance:(Class)arg1 factory:(id (^)(NSString *, NSArray *))arg2 createInstanceImmediately:(_Bool)arg3;
- (void)registerInstance:(Class)arg1 factory:(id (^)(NSString *, NSArray *))arg2;
- (void)registerInstance:(Class)arg1 createInstanceImmediately:(_Bool)arg2 key:(NSString *)arg3;
- (void)registerInstance:(Class)arg1 createInstanceImmediately:(_Bool)arg2;
- (void)registerInstance:(Class)arg1;
- (void)registerInstance:(Protocol *)arg1 tClassName:(Class)arg2 createInstanceImmediately:(_Bool)arg3 key:(NSString *)arg4;
- (void)registerInstance:(Protocol *)arg1 tClassName:(Class)arg2 createInstanceImmediately:(_Bool)arg3;
- (void)registerInstance:(Protocol *)arg1 tClassName:(Class)arg2;
- (_Bool)isRegistered:(NSString *)arg1 key:(NSString *)arg2;
- (_Bool)isRegistered:(NSString *)arg1;
- (_Bool)containCreated:(NSString *)arg1 key:(NSString *)arg2;
- (_Bool)containCreated:(NSString *)arg1;
@end

