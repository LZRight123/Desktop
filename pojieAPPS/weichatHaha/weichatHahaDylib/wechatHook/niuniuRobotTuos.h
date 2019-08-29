//
//  niuniuTuos.h
//  wechatHook
//
//  Created by antion on 2017/4/4.
//
//

#import <Foundation/Foundation.h>

@interface niuniuRobotTuos : NSObject

//添加托
-(void) addTuoQuick:(NSString*)userid;
-(NSString*) addTuo:(NSString*)userid;

//删除托
-(void) delTuo:(NSString*)userid;

//删除曾经是托的记录
-(void) delEverTuo:(NSString*)userid;

//是否托
-(BOOL) isTuo:(NSString*)userid;

//是否曾经是托
-(BOOL) isEverTuo:(NSString*)userid;

//获取托总数
-(int) getTuoCount;

//获取所有托
-(NSArray*) getAllTuoDetail: (BOOL)everTuo sortType: (NSString*)sortType;

@end
