//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import "JPUSHReportRequest.h"

@class NSString;

@interface JPUSHMessageReportRequest : JPUSHReportRequest
{
    unsigned short _messageStateType;
    int _flag;
    NSString *_messageID;
}

@property(readonly, nonatomic) int flag; // @synthesize flag=_flag;
@property(readonly, nonatomic) NSString *messageID; // @synthesize messageID=_messageID;
@property(readonly, nonatomic) unsigned short messageStateType; // @synthesize messageStateType=_messageStateType;
- (void).cxx_destruct;
- (void)setResponseBlock;
- (_Bool)packData;
- (void)setActiveType:(int)arg1 messageID:(id)arg2 flag:(int)arg3;
- (id)init;

@end

