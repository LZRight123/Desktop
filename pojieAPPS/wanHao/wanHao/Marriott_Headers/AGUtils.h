//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@interface AGUtils : NSObject
{
}

+ (id)cryptOperation:(unsigned int)arg1 data:(id)arg2 keyString:(id)arg3 ivString:(id)arg4;
+ (id)decrypt:(id)arg1 key:(id)arg2 iv:(id)arg3;
+ (id)encrypt:(id)arg1 key:(id)arg2 iv:(id)arg3;
+ (_Bool)isStateBlockCacheAvail;
+ (id)loadStateBlock;
+ (_Bool)saveStateBlock:(id)arg1;
+ (id)stateBlockCacheFilePath;
+ (_Bool)isNetworkReachable:(id)arg1;
+ (id)computeSignature:(id)arg1 uuid:(id)arg2;
+ (id)computeHashWithData:(id)arg1 hashKey:(id)arg2 uuid:(id)arg3;
+ (id)computeHashWithURL:(id)arg1 hashKey:(id)arg2 uuid:(id)arg3;
+ (id)getEncodedSDKVersion;
+ (id)getDataFromBodyStream:(id)arg1;
+ (int)secondsHavePassed:(id)arg1 and:(id)arg2;
+ (id)randomBytesWithLength:(int)arg1;
+ (id)hmacFromData:(id)arg1 secret:(id)arg2;
+ (id)getUTCFormatDate:(id)arg1;
+ (id)arrayToJSON:(id)arg1;
+ (id)base64EncodeData:(id)arg1;

@end

