//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTObject.h"

#import "NSCopying-Protocol.h"

@class MRTLookupType;

@interface MRTCommunicationSubscription : MRTObject <NSCopying>
{
    _Bool _isSubscribed;
    MRTLookupType *_subscriptionType;
    MRTLookupType *_methodType;
}

+ (id)subscriptionWithType:(id)arg1 method:(id)arg2 subscribed:(_Bool)arg3;
@property(nonatomic) _Bool isSubscribed; // @synthesize isSubscribed=_isSubscribed;
@property(retain, nonatomic) MRTLookupType *methodType; // @synthesize methodType=_methodType;
@property(retain, nonatomic) MRTLookupType *subscriptionType; // @synthesize subscriptionType=_subscriptionType;
- (void).cxx_destruct;
- (id)serializationPropertyNames;
- (id)copyWithZone:(struct _NSZone *)arg1;

@end

