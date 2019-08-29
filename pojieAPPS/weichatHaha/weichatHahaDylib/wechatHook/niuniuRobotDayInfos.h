//
//  niuniuRobotDayInfos.h
//  wechatHook
//
//  Created by antion on 2017/11/28.
//
//

#import <Foundation/Foundation.h>

@interface niuniuRobotDayInfos : NSObject {
    
}

@property(nonatomic, retain) NSString* mQunScoreCountDate;
@property(nonatomic, assign) NSMutableDictionary* mQunScoreCount;

-(void) loadAll;

//检测是否是新的一天
-(BOOL) checkNewDay;

//留分检测
-(void) checkPlayerScoreCount;

//获取留分, 小于0代表未知
-(int) getPlayerScore:(NSString*)date;

//更新群上下分统计
-(void) updateQunScoreCount: (NSDictionary*)dic;

//获取一个群的上下分统计
-(NSDictionary*) getQunUpScoreCount: (NSString*)chatroom;

@end
