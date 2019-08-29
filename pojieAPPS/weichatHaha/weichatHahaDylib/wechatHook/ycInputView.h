//
//  inputView.h
//  wechatHook
//
//  Created by antion on 16/12/1.
//
//

#import <UIKit/UIKit.h>

typedef void (^ycInputViewEnd)(BOOL, NSString*);

@interface ycInputView : UIView<UITextFieldDelegate, UITextViewDelegate>

-(id) initWithFrame:(CGRect)frame title:(NSString*)title text:(NSString*)text;
-(id) initWithFrame:(CGRect)frame title:(NSString*)title text:(NSString*)text useTextView:(BOOL)userTextView;

@property(nonatomic, copy) ycInputViewEnd mFunc;

@end
