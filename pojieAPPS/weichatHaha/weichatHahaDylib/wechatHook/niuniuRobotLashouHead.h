//
//  niuniuRobotLashouHead.h
//  wechatHook
//
//  Created by antion on 2017/11/10.
//
//

#import <Foundation/Foundation.h>

@interface niuniuRobotLashouHead : NSObject

//添加拉手团长
-(void) addLashouHead:(NSString*)userid;

//删除拉手团长
-(void) delLashouHead:(NSString*)userid;

//获取拉手成员人数
-(int) getLashouHeadMemberCount:(NSString*)userid;

//是否是拉手团长
-(BOOL) isLashouHead:(NSString*)userid;

//添加拉手
-(NSString*) addLashou:(NSString*)userid lashou:(NSString*)lashou;
-(NSString*) addLashou:(NSString*)userid lashou:(NSString*)lashou isSave:(BOOL)isSave;

//删除拉手
-(NSString*) delLashou:(NSString*)userid lashou:(NSString*)lashou;

//获取拉手归属哪个团长
-(NSDictionary*) getLashouHeadWithLashou:(NSString*)lashou;

//是否是指定团长的成员
-(BOOL) isFromlashouHead: (NSString*)userid lashou:(NSString*)lashou;

//拉手团长转移
-(BOOL) lashouHeadMove: (NSString*)userid destUserid:(NSString*)destUserid;

//获取指定拉手团长名下所有成员, sortType: index/membersCount
-(NSMutableArray*) getAllLashouHeadMemberDetail:(NSString*)userid sortType: (NSString*)sortType;

//获取所有拉手团长
-(NSMutableArray*) getAllLashouHeadDetail;

@end
