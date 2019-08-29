//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import "IMYLanguageActionProtocol-Protocol.h"

@class NSMutableArray;

@interface IMYLanguageChangedAction : NSObject <IMYLanguageActionProtocol>
{
    id _weakObject;
    NSMutableArray *_blocks;
}

+ (id)actionWithWeakObject:(id)arg1;
@property(retain, nonatomic) NSMutableArray *blocks; // @synthesize blocks=_blocks;
@property(nonatomic) __weak id weakObject; // @synthesize weakObject=_weakObject;
- (void).cxx_destruct;
- (void)actionBlocks;
- (void)removeActionBlockWithFilter:(CDUnknownBlockType)arg1;
- (void)removeActionBlockForKey:(id)arg1;
- (void)addActionBlock:(CDUnknownBlockType)arg1 forKey:(id)arg2;
- (id)init;

@end
