//
//  baijiale.h
//  wechatHook
//
//  Created by antion on 2017/11/1.
//
//

#import <Foundation/Foundation.h>

@interface baijiale : NSObject

//牌型比较大小， -2代表认输
+(int) compareAmount:(int)player banker:(int)banker;

//计算输赢
+(int) computeWinOrLose: (int)player banker:(int)banker num:(int)num betType: (NSString*)betType;

//获取牌型
+(NSString*) getCardType: (int)player banker:(int)banker;

//是否是对
+(BOOL) isPair: (int)amount;

//是否和
+(BOOL) isTie: (int)player banker:(int)banker;

@end
