//
//  niuniuRobotResultSettingView.h
//  wechatHook
//
//  Created by antion on 2017/7/27.
//
//

#import <UIKit/UIKit.h>
#import "niuniuRobotGameViewController.h"
#import "ycDefine.h"

@interface niuniuRobotResultSettingView : UIView<UITableViewDataSource, UITableViewDelegate>

-(id) initWithFrame:(CGRect)frame;

@property(nonatomic, copy) funcFinish mBackFunc;
@property (assign, nonatomic) niuniuRobotGameViewController* mSuperViewVC;

@end
