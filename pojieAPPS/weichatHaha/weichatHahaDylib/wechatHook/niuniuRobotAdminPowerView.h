//
//  niuniuAdminPowerView.h
//  wechatHook
//
//  Created by antion on 2017/7/6.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

@interface niuniuRobotAdminPowerView : UIView<UITableViewDataSource, UITableViewDelegate>

-(id) initWithFrame:(CGRect)frame userid:(NSString*)userid;

@property(nonatomic, copy) funcEnd mBackFunc;

@end

