//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSDate;

@interface YBBToolsMyMensesModel : NSObject
{
    long long _dateInt;
    long long _mid;
    NSDate *_date;
    unsigned long long _operation;
}

+ (id)getTableName;
+ (void)SY_UserIDChanged:(id)arg1;
+ (id)getPrimaryKey;
+ (id)getUsingLKDBHelper;
+ (id)modelWithDateInt:(long long)arg1;
+ (void)initialize;
+ (void)load;
@property(nonatomic) unsigned long long operation; // @synthesize operation=_operation;
@property(retain, nonatomic) NSDate *date; // @synthesize date=_date;
@property(nonatomic) long long mid; // @synthesize mid=_mid;
@property(nonatomic) long long dateInt; // @synthesize dateInt=_dateInt;
- (void).cxx_destruct;
- (id)copyWithZone:(struct _NSZone *)arg1;

@end

