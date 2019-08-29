//
//  niuniuRobotLashou.h
//  wechatHook
//
//  Created by antion on 2017/3/8.
//
//

#import <Foundation/Foundation.h>

@interface niuniuRobotLashou : NSObject

//添加拉手
-(void) addLashou:(NSString*)userid;

//删除拉手
-(void) delLashou:(NSString*)userid;

//获取拉手成员人数
-(int) getLashouMemberCount:(NSString*)userid;

//是否是拉手
-(BOOL) isLashou:(NSString*)userid;

//添加拉手成员
-(NSString*) addPlayer:(NSString*)userid player:(NSString*)player;

//删除拉手成员
-(NSString*) delPlayer:(NSString*)userid player:(NSString*)player;

//获取玩家归属哪个拉手
-(NSDictionary*) getLashouWithPlayer:(NSString*)player;

//是否是指定拉手的成员
-(BOOL) isFromlashou: (NSString*)userid player:(NSString*)player;

//拉手转移
-(BOOL) lashouMove: (NSString*)userid destUserid:(NSString*)destUserid;

//获取所有拉手
-(NSMutableArray*) getAllLashouDetail;

//获取所有拉手下的成员
-(NSArray*) getAllLashouMemberDetail:(NSString*)userid sortType: (NSString*)sortType;

@end
