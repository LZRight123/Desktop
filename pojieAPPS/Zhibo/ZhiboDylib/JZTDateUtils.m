//
//  JZTDateUtils.m
//  qmyios
//
//  Created by 黄康 on 14-10-28.
//  Copyright (c) 2014年 NeilCheung. All rights reserved.
//

#import "JZTDateUtils.h"

@implementation JZTDateUtils


+ (NSString *)stringWithTime:(NSTimeInterval)time andDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:dateFormat];
    return [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
}

+ (NSTimeInterval)timeWithString:(NSString *)string andDateFormat:(NSString *)dateFormat {
    if(string==nil){
        return [[NSDate date] timeIntervalSince1970];
    }
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:dateFormat];
    NSDate *date = [dateformatter dateFromString:string];
    return date.timeIntervalSince1970;
}


+ (NSString *)stringWithTime1:(NSTimeInterval)time {
    return [JZTDateUtils stringWithTime:time andDateFormat:@"yyyy年MM月dd日"];
}

+ (NSString *)stringWithTime2:(NSTimeInterval)time {
    return [JZTDateUtils stringWithTime:time andDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)stringWithTime3:(NSTimeInterval)time {
    return [JZTDateUtils stringWithTime:time andDateFormat:@"yyyy-MM-dd"];
}

+ (NSString *)stringWithTime4:(NSTimeInterval)time {
  return [JZTDateUtils stringWithTime:time andDateFormat:@"yyyy-MM-dd HH:mm"];
}

+ (NSString *)stringWithTime5:(NSTimeInterval)time {
  return [JZTDateUtils stringWithTime:time andDateFormat:@"HH:mm"];
}

+ (NSString *)stringWithTime6:(NSTimeInterval)time {
  return [JZTDateUtils stringWithTime:time andDateFormat:@"MM.dd"];
}

+ (NSString *)stringWithTime7:(NSTimeInterval)time {
    return [JZTDateUtils stringWithTime:time andDateFormat:@"MM-dd HH:mm"];
}

+ (NSString *)stringWithTime8:(NSTimeInterval)time {
  return [JZTDateUtils stringWithTime:time andDateFormat:@"MM-dd"];
}

+ (NSString *)stringWithTime9:(NSTimeInterval)time {
  return [JZTDateUtils stringWithTime:time andDateFormat:@"MM月dd日"];
}

+ (NSString *)stringWithTime10:(NSTimeInterval)time {
    return [JZTDateUtils stringWithTime:time andDateFormat:@"MM/dd"];
}

+ (NSString *)stringWithTime0:(NSTimeInterval)time {
    return [JZTDateUtils stringWithTime:time andDateFormat:@"yyyy.MM.dd"];
}

+ (NSTimeInterval)timeWithString1:(NSString *)string {
    return [JZTDateUtils timeWithString:string andDateFormat:@"yyyy年MM月dd日"];
}

+ (NSTimeInterval)timeWithString2:(NSString *)string {
    return [JZTDateUtils timeWithString:string andDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSTimeInterval)timeWithString3:(NSString *)string {
    return [JZTDateUtils timeWithString:string andDateFormat:@"yyyy-MM-dd"];
}

+ (NSTimeInterval)timeWithString4:(NSString *)string {
  return [JZTDateUtils timeWithString:string andDateFormat:@"yyyy-MM-dd HH:mm"];
}


+ (NSTimeInterval)timeWithString5:(NSString *)string {
    return [JZTDateUtils timeWithString:string andDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
}



+ (NSString*)dateToOld:(int)year month:(int)month day:(int)day {
    
    NSString *dateString = [NSString stringWithFormat:@"%d-%d-%d",year,month,day];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *bornDate=[formatter dateFromString:dateString];
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDateComponents *date = [calendar components:unitFlags fromDate:bornDate toDate:currentDate options:0];
    if( [date year] > 0)
    {
        return [NSString stringWithFormat:(@"%ld"),(long)[date year]];
    }
    return @"0";
}
@end
