//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "IMYYBBaseViewModel.h"

@class IMYYBSessionModel, NSDictionary;

@interface IMYYBSessionVM : IMYYBBaseViewModel
{
    _Bool _next_brand_area;
    long long _item_id;
    long long _brand_area_id;
    long long _activity_id;
    NSDictionary *_appendParams;
    IMYYBSessionModel *_sessionModel;
    long long _next_brand_area_id;
    IMYYBSessionModel *_next_sessionModel;
}

@property(retain, nonatomic) IMYYBSessionModel *next_sessionModel; // @synthesize next_sessionModel=_next_sessionModel;
@property(nonatomic) long long next_brand_area_id; // @synthesize next_brand_area_id=_next_brand_area_id;
@property(nonatomic) _Bool next_brand_area; // @synthesize next_brand_area=_next_brand_area;
@property(retain, nonatomic) IMYYBSessionModel *sessionModel; // @synthesize sessionModel=_sessionModel;
@property(retain, nonatomic) NSDictionary *appendParams; // @synthesize appendParams=_appendParams;
@property(nonatomic) long long activity_id; // @synthesize activity_id=_activity_id;
@property(nonatomic) long long brand_area_id; // @synthesize brand_area_id=_brand_area_id;
@property(nonatomic) long long item_id; // @synthesize item_id=_item_id;
- (void).cxx_destruct;
- (id)cacheKey;
- (id)nextCacheKey;
- (void)translateNextToCurrent;
- (void)requestNextPage;
- (void)requestData;
- (unsigned long long)initData:(_Bool)arg1;

@end

