//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MTLogPlugin.h"

@interface MTLogPluginPrefix : MTLogPlugin
{
    _Bool _initialized;
    _Bool _shouldSkipCurrentMessage;
}

+ (struct _NSRange)expectedNumberOfArgumentsForCommand:(id)arg1;
@property(nonatomic) _Bool shouldSkipCurrentMessage; // @synthesize shouldSkipCurrentMessage=_shouldSkipCurrentMessage;
- (void)postProcessLogMessage:(id)arg1 env:(id)arg2;
- (id)preProcessLogMessage:(id)arg1 env:(id)arg2;
- (void)willEnableForLog:(id)arg1;

@end

