//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSDate.h>

@interface NSDate (SAMAdditions)
+ (id)sam_timeInWordsFromTimeInterval:(double)arg1 includingSeconds:(_Bool)arg2;
+ (id)sam_dateFromISO8601String:(id)arg1;
- (id)sam_timeInWordsIncludingSeconds:(_Bool)arg1;
- (id)sam_timeInWords;
- (id)sam_briefTimeInWords;
- (id)sam_ISO8601String;
@end

