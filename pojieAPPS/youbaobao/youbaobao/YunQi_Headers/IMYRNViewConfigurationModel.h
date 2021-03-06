//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSDictionary, NSString;

@interface IMYRNViewConfigurationModel : NSObject
{
    _Bool _isShareBridge;
    NSString *_convertKey;
    NSString *_sourceURL;
    NSDictionary *_params;
    NSString *_bundleURL;
    NSString *_bundleFileName;
    NSString *_moduleName;
    struct CGRect _rnFrame;
}

@property(nonatomic) struct CGRect rnFrame; // @synthesize rnFrame=_rnFrame;
@property(copy, nonatomic) NSString *moduleName; // @synthesize moduleName=_moduleName;
@property(copy, nonatomic) NSString *bundleFileName; // @synthesize bundleFileName=_bundleFileName;
@property(copy, nonatomic) NSString *bundleURL; // @synthesize bundleURL=_bundleURL;
@property(nonatomic) _Bool isShareBridge; // @synthesize isShareBridge=_isShareBridge;
@property(copy, nonatomic) NSDictionary *params; // @synthesize params=_params;
@property(copy, nonatomic) NSString *sourceURL; // @synthesize sourceURL=_sourceURL;
@property(copy, nonatomic) NSString *convertKey; // @synthesize convertKey=_convertKey;
- (void).cxx_destruct;
- (void)analysisRawParams:(id)arg1;
- (id)initWithRawParams:(id)arg1;

@end

