//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class BVNetwork, NSString;
@protocol BVDelegate;

@interface BVGet : NSObject
{
    _Bool _excludeFamily;
    int _type;
    int _limit;
    int _offset;
    NSString *_requestURL;
    NSString *_search;
    NSString *_locale;
    BVNetwork *_network;
}

@property(retain) BVNetwork *network; // @synthesize network=_network;
@property(nonatomic) _Bool excludeFamily; // @synthesize excludeFamily=_excludeFamily;
@property(nonatomic) int offset; // @synthesize offset=_offset;
@property(nonatomic) int limit; // @synthesize limit=_limit;
@property(nonatomic) NSString *locale; // @synthesize locale=_locale;
@property(nonatomic) NSString *search; // @synthesize search=_search;
@property(nonatomic) NSString *requestURL; // @synthesize requestURL=_requestURL;
@property(nonatomic) int type; // @synthesize type=_type;
- (void).cxx_destruct;
- (id)getEqualityString:(int)arg1;
- (id)getIncludeStatsTypeString:(int)arg1;
- (id)getIncludeTypeString:(int)arg1;
- (id)getTypeString;
- (void)setFilterOnIncludedType:(int)arg1 forAttribute:(id)arg2 equality:(int)arg3 values:(id)arg4;
- (void)setFilterOnIncludedType:(int)arg1 forAttribute:(id)arg2 equality:(int)arg3 value:(id)arg4;
- (void)setFilterForAttribute:(id)arg1 equality:(int)arg2 values:(id)arg3;
- (void)setFilterForAttribute:(id)arg1 equality:(int)arg2 value:(id)arg3;
- (void)setLimitOnIncludedType:(int)arg1 value:(int)arg2;
- (void)addSortOnIncludedType:(int)arg1 attribute:(id)arg2 ascending:(_Bool)arg3;
- (void)setSearchOnIncludedType:(int)arg1 search:(id)arg2;
- (void)addStatsOn:(int)arg1;
- (void)addSortForAttribute:(id)arg1 ascending:(_Bool)arg2;
- (void)addAttribute:(id)arg1;
- (void)addInclude:(int)arg1;
- (void)setGenericParameterWithName:(id)arg1 value:(id)arg2;
- (void)send;
- (void)sendRequestWithDelegate:(id)arg1;
@property __weak id <BVDelegate> delegate;
- (id)initWithType:(int)arg1;
- (id)init;

@end

