//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSDate;

@interface YBBToolsVaccinumManager : NSObject
{
    _Bool _isSync;
    NSDate *_savedBabyBirthday;
}

+ (id)getVaccinumByVid:(unsigned long long)arg1;
+ (id)sharedManager;
+ (void)load;
@property(nonatomic) _Bool isSync; // @synthesize isSync=_isSync;
@property(retain, nonatomic) NSDate *savedBabyBirthday; // @synthesize savedBabyBirthday=_savedBabyBirthday;
- (void).cxx_destruct;
- (void)initVaccinumList:(id)arg1;
- (id)alertStringWithTime:(long long)arg1 noticeTime:(long long)arg2;
- (void)showMarkCompleteAnimation;
- (_Bool)isCompleteBabyMonths:(id)arg1;
- (void)checkMarkCompletionActionWithMonth:(long long)arg1;
- (unsigned long long)updateVaccinum:(id)arg1 mark:(_Bool)arg2;
- (void)postVaccinumsUploadWithParameters:(id)arg1 handler:(CDUnknownBlockType)arg2;
- (void)uploadChangeOfUserData;
- (void)getVaccinumDataWithType:(int)arg1 extraInfo:(id)arg2 handler:(CDUnknownBlockType)arg3;
- (void)getVaccinumDetailWithID:(long long)arg1 handler:(CDUnknownBlockType)arg2;
- (void)getVaccinumSimplifyList:(CDUnknownBlockType)arg1;
- (void)getVaccinumUserList:(CDUnknownBlockType)arg1;
- (void)getVaccinumList:(CDUnknownBlockType)arg1;
- (id)getVaccinumNotifyList;
- (id)loadLocalVaccinumList;
- (void)saveVaccinumDataWithVaccinum:(id)arg1 isSync:(_Bool)arg2;
- (void)saveVaccinumList:(id)arg1 withIsSync:(_Bool)arg2;
- (void)saveVaccinumList:(id)arg1;
- (id)getRecentVaccinumByTimestamp:(long long)arg1;
- (void)refreshVaccinumListWithNewBabyBirthday;
- (id)init;

@end

