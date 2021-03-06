//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTObject.h"

@class MRTRemoteImage, NSDate, NSString, NSURL;

@interface MRTCreditCardMarketingPageTemplate : MRTObject
{
    _Bool _defaultTemplate;
    _Bool _isGuardrailsOffer;
    MRTRemoteImage *_image;
    NSString *_headlineText;
    NSString *_bodyText;
    NSString *_callToActionText;
    NSURL *_callToActionDestinationURL;
    NSString *_callToActionDestinationURLTemplate;
    NSString *_metaTags;
    NSString *_guardrailsEventInfo;
    NSString *_analyticsName;
    NSString *_category;
    NSString *_domainName;
    NSString *_creditAmountString;
    double _creditAmount;
    NSString *_termsAndConditionsURL;
    NSString *_termsAndConditionsTitle;
    NSString *_termsAndConditionsDescription;
    NSDate *_usageRightsExpirationDate;
    NSDate *_offerExpirationDate;
}

@property(nonatomic) _Bool isGuardrailsOffer; // @synthesize isGuardrailsOffer=_isGuardrailsOffer;
@property(retain, nonatomic) NSDate *offerExpirationDate; // @synthesize offerExpirationDate=_offerExpirationDate;
@property(retain, nonatomic) NSDate *usageRightsExpirationDate; // @synthesize usageRightsExpirationDate=_usageRightsExpirationDate;
@property(copy, nonatomic) NSString *termsAndConditionsDescription; // @synthesize termsAndConditionsDescription=_termsAndConditionsDescription;
@property(copy, nonatomic) NSString *termsAndConditionsTitle; // @synthesize termsAndConditionsTitle=_termsAndConditionsTitle;
@property(copy, nonatomic) NSString *termsAndConditionsURL; // @synthesize termsAndConditionsURL=_termsAndConditionsURL;
@property(nonatomic) double creditAmount; // @synthesize creditAmount=_creditAmount;
@property(copy, nonatomic) NSString *creditAmountString; // @synthesize creditAmountString=_creditAmountString;
@property(copy, nonatomic) NSString *domainName; // @synthesize domainName=_domainName;
@property(copy, nonatomic) NSString *category; // @synthesize category=_category;
@property(copy, nonatomic) NSString *analyticsName; // @synthesize analyticsName=_analyticsName;
@property(copy, nonatomic) NSString *guardrailsEventInfo; // @synthesize guardrailsEventInfo=_guardrailsEventInfo;
@property(copy, nonatomic) NSString *metaTags; // @synthesize metaTags=_metaTags;
@property(copy, nonatomic) NSString *callToActionDestinationURLTemplate; // @synthesize callToActionDestinationURLTemplate=_callToActionDestinationURLTemplate;
@property(retain, nonatomic) NSURL *callToActionDestinationURL; // @synthesize callToActionDestinationURL=_callToActionDestinationURL;
@property(copy, nonatomic) NSString *callToActionText; // @synthesize callToActionText=_callToActionText;
@property(copy, nonatomic) NSString *bodyText; // @synthesize bodyText=_bodyText;
@property(copy, nonatomic) NSString *headlineText; // @synthesize headlineText=_headlineText;
@property(retain, nonatomic) MRTRemoteImage *image; // @synthesize image=_image;
@property(nonatomic, getter=isDefaultTemplate) _Bool defaultTemplate; // @synthesize defaultTemplate=_defaultTemplate;
- (void).cxx_destruct;
@property(copy, nonatomic) NSString *baseImageURLString;
@property(nonatomic) struct CGSize baseImageSize;
- (void)setBaseImageHeight:(double)arg1;
- (void)setBaseImageWidth:(double)arg1;
- (_Bool)isKeyDeserializationWarningIgnored:(id)arg1;

@end

