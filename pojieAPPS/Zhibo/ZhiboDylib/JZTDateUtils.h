//
//  JZTDateUtils.h
//  qmyios
//
//  Created by 黄康 on 14-10-28.
//  Copyright (c) 2014年 NeilCheung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZTDateUtils : NSObject

/**
 *  根据long转化为字符串
 *
 *  @param time       时间戳
 *  @param dateFormat 时间格式
 *
 *  @return 字符串
 */
+ (NSString *)stringWithTime:(NSTimeInterval)time andDateFormat:(NSString *)dateFormat;

/**
 *  根据字符串转化为时间戳
 *
 *  @param string     字符串
 *  @param dateFormat 时间格式
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)timeWithString:(NSString *)string andDateFormat:(NSString *)dateFormat;

/**
 *  根据long转化为字符串（yyyy年MM月dd日）
 *
 *  @param time 时间戳
 *
 *  @return yyyy年MM月dd日
 */
+ (NSString *)stringWithTime1:(NSTimeInterval)time;

/**
 *  根据long转化为字符串（yyyy-MM-dd HH:mm:ss）
 *
 *  @param time 时间戳
 *
 *  @return yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)stringWithTime2:(NSTimeInterval)time;

/**
 *  根据long转化为字符串（yyyy-MM-dd）
 *
 *  @param time time 时间戳
 *
 *  @return yyyy-MM-dd
 */
+ (NSString *)stringWithTime3:(NSTimeInterval)time;
/**
 *  根据long转化为字符串（yyyy-MM-dd HH:mm）
 *
 *  @param time time 时间戳
 *
 *  @return yyyy-MM-dd HH:mm
 */
+ (NSString *)stringWithTime4:(NSTimeInterval)time;
/**
 *  根据long转化为字符串（HH:mm）
 *
 *  @param time time 时间戳
 *
 *  @return HH:mm
 */
+ (NSString *)stringWithTime5:(NSTimeInterval)time;

/**
 *  根据long转化为字符串（MM月dd日）
 *
 *  @param time time 时间戳
 *
 *  @return MM月dd日
 */
+ (NSString *)stringWithTime6:(NSTimeInterval)time;
/**
 *  根据long转化为字符串（MM-dd HH:mm）
 *
 *  @param time time 时间戳
 *
 *  @return MM-dd HH:mm
 */
+ (NSString *)stringWithTime7:(NSTimeInterval)time;
/**
 *  根据long转化为字符串（MM-dd）
 *
 *  @param time time 时间戳
 *
 *  @return MM-dd
 */
+ (NSString *)stringWithTime8:(NSTimeInterval)time;
/**
 *  根据long转化为字符串（MM月dd日）
 *
 *  @param time time 时间戳
 *
 *  @return MM月dd日
 */
+ (NSString *)stringWithTime9:(NSTimeInterval)time;

/**
 *  根据long转化为字符串（MM/dd）
 *
 *  @param time time 时间戳
 *
 *  @return MM/dd
 */
+ (NSString *)stringWithTime10:(NSTimeInterval)time;

/**
 根据long转化为字符串（yyyy.MM.dd）

 @param time 时间戳
 @return 2017.01.01
 */
+ (NSString *)stringWithTime0:(NSTimeInterval)time;
/**
 *  根据字符串转化为时间戳（yyyy年MM月dd日）
 *
 *  @param string yyyy年MM月dd日
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)timeWithString1:(NSString *)string;

/**
 *  根据字符串转化为时间戳（yyyy-MM-dd HH:mm:ss）
 *
 *  @param string yyyy-MM-dd HH:mm:ss
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)timeWithString2:(NSString *)string;

/**
 *  根据字符串转化为时间戳（yyyy-MM-dd HH:mm:ss.SSS）
 *
 *  @param string yyyy-MM-dd HH:mm:ss
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)timeWithString5:(NSString *)string;

/**
 *  根据字符串转化为时间戳（yyyy-MM-dd）
 *
 *  @param string yyyy-MM-dd
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)timeWithString3:(NSString *)string;
/**
 *  根据字符串转化为时间戳（yyyy-MM-dd HH:mm）
 *
 *  @param string yyyy-MM-dd HH:mm
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)timeWithString4:(NSString *)string;

+ (NSString*)dateToOld:(int)year month:(int)month day:(int)day;

@end
