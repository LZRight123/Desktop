//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface YSFMiniAppTimeout : NSObject
{
    long long _sessionId;
    NSString *_msgIdClient;
    NSString *_info;
}

+ (id)dataByJson:(id)arg1;
@property(copy, nonatomic) NSString *info; // @synthesize info=_info;
@property(copy, nonatomic) NSString *msgIdClient; // @synthesize msgIdClient=_msgIdClient;
@property(nonatomic) long long sessionId; // @synthesize sessionId=_sessionId;
- (void).cxx_destruct;

@end

