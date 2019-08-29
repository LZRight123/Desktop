//
//  niuniuRobotSendMsg.m
//  wechatHook
//
//  Created by antion on 2017/3/8.
//
//

#import "niuniuRobotSendMsg.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "wxFunction.h"
#import "ycFunction.h"
#import "toolManager.h"

@implementation niuniuRobotSendMsg

-(id) init {
    if (self = [super init]) {
        self.mMsgTasks = [@[] mutableCopy];
        mRoomContentLogicController = [[NSClassFromString(@"RoomContentLogicController") alloc] init];
        mBaseMsgContentLogicController = [[NSClassFromString(@"BaseMsgContentLogicController") alloc] init];
    }
    return self;
}

-(void) addTask:(NSString*)target type:(NSString*)type title:(NSString*)title content:(NSString*)content data:(NSData*)data image:(UIImage*)image at:(NSString*)at {
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"target"] = target;
    dic[@"type"] = type;
    if (title) {
        dic[@"title"] = title;
    }
    if (content) {
        dic[@"content"] = content;
    }
    if (data) {
        dic[@"data"] = data;
    }
    if (image) {
        dic[@"image"] = image;
    }
    if (at) {
        dic[@"at"] = at;
    }
    [self.mMsgTasks addObject:dic];
}

-(void) addTextTask:(NSString*)target content:(NSString*)content at:(NSString*)at title:(NSString*)title isNow:(BOOL)isNow{
    if (isNow) {
        [self do_sendText:target content:content at:at title:title];
    } else {
        [self.mMsgTasks addObject: @{
                                     @"type" : @"text",
                                     @"target" : target,
                                     @"content" : content,
                                     @"title" : title,
                                     @"at" : at ? at : @""
                                     }];
    }
}

-(void) sendText:(NSString*)target content:(NSString*)content at:(NSString*)at title:(NSString*)title isNow:(BOOL)isNow{
//    if ([content length] > 5000) {
//        NSArray* lines = [content componentsSeparatedByString: @"\n"];
//        int limit = 350;
//        if ([lines count] > limit) {//拆分
//            int count = 0;
//            NSMutableString* newStr = [NSMutableString string];
//            for (NSString* line in lines) {
//                [newStr appendFormat: @"%@\n", line];
//                if (++count >= limit) {
//                    [self addTextTask:target content:newStr at:at isNow:isNow];
//                    count = 0;
//                    newStr = [NSMutableString string];
//                }
//            }
//            if ([newStr length] > 0) {
//                [self addTextTask:target content:newStr at:at isNow:isNow];
//            }
//            return;
//        }
//    }
    [self addTextTask:target content:content at:at title:(NSString*)title isNow:isNow];
}

-(void) sendText:(NSString*)target content:(NSString*)content at:(NSString*)at title:(NSString*)title{
    [self sendText:target content:content at:at title:title isNow:NO];
}

-(void) sendTextNow:(NSString*)target content:(NSString*)content at:(NSString*)at title:(NSString*)title{
    [self sendText:target content:content at:at title:title isNow:YES];
}

-(void) do_sendText:(NSString*)target content:(NSString*)content at:(NSString*)at title:(NSString*)title {
    if ([content length] > 5000) {//信息过长的用文本文件
        if (!title || [title isEqualToString: @""]) {
            title = @"文本";
        }
        title = deString(@"%@.txt", title);
        [self sendFile:target title:title ext:@"txt" data:[content dataUsingEncoding:NSUTF8StringEncoding]];
        return;
    }

    if (at && [at isEqualToString: @""]) {
        at = nil;
    }
    id CMessageMgr = [wxFunction getMgr: @"CMessageMgr"];
    SEL sel = @selector(AddMsg:MsgWrap:);
    id (*action)(id, SEL, id, id) = (id (*)(id, SEL, id, id)) objc_msgSend;
    id CMessageWrap = [[NSClassFromString(@"CMessageWrap") alloc] initWithMsgType: 1];
    [ycFunction setVar:CMessageWrap name:@"m_nsToUsr" value:target];
    [ycFunction setVar:CMessageWrap name:@"m_nsContent" value:content];
    if (at) {
        [ycFunction setVar:CMessageWrap name:@"m_nsToUsr" value:target];
        [ycFunction setVar:CMessageWrap name:@"m_nsMsgSource" value:deString(@"<msgsource><atuserlist>%@</atuserlist></msgsource>", at)];
    }
    action(CMessageMgr, sel, target, CMessageWrap);
}

-(void) sendPic:(NSString*)target img:(UIImage*)img {
    id CMessageWrap = [mRoomContentLogicController FormImageMsg:target withImage:img];
    id CMessageMgr = [wxFunction getMgr: @"CMessageMgr"];
    {
        SEL sel = @selector(AddMsg:MsgWrap:);
        id (*action)(id, SEL, id, id) = (id (*)(id, SEL, id, id)) objc_msgSend;
        action(CMessageMgr, sel, target, CMessageWrap);
    }
}

-(void) sendFile:(NSString*)target title: (NSString*)title ext:(NSString*)ext data:(NSData*)data {
    int length = (int)[data length];
    id CExtendInfoOfAPP = [[NSClassFromString(@"CExtendInfoOfAPP") alloc] init];
    [ycFunction setVar:CExtendInfoOfAPP name:@"m_nsTitle" value:title];
    [ycFunction setVar:CExtendInfoOfAPP name:@"m_nsDesc" value:deString(@"%dk", length/1024)];
    [ycFunction setVar:CExtendInfoOfAPP name:@"m_nsAppFileExt" value:ext];
    [ycFunction setVarInt:CExtendInfoOfAPP name:@"m_uiAppMsgInnerType" value:6];
    [ycFunction setVarInt:CExtendInfoOfAPP name:@"m_uiAppDataSize" value:length];
    [ycFunction setVarInt:CExtendInfoOfAPP name:@"m_bIsForceUpdate" value:1];
    
    id CMessageWrap = [[NSClassFromString(@"CMessageWrap") alloc] initWithMsgType: 49];
    [ycFunction setVar:CMessageWrap name:@"m_nsToUsr" value:target];
    [ycFunction setVar:CMessageWrap name:@"m_extendInfoWithMsgType" value: CExtendInfoOfAPP];
    
    [ycFunction setVar:CExtendInfoOfAPP name:@"m_refMessageWrap" value:CMessageWrap];
    
    id CMessageMgr = [wxFunction getMgr: @"CMessageMgr"];
    SEL sel = @selector(AddAppMsg:MsgWrap:Data:Scene:);
    id (*action)(id, SEL, id, id, id, unsigned int) = (id (*)(id, SEL, id, id, id, unsigned int)) objc_msgSend;
    action(CMessageMgr, sel, target, CMessageWrap, data, 0);
}

//发送一条消息
-(void) doFirstTask {
    if ([self.mMsgTasks count] == 0) {
        return;
    }
    NSDictionary* dic = self.mMsgTasks[0];
    if ([dic[@"type"] isEqualToString: @"text"]) {
        [self do_sendText: dic[@"target"] content:dic[@"content"] at:dic[@"at"] title: dic[@"title"]];
    }
    else if([dic[@"type"] isEqualToString: @"txt"]) {
        [self sendFile: dic[@"target"] title: dic[@"title"] ext: @"txt" data: dic[@"data"]];
    }
    else if([dic[@"type"] isEqualToString: @"pic"]) {
        [self sendPic:dic[@"target"]  img: dic[@"image"]];
    }
    else if([dic[@"type"] isEqualToString: @"xls"]) {
        [self sendFile: dic[@"target"] title: dic[@"title"] ext: @"xls" data: dic[@"data"]];
    }
    [self.mMsgTasks removeObjectAtIndex:0];
}

@end
