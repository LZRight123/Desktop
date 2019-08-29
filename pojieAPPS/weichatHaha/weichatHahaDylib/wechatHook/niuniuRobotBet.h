//
//  niuniuRobotBet.h
//  wechatHook
//
//  Created by antion on 2017/2/23.
//
//

#import <Foundation/Foundation.h>

@protocol niuniuRobotBetDelegate <NSObject>
@optional
-(void) hasPlayerBet;
-(void) hasBetRemoved;
-(void) betHasChanged:(NSString*)userid;
-(void) bankerInfoChanged;
-(void) headInfoChanged;

@end

@interface niuniuRobotBet : NSObject

//来自已有数据
-(void) loadWithRoundData: (NSDictionary*)dic;

//开始下注
-(void) startBet: (NSString*)type value:(id)value;

//取消下注(返回)
-(void) cancelBet;

//结束下注
-(NSString*) endBet;

//准备
-(BOOL) ready;

//出押注单
-(void) showBill;

//报
-(void) sendLimit;

//@无效人员
-(void) atInvalid;

//重新加载下注列表
-(BOOL) reloadBetList;

//清理下注数据
-(void) clearBetData: (BOOL)clearBanker;

//添加一个庄
-(BOOL) addBanker:(NSString*)userid name:(NSString*)name;

//删除一个庄
-(void) removeBankerWithIndex:(int)index;

//设置庄费
-(void) setBankerFee:(NSMutableDictionary*)dic num:(int)num;

//设置是否抽水
-(void) setIsRatio:(BOOL)b;

//获取庄家
-(NSMutableDictionary*) getBanker:(NSString*)userid;

//获取主庄家
-(NSMutableDictionary*) getMainBanker;

//设置主庄家
-(void) setMainBanker:(NSMutableDictionary*)dic;

//获取总庄费
-(int) getAllBankerFee;

//删除下注
-(void) removeBetWithIndex:(int)index;

//玩家下注
-(void) playerBet:(NSString*)name userid:(NSString*)userid num:(int)num values:(NSArray*)values content:(NSString*)content from:(NSString*)from;

//撤回
-(void) revokeBet: (NSString*)msgid;

//设置玩家下注值
-(void) setBetNum:(NSMutableDictionary*)dic num:(int)num values:(NSArray*)values;

//设置押注值
-(void) setBetValues: (NSMutableDictionary*)dic values:(NSArray*)values;

//设置下注是否有效
-(void) setBetValid:(int)index valid:(BOOL)valid;

//获取某个人的所有下注索引
-(NSArray*) betIndexs:(NSString*)userid;

//获取重复个数
-(int) getRepeatBetCount;

//获取托下注个数
-(int) getTuoBetCount;

//一键导入
-(NSString*) importPlayers: (NSString*)billText;

//代理
@property(nonatomic, assign) id<niuniuRobotBetDelegate> mDelegate;

//庄家
@property(nonatomic, assign) NSMutableArray* mBankers;

//玩家下注
@property(nonatomic, assign) NSMutableArray* mPlayerBets;

//玩家有效下注
@property(nonatomic, assign) NSMutableArray* mPlayerBetsValid;

//玩家无效下注
@property(nonatomic, assign) NSMutableArray* mPlayerBetsInvalid;

//福利庄设置
@property(nonatomic, assign) NSMutableDictionary* mFuliSetting;

//有效下注积分统计
@property(nonatomic, assign) NSInteger mBetScoreCount;

//有效梭哈积分统计
@property(nonatomic, assign) NSInteger mBetScoreSuohaCount;

//有效龙虎下注统计
@property(nonatomic, assign) NSInteger mBetScoreLonghuCount;

//有效龙虎和下注统计
@property(nonatomic, assign) NSInteger mBetScoreLonghuHeCount;

//特码下注统计
@property(nonatomic, assign) NSInteger mBetScoreTemaCount;

//百家乐下注统计
@property(nonatomic, assign) NSInteger mBetScoreBaijialeCount;

//有效下注个数统计(含庄)
@property(nonatomic, assign) NSInteger mBetRecordCount;

//无效下注个数统计
@property(nonatomic, assign) NSInteger mInvalidBetRecordCount;

//记录是否出过单
@property(nonatomic, assign) NSMutableDictionary* mShowBillRecords;

//限制下注
@property(nonatomic, assign) int mLimitBet;
@property(nonatomic, assign) int mLimitSuohaBet;
@property(nonatomic, assign) int mLimitLonghuBet;
@property(nonatomic, assign) int mLimitLonghuHeBet;
@property(nonatomic, assign) int mLimitTema;
@property(nonatomic, assign) int mLimitBaijiale;

//是否抽水
@property(nonatomic, assign) BOOL mIsRatio;

//是否已经出了单
@property(nonatomic, assign) BOOL mIsShowBilled;

//最后一次账单
@property(nonatomic, retain) NSString* mLastBillText;

//最后一次金额，人数
@property(nonnull, retain) NSString* mLastPlayerCountAndAmountText;

@end
