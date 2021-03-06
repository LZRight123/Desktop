//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "NSCoding-Protocol.h"

@class NSDictionary, NSString;

@interface ApptentivePersonInfo : NSObject <NSCoding>
{
    NSString *_apptentiveID;
    NSString *_name;
    NSString *_emailAddress;
}

+ (id)newPersonFromJSON:(id)arg1;
+ (id)currentPerson;
+ (void)load;
@property(copy, nonatomic) NSString *emailAddress; // @synthesize emailAddress=_emailAddress;
@property(copy, nonatomic) NSString *name; // @synthesize name=_name;
@property(readonly, nonatomic) NSString *apptentiveID; // @synthesize apptentiveID=_apptentiveID;
- (void).cxx_destruct;
- (void)save;
- (id)apiJSON;
@property(readonly, nonatomic) NSDictionary *dictionaryRepresentation;
- (id)initWithJSONDictionary:(id)arg1;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;

@end

