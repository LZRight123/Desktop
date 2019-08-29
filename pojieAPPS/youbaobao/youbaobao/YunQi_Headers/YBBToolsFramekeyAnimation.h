//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class CADisplayLink, NSArray, NSCache, RACSignal, RACSubject, UIImage;

@interface YBBToolsFramekeyAnimation : UIView
{
    _Bool _isStart;
    NSArray *_imagesPath;
    double _durition;
    long long _index;
    unsigned long long _repeatCount;
    unsigned long long _maxCache;
    CADisplayLink *_link;
    unsigned long long _count;
    UIImage *_curImage;
    double _totalTime;
    double _preTime;
    NSCache *_cache;
    RACSubject *_subject;
}

@property(retain, nonatomic) RACSubject *subject; // @synthesize subject=_subject;
@property(retain, nonatomic) NSCache *cache; // @synthesize cache=_cache;
@property(nonatomic) _Bool isStart; // @synthesize isStart=_isStart;
@property(nonatomic) double preTime; // @synthesize preTime=_preTime;
@property(nonatomic) double totalTime; // @synthesize totalTime=_totalTime;
@property(retain, nonatomic) UIImage *curImage; // @synthesize curImage=_curImage;
@property(nonatomic) unsigned long long count; // @synthesize count=_count;
@property(retain, nonatomic) CADisplayLink *link; // @synthesize link=_link;
@property(nonatomic) unsigned long long maxCache; // @synthesize maxCache=_maxCache;
@property(nonatomic) unsigned long long repeatCount; // @synthesize repeatCount=_repeatCount;
@property(nonatomic) long long index; // @synthesize index=_index;
@property(nonatomic) double durition; // @synthesize durition=_durition;
@property(retain, nonatomic) NSArray *imagesPath; // @synthesize imagesPath=_imagesPath;
- (void).cxx_destruct;
- (void)dealloc;
@property(readonly, nonatomic) RACSignal *completedSignal;
- (void)displayLayer:(id)arg1;
- (long long)getCost:(id)arg1;
- (void)step:(id)arg1;
- (void)stop;
- (void)start;
- (id)initWithImagePaths:(id)arg1 durition:(double)arg2 repeatCount:(unsigned long long)arg3;

@end
