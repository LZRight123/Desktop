//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "IMYHTTPResponse-Protocol.h"
#import "NSCopying-Protocol.h"
#import "NSMutableCopying-Protocol.h"

@class NSData, NSDictionary, NSHTTPURLResponse, NSString;

@interface IMYHTTPResponse : NSObject <IMYHTTPResponse, NSCopying, NSMutableCopying>
{
    _Bool _abtest;
    NSHTTPURLResponse *_response;
    id _responseObject;
    NSDictionary *_userInfo;
}

@property(retain, nonatomic) NSDictionary *userInfo; // @synthesize userInfo=_userInfo;
@property(nonatomic) _Bool abtest; // @synthesize abtest=_abtest;
@property(retain, nonatomic) id responseObject; // @synthesize responseObject=_responseObject;
@property(retain, nonatomic) NSHTTPURLResponse *response; // @synthesize response=_response;
- (void).cxx_destruct;
- (id)mutableCopyWithZone:(struct _NSZone *)arg1;
- (id)copyWithZone:(struct _NSZone *)arg1;
@property(readonly, nonatomic) NSString *responseString;
@property(readonly, nonatomic) NSData *responseData;
@property(readonly, nonatomic) CDUnknownBlockType ABTEST;
@property(readonly, nonatomic) CDUnknownBlockType USERINFO;
@property(readonly, nonatomic) CDUnknownBlockType OBJECT;
@property(readonly, nonatomic) CDUnknownBlockType RESPONSE;
@property(readonly, copy) NSString *description;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
