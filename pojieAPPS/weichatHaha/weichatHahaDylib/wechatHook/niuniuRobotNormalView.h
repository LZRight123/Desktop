//
//  niuniuRobotNormalView.h
//  wechatHook
//
//  Created by antion on 2017/2/20.
//
//

#import <UIKit/UIKit.h>
#import "niuniuRobotGameViewController.h"

@interface niuniuRobotNormalView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) niuniuRobotGameViewController* mSuperViewVC;

@end
