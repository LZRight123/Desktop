//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface IMYChouChouRecordModel : NSObject
{
    _Bool _is_delete;
    _Bool _hasSync;
    long long _datetime;
    unsigned long long _shape;
    unsigned long long _color;
    NSString *_recordDate;
    unsigned long long _number;
}

+ (id)sortModelByDate:(id)arg1 isDesc:(_Bool)arg2;
+ (long long)averageTimes;
+ (unsigned long long)yesterdayTimes;
+ (id)todayModel;
+ (id)allUnsyncDeleteModelFromBabyBirth;
+ (id)allUnsyncModelFromBabyBirth;
+ (id)allModelFromBabyBirth;
+ (id)modelForSpecificDate:(id)arg1;
+ (id)recent7DaysModel;
+ (id)recent24HoursModel;
+ (id)lastDayModels;
+ (id)lastModel;
+ (id)modelWithDatetime:(long long)arg1;
+ (id)getTableName;
+ (id)getPrimaryKey;
+ (void)imy_userIDChanged:(id)arg1;
+ (void)initialize;
+ (id)modelPropertyBlacklist;
@property(nonatomic) unsigned long long number; // @synthesize number=_number;
@property(nonatomic) _Bool hasSync; // @synthesize hasSync=_hasSync;
@property(copy, nonatomic) NSString *recordDate; // @synthesize recordDate=_recordDate;
@property(nonatomic) _Bool is_delete; // @synthesize is_delete=_is_delete;
@property(nonatomic) unsigned long long color; // @synthesize color=_color;
@property(nonatomic) unsigned long long shape; // @synthesize shape=_shape;
@property(nonatomic) long long datetime; // @synthesize datetime=_datetime;
- (void).cxx_destruct;
- (_Bool)saveToDB;

@end

