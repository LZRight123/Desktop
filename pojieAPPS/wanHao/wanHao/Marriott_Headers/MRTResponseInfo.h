//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSDate;

@interface MRTResponseInfo : NSObject
{
    _Bool _duplicate;
    _Bool _cached;
    _Bool _cacheOnly;
    _Bool _hadPreviousCache;
    _Bool _unmodified;
    NSDate *_date;
}

+ (id)infoForUnmodifiedDate:(id)arg1 duplicate:(_Bool)arg2 previousCache:(_Bool)arg3;
+ (id)infoForCacheDate:(id)arg1 cacheOnly:(_Bool)arg2;
+ (id)infoForPreviousCache:(_Bool)arg1;
@property(readonly) NSDate *date; // @synthesize date=_date;
@property(readonly, getter=isUnmodified) _Bool unmodified; // @synthesize unmodified=_unmodified;
@property(readonly) _Bool hadPreviousCache; // @synthesize hadPreviousCache=_hadPreviousCache;
@property(readonly, getter=isCacheOnly) _Bool cacheOnly; // @synthesize cacheOnly=_cacheOnly;
@property(readonly, getter=isCached) _Bool cached; // @synthesize cached=_cached;
@property(readonly, getter=isDuplicate) _Bool duplicate; // @synthesize duplicate=_duplicate;
- (void).cxx_destruct;
- (id)cacheDate;
- (id)initWithUnmodifiedDate:(id)arg1 duplicate:(_Bool)arg2 previousCache:(_Bool)arg3;
- (id)initWithCacheDate:(id)arg1 cacheOnly:(_Bool)arg2;
- (id)initWithDuplicate:(_Bool)arg1 previousCache:(_Bool)arg2;

@end

