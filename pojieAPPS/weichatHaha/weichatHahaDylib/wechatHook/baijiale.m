//
//  baijiale.m
//  wechatHook
//
//  Created by antion on 2017/11/1.
//
//

#import "baijiale.h"
#import "ycDefine.h"
#import "niuniu.h"
#import "toolManager.h"

@implementation baijiale

//牌型比较大小， -2代表认输
+(int) compareAmount:(int)player banker:(int)banker{
    player %= 1000;
    banker %= 1000;
    
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    
    int pow1 = [niuniu amount2pow: player];
    int pow2 = [niuniu amount2pow: banker];
    if (pow1 != pow2) {
        if ((pow1 == 13 && pow2 == 14) || (pow1 == 14 && pow2 == 13)) {//正顺、倒顺
            if ([setting[@"daoshunBiShunziDa"] isEqualToString: @"true"]) {
                return pow1 == 14 ? -1 : 1;
            } else if ([setting[@"shunziDaoshunCompareAmount"] isEqualToString: @"true"]) {
                return player > banker ? 1 : player == banker ? 0 : -1;
            }
        }
        return pow1 > pow2 ? 1 : -1;
    } else {
        if (pow1 < [setting[@"baijialeStartCompare"] intValue]) {
            return -2;
        }
    }
    if (pow1 == 12) {//对子
        int a2 = player%10;
        int b2 = banker%10;
        if (a2 != b2) {
            return a2 > b2 ? 1 : -1;
        }
    }
    return player > banker ? 1 : player == banker ? 0 : -1;
}

//计算输赢
+(int) computeWinOrLose: (int)player banker:(int)banker num:(int)num betType: (NSString*)betType {    
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if ([betType isEqualToString: @"庄"] || [betType isEqualToString: @"闲"]) {
        int ret = [baijiale compareAmount:player banker:banker];
        if (-2 == ret) {//认输
            return -num;
        } else if (ret > 0) {
            if ([betType isEqualToString: @"闲"]) {
                return num*[setting[@"baijialePowXian"] floatValue];
            } else {
                return -num;
            }
        } else if (ret < 0) {
            if ([betType isEqualToString: @"庄"]) {
                return num*[setting[@"baijialePowZhuang"] floatValue];
            } else {
                return -num;
            }
        }
        return 0;
    }
    else if ([betType isEqualToString: @"和"]) {
        if ([baijiale isTie:player banker:banker]) {
            return num*[setting[@"baijialePowTie"] floatValue];
        } else {
            return -num;
        }
    }
    else if ([betType isEqualToString: @"庄对"]) {
        if ([baijiale isPair: banker]) {
            return num*[setting[@"baijialePowZhuangPair"] floatValue];
        } else {
            return -num;
        }
    }
    else if ([betType isEqualToString: @"闲对"]) {
        if ([baijiale isPair: player]) {
            return num*[setting[@"baijialePowXianPair"] floatValue];
        } else {
            return -num;
        }
    }
    return 0;
}

//获取牌型
+(NSString*) getCardType: (int)player banker:(int)banker {
    NSMutableString* ret = [NSMutableString string];
    int compareRet = [baijiale compareAmount:player banker:banker];
    if (compareRet == -1) {
        [ret appendString: @"庄赢"];
    }
    else if (compareRet == 1) {
        [ret appendString: @"闲赢"];
    }

    if ([baijiale isTie:player banker:banker]) {
        if (ret.length > 0) {
            [ret appendString: @"/"];
        }
        [ret appendString: @"和"];
    }
//    
//    if ([baijiale isPair:player]) {
//        if (ret.length > 0) {
//            [ret appendString: @"/"];
//        }
//        [ret appendString: @"闲对"];
//    }
//    
//    if ([baijiale isPair:banker]) {
//        if (ret.length > 0) {
//            [ret appendString: @"/"];
//        }
//        [ret appendString: @"庄对"];
//    }
    return ret;
}

//是否是对
+(BOOL) isPair: (int)amount {
    return amount/10%10 == amount%10;
}

//是否和
+(BOOL) isTie: (int)player banker:(int)banker {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    int pow1 = [niuniu amount2pow: player];
    int pow2 = [niuniu amount2pow: banker];
    if (pow1 == pow2) {
        return YES;
    }
    if ((pow1 == 13 && pow2 == 14) || (pow1 == 14 && pow2 == 13)) {//正顺、倒顺
        return [setting[@"powDaoshun"] intValue] == [setting[@"powShunzi"] intValue];
    }
    return NO;
}

@end
