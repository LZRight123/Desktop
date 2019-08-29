//
//  longhu.m
//  wechatHook
//
//  Created by antion on 2017/3/24.
//
//

#import "longhu.h"
#import "toolManager.h"
#import "ycDefine.h"

@implementation longhu

//计算输赢
+(int) computeWinOrLose: (NSString*)card num:(int)num betType: (NSString*)betType {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    BOOL longhuHeBackHalf = [setting[@"longhuHeBackHalf"] isEqualToString: @"true"];
    if ([betType isEqualToString: @"大"] || [betType isEqualToString: @"小"] || [betType isEqualToString: @"单"] || [betType isEqualToString: @"双"]) {
        if ([card containsString: betType]) {
            return num*[setting[@"powLonghuDaXiaoDanShuang"] floatValue];
        }
        if (longhuHeBackHalf) {
            return [card isEqualToString: @"合"] ? -num/2 : -num;
        } else {
            return -num;
        }
    }
    else if ([betType isEqualToString: @"小单"] || [betType isEqualToString: @"大双"]) {
        if ([card isEqualToString: betType]) {
            return num*[setting[@"powLonghuDaXiaoDanShuangZuhe3"] floatValue];
        }
        if (longhuHeBackHalf) {
            return [card isEqualToString: @"合"] ? -num/2 : -num;
        } else {
            return -num;
        }
    }
    else if ([betType isEqualToString: @"大单"] || [betType isEqualToString: @"小双"]) {
        if ([card isEqualToString: betType]) {
            return num*[setting[@"powLonghuDaXiaoDanShuangZuhe2"] floatValue];
        }
        if (longhuHeBackHalf) {
            return [card isEqualToString: @"合"] ? -num/2 : -num;
        } else {
            return -num;
        }
    }
    else if([betType isEqualToString: @"合"]) {
        if ([card isEqualToString: betType]) {
            return num*[setting[@"powLonghuHe"] floatValue];
        }
        return -num;
    }
    return 0;
}

//pow转换为牌型名
+(NSString*) pow2card:(int)pow {
    if (pow >= 1 && pow <= 10) {
        NSMutableString* ret = [NSMutableString string];
        if (pow <= 5) {
            [ret appendString: @"小"];
        } else {
            [ret appendString: @"大"];
        }
        if (pow % 2 == 0) {
            [ret appendString: @"双"];
        } else {
            [ret appendString: @"单"];
        }
        return ret;
    }
    return @"合";
}

@end
