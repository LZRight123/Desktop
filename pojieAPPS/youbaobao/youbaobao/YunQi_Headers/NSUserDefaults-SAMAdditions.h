//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/NSUserDefaults.h>

@interface NSUserDefaults (SAMAdditions)
+ (id)sam_signatureSalt;
+ (void)sam_setSignatureSalt:(id)arg1;
- (id)sam_signatureKeyForKey:(id)arg1;
- (id)sam_signatureForObject:(id)arg1 key:(id)arg2;
- (void)sam_setSignedURL:(id)arg1 forKey:(id)arg2;
- (void)sam_setSignedBool:(_Bool)arg1 forKey:(id)arg2;
- (void)sam_setSignedDouble:(double)arg1 forKey:(id)arg2;
- (void)sam_setSignedFloat:(float)arg1 forKey:(id)arg2;
- (void)sam_setSignedInteger:(long long)arg1 forKey:(id)arg2;
- (id)sam_signedURLForKey:(id)arg1;
- (_Bool)sam_signedBoolForKey:(id)arg1;
- (double)sam_signedDoubleForKey:(id)arg1;
- (float)sam_signedFloatForKey:(id)arg1;
- (long long)sam_signedIntegerForKey:(id)arg1;
- (id)sam_signedStringForKey:(id)arg1;
- (id)sam_signedDataForKey:(id)arg1;
- (id)sam_signedDictionaryForKey:(id)arg1;
- (id)sam_signedArrayForKey:(id)arg1;
- (void)sam_removeSignedObjectForKey:(id)arg1;
- (void)sam_setSignedObject:(id)arg1 forKey:(id)arg2;
- (id)sam_signedObjectForKey:(id)arg1;
@end

