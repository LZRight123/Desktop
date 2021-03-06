//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "NSObject-Protocol.h"

@class IMYDaduModel, NSArray, RACSignal;

@protocol IMYDaduSyncService <NSObject>
+ (RACSignal *)getDaduShareURL;
+ (RACSignal *)uploadImageToServerWithData:(IMYDaduModel *)arg1;
+ (RACSignal *)updateLocal;
+ (RACSignal *)deleteToServerWithData:(NSArray *)arg1;
+ (RACSignal *)uploadToServerWithImageData:(IMYDaduModel *)arg1;
+ (RACSignal *)uploadToServerWithData:(NSArray *)arg1;
@end

