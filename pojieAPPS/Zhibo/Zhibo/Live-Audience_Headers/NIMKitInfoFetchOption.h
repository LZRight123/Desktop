//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NIMMessage, NIMSession;

@interface NIMKitInfoFetchOption : NSObject
{
    _Bool _forbidaAlias;
    NIMSession *_session;
    NIMMessage *_message;
}

@property(nonatomic) _Bool forbidaAlias; // @synthesize forbidaAlias=_forbidaAlias;
@property(retain, nonatomic) NIMMessage *message; // @synthesize message=_message;
@property(retain, nonatomic) NIMSession *session; // @synthesize session=_session;
- (void).cxx_destruct;

@end

