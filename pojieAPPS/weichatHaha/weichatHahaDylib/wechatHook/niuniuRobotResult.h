//
//  niuniuRobotResult.h
//  wechatHook
//
//  Created by antion on 2017/2/20.
//
//

#import <UIKit/UIKit.h>

@protocol niuniuRobotResultDelegate <NSObject>
@optional
-(void) resultSaved;
-(void) autoQueryHongbaoEnd;
-(void) stopAutoQueryHongbao;
@end

@interface niuniuRobotResult : NSObject

-(void) loadWithRoundData: (NSDictionary*)dic;
-(void) setHongbaoData:(NSDictionary*)dic;
-(BOOL) setMount: (NSMutableDictionary*)dic mount:(int)mount;
-(BOOL) setResultHandle: (NSMutableDictionary*)dic type:(NSString*)type;
-(NSString*) amountStr:(int)amout;
-(NSString*) genReport;

//保存红包消息数据
-(void) saveHongbaoMsg:(id)msg;

//清除红包消息数据
-(void) clearHongbaoMsg;

//设置是否自动获取红包
-(void) setIsAutoQueryHongbao:(BOOL)value;

//手动查询红包
-(void) manualQueryHongbao;

//关闭红包窗口检测
-(void) closeHongbaoWindowCheck;

//接收红包状态
-(void) recvHongbaoStatus: (NSDictionary*)dic;

//接收红包详情
-(void) recvHongbaoDetail;

//认尾
-(void) asLast:(NSMutableDictionary*)dic;
-(void) setLastAmount: (int)amount index:(int)index;

//自定义认尾
-(void) setCustomAsLastEnable:(BOOL)enable;
-(void) setCustomAsLastType:(NSString*)type;
-(void) setCustomAsLastMax:(int)max;
-(void) setPass100Need:(BOOL)pass100need;
-(void) setCustomAsLastPlayerIndex:(int)index;
-(void) setCustomAsLastBankerIndex:(int)index;
-(void) setCustomHeadAmount: (int)amount;
-(void) updateCustomAsLast;

//是否开启自动查询红包
@property(nonatomic, assign) BOOL mEnableAutoQueryHongbao;

@property(nonatomic, assign) id<niuniuRobotResultDelegate> mDelegate;

@property(nonatomic, assign) NSMutableArray* mNullHongbao;
@property(nonatomic, assign) NSMutableArray* mRobHongbao;
@property(nonatomic, assign) NSMutableArray* mTimeover;
@property(nonatomic, assign) NSMutableArray* mBanker;
@property(nonatomic, assign) NSMutableArray* mNormal;
@property(nonatomic, assign) NSMutableDictionary* mReport;
@property(nonatomic, assign) NSMutableDictionary* mCustomAsLast;
@property(nonatomic, assign) NSMutableArray* mLastAmounts;

@property(nonatomic, assign) long long mMinSecond;
@property(nonatomic, assign) long long mMaxSecond;
@property(nonatomic, assign) BOOL mLastIsOvertime;
@property(nonatomic, assign) BOOL mOvertimeNoWin;
@property(nonatomic, assign) BOOL mRobNoWin;
@property(nonatomic, assign) BOOL mResetSeriesWin;
@property(nonatomic, assign) BOOL mHasHongbaoData;
@property(nonatomic, assign) int mTotalAmount;
@property(nonatomic, assign) int mResetBonusPool;

@end
