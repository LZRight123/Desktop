//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYSimpleCellModel.h"

@class NSArray, NSString;

@interface SYMineCellModel : IMYSimpleCellModel
{
    NSString *_titleName;
    NSString *_iconName;
    NSArray *_data;
}

@property(retain, nonatomic) NSArray *data; // @synthesize data=_data;
@property(nonatomic) __weak NSString *iconName; // @synthesize iconName=_iconName;
@property(nonatomic) __weak NSString *titleName; // @synthesize titleName=_titleName;
- (void).cxx_destruct;

// Remaining properties
@property(copy, nonatomic) NSString *content;
@property(nonatomic) unsigned long long type;

@end

