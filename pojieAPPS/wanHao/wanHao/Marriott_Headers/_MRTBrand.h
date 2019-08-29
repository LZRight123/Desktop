//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTManagedObject.h"

@class MRTBrandID, NSDate, NSNumber, NSSet, NSString;

@interface _MRTBrand : MRTManagedObject
{
}

+ (id)keyPathsForValuesAffectingValueForKey:(id)arg1;
+ (id)entityInManagedObjectContext:(id)arg1;
+ (id)entityName;
+ (id)insertInManagedObjectContext:(id)arg1;
- (id)propertiesSet;
- (id)logosSet;
- (id)brandImagesSet;
- (void)setPrimitiveSortIndexValue:(short)arg1;
- (short)primitiveSortIndexValue;
@property short sortIndexValue;
- (void)setPrimitiveShouldFilterValue:(_Bool)arg1;
- (_Bool)primitiveShouldFilterValue;
@property _Bool shouldFilterValue;
- (void)setPrimitiveBrandFlagsValue:(long long)arg1;
- (long long)primitiveBrandFlagsValue;
@property long long brandFlagsValue;
@property(readonly, nonatomic) MRTBrandID *objectID;

// Remaining properties
@property(retain, nonatomic) NSString *brandDescription; // @dynamic brandDescription;
@property(retain, nonatomic) NSNumber *brandFlags; // @dynamic brandFlags;
@property(retain, nonatomic) NSSet *brandImages; // @dynamic brandImages;
@property(retain, nonatomic) NSString *brandType; // @dynamic brandType;
@property(retain, nonatomic) NSString *identifier; // @dynamic identifier;
@property(retain, nonatomic) NSSet *logos; // @dynamic logos;
@property(retain, nonatomic) NSString *name; // @dynamic name;
@property(retain, nonatomic) NSString *primaryColor; // @dynamic primaryColor;
@property(retain, nonatomic) NSSet *properties; // @dynamic properties;
@property(retain, nonatomic) NSString *secondaryColor; // @dynamic secondaryColor;
@property(retain, nonatomic) NSNumber *shouldFilter; // @dynamic shouldFilter;
@property(retain, nonatomic) NSNumber *sortIndex; // @dynamic sortIndex;
@property(retain, nonatomic) NSDate *timeCreated; // @dynamic timeCreated;
@property(retain, nonatomic) NSDate *timeUpdated; // @dynamic timeUpdated;

@end
