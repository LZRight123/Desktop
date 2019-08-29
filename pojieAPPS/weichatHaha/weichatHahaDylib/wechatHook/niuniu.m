//
//  niuniu.m
//  wechatHook
//
//  Created by antion on 2017/2/22.
//
//

#import "niuniu.h"
#import "ycDefine.h"
#import "toolManager.h"

@implementation niuniu

//牌型比较大小
+(int) compareAmount:(int)a b:(int)b bIsBanker:(BOOL)bIsBanker mianyong:(BOOL)mianyong yibi:(BOOL)yibi{
    a %= 1000;
    b %= 1000;
    
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;

    int pow1 = [niuniu amount2pow: a];
    
    int admitDefeatPow = [setting[mianyong ? @"admitDefeatPowForMianyong" : yibi ? @"admitDefeatPowForYibi" : @"admitDefeatPow"] intValue];
    if (bIsBanker && pow1 <= admitDefeatPow) {//牛几以下认输
        return -1;
    }
    
    int pow2 = [niuniu amount2pow: b];
    if (pow1 != pow2) {
        if ((pow1 == 13 && pow2 == 14) || (pow1 == 14 && pow2 == 13)) {//正顺、倒顺
            if ([setting[@"daoshunBiShunziDa"] isEqualToString: @"true"]) {
                return pow1 == 14 ? -1 : 1;
            } else if ([setting[@"shunziDaoshunCompareAmount"] isEqualToString: @"true"]) {
                return a > b ? 1 : a == b ? 0 : -1;
            }
        }
        return pow1 > pow2 ? 1 : -1;
    } else {
        int startComparePow;
        int daPingXiaoPeiPow;
        if (yibi) {
            startComparePow = [setting[@"startComparePowForYibi"] intValue];
            daPingXiaoPeiPow = [setting[@"daPingXiaoPeiPowForYibi"] intValue];
        } else if (mianyong) {
            startComparePow = [setting[@"startComparePowForMianyong"] intValue];
            daPingXiaoPeiPow = [setting[@"daPingXiaoPeiPowForMianyong"] intValue];
        } else {
            startComparePow = [setting[@"startComparePow"] intValue];
            daPingXiaoPeiPow = [setting[@"daPingXiaoPeiPow"] intValue];
        }
        if (bIsBanker) {
            if (pow1 < startComparePow) {//牛几开始比
                return -1;
            }
            if (pow1 <= daPingXiaoPeiPow) {//牛几大平小赔
                if (a >= b) {
                    return 0;
                } else {
                    return -1;
                }
            }
        }
        BOOL isSameMeonyPlayerWin = [setting[@"sameMoneyPlayerWin"] isEqualToString: @"true"];
        if(isSameMeonyPlayerWin && bIsBanker && a == b) {//同金额闲赢
            return 1;
        }
    }
    if (pow1 == 12) {//对子
        int a2 = a%10;
        int b2 = b%10;
        if (a2 != b2) {
            return a2 > b2 ? 1 : -1;
        }
    }

    return a > b ? 1 : a == b ? 0 : -1;
}

//金额转换成倍数
+(int) amount2pow:(int)amout {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    int d1, d2, d3;
    d1 = amout/100%10;
    d2 = amout/10%10;
    d3 = amout%10;
    
    if (d1 == d2 && d2 == d3) {
        if ([setting[@"powEnableBaozi"] isEqualToString: @"true"]) {
            return 18;
        }
    }
    if (d2 == 0 && d3 == 0) {
        if ([setting[@"powEnableManniu"] isEqualToString: @"true"]) {
            return 15;
        }
    }
    if (d2-d1 == 1 && d3-d2 == 1 && (d1 != 0 || [setting[@"012shunzi"] isEqualToString: @"true"])) {
        if ([setting[@"powEnableShunzi"] isEqualToString: @"true"]) {
            return 14;
        }
    }
    if (d1-d2 == 1 && d2-d3 == 1 && (d3 != 0 || [setting[@"210daoshun"] isEqualToString: @"true"])) {
        if ([setting[@"powEnableDaoshun"] isEqualToString: @"true"]) {
            return 13;
        }
    }
    if (d2 == d3 && (d1 == 0 || ![setting[@"0duizi"] isEqualToString: @"true"])) {
        if ([setting[@"powEnableDuizi"] isEqualToString: @"true"]) {
            return 12;
        }
    }
    if (d1 == 0 && d3 == 0) {
        if ([setting[@"powEnableJinniu"] isEqualToString: @"true"]) {
            return 11;
        }
    }
    int pow = (d1+d2+d3) % 10;
    return pow == 0 ? 10 : pow;
}

//获取补贴倍数
+(float) pow2heshuiSubsidy:(int)pow {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if (pow <= 10) {
        return [setting[deString(@"heshuiSubsidyNiu%d", pow)] floatValue];
    }
    if (11 == pow) {
        return [setting[@"heshuiSubsidyJinniu"] floatValue];;
    }
    else if (12 == pow) {
        return [setting[@"heshuiSubsidyDuizi"] floatValue];;
    }
    else if (13 == pow) {
        return [setting[@"heshuiSubsidyDaoshun"] floatValue];;
    }
    else if (14 == pow) {
        return [setting[@"heshuiSubsidyShunzi"] floatValue];;
    }
    else if (15 == pow) {
        return [setting[@"heshuiSubsidyManniu"] floatValue];;
    }
    else if (18 == pow) {
        return [setting[@"heshuiSubsidyBaozi"] floatValue];
    }
    return 0;
}

//pow转换为正式的倍数
+(float) factPow: (int)pow {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if (pow <= 10) {
        return [setting[deString(@"powNiu%d", pow)] floatValue];
    }
    if (11 == pow) {
        return [setting[@"powJinniu"] floatValue];;
    }
    else if (12 == pow) {
        return [setting[@"powDuizi"] floatValue];;
    }
    else if (13 == pow) {
        return [setting[@"powDaoshun"] floatValue];;
    }
    else if (14 == pow) {
        return [setting[@"powShunzi"] floatValue];;
    }
    else if (15 == pow) {
        return [setting[@"powManniu"] floatValue];;
    }
    else if (18 == pow) {
        return [setting[@"powBaozi"] floatValue];
    }
    return pow;
}

//pow转换为正式的倍数
+(float) factPowBanker: (int)pow {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if (pow <= 10) {
        return [setting[deString(@"powBankerNiu%d", pow)] floatValue];
    }
    if (11 == pow) {
        return [setting[@"powBankerJinniu"] floatValue];;
    }
    else if (12 == pow) {
        return [setting[@"powBankerDuizi"] floatValue];;
    }
    else if (13 == pow) {
        return [setting[@"powBankerDaoshun"] floatValue];;
    }
    else if (14 == pow) {
        return [setting[@"powBankerShunzi"] floatValue];;
    }
    else if (15 == pow) {
        return [setting[@"powBankerManniu"] floatValue];;
    }
    else if (18 == pow) {
        return [setting[@"powBankerBaozi"] floatValue];
    }
    return pow;
}

//pow转换为正式的倍数(梭哈闲赢)
+(float) factPowForSuoha: (int)pow {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if (pow <= 10) {
        return [setting[deString(@"powSuohaNiu%d", pow)] floatValue];
    }
    if (11 == pow) {
        return [setting[@"powSuohaJinniu"] floatValue];;
    }
    else if (12 == pow) {
        return [setting[@"powSuohaDuizi"] floatValue];;
    }
    else if (13 == pow) {
        return [setting[@"powSuohaDaoshun"] floatValue];;
    }
    else if (14 == pow) {
        return [setting[@"powSuohaShunzi"] floatValue];;
    }
    else if (15 == pow) {
        return [setting[@"powSuohaManniu"] floatValue];;
    }
    else if (18 == pow) {
        return [setting[@"powSuohaBaozi"] floatValue];
    }
    return pow;
}

//pow转换为正式的倍数(梭哈庄赢)
+(float) factPowForSuohaBanker: (int)pow {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if (pow <= 10) {
        return [setting[deString(@"powSuohaBankerNiu%d", pow)] floatValue];
    }
    if (11 == pow) {
        return [setting[@"powSuohaBankerJinniu"] floatValue];;
    }
    else if (12 == pow) {
        return [setting[@"powSuohaBankerDuizi"] floatValue];;
    }
    else if (13 == pow) {
        return [setting[@"powSuohaBankerDaoshun"] floatValue];;
    }
    else if (14 == pow) {
        return [setting[@"powSuohaBankerShunzi"] floatValue];;
    }
    else if (15 == pow) {
        return [setting[@"powSuohaBankerManniu"] floatValue];;
    }
    else if (18 == pow) {
        return [setting[@"powSuohaBankerBaozi"] floatValue];
    }
    return pow;
}

//pow转换为正式的倍数(免佣)
+(float) factPowForMianyong: (int)pow {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if (pow <= 10) {
        return [setting[deString(@"powMianyongNiu%d", pow)] floatValue];
    }
    if (11 == pow) {
        return [setting[@"powMianyongJinniu"] floatValue];;
    }
    else if (12 == pow) {
        return [setting[@"powMianyongDuizi"] floatValue];;
    }
    else if (13 == pow) {
        return [setting[@"powMianyongDaoshun"] floatValue];;
    }
    else if (14 == pow) {
        return [setting[@"powMianyongShunzi"] floatValue];;
    }
    else if (15 == pow) {
        return [setting[@"powMianyongManniu"] floatValue];;
    }
    else if (18 == pow) {
        return [setting[@"powMianyongBaozi"] floatValue];
    }
    return pow;
}

//pow转换为正式的倍数(免佣庄)
+(float) factPowForMianyongBanker: (int)pow {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if (pow <= 10) {
        return [setting[deString(@"powMianyongBankerNiu%d", pow)] floatValue];
    }
    if (11 == pow) {
        return [setting[@"powMianyongBankerJinniu"] floatValue];;
    }
    else if (12 == pow) {
        return [setting[@"powMianyongBankerDuizi"] floatValue];;
    }
    else if (13 == pow) {
        return [setting[@"powMianyongBankerDaoshun"] floatValue];;
    }
    else if (14 == pow) {
        return [setting[@"powMianyongBankerShunzi"] floatValue];;
    }
    else if (15 == pow) {
        return [setting[@"powMianyongBankerManniu"] floatValue];;
    }
    else if (18 == pow) {
        return [setting[@"powMianyongBankerBaozi"] floatValue];
    }
    return pow;
}

//pow转换为正式的倍数(一比)
+(float) factPowForYibi: (int)pow {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if (pow <= 10) {
        return [setting[deString(@"powYibiNiu%d", pow)] floatValue];
    }
    if (11 == pow) {
        return [setting[@"powYibiJinniu"] floatValue];;
    }
    else if (12 == pow) {
        return [setting[@"powYibiDuizi"] floatValue];;
    }
    else if (13 == pow) {
        return [setting[@"powYibiDaoshun"] floatValue];;
    }
    else if (14 == pow) {
        return [setting[@"powYibiShunzi"] floatValue];;
    }
    else if (15 == pow) {
        return [setting[@"powYibiManniu"] floatValue];;
    }
    else if (18 == pow) {
        return [setting[@"powYibiBaozi"] floatValue];
    }
    return pow;
}

//pow转换为正式的倍数(一比庄)
+(float) factPowForYibiBanker: (int)pow {
    NSDictionary* setting = tmanager.mRobot.mData.mBaseSetting;
    if (pow <= 10) {
        return [setting[deString(@"powYibiBankerNiu%d", pow)] floatValue];
    }
    if (11 == pow) {
        return [setting[@"powYibiBankerJinniu"] floatValue];;
    }
    else if (12 == pow) {
        return [setting[@"powYibiBankerDuizi"] floatValue];;
    }
    else if (13 == pow) {
        return [setting[@"powYibiBankerDaoshun"] floatValue];;
    }
    else if (14 == pow) {
        return [setting[@"powYibiBankerShunzi"] floatValue];;
    }
    else if (15 == pow) {
        return [setting[@"powYibiBankerManniu"] floatValue];;
    }
    else if (18 == pow) {
        return [setting[@"powYibiBankerBaozi"] floatValue];
    }
    return pow;
}

//0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣
+(NSString*) amount2emoji:(int)amount {
    int d1, d2, d3;
    d1 = amount/100%10;
    d2 = amount/10%10;
    d3 = amount%10;
    NSArray* strs = @[@"0️⃣", @"1️⃣", @"2️⃣", @"3️⃣", @"4️⃣", @"5️⃣", @"6️⃣", @"7️⃣", @"8️⃣", @"9️⃣"];
    NSMutableString* ret = [NSMutableString string];
    [ret appendString: strs[d1]];
    [ret appendString: strs[d2]];
    [ret appendString: strs[d3]];
    return ret;
}

//pow转字符串
+(NSString*) pow2string: (int)pow {
    if (pow >= 1 && pow <= 9) {
        return deString(@"牛%d", pow);
    }
    else if (10 == pow) {
        return @"牛牛";
    }
    else if (11 == pow) {
        return @"金牛";
    }
    else if (12 == pow) {
        return @"对子";
    }
    else if (13 == pow) {
        return @"倒顺";
    }
    else if (14 == pow) {
        return @"顺子";
    }
    else if (15 == pow) {
        return @"满牛";
    }
    else if (18 == pow) {
        return @"豹子";
    }
    
    return deInt2String(pow);
}


@end
