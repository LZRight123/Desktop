//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MRTManagedObject.h"

@class MRTBrandLogo, MRTImageID, MRTImageInfo, NSDate, NSNumber, NSString;

@interface _MRTImage : MRTManagedObject
{
}

+ (id)keyPathsForValuesAffectingValueForKey:(id)arg1;
+ (id)entityInManagedObjectContext:(id)arg1;
+ (id)entityName;
+ (id)insertInManagedObjectContext:(id)arg1;
- (void)setPrimitiveWidthValue:(long long)arg1;
- (long long)primitiveWidthValue;
@property long long widthValue;
- (void)setPrimitiveOrderValue:(long long)arg1;
- (long long)primitiveOrderValue;
@property long long orderValue;
- (void)setPrimitiveImageFlagsValue:(long long)arg1;
- (long long)primitiveImageFlagsValue;
@property long long imageFlagsValue;
- (void)setPrimitiveHeightValue:(long long)arg1;
- (long long)primitiveHeightValue;
@property long long heightValue;
@property(readonly, nonatomic) MRTImageID *objectID;

// Remaining properties
@property(retain, nonatomic) NSString *alternateText; // @dynamic alternateText;
@property(retain, nonatomic) MRTBrandLogo *brandLogo; // @dynamic brandLogo;
@property(retain, nonatomic) NSString *category; // @dynamic category;
@property(retain, nonatomic) NSNumber *height; // @dynamic height;
@property(retain, nonatomic) NSNumber *imageFlags; // @dynamic imageFlags;
@property(retain, nonatomic) MRTImageInfo *imageInfo; // @dynamic imageInfo;
@property(retain, nonatomic) NSNumber *order; // @dynamic order;
@property(retain, nonatomic) NSDate *timeCreated; // @dynamic timeCreated;
@property(retain, nonatomic) NSDate *timeUpdated; // @dynamic timeUpdated;
@property(retain, nonatomic) NSString *url; // @dynamic url;
@property(retain, nonatomic) NSNumber *width; // @dynamic width;

@end

