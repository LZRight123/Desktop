//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSMutableDictionary;

@interface ApptentiveConnectionManager : NSObject
{
    NSMutableDictionary *channels;
}

+ (id)sharedSingleton;
- (void).cxx_destruct;
- (void)dealloc;
- (id)channelForName:(id)arg1;
- (void)setMaximumActiveConnections:(unsigned long long)arg1 forChannel:(id)arg2;
- (void)cancelConnection:(id)arg1 inChannel:(id)arg2;
- (void)cancelAllConnectionsInChannel:(id)arg1;
- (void)addConnection:(id)arg1 toChannel:(id)arg2;
- (void)stop;
- (void)start;
- (id)init;

@end

