//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@interface LegicBlePluginKeychainFilesystem : NSObject
{
}

- (int)getBLEPluginSpecificErrorCode:(int)arg1;
- (void)deleteAllFiles:(id)arg1;
- (_Bool)fileExists:(id)arg1 storageGroup:(id)arg2 accessGroup:(id)arg3;
- (id)getFilenameWithWalletCustomerAppId:(id)arg1 qualifier:(int)arg2 storageGroup:(id)arg3 accessGroup:(id)arg4 error:(id *)arg5;
- (id)getWalletCustomerAppIdWithFilename:(id)arg1 storageGroup:(id)arg2 accessGroup:(id)arg3 error:(id *)arg4;
- (id)getInventory:(id)arg1 accessGroup:(id)arg2 error:(id *)arg3;
- (_Bool)deleteFile:(id)arg1 storageGroup:(id)arg2 accessGroup:(id)arg3 error:(id *)arg4;
- (_Bool)readFile:(id)arg1 storageGroup:(id)arg2 accessGroup:(id)arg3 data:(id *)arg4 error:(id *)arg5;
- (void)setWalletCustomerAppIdAndQualifier:(id)arg1 walletCustomerAppId:(id)arg2 qualifier:(int)arg3;
- (_Bool)writeFile:(id)arg1 filename:(id)arg2 walletCustomerAppId:(id)arg3 qualifier:(int)arg4 storageGroup:(id)arg5 accessGroup:(id)arg6 error:(id *)arg7;
- (id)getDefaultDictionary:(id)arg1 storageGroup:(id)arg2 accessGroup:(id)arg3;

@end
