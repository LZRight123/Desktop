//
//  robotSettingBillColorView.h
//  wechatHook
//
//  Created by antion on 2017/10/21.
//
//

#import <UIKit/UIKit.h>

typedef void (^billColorViewEnd)(BOOL, int, int, int);

@interface robotSettingBillColorView : UIView

-(id) initWithFrame:(CGRect)frame key:(NSString*)key;

@property(nonatomic, copy) billColorViewEnd mFunc;

@end
