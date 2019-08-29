//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

#import <OfferWallBase/NSStreamDelegate-Protocol.h>

@class NSData, NSInputStream, NSMutableArray, NSMutableData, NSOutputStream, NSString;
@protocol OS_dispatch_queue;

@interface XGLiteSocket : NSObject <NSStreamDelegate>
{
    NSObject<OS_dispatch_queue> *task_queue;
    NSMutableData *readBuf;
    _Bool readHeaderComplete;
    _Bool readComplete;
    NSInputStream *inputStream;
    NSOutputStream *outStream;
    _Bool isConnecting;
    _Bool isSending;
    NSData *magic;
    NSData *ver;
    NSData *config;
    long long bodyLen;
    NSMutableArray *jsonEventsQueue;
    NSMutableArray *sendCallbackQueue;
    long long tryReconnectNum;
    id _jsonEvents;
    CDUnknownBlockType _sendCallback;
}

+ (id)getInstance;
@property(copy, nonatomic) CDUnknownBlockType sendCallback; // @synthesize sendCallback=_sendCallback;
@property(retain, nonatomic) id jsonEvents; // @synthesize jsonEvents=_jsonEvents;
- (void).cxx_destruct;
- (_Bool)isSocketEnabled;
- (void)handleSendError;
- (void)stream:(id)arg1 handleEvent:(unsigned long long)arg2;
- (void)startSocket:(id)arg1 callback:(CDUnknownBlockType)arg2;
- (_Bool)isEqualToMagic:(id)arg1;
- (void)handleBodyResult:(id)arg1 configData:(id)arg2;
- (id)filterBodyData:(id)arg1 configData:(id)arg2;
- (void)cleanUpStream:(id)arg1;
- (void)closeBuffer;
- (void)tcpRequest:(id)arg1;
- (id)getSendData:(id)arg1;
- (void)sendEvent:(id)arg1 callback:(CDUnknownBlockType)arg2;
- (void)send:(id)arg1 callback:(CDUnknownBlockType)arg2;
- (void)sendData;
- (void)initConfig;
- (void)initVer;
- (void)initMagic;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
