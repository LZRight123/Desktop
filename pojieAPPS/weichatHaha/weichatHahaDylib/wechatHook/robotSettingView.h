//
//  robotSettingView.h
//  wechatHook
//
//  Created by antion on 2017/10/20.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

@interface robotSettingView : UIView<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(id) initWithType:(CGRect)frame type:(NSString*)type;

@property(nonatomic, assign) UILabel* mTitle;
@property(nonatomic, copy) funcEnd mBackFunc;
@property (assign, nonatomic) UIViewController* mSuperViewVC;

@end
