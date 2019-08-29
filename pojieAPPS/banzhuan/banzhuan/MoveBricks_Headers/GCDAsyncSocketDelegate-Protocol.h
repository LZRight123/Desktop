//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class EAccountGCDAsyncSocket, NSData, NSError, NSString;

@protocol GCDAsyncSocketDelegate <NSObject>

@optional
- (void)socket:(EAccountGCDAsyncSocket *)arg1 didReceiveTrust:(struct __SecTrust *)arg2 completionHandler:(void (^)(_Bool))arg3;
- (void)socketDidSecure:(EAccountGCDAsyncSocket *)arg1;
- (void)socketDidDisconnect:(EAccountGCDAsyncSocket *)arg1 withError:(NSError *)arg2;
- (void)socketDidCloseReadStream:(EAccountGCDAsyncSocket *)arg1;
- (double)socket:(EAccountGCDAsyncSocket *)arg1 shouldTimeoutWriteWithTag:(long long)arg2 elapsed:(double)arg3 bytesDone:(unsigned long long)arg4;
- (double)socket:(EAccountGCDAsyncSocket *)arg1 shouldTimeoutReadWithTag:(long long)arg2 elapsed:(double)arg3 bytesDone:(unsigned long long)arg4;
- (void)socket:(EAccountGCDAsyncSocket *)arg1 didWritePartialDataOfLength:(unsigned long long)arg2 tag:(long long)arg3;
- (void)socket:(EAccountGCDAsyncSocket *)arg1 didWriteDataWithTag:(long long)arg2;
- (void)socket:(EAccountGCDAsyncSocket *)arg1 didReadPartialDataOfLength:(unsigned long long)arg2 tag:(long long)arg3;
- (void)socket:(EAccountGCDAsyncSocket *)arg1 didReadData:(NSData *)arg2 withTag:(long long)arg3;
- (void)socket:(EAccountGCDAsyncSocket *)arg1 didConnectToHost:(NSString *)arg2 port:(unsigned short)arg3;
- (void)socket:(EAccountGCDAsyncSocket *)arg1 didAcceptNewSocket:(EAccountGCDAsyncSocket *)arg2;
@end
