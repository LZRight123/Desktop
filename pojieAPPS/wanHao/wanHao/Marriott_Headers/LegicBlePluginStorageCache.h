//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class LegicBlePluginKeyDataInfo, LegicBlePluginStorageManager, NSString;

@interface LegicBlePluginStorageCache : NSObject
{
    NSString *_filename;
    LegicBlePluginStorageManager *_storage;
    NSString *_accessGroup;
    LegicBlePluginKeyDataInfo *_keyDataInfo;
    _Bool _useCache;
}

- (void).cxx_destruct;
- (id)get_walletCustomerAppId:(id *)arg1;
- (id)get_qualifier:(id *)arg1;
- (_Bool)selectFile:(id)arg1 error:(id *)arg2;
- (id)get_derive_info:(id *)arg1;
- (id)get_RW_Key:(id *)arg1;
- (id)get_RO_Key:(id *)arg1;
- (unsigned long long)get_file_length:(id *)arg1;
- (unsigned long long)get_file_size:(id *)arg1;
- (_Bool)write:(id)arg1 offset:(unsigned long long)arg2 error:(id *)arg3;
- (id)read:(unsigned long long)arg1 offset:(unsigned long long)arg2 error:(id *)arg3;
- (void)invalidate;
- (_Bool)vaild:(id)arg1;
- (id)init;

@end

