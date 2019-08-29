//
//  niuniuRobotFuliBankerSettingView.h
//  wechatHook
//
//  Created by antion on 2017/11/28.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

@interface niuniuRobotFuliBankerSettingView : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, copy) funcEnd mBackFunc;
@property (assign, nonatomic) UIViewController* mSuperViewVC;

@end
