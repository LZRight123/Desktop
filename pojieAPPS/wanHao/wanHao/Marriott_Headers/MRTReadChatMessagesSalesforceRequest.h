//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTSalesforceRequest.h"

@class NSString;

@interface MRTReadChatMessagesSalesforceRequest : MRTSalesforceRequest
{
    NSString *_guestId;
}

@property(copy, nonatomic) NSString *guestId; // @synthesize guestId=_guestId;
- (void).cxx_destruct;
- (id)transformResponse:(id)arg1 error:(id *)arg2;
- (id)createChatMessage:(id)arg1;
- (id)responseISODateFormatter;
- (id)requestDateFormatter;
- (id)initWithCaseId:(id)arg1 direction:(unsigned long long)arg2 timestamp:(id)arg3 fetchLimit:(unsigned long long)arg4;

@end
