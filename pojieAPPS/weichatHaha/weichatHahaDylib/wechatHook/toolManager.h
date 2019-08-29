//
//  toolManager.h
//  wechatHook
//
//  Created by antion on 16/11/12.
//
//

#import <Foundation/Foundation.h>
#import "niuniuRobot.h"
#import "toolWindows.h"

#define tmanager [toolManager getInst]
@interface toolManager : NSObject

+(toolManager*) getInst;

-(id) init;

//收到一条新消息
-(void) asyncOnAddMsg:(id)arg1 arg2:(id)arg2;

//撤回消息
-(void) onRevokeMsg:(id)msg;

//收到一个红包
-(void) recvHongbao:(id)arg1;

//清空红包数据
-(void) clearHongbaoData;

//开始启动牛牛机器人
-(void) startNiuniuRobot;

//关闭机器人
-(void) stopNiuniuRobot;

@property(nonatomic, assign) niuniuRobot* mRobot;
@property(nonatomic, assign) toolWindows* mWindows;
@property(nonatomic, assign) NSMutableDictionary* mLastHongbaoDetail;


@end
