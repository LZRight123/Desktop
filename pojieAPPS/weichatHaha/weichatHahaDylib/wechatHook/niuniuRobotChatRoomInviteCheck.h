//
//  niuniuRobotChatRoomInviteCheck.h
//  wechatHook
//
//  Created by antion on 2017/8/14.
//
//

#import <Foundation/Foundation.h>

@interface niuniuRobotChatRoomInviteCheck : NSObject

//获取数据群
-(NSString*) getChatroom;

//绑定群
-(void) bindChatroom;

//有人邀请进群
-(void) addInviteMsg:(NSString*)content;

//每局播报
-(void) roundReport;

//定时处理任务
-(void) handleTasks;

//过滤
-(void) filter:(int)listid isCancel:(BOOL)isCancel;

//查过滤
-(void) checkFilter;

@end
