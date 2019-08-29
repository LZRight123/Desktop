//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MMObject.h"

#import "PBCoding-Protocol.h"

@class NSMutableArray, NSString;

@interface WARecommendItemData : MMObject <PBCoding>
{
    NSString *userName;
    NSString *appId;
    NSString *nickName;
    NSString *iconUrl;
    NSMutableArray *categoryList;
    NSString *words;
    NSString *descString;
    double evaluateScore;
}

+ (void)initialize;
@property(nonatomic) double evaluateScore; // @synthesize evaluateScore;
@property(retain, nonatomic) NSString *descString; // @synthesize descString;
@property(retain, nonatomic) NSString *words; // @synthesize words;
@property(retain, nonatomic) NSMutableArray *categoryList; // @synthesize categoryList;
@property(retain, nonatomic) NSString *iconUrl; // @synthesize iconUrl;
@property(retain, nonatomic) NSString *nickName; // @synthesize nickName;
@property(retain, nonatomic) NSString *appId; // @synthesize appId;
@property(retain, nonatomic) NSString *userName; // @synthesize userName;
- (void).cxx_destruct;
- (const map_f8690629 *)getValueTagIndexMap;
- (id)getValueTypeTable;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
