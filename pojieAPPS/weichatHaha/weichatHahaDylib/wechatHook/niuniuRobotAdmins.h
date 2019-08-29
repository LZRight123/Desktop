//
//  niuniuRobotAdmins.h
//  wechatHook
//
//  Created by antion on 2017/2/23.
//
//

#import <Foundation/Foundation.h>

@interface niuniuRobotAdmins : NSObject

//添加管理员
-(void) addAdmin:(NSString*)userid;

//删除管理员
-(void) delAdmin:(NSString*)userid;

//是否管理员
-(BOOL) isAdmin:(NSString*)userid;

//获取权限个数
-(int) getPowerCount:(NSString*)userid;

//是否有权限
-(BOOL) hasPower:(NSString*)userid key:(NSString*)key;

//编辑权限
-(void) setPower:(NSString*)userid key:(NSString*)key isEnable:(BOOL)isEnable;

//设置所有权限
-(void) setAllPower:(NSString*)userid isEnable:(BOOL)isEnable;

//获取所有管理员
-(NSArray*) getAllAdminDetail;

//获取所有权限信息
-(NSArray*) getAllPowers;

@end
