//
//  niuniuRobot.h
//  wechatHook
//
//  Created by antion mac on 2016/12/9.
//
//

#import <Foundation/Foundation.h>
#import "niuniuRobotResult.h"
#import "niuniuRobotBet.h"
#import "niuniuRobotMembers.h"
#import "niuniuRobotData.h"
#import "niuniuRobotAdmins.h"
#import "niuniuRobotTuos.h"
#import "niuniuRobotLashou.h"
#import "niuniuRobotLashouHead.h"
#import "niuniuRobotCommand.h"
#import "niuniuRobotSendMsg.h"
#import "niuniuRobotTimer.h"
#import "niuniuRobotPlayerCmd.h"
#import "niuniuRobotChatRoomInviteCheck.h"
#import "niuniuRobotDayInfos.h"
#import "niuniuRobotRework.h"

typedef enum {
    eNiuniuRobotStatusNone,
    eNiuniuRobotStatusBet,
    eNiuniuRobotStatusResult,
}eNiuniuRobotStatus;

@interface niuniuRobot : NSObject

-(NSString*) getIdentityStr:(NSString*)userid;

//绑定、解绑游戏群
-(void) bindGameRoom: (NSString*)room title:(NSString*)title;
-(void) unbindGameRoom;

//绑定、解绑后台群
-(BOOL) loadLastBackgroundData;
-(void) bindBackgroundRoom: (NSString*)room title:(NSString*)title;
-(void) unbindBackgroundRoom: (NSString*)room;
-(BOOL) isBackroundRoom: (NSString*)room;
-(NSDictionary*) getBackroundRoom: (NSString*)room;
-(BOOL) setBackgroundType: (NSString*)room type:(NSString*)type only:(BOOL)only;
-(BOOL) setBackgroundFunc:(NSString *)room func:(NSString *)func value:(BOOL)value only:(BOOL)only;
-(NSArray*) getBackgroundWithType:(NSString*)type;
-(NSArray*) getBackgroundWithFunc:(NSString*)func;
-(BOOL) getBackgroundIsType:(NSString*)room type:(NSString*)type;
-(BOOL) getBackgroundHasFunc:(NSString*)room func:(NSString*)func;
-(void) sortBackgrounds;

//修改上局
-(BOOL) frontRound;

//存档
-(void) savedResult;

//切换状态
-(void) changeStatus:(eNiuniuRobotStatus)status;

//CMessageWrap
-(void) addMsg:(id)msg isNew: (BOOL)isNew;

//撤回
-(void) revokeMsg: (NSString*)msgid;

//判断是否是红包
-(BOOL) parseIsHongbao:(NSString*)content;

//判断是否是下注
-(BOOL) parseBet:(NSString*)userid content:(NSString*)content outBetCount:(int*)outBetCount outValues:(NSArray**)outValues;

//游戏群id， 标题
@property(nonatomic, retain) NSString* mGameRoom;
@property(nonatomic, retain) NSString* mGameTitle;

//后台群
@property(nonatomic, assign) NSMutableArray* mBackroundRooms;

//是否开启牛牛玩法
@property(nonatomic, assign) BOOL mEnableNiuniu;

//是否开启龙虎玩法
@property(nonatomic, assign) BOOL mEnableLonghu;

//是否开启特码玩法
@property(nonatomic, assign) BOOL mEnableTema;

//是否开启百家乐
@property(nonatomic, assign) BOOL mEnableBaijiale;

//当前状态
@property(nonatomic, assign) eNiuniuRobotStatus mStatus;

//第几局
@property(nonatomic, assign) int mNumber;

//查询日期
@property(nonatomic, retain) NSString* mQueryDate;

//查询日期
@property(nonatomic, retain) NSString* mQueryDateForLashou;

//会员数据
@property(nonatomic, assign) niuniuRobotMembers* mMembers;

//管理
@property(nonatomic, assign) niuniuRobotAdmins* mAdmins;

//托
@property(nonatomic, assign) niuniuRobotTuos* mTuos;

//拉手
@property(nonatomic, assign) niuniuRobotLashou* mLashous;

//拉手
@property(nonatomic, assign) niuniuRobotLashouHead* mLashouHeads;

//押注数据
@property(nonatomic, assign) niuniuRobotBet* mBet;

//结算数据
@property(nonatomic, assign) niuniuRobotResult* mResult;

//玩家命令
@property(nonatomic, assign) niuniuRobotPlayerCmd* mPlayerCmd;

//命令
@property(nonatomic, assign) niuniuRobotCommand* mCommand;

//群邀请检查
@property(nonatomic, assign) niuniuRobotChatRoomInviteCheck* mInviteCheck;

//发送消息
@property(nonatomic, assign) niuniuRobotSendMsg* mSendMsg;

//定时器
@property(nonatomic, assign) niuniuRobotTimer* mTimer;

//每日数据
@property(nonatomic, assign) niuniuRobotDayInfos* mDayInfos;

//人为修改
@property(nonatomic, assign) niuniuRobotRework* mRework;

//数据中心
@property(nonatomic, assign) niuniuRobotData* mData;

@end
