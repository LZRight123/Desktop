//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTAPIRequest.h"

@interface MRTRitzBackendAPIRequest : MRTAPIRequest
{
}

- (id)dueDateFormatter;
- (id)ritzOptionValueForServiceID:(id)arg1;
- (id)ritzTypeIDForServiceID:(id)arg1;
- (id)serviceIDForRitzTypeID:(id)arg1 optionValue:(id)arg2;
- (id)serviceMap;
- (id)fullServiceList;
- (id)transformResponse:(id)arg1 error:(id *)arg2;
- (id)baseURL;
- (id)initWithUrlString:(id)arg1;

@end

