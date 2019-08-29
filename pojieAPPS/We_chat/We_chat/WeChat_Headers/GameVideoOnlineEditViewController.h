//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "MMUIViewController.h"

#import "GameVideoEditViewControllerDelegate-Protocol.h"
#import "NSURLSessionDataDelegate-Protocol.h"

@class MMProgressViewEx, MMWebImageView, NSData, NSString, NSURLSessionTask;

@interface GameVideoOnlineEditViewController : MMUIViewController <GameVideoEditViewControllerDelegate, NSURLSessionDataDelegate>
{
    NSString *_videoUrl;
    NSString *_thumbUrl;
    NSData *_videoData;
    CDUnknownBlockType _resultBlock;
    NSURLSessionTask *_currentTask;
    _Bool _isSkipCelluarTips;
    int _ssid;
    NSString *_appId;
    MMWebImageView *_imageView;
    MMProgressViewEx *_progressView;
    unsigned long long _downloadStartTimeMills;
}

@property(nonatomic) unsigned long long downloadStartTimeMills; // @synthesize downloadStartTimeMills=_downloadStartTimeMills;
@property(retain, nonatomic) MMProgressViewEx *progressView; // @synthesize progressView=_progressView;
@property(retain, nonatomic) MMWebImageView *imageView; // @synthesize imageView=_imageView;
@property(retain, nonatomic) NSString *appId; // @synthesize appId=_appId;
@property(nonatomic) int ssid; // @synthesize ssid=_ssid;
@property(nonatomic) _Bool isSkipCelluarTips; // @synthesize isSkipCelluarTips=_isSkipCelluarTips;
- (void).cxx_destruct;
- (id)reportObjWithPosition:(int)arg1 action:(int)arg2;
- (unsigned long long)calculateDownloadDuration;
- (id)buildTrackEventProps:(_Bool)arg1 moreAction:(CDUnknownBlockType)arg2;
- (void)trackEventDownloadFailed:(long long)arg1;
- (void)trackEventDownloadSucceed;
- (void)trackEventDownloadCancel;
- (void)trackEventExplosured;
- (void)gameVideoEditController:(id)arg1 didFailedWithError:(id)arg2;
- (void)gameVideoEditController:(id)arg1 didFinishWithFilePath:(id)arg2;
- (void)notifyErrorResult:(unsigned long long)arg1;
- (void)notifySucceedWithVideoInfo:(id)arg1;
- (void)handleCompositionFailed:(unsigned long long)arg1;
- (void)handleCompositionSucceed:(id)arg1;
- (void)startVideoEditor:(id)arg1;
- (void)handleDownloadCanceled;
- (void)handleDownloadFailed:(long long)arg1;
- (void)onClose;
- (void)handleDownloadFinished:(id)arg1 location:(id)arg2;
- (void)URLSession:(id)arg1 task:(id)arg2 didCompleteWithError:(id)arg3;
- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didFinishDownloadingToURL:(id)arg3;
- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didWriteData:(long long)arg3 totalBytesWritten:(long long)arg4 totalBytesExpectedToWrite:(long long)arg5;
- (void)URLSession:(id)arg1 dataTask:(id)arg2 didBecomeDownloadTask:(id)arg3;
- (void)URLSession:(id)arg1 dataTask:(id)arg2 didReceiveResponse:(id)arg3 completionHandler:(CDUnknownBlockType)arg4;
- (void)URLSession:(id)arg1 task:(id)arg2 willPerformHTTPRedirection:(id)arg3 newRequest:(id)arg4 completionHandler:(CDUnknownBlockType)arg5;
- (void)startDownloadVideo;
- (void)startWithVideoDataMode;
- (void)setupViews;
- (id)navigationBarBackgroundColor;
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewDidLoad;
- (_Bool)isVideoDataMode;
- (id)initWithVideoData:(id)arg1 andResultBlock:(CDUnknownBlockType)arg2;
- (id)initWithVideoUrl:(id)arg1 andThumb:(id)arg2 andResultBlock:(CDUnknownBlockType)arg3;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
