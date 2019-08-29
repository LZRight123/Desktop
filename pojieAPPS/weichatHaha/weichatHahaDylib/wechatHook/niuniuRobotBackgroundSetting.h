//
//  robotBackgroundSetting.h
//  wechatHook
//
//  Created by antion on 2017/11/26.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

@interface niuniuRobotBackgroundSetting : UIView<UITableViewDataSource, UITableViewDelegate>

-(id) initWithChatroom:(CGRect)frame chatroom:(NSString*)chatroom;

@property(nonatomic, assign) UILabel* mTitle;
@property(nonatomic, copy) funcEnd mBackFunc;
@property (assign, nonatomic) UIViewController* mSuperViewVC;

@end
