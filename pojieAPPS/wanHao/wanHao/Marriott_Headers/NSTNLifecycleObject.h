//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "NSCoding-Protocol.h"

@class NSDate, NSMutableDictionary, NSNumber;

@interface NSTNLifecycleObject : NSObject <NSCoding>
{
    _Bool _crashEvent;
    NSDate *_installDate;
    NSDate *_lastUseDate;
    NSNumber *_previousSessionLength;
    NSNumber *_launchNumber;
    NSNumber *_daysSinceFirstUse;
    NSNumber *_daysSinceLastUse;
    NSNumber *_hourOfDay;
    NSNumber *_dayOfWeek;
    NSMutableDictionary *_timedActions;
}

@property(retain) NSMutableDictionary *timedActions; // @synthesize timedActions=_timedActions;
@property _Bool crashEvent; // @synthesize crashEvent=_crashEvent;
@property(retain) NSNumber *dayOfWeek; // @synthesize dayOfWeek=_dayOfWeek;
@property(retain) NSNumber *hourOfDay; // @synthesize hourOfDay=_hourOfDay;
@property(retain) NSNumber *daysSinceLastUse; // @synthesize daysSinceLastUse=_daysSinceLastUse;
@property(retain) NSNumber *daysSinceFirstUse; // @synthesize daysSinceFirstUse=_daysSinceFirstUse;
@property(retain) NSNumber *launchNumber; // @synthesize launchNumber=_launchNumber;
@property(retain) NSNumber *previousSessionLength; // @synthesize previousSessionLength=_previousSessionLength;
@property(retain) NSDate *lastUseDate; // @synthesize lastUseDate=_lastUseDate;
@property(retain) NSDate *installDate; // @synthesize installDate=_installDate;
- (void).cxx_destruct;
- (void)backgroundTimedActions:(id)arg1;
- (id)stopTimedAction:(id)arg1 withDate:(id)arg2;
- (void)startTimedAction:(id)arg1 withDate:(id)arg2;
- (void)updateDayAndWeek;
- (id)buildAsDictionary;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)init;

@end
