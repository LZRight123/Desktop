//
//  niuniuRobotData.h
//  wechatHook
//
//  Created by antion on 2017/2/28.
//
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface niuniuRobotData : NSObject

//会员数据
@property(nonatomic, assign) NSMutableDictionary* mMemberList;

//保存上下分纪录
@property(nonatomic, assign) NSMutableArray* mScoreChangedRecords;

//管理员数据
@property(nonatomic, assign) NSMutableDictionary* mAdminList;

//托数据
@property(nonatomic, assign) NSMutableDictionary* mTuoList;

//拉手数据
@property(nonatomic, assign) NSMutableDictionary* mLashouList;

//拉手团长数据
@property(nonatomic, assign) NSMutableDictionary* mLashouHeadList;

//保存每个回合的数据
@property(nonatomic, assign) NSMutableArray* mRounds;

//进群检测数据
@property(nonatomic, assign) NSMutableDictionary* mChatroomInviteList;

//每日一些数据保存(存分、大小号)
@property(nonatomic, assign) NSMutableDictionary* mDayInfosList;

//机器人为修改机器
@property(nonatomic, assign) NSMutableArray* mReworksList;

//设置
@property(nonatomic, assign) NSMutableDictionary* mBaseSetting;

//保存回合数据
-(NSString*) saveCurrentRound;

//删除上一局
-(NSDictionary*) removeLastRound;

//最后一局局数
-(int) lastRoundNumber;

//最多能存储局数
-(int) maxSaveRound;

//保存会员数据
-(void) saveMemberListFile;

//保存上下分纪录
-(void) saveScoreChangedRecordsFile;

//保存管理员数据
-(void) saveAdminListFile;

//保存托数据
-(void) saveTuoListFile;

//保存拉手数据
-(void) saveLashouListFile;

//保存拉手数据
-(void) saveLashouHeadListFile;

//保存回合数据
-(void) saveRoundFile;

//恢复默认设置
-(void) setBaseSettingDefault;

//保存每天数据
-(void) saveDataInfos;

//保存机器人为修改记录
-(void) saveReworksFile;

//保存基本设置
-(void) saveBaseSettingFile;

//保存账单广告图
-(void) saveBillHeadPic: (UIImage*)img;

//获取账单广告图
-(UIImage*) getBillHeadPic;

//保存账单走势图背景图
-(void) saveBillTrendPic: (UIImage*)img;

//获取账单走势图背景图
-(UIImage*) getBillTrendPic;

//保存后台群
-(void) saveBackgroundChatroom:(NSArray*)array;

//获取缓存保存后台群
-(NSArray*) getBackgroundChatroom;

//保存群邀请数据
-(void) saveChatroomInviteListFile;

//删除部分回合数据
-(int) clearPartRounds:(int)endRoundNum;

//清空回合
-(void) clearRounds;

//删除部分上下分记录
-(int) clearPartScoreChangedRecords:(int)endRoundNum;

//清空上下分纪录
-(void) clearScoreChangedRecords;

//清空会员积分数据
-(void) clearMemberScores;

//清空会员数据
-(void) clearMembers;

//清空管理
-(void) clearAdmins;

//清空托
-(void) clearTuos;

//清空拉手
-(void) clearLashous;

//清空拉手团长
-(void) clearLashouHeads;

//备份所有数据到聊天框
-(void) bakAllFiles2Chat;

//从zip路径恢复所有数据
-(void) resumeAllFilesFromZip:(NSString*)zipPath;

//获取所有文件
-(NSArray*) allDataFileNames;

//删除所有文件缓存
-(void) removeAllDataFile;


@end
