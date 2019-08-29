//
//  inputView.m
//  wechatHook
//
//  Created by antion on 16/12/1.
//
//

#import "ycInputView.h"
#import "ycButtonView.h"

@implementation ycInputView {
    UITextField* mTextFileld;
    UITextView* mTextView;
}

-(id) initWithFrame:(CGRect)frame title:(NSString*)title text:(NSString*)text {
    return [self initWithFrame:frame title:title text:text useTextView:NO];
}

-(id) initWithFrame:(CGRect)frame title:(NSString*)title text:(NSString*)text useTextView:(BOOL)useTextView {
    if (self = [super initWithFrame: frame]) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 22)];
        label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-70);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = title;
        label.textColor = [UIColor yellowColor];
        [self addSubview:label];
        [label release];
        
        UIView* edge = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width-50, 40)];
        edge.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-30);
        edge.backgroundColor = [UIColor clearColor];
        edge.layer.cornerRadius = 8;
        edge.layer.masksToBounds = YES;
        edge.layer.borderWidth = 2;
        edge.layer.borderColor = [UIColor yellowColor].CGColor;
        [self addSubview: edge];
        [edge release];
        
        if (useTextView) {
            mTextView= [[UITextView alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width-60, 40)];
            mTextView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-30);
            mTextView.text = text;
            mTextView.textColor = [UIColor whiteColor];
            mTextView.backgroundColor = [UIColor clearColor];
            [mTextView setDelegate: self];
            [mTextView becomeFirstResponder];
            [self addSubview: mTextView];
            [mTextView release];
        } else {
            mTextFileld = [[UITextField alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width-60, 40)];
            mTextFileld.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-30);
            mTextFileld.text = text;
            mTextFileld.textColor = [UIColor whiteColor];
            [mTextFileld setDelegate: self];
            [mTextFileld setTextAlignment:NSTextAlignmentCenter];
            [mTextFileld becomeFirstResponder];
            [self addSubview: mTextFileld];
            [mTextFileld release];
        }
        
        ycButtonView* okBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 80, 30) text: @"确定" func: ^() {
            if (useTextView) {
                self.mFunc(true, mTextView.text);
            } else {
                self.mFunc(true, mTextFileld.text);
            }
        }];
        okBtn.center = CGPointMake(self.frame.size.width/2-50, self.frame.size.height/2+30);
        [self addSubview: okBtn];
        [okBtn release];
        
        ycButtonView* cancelBtn = [[ycButtonView alloc] initWithFrame: CGRectMake(0, 0, 80, 30) text: @"取消" func: ^(){
            self.mFunc(false, nil);
        }];
        cancelBtn.center = CGPointMake(self.frame.size.width/2+50, self.frame.size.height/2+30);
        [self addSubview: cancelBtn];
        [cancelBtn release];
    }
    return self;
}

-(void) dealloc {
    self.mFunc = nil;
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (mTextView) {
        [mTextView resignFirstResponder];
    }
    if (mTextFileld) {
        [mTextFileld resignFirstResponder];
    }
}

@end
