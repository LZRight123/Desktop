//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSMutableDictionary, NSString;

@interface ADBTargetLocationRequest : NSObject
{
    NSString *_name;
    NSString *_defaultContent;
    NSMutableDictionary *_parameters;
}

@property(retain, nonatomic) NSMutableDictionary *parameters; // @synthesize parameters=_parameters;
@property(retain, nonatomic) NSString *defaultContent; // @synthesize defaultContent=_defaultContent;
@property(retain, nonatomic) NSString *name; // @synthesize name=_name;
- (void)dealloc;
- (id)init;

@end

