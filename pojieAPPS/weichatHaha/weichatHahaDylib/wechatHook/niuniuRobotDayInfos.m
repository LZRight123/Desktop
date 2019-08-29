//
//  niuniuRobotDayInfos.m
//  wechatHook
//
//  Created by antion on 2017/11/28.
//
//

#import "niuniuRobotDayInfos.h"
#import "ycDefine.h"
#import "toolManager.h"
#import "ycFunction.h"

@implementation niuniuRobotDayInfos

-(id) init {
    if (self = [super init]) {
        self.mQunScoreCountDate = @"";
        self.mQunScoreCount = [@{} mutableCopy];
       
        [self performSelector:@selector(loadAll) withObject:nil afterDelay:.1];
    }
    return self;
}

-(void) loadAll {
    self.mQunScoreCountDate = [ycFunction getTodayDate];
    BOOL finded = NO;
    for (int i = (int)[tmanager.mRobot.mData.mScoreChangedRecords count]-1; i >=0 ; --i) {
        NSDictionary* dic = tmanager.mRobot.mData.mScoreChangedRecords[i];
        if (![dic[@"date"] hasPrefix: self.mQunScoreCountDate]) {
            if (finded) {
                break;
            }
            continue;
        }
        finded = YES;
        
        [self updateQunScoreCount: dic];
    }
}

//检测是否是新的一天
-(BOOL) checkNewDay {
    NSString* key = [ycFunction getTodayDate];
    NSDictionary* dic = tmanager.mRobot.mData.mDayInfosList[key];
    if (!dic) {
        tmanager.mRobot.mData.mDayInfosList[key] = [NSMutableDictionary dictionary];
        tmanager.mRobot.mData.mDayInfosList[key][@"scoreCount"] = @"unknow";
        tmanager.mRobot.mData.mDayInfosList[key][@"connectedUserids"] = [NSMutableDictionary dictionary];
        [tmanager.mRobot.mData saveDataInfos];
        return YES;
    }
    return NO;
}

//留分检测
-(void) checkPlayerScoreCount {
    if ([self checkNewDay]) {
        NSString* key = [ycFunction getLastdayDate];
        if (tmanager.mRobot.mData.mDayInfosList[key]) {
            tmanager.mRobot.mData.mDayInfosList[key][@"scoreCount"] = deInt2String([tmanager.mRobot.mMembers getAllScoreCountOnlyPlayer]);
            [tmanager.mRobot.mData saveDataInfos];
        }
    }
}


//获取留分, 小于0代表未知
-(int) getPlayerScore:(NSString*)date {
    NSDictionary* dic = tmanager.mRobot.mData.mDayInfosList[date];
    if (!dic) {
        return -1;
    }
    if ([dic[@"scoreCount"] isEqualToString: @"unknow"]) {
        return -2;
    }
    return [dic[@"scoreCount"] intValue];
}

//更新群上下分统计
-(void) updateQunScoreCount: (NSDictionary*)dic {
    NSString* key = dic[@"chatroom"];
    if ([dic[@"type"] isEqualToString: @"command"] && key) {
        if (![dic[@"date"] hasPrefix: self.mQunScoreCountDate]) {
            self.mQunScoreCountDate = [ycFunction getTodayDate];
            [self.mQunScoreCount removeAllObjects];
            if (![dic[@"date"] hasPrefix: self.mQunScoreCountDate]) {
                return;
            }
        }
        if (!self.mQunScoreCount[key]) {
            self.mQunScoreCount[key] = [NSMutableDictionary dictionary];
            self.mQunScoreCount[key][@"upCount"] = @"0";
            self.mQunScoreCount[key][@"downCount"] = @"0";
        }
        if (![tmanager.mRobot.mTuos isTuo: dic[@"userid"]]) {
            int change = [dic[@"newScore"] intValue]-[dic[@"oldScore"] intValue];
            if (change >= 0) {
                int value = [self.mQunScoreCount[key][@"upCount"] intValue];
                self.mQunScoreCount[key][@"upCount"] = deInt2String(value + abs(change));
            } else {
                int value = [self.mQunScoreCount[key][@"downCount"] intValue];
                self.mQunScoreCount[key][@"downCount"] = deInt2String(value + abs(change));
            }
        }
    }
}

//获取一个群的上下分统计
-(NSDictionary*) getQunUpScoreCount: (NSString*)chatroom {
    return self.mQunScoreCount[chatroom];
}

@end
