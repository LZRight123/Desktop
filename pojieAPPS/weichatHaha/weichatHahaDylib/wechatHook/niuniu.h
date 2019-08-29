//
//  niuniu.h
//  wechatHook
//
//  Created by antion on 2017/2/22.
//
//

#import <Foundation/Foundation.h>

@interface niuniu : NSObject

//牌型比较大小
+(int) compareAmount:(int)a b:(int)b bIsBanker:(BOOL)bIsBanker mianyong:(BOOL)mianyong yibi:(BOOL)yibi;

//金额转换成倍数
+(int) amount2pow:(int)amout;

//获取补贴倍数
+(float) pow2heshuiSubsidy:(int)pow;

//pow转换为正式的倍数(闲赢)
+(float) factPow: (int)pow;

//pow转换为正式的倍数(庄赢)
+(float) factPowBanker: (int)pow;

//pow转换为正式的倍数(梭哈闲赢)
+(float) factPowForSuoha: (int)pow;

//pow转换为正式的倍数(梭哈庄赢)
+(float) factPowForSuohaBanker: (int)pow;

//pow转换为正式的倍数(免佣闲)
+(float) factPowForMianyong: (int)pow;

//pow转换为正式的倍数(免佣庄)
+(float) factPowForMianyongBanker: (int)pow;

//pow转换为正式的倍数(一比闲)
+(float) factPowForYibi: (int)pow;

//pow转换为正式的倍数(一比庄)
+(float) factPowForYibiBanker: (int)pow;

//0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣
+(NSString*) amount2emoji:(int)amount;

//pow转字符串
+(NSString*) pow2string: (int)pow;

@end
