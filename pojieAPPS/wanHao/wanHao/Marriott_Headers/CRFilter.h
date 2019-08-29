//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSString;

@interface CRFilter : NSObject
{
    unsigned long long _filterType;
    NSString *_token;
}

+ (id)applyFilter:(unsigned long long)arg1 ToURL:(id)arg2;
+ (id)queryPreservingFilterWithString:(id)arg1;
+ (id)filterWithString:(id)arg1;
@property(copy) NSString *token; // @synthesize token=_token;
@property(readonly) unsigned long long filterType; // @synthesize filterType=_filterType;
- (void).cxx_destruct;
- (_Bool)doesMatch:(id)arg1;
- (id)initWithString:(id)arg1 andFilterType:(unsigned long long)arg2;
- (id)initWithString:(id)arg1;

@end
