//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "MRTStyledTextFieldDelegate-Protocol.h"

@class MRTPhone, MRTPickListField, MRTStyledTextField, NSString, UIView;

@interface MRTFormPhoneController : NSObject <MRTStyledTextFieldDelegate>
{
    MRTPhone *_phone;
    MRTPickListField *_prefixField;
    MRTStyledTextField *_phoneNumberField;
    UIView *_borderView;
}

+ (id)_makeDialingPrefixesByCountryCode;
+ (void)_setupViewModels;
+ (void)initialize;
@property(retain, nonatomic) UIView *borderView; // @synthesize borderView=_borderView;
@property(retain, nonatomic) MRTStyledTextField *phoneNumberField; // @synthesize phoneNumberField=_phoneNumberField;
@property(retain, nonatomic) MRTPickListField *prefixField; // @synthesize prefixField=_prefixField;
@property(retain, nonatomic) MRTPhone *phone; // @synthesize phone=_phone;
- (void).cxx_destruct;
- (void)textFieldDidEndEditing:(id)arg1;
- (_Bool)textFieldShouldEndEditing:(id)arg1;
- (void)textFieldDidBeginEditing:(id)arg1;
- (_Bool)textFieldShouldReturn:(id)arg1;
- (void)textField:(id)arg1 didSetObjectValue:(id)arg2;
- (void)_updatePrefixTextFromCountryCode:(id)arg1;
- (void)_setup;
- (id)initWithPrefixField:(id)arg1 phoneNumberField:(id)arg2 borderView:(id)arg3 phone:(id)arg4;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
