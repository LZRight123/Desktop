//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MMObject.h"

@class NSString;

@interface WCGestureReportInfo : MMObject
{
    unsigned int _distance;
    unsigned int _result;
    NSString *_snsId;
    NSString *_targetGesturePoints;
    NSString *_sourceGesturePoints;
    NSString *_aid;
    NSString *_uxInfo;
}

+ (unsigned int)distanceToInt:(double)arg1;
+ (id)arrayToString:(id)arg1 samplingInterval:(long long)arg2;
@property(retain, nonatomic) NSString *uxInfo; // @synthesize uxInfo=_uxInfo;
@property(retain, nonatomic) NSString *aid; // @synthesize aid=_aid;
@property(nonatomic) unsigned int result; // @synthesize result=_result;
@property(nonatomic) unsigned int distance; // @synthesize distance=_distance;
@property(retain, nonatomic) NSString *sourceGesturePoints; // @synthesize sourceGesturePoints=_sourceGesturePoints;
@property(retain, nonatomic) NSString *targetGesturePoints; // @synthesize targetGesturePoints=_targetGesturePoints;
@property(retain, nonatomic) NSString *snsId; // @synthesize snsId=_snsId;
- (void).cxx_destruct;
- (id)toReportString;
- (id)init;

@end
