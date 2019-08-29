//
//  niuniuRobotGameViewController.h
//  wechatHook
//
//  Created by antion mac on 2016/12/9.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"
#import "ycButtonView.h"
#import "niuniuRobot.h"

@interface niuniuRobotGameViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

-(void) updateTableView: (int)aniType;

@property (copy, nonatomic) funcEnd mBackFunc;
@property (assign, nonatomic) UIView* mBgView;
@property(retain, nonatomic) UITableView* mTableView;

@end
