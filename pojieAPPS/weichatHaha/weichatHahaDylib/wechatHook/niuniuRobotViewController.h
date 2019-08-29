//
//  niuniuRobotViewController.h
//  wechatHook
//
//  Created by antion mac on 2016/12/8.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

@interface niuniuRobotViewController : UIViewController<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, copy) funcEnd mFunc;

-(void) reload;

@end
