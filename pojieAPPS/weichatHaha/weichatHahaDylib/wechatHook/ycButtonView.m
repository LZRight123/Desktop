//
//  ycButtonView.m
//  wechatHook
//
//  Created by antion on 16/12/1.
//
//

#import "ycButtonView.h"

typedef void(^ycButtonFunc)(void);

@implementation ycButtonView {
    UIColor* mBtnColor1;
    UIColor* mBtnColor2;
    UIColor* mTextColor1;
    UIColor* mTextColor2;
    UILabel* mLabel;
    UIScrollView* mScrollView;
    BOOL mIsSelected;
    ycButtonFunc mFunc;
}

-(void) dealloc {
    if (mFunc) {
        [mFunc release];
    }
    [mBtnColor1 release];
    [mBtnColor2 release];
    [mTextColor1 release];
    [mTextColor2 release];
    [super dealloc];
}

-(id) initWithFrame:(CGRect)frame text:(NSString*)text func:(funcEnd)func {
    if (self = [self initWithFrame: frame]) {
        [self initBtn];
        [self setText: text];
        [self setFunc: func];
    }
    return self;
}

-(void) initBtn {
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
    mLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] autorelease];
    mLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    mLabel.textAlignment = NSTextAlignmentCenter;
    mLabel.text = @"";
    [self addSubview:mLabel];
    
    mBtnColor1 = [[UIColor colorWithRed:233.0/255 green:102.0/255 blue:15.0/255 alpha:1] retain];
    mBtnColor2 = [[UIColor whiteColor] retain];
    mTextColor1 = [[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1] retain];
    mTextColor2 = [[UIColor blackColor] retain];
    [self updateColors: NO];
}

-(void) xibConvert {
    UIColor* color = self.backgroundColor;
    [self initBtn];
    [self setBtnColor: color isSelected: NO];
    UILabel* xibLabel = [self.subviews firstObject];
    [self setText: xibLabel.text];
    [xibLabel removeFromSuperview];
}

-(void) setText:(NSString*)text {
    mLabel.text = text;
}

-(void) setFunc:(funcEnd)func {
    if (mFunc) {
        [mFunc release];
        mFunc = nil;
    }
    if (func) {
        mFunc = [func copy];
    }
}

-(void) setBtnColor:(UIColor*)color isSelected:(BOOL)isSelected {
    if (isSelected) {
        [mBtnColor2 release];
        mBtnColor2 = [color retain];
    } else {
        [mBtnColor1 release];
        mBtnColor1 = [color retain];
    }
    [self updateColors: NO];
}

-(void) setTextColor:(UIColor*)color isSelected:(BOOL)isSelected {
    if (isSelected) {
        [mTextColor2 release];
        mTextColor2 = [color retain];
    } else {
        [mTextColor1 release];
        mTextColor1 = [color retain];
    }
    [self updateColors: NO];
}

-(void) updateColors:(BOOL)ani {
    if (mIsSelected) {
        if (ani) {
            [UIView animateWithDuration: .5 animations:^{
                self.backgroundColor = mBtnColor2;
                mLabel.textColor = mTextColor2;
            }];
        } else {
            self.backgroundColor = mBtnColor2;
            mLabel.textColor = mTextColor2;
        }
        
    } else {
        if (ani) {
            [UIView animateWithDuration: .5 animations:^{
                self.backgroundColor = mBtnColor1;
                mLabel.textColor = mTextColor1;
            }];
        } else {
            self.backgroundColor = mBtnColor1;
            mLabel.textColor = mTextColor1;
        }
        
    }
}

-(void) setScrollView:(UIScrollView*)scroll {
    mScrollView = scroll;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (mScrollView) {
        mScrollView.scrollEnabled = NO;
    }
    mIsSelected = true;
    [self updateColors: NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView: self];
    mIsSelected = [self hitTest: point withEvent:event];
    [self updateColors: NO];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (mScrollView) {
        mScrollView.scrollEnabled = YES;
    }
    mIsSelected = false;
    [self updateColors: YES];
    CGPoint point = [[touches anyObject] locationInView: self];
    if ([self hitTest: point withEvent:event]) {
        if (mFunc) {
            mFunc();
        }
    }
}

@end
