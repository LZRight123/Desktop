//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@interface GXActionDirectorBase : NSObject
{
}

- (long long)pendingScriptsCount;
- (void)feedback:(int)arg1 message:(id)arg2 result:(id)arg3;
- (_Bool)scheduleScripting:(id)arg1 withStoredToken:(id)arg2;
- (void)cleanup;
- (void)dealloc;
- (id)init;

@end

