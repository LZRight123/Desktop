//
//  niuniuRobotCommand.h
//  wechatHook
//
//  Created by antion on 2017/3/8.
//
//

#import <UIKit/UIKit.h>

@interface niuniuRobotCommand : NSObject

-(void) addMsg:(id)msg isNew: (BOOL)isNew;

//财务定制端
-(NSString*) financeContentParse: (NSString*)content sayerUserid:(NSString*)sayerUserid sayerName:(NSString*)sayerName hasPower:(BOOL)hasPower fromUsr:(NSString*)fromUsr;

//导出所有数据
-(void) exportAllData: (NSString*)target;

//生成积分变化字符串
-(NSString*) newScoreChangedMsg: (int)oldScore memData:(NSDictionary*)memData from:(NSString*)from chatroom:(NSString*)chatroom;

//是否能下分
-(NSString*) canDownScore: (int)downScore memData:(NSDictionary*)memData from:(NSString*)from;

//生成流水字符串
-(NSString*) newTotalInfo:(int)start end:(int)end;

//查询所有拉手
-(NSString*) newAllLashou;

//查询所有拉手名单
-(NSString*) newAllLashouNames;

//查询指定拉手
-(NSString*) newLashouMembers:(NSString*)userid name:(NSString*)name queryDate:(NSString*)queryDate;

//生成拉手排行榜
-(NSString*) newLashouTops:(NSString*)userid name:(NSString*)name;

//生成玩家下注信息
-(NSString*) newPlayerBetInfo:(NSDictionary*)memData queryDate:(NSString*)queryDate;

//生成玩家输赢信息
-(NSString*) newPlayerResultInfo:(NSDictionary*)memData queryDate:(NSString*)queryDate;

//查托名单
-(NSString*) queryAllTuoMembers;

//查托点包
-(NSString*) queryAllTuoAmount: (int)back start:(int)start end:(int)end;

//托分清零
-(NSString*) clearAllTuoScore;

//生成上下分纪录
-(NSString*) newUpScoreRecords:(NSDictionary*)memData queryDate:(NSString*)queryDate;

//生成龙虎概率
-(NSString*) newLonghuChance;

//查输赢排行榜
-(NSString*) newWinOrLoseTop: (BOOL)showTuo onlyPlayer:(BOOL)onlyPlayer;

//获取查询日期
-(NSString*) getQueryDate;

//设置查询日期
-(NSString*) setQueryDate:(int)date;

//获取查询日期
-(NSString*) getQueryDateForLashou;

//设置查询日期
-(NSString*) setQueryDateForLashou:(int)date;

//托自助上下分
-(NSString*) tuoSelfChangeScore:(NSString*)userid name:(NSString*)name value:(int)value;

//批量添加托
-(NSString*) batchAddTuo:(NSString*)fromUsr;

//最后一句参与玩家奖励分数
-(NSString*) lastRoundPlayerAddScore:(int)value sayerUserid:(NSString*)sayerUserid sayerName:(NSString*)sayerName;

//搜索
-(NSString*) searchPlayer: (NSString*)keyworld sayerUserid:(NSString*)sayerUserid sayerName:(NSString*)sayerName isAdmin: (BOOL)isAdmin;

//查指定局数信息
-(NSString*) lookRound: (int)number;

//查所有上下分
-(NSString*) queryAllScoreChanged;

//查管理上下分
-(void) queryAdminScoreChanged:(NSDictionary*)memData target: (NSString*)target replyType:(NSString*)replyType;

//添加、删除拉手
-(NSString*) addLashou: (NSDictionary*)memData sayerName:(NSString*)sayerName isRemove: (BOOL)isRemove;

//将名片那个人从原来拉手名下移除。
-(NSString*) delLashouPlayer: (NSDictionary*)memData sayerName:(NSString*)sayerName;

//添加、删除团长
-(NSString*) addLashouHead: (NSDictionary*)memData sayerName:(NSString*)sayerName isRemove: (BOOL)isRemove;

//将名片那个人从原来团长名下移除。
-(NSString*) delLashouHeadLashou: (NSDictionary*)memData sayerName:(NSString*)sayerName;

//批量添加团长成员
-(NSString*) batchAddLashouHeadMember:(NSString*)fromUsr memData:(NSDictionary*)memData;

//查团长成员
-(NSString*) newLashouHeadTops:(NSString*)userid name:(NSString*)name;

//查团长流水
-(NSString*) newLashouHeadMembers:(NSString*)userid name:(NSString*)name;

//查明细
-(UIImage*) queryPlayerAllDetail:(NSDictionary*)memData;

//清理低分
-(NSString*) clearLowScores: (int)score;

//查询所有可用命令
-(NSString*) newAllCommandString;

//测试口令
-(NSString*) test;

//反水奖励
-(void) queryPlayerBack: (NSString*)target diffTuo:(BOOL)diffTuo;
-(NSString*) exePlayerBack:(NSString*)sayerUserid sayerName:(NSString*)sayerName isCancel:(BOOL)isCancel;

//输分奖励
-(void) queryLoseBonus: (NSString*)target diffTuo:(BOOL)diffTuo;
-(NSString*) exeLoseBonus:(NSString*)sayerUserid sayerName:(NSString*)sayerName isCancel:(BOOL)isCancel;

//局数奖励
-(void) queryRoundBonus: (NSString*)target diffTuo:(BOOL)diffTuo;
-(NSString*) exeRoundBonus:(NSString*)sayerUserid sayerName:(NSString*)sayerName isCancel:(BOOL)isCancel;

//集齐奖励
-(void) queryCollectBonus: (NSString*)target diffTuo:(BOOL)diffTuo;
-(NSString*) exeCollectBonus:(NSString*)sayerUserid sayerName:(NSString*)sayerName isCancel:(BOOL)isCancel;

//查修改
-(void) chaxiugai: (NSString*)target day:(int)day;

//查点数
-(void) chadianshu: (NSString*)target;
    
//查庄同点杀概率
-(void) chatongdianzhuangshagailv:(NSString*)target pow:(int)pow;

//查所有上下分明细
-(void) chasuoyoushangxiafenmingxi: (NSString*)target;

//查所有群上下分
-(void) chasuoyouqunshangxiafen: (NSString*)target;

//清理档案
-(void) qinglidangan:(NSString*)target;

@end
