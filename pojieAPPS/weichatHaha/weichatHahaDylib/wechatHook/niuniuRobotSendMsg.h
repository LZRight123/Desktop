//
//  niuniuRobotSendMsg.h
//  wechatHook
//
//  Created by antion on 2017/3/8.
//
//

#import <UIKit/UIKit.h>

@interface niuniuRobotSendMsg : NSObject {
    id mRoomContentLogicController;
    id mBaseMsgContentLogicController;
}

//添加发送任务
-(void) addTask:(NSString*)target type:(NSString*)type title:(NSString*)title content:(NSString*)content data:(NSData*)data image:(UIImage*)image at:(NSString*)at;

//发送消息
-(void) sendText:(NSString*)target content:(NSString*)content at:(NSString*)at title:(NSString*)title;
-(void) sendTextNow:(NSString*)target content:(NSString*)content at:(NSString*)at title:(NSString*)title;

//发送图片
-(void) sendPic:(NSString*)target img:(UIImage*)img;

//发送文件
-(void) sendFile:(NSString*)target title: (NSString*)title ext:(NSString*)ext data:(NSData*)data;

//发送第一条消息
-(void) doFirstTask;

//发送任务
@property(nonatomic, assign) NSMutableArray* mMsgTasks;

@end
