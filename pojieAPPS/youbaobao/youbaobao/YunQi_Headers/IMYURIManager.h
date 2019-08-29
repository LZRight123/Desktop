//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSArray, NSMutableArray, NSMutableDictionary, NSRecursiveLock;

@interface IMYURIManager : NSObject
{
    NSRecursiveLock *_recursiveLock;
    NSMutableDictionary *_pathMapDictionary;
    NSMutableDictionary *_uriCache;
    NSMutableArray *_pathBlockArray;
    NSArray *_urlSchemes;
}

+ (id)shareURIManager;
@property(retain, nonatomic) NSArray *urlSchemes; // @synthesize urlSchemes=_urlSchemes;
@property(retain, nonatomic) NSMutableArray *pathBlockArray; // @synthesize pathBlockArray=_pathBlockArray;
@property(retain, nonatomic) NSMutableDictionary *uriCache; // @synthesize uriCache=_uriCache;
@property(retain, nonatomic) NSMutableDictionary *pathMapDictionary; // @synthesize pathMapDictionary=_pathMapDictionary;
@property(retain, nonatomic) NSRecursiveLock *recursiveLock; // @synthesize recursiveLock=_recursiveLock;
- (void).cxx_destruct;
- (id)hitURIBlocksForPath:(id)arg1;
- (_Bool)containActionBlockForPath:(id)arg1;
- (_Bool)containScheme:(id)arg1;
- (id)init;
- (void)addForPath:(id)arg1 level:(long long)arg2 withActionBlock:(CDUnknownBlockType)arg3;
- (void)addForPath:(id)arg1 withActionBlock:(CDUnknownBlockType)arg2;
- (void)addPathMap:(id)arg1;
- (void)addPathActionBlock:(CDUnknownBlockType)arg1 forPath:(id)arg2 level:(long long)arg3;
- (void)addPathActionBlock:(CDUnknownBlockType)arg1 forPath:(id)arg2;
- (void)invocaWithTarget:(id)arg1 initSELString:(id)arg2 paramsDic:(id)arg3;
- (_Bool)runViewControllerMapActionWithActionObject:(id)arg1;
- (_Bool)runPathBlockActionWithActionObject:(id)arg1;
- (_Bool)runActionWithActionObject:(id)arg1 completed:(CDUnknownBlockType)arg2;
- (_Bool)runActionAndSyncResultWithPath:(id)arg1 params:(id)arg2 callbackBlock:(CDUnknownBlockType)arg3;
- (id)runActionAndSyncResultWithPath:(id)arg1 params:(id)arg2;
- (_Bool)runActionWithURI:(id)arg1 completed:(CDUnknownBlockType)arg2;
- (_Bool)runActionWithString:(id)arg1 completed:(CDUnknownBlockType)arg2;
- (_Bool)runActionWithURI:(id)arg1;
- (_Bool)runActionWithString:(id)arg1;
- (_Bool)runActionWithPath:(id)arg1 params:(id)arg2 info:(id)arg3;
- (_Bool)runActionWithUserActivity:(id)arg1;
- (_Bool)runActionWithWebPageURLString:(id)arg1;

@end
