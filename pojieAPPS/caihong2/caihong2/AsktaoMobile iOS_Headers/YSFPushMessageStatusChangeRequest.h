//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "YSFIMCustomSystemMessageApiProtocol-Protocol.h"

@class NSString;

@interface YSFPushMessageStatusChangeRequest : NSObject <YSFIMCustomSystemMessageApiProtocol>
{
    long long _msgSessionId;
    long long _status;
}

@property(nonatomic) long long status; // @synthesize status=_status;
@property(nonatomic) long long msgSessionId; // @synthesize msgSessionId=_msgSessionId;
- (id)toDict;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

