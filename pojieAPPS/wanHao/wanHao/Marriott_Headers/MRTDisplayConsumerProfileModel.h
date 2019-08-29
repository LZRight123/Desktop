//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSArray, NSDictionary;

@interface MRTDisplayConsumerProfileModel : NSObject
{
    NSDictionary *_modelDict;
    NSArray *_dialingPrefixes;
}

@property(retain, nonatomic) NSArray *dialingPrefixes; // @synthesize dialingPrefixes=_dialingPrefixes;
@property(retain, nonatomic) NSDictionary *modelDict; // @synthesize modelDict=_modelDict;
- (void).cxx_destruct;
- (id)titleForSection:(unsigned long long)arg1;
- (long long)numberOfElementsInSection:(unsigned long long)arg1;
- (id)elementsInSection:(unsigned long long)arg1;
- (id)phoneNumberDisplayStringWithPhoneNumber:(id)arg1;
- (void)_buildModelFromConsumer:(id)arg1;
- (id)initWithConsumer:(id)arg1;

@end
