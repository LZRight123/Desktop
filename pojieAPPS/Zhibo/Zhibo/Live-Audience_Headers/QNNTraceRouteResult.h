//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface QNNTraceRouteResult : NSObject
{
    long long _code;
    NSString *_ip;
    NSString *_content;
}

@property(readonly) NSString *content; // @synthesize content=_content;
@property(readonly) NSString *ip; // @synthesize ip=_ip;
@property(readonly) long long code; // @synthesize code=_code;
- (void).cxx_destruct;
- (id)init:(long long)arg1 ip:(id)arg2 content:(id)arg3;

@end

