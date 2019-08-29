//
//  robotSettingVC.h
//  wechatHook
//
//  Created by antion on 2017/10/20.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

@interface robotSettingVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (copy, nonatomic) funcEnd mBackFunc;

@end
