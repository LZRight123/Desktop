//
//  tema.m
//  wechatHook
//
//  Created by antion on 2017/9/23.
//
//

#import "tema.h"
#import "toolManager.h"
#import "ycDefine.h"

@implementation tema

//计算输赢
+(int) computeWinOrLose: (int)pow bet:(NSString*)bet num:(NSString*)num {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    BOOL temaHeBackHalf = [setting[@"temaHeBackHalf"] isEqualToString: @"true"];
    int numNeed = (int)bet.length * [num intValue];
    if (pow > 10) {
        return temaHeBackHalf ? -numNeed/2 : -numNeed;
    }
    if (pow == 10) {
        pow = 0;
    }
    if ([bet containsString: deInt2String(pow)]) {
        return [num intValue] * [setting[@"powTema"] floatValue] - numNeed;
    }
    return -numNeed;
}

//pow转换为牌型名
+(NSString*) pow2card:(int)pow {
    if (pow >= 1 && pow <= 9) {
        return deString(@"特%d", pow);
    }
    if (10 == pow) {
        return @"特0";
    }
    return @"合";
}

@end
