//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSData, NSError, NSHTTPURLResponse, NSURLResponse;
@protocol NSTNAsyncDelegate, OS_dispatch_queue;

@interface NSTNAsyncConnection : NSObject
{
    NSHTTPURLResponse *responseSave;
    NSError *errorSave;
    _Bool _forceSynchronous;
    int _downloadInProgress;
    id <NSTNAsyncDelegate> delegate;
    NSURLResponse *_response;
    NSError *_error;
    NSObject<OS_dispatch_queue> *_asyncQueue;
    NSData *_downloadedData;
}

+ (id)createPostRequest:(id)arg1 withData:(id)arg2 url:(id)arg3 filename:(id)arg4;
@property int downloadInProgress; // @synthesize downloadInProgress=_downloadInProgress;
@property(retain, nonatomic) NSData *downloadedData; // @synthesize downloadedData=_downloadedData;
@property(retain) NSObject<OS_dispatch_queue> *asyncQueue; // @synthesize asyncQueue=_asyncQueue;
@property(retain) NSError *error; // @synthesize error=_error;
@property(retain) NSURLResponse *response; // @synthesize response=_response;
@property _Bool forceSynchronous; // @synthesize forceSynchronous=_forceSynchronous;
@property __weak id <NSTNAsyncDelegate> delegate; // @synthesize delegate;
- (void).cxx_destruct;
- (void)loadForcedSynchronousRequest:(id)arg1;
- (void)loadForcedSynchronousPostRequest:(id)arg1 postKeys:(id)arg2 withData:(id)arg3 filename:(id)arg4;
- (void)loadPostRequest:(id)arg1 postKeys:(id)arg2 withData:(id)arg3 filename:(id)arg4;
- (void)loadRequest:(id)arg1;
- (void)loadRequests:(id)arg1;
- (void)startRequest:(id)arg1;
- (id)initWithDelegate:(id)arg1 andQueue:(id)arg2;
- (id)initWithDelegate:(id)arg1;
- (id)init;

@end

