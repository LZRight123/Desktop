//
//  ycButtonView.h
//  wechatHook
//
//  Created by antion on 16/12/1.
//
//

#import <UIKit/UIKit.h>
#import "ycDefine.h"

@interface ycButtonView : UIView

-(id) initWithFrame:(CGRect)frame text:(NSString*)text func:(funcEnd)func;

-(void) xibConvert;
-(void) setFunc:(funcEnd)func;
-(void) setText:(NSString*)text;
-(void) setBtnColor:(UIColor*)color isSelected:(BOOL)isSelected;
-(void) setTextColor:(UIColor*)color isSelected:(BOOL)isSelected;
-(void) setScrollView:(UIScrollView*)scroll;

@end
