//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class OWUuidPairItem;

@interface OWUdidManager : NSObject
{
    OWUuidPairItem *_deviceUuidPair;
}

+ (id)defaultManager;
- (void).cxx_destruct;
- (id)uuidForKeychainKey:(id)arg1 service:(id)arg2;
- (int)setUuid:(id)arg1 forKeychainKey:(id)arg2 inService:(id)arg3;
- (id)keychainItemForKey:(id)arg1 service:(id)arg2;
- (_Bool)setUuid:(id)arg1 forUserDefaultsKey:(id)arg2;
- (id)uuidForUserDefaultsKey:(id)arg1;
@property(retain, nonatomic) OWUuidPairItem *deviceUuidPair; // @synthesize deviceUuidPair=_deviceUuidPair;

@end

