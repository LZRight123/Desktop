//
//  niuniuRobotFriends.h
//  wechatHook
//
//  Created by antion on 2017/3/8.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

typedef void(^friendChooseFunc)(NSDictionary*);

@interface niuniuMembersGroupView : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, assign) UILabel* mTitle;
@property(nonatomic, copy) friendChooseFunc mChooseFunc;
@property(nonatomic, copy) funcEnd mBackFunc;
@property (assign, nonatomic) UIViewController* mSuperViewVC;

@end
