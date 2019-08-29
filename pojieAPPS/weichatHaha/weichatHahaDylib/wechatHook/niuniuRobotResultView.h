//
//  niuniuRobotResultView.h
//  wechatHook
//
//  Created by antion on 2017/2/20.
//
//

#import <UIKit/UIKit.h>
#import "niuniuRobotGameViewController.h"
#import "niuniuRobotResult.h"

@interface niuniuRobotResultView : UITableView<UITableViewDataSource, UITableViewDelegate, niuniuRobotResultDelegate>

@property (assign, nonatomic) niuniuRobotGameViewController* mSuperViewVC;

@end
