//
//  tema.h
//  wechatHook
//
//  Created by antion on 2017/9/23.
//
//

#import <Foundation/Foundation.h>

@interface tema : NSObject

//计算输赢
+(int) computeWinOrLose: (int)pow bet:(NSString*)bet num:(NSString*)num;

//pow转换为牌型名
+(NSString*) pow2card:(int)pow;

@end
