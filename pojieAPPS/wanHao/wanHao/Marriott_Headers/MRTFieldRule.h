//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTObject.h"

@class NSString;

@interface MRTFieldRule : MRTObject
{
    _Bool _isRequired;
    _Bool _multipleValues;
    NSString *_fieldId;
    NSString *_fieldDescription;
    NSString *_fieldType;
    NSString *_lookup;
    NSString *_defaultValue;
}

@property(nonatomic) _Bool multipleValues; // @synthesize multipleValues=_multipleValues;
@property(nonatomic) _Bool isRequired; // @synthesize isRequired=_isRequired;
@property(copy, nonatomic) NSString *defaultValue; // @synthesize defaultValue=_defaultValue;
@property(copy, nonatomic) NSString *lookup; // @synthesize lookup=_lookup;
@property(copy, nonatomic) NSString *fieldType; // @synthesize fieldType=_fieldType;
@property(copy, nonatomic) NSString *fieldDescription; // @synthesize fieldDescription=_fieldDescription;
@property(copy, nonatomic) NSString *fieldId; // @synthesize fieldId=_fieldId;
- (void).cxx_destruct;
- (id)copyWithZone:(struct _NSZone *)arg1;

@end
