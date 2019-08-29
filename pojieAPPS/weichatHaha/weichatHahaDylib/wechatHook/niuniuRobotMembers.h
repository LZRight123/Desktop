//
//  niuniuRobotMembers.h
//  wechatHook
//
//  Created by antion on 2017/2/23.
//
//

#import <UIKit/UIKit.h>

#define deFillName(name) [niuniuRobotMembers formatAndfillName: name]
@interface niuniuRobotMembers : NSObject

//不足4个字自动填充空白
+(NSString*) formatAndfillName:(NSString*)str;

//格式化名字
+(NSString*) formatName:(NSString*)str;

//生成备注
+(NSString*) newRemark: (NSDictionary*)dic;

//根据红包名字返回index
+(NSString*) name2index: (NSString*)name;

//更新所有名字
-(void) updateAllName;

//添加会员
-(NSString*) addMember: (NSString*)userid billName: (NSString*)billName;

//删除会员
-(NSString*) delMember: (NSString*)userid;

//修改会员名字
-(NSString*) renameMemberBillName: (NSString*)userid billName: (NSString*)billName;

//上下分, 设置分
-(BOOL) addScore:(NSString*)userid score:(int)score isSet:(BOOL)isSet params:(NSDictionary*)params;

//清空所有会员积分
-(void) clearAllScore;

//获取某个会员的积分
-(int) getMemberScore: (NSString*)userid;

//获取某个会员
-(NSMutableDictionary*) getMember: (NSString*)userid;

//获取某个会员
-(NSDictionary*) getMemberWithEncodeUserid: (NSString*)encodeUserid;

//获取某个会员
-(NSDictionary*) getMemberWithIndex: (NSString*)index;

//获取某个会员(测试或免备注模式使用)
-(NSDictionary*) getMemberWithName: (NSString*)name;

//搜索会员名片
-(NSArray*) searchMember: (NSString*)keyworld;

//获取总积分
-(int) getAllScoreCount;

//获取总积分, 玩家
-(int) getAllScoreCountOnlyPlayer;

//格式序号
-(NSString*) numFormat:(int)num;

//获取积分榜字符串
-(NSString*) getTopStr: (BOOL)showTuo onlyPlayer:(BOOL)onlyPlayer onlyTuo:(BOOL)onlyTuo;

//出单
-(void) showTop;

//出图片单
-(UIImage*) showPicTop:(UIView*)resultView;

//获取所有真玩家
-(NSArray*) getMembersOnlyPlayer;

//获取所有会员列表, sortType: index/socre
-(NSArray*) getAllMembers: (NSString*)sortType filterText:(NSString*)filterText;

//获取正常会员列表, sortType: index/socre
-(NSArray*) getNormalMembers: (NSString*)sortType;

//获取有会员无好友列表, sortType: index/socre
-(NSArray*) getNullFriendMembers: (NSString*)sortType;

//获取有好友无会员列表
-(NSArray*) getNullMembers;

//最后一次账单
@property(nonatomic, retain) NSString* mLastTopText;

@end
