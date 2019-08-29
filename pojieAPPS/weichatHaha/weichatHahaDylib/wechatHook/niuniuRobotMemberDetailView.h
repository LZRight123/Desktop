//
//  niuniuRobotMemberDetailView.h
//  wechatHook
//
//  Created by antion on 2017/3/10.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"
#import "niuniuRobotMembersVC.h"

@interface niuniuRobotMemberDetailView : UIView<UITableViewDataSource, UITableViewDelegate>

-(id) initWithFrame:(CGRect)frame userid: (NSString*)userid hasBtn:(BOOL)hasBtn;

@property(nonatomic, copy) funcEnd mBackFunc;
@property (assign, nonatomic) UIViewController* mSuperViewVC;
@property (nonatomic, retain) NSString* mAlertFrameText;

@end
