//
//  niuniuRobotPlayerCmd.h
//  wechatHook
//
//  Created by antion on 2017/8/6.
//
//

#import <Foundation/Foundation.h>

@interface niuniuRobotPlayerCmd : NSObject

-(void) addMsg:(id)msg;


@property(nonatomic, assign) NSMutableDictionary* mPlayerLastQuery;

@end
