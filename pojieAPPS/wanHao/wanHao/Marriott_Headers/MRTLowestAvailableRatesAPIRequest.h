//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTRateAPIRequest.h"

@class MRTPropertiesRoomsSearchRequest;

@interface MRTLowestAvailableRatesAPIRequest : MRTRateAPIRequest
{
    _Bool _showUnavailable;
    _Bool _showUnavailableForRedemption;
    MRTPropertiesRoomsSearchRequest *_searchRequest;
}

@property(nonatomic) _Bool showUnavailableForRedemption; // @synthesize showUnavailableForRedemption=_showUnavailableForRedemption;
@property(nonatomic) _Bool showUnavailable; // @synthesize showUnavailable=_showUnavailable;
@property(retain, nonatomic) MRTPropertiesRoomsSearchRequest *searchRequest; // @synthesize searchRequest=_searchRequest;
- (void).cxx_destruct;
- (void)trackResponsesWithoutRates:(id)arg1;
- (_Bool)foundLowestAvailableRateForPropertyRoom:(id)arg1 seekingSpecialRate:(_Bool)arg2;
- (_Bool)shouldAddPropertyRoom:(id)arg1;
- (id)propertyRoomsForRateInfos:(id)arg1 isMarshaError:(_Bool)arg2;
- (id)marshaCodeForRateInfo:(id)arg1;
- (id)rateInfosForLARResponse:(id)arg1;
- (_Bool)isMarshaError:(id)arg1;
- (id)transformResponse:(id)arg1 error:(id *)arg2;
- (id)facetTermsForSearchRequest:(id)arg1;
- (id)standardRequestTypes;
- (_Bool)includeImpliedStandardTypes;
- (id)basicParametersForSearchRequest:(id)arg1;
- (id)parametersForSearchRequest:(id)arg1;
- (id)lowestAvailableRatesKey;
- (id)endPointName;
- (id)initWithSearchRequest:(id)arg1;

@end

