//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTManagedObject.h"

@class MRTCategoryTypeID, NSDate, NSSet, NSString;

@interface _MRTCategoryType : MRTManagedObject
{
}

+ (id)keyPathsForValuesAffectingValueForKey:(id)arg1;
+ (id)entityInManagedObjectContext:(id)arg1;
+ (id)entityName;
+ (id)insertInManagedObjectContext:(id)arg1;
- (id)propertiesSet;
@property(readonly, nonatomic) MRTCategoryTypeID *objectID;

// Remaining properties
@property(retain, nonatomic) NSString *categoryCode; // @dynamic categoryCode;
@property(retain, nonatomic) NSString *categoryDescription; // @dynamic categoryDescription;
@property(retain, nonatomic) NSString *categoryLabel; // @dynamic categoryLabel;
@property(retain, nonatomic) NSSet *properties; // @dynamic properties;
@property(retain, nonatomic) NSDate *timeCreated; // @dynamic timeCreated;
@property(retain, nonatomic) NSDate *timeUpdated; // @dynamic timeUpdated;

@end

