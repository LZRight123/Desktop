//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSMutableArray;

@interface IMYEBRecomNotiManager : NSObject
{
    NSMutableArray *_recommendItemList;
}

+ (id)sharedManager;
@property(retain, nonatomic) NSMutableArray *recommendItemList; // @synthesize recommendItemList=_recommendItemList;
- (void).cxx_destruct;
- (void)clearRecommendItem;
- (id)getRecommendItem;
- (void)addRecommendItem:(id)arg1;
- (void)sendRecommendNotificationWithModel:(id)arg1;

@end
