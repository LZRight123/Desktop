//
//  longhu.h
//  wechatHook
//
//  Created by antion on 2017/3/24.
//
//

#import <Foundation/Foundation.h>

@interface longhu : NSObject

//计算输赢
+(int) computeWinOrLose: (NSString*)card num:(int)num betType: (NSString*)betType;

//pow转换为牌型名
+(NSString*) pow2card:(int)pow;

@end
