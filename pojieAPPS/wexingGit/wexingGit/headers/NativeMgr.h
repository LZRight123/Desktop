//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSThread;
@protocol wxNativeLogDelegate;

@interface NativeMgr : NSObject
{
    struct IMBNativeInterface *_nativeInterface;
    NSThread *_thread;
    id <wxNativeLogDelegate> _delegate;
}

+ (id)shareInstance;
@property(nonatomic) __weak id <wxNativeLogDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)nativeLog:(int)arg1 log:(const char *)arg2;
- (void)update;
- (void)updateEvent;
- (void)setInterface:(struct IMBNativeInterface *)arg1;

@end

