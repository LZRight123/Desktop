//
//  niuniuSupportDragView.m
//  wechatHook
//
//  Created by antion on 2017/3/9.
//
//

#import "niuniuSupportDragView.h"
#import "toolManager.h"
#import "ycFunction.h"

@implementation niuniuSupportDragView {
    int mViewHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) initWithView:(UIView*)superView maxh:(int)maxh h:(int)h mask:(int)mask {
    if (self = [super initWithFrame: CGRectMake(0, 0, superView.frame.size.width, h)]) {
        self.backgroundColor = [UIColor clearColor];
        [superView addSubview: self];
        [self release];

        mViewHeight = maxh;
        
        if (mask & niuniuSupportDragTypeDrag) {//拖动手势
            UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePos:)];
            [self addGestureRecognizer:pan];
            [pan release];
        }
        
        UITapGestureRecognizer* tap = nil;
        if (mask & niuniuSupportDragTypeOnce) {//单击展开
            tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnce)];
            [self addGestureRecognizer: tap];
            [tap release];
        }
        
        UITapGestureRecognizer* tap2 = nil;
        if (mask & niuniuSupportDragTypeDouble) {//双击关闭
            tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDouble)];
            tap2.numberOfTapsRequired = 2;
            [self addGestureRecognizer: tap2];
            [tap2 release];
        }
        
        if (tap && tap2) {//防止拦截
            [tap requireGestureRecognizerToFail:tap2];
        }
    }
    return self;
}

-(void) dealloc {
    
    [super dealloc];
}


//面板拖动
-(void)changePos:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView: tmanager.mWindows];
    CGRect frame = tmanager.mWindows.frame;
    frame.origin.x += point.x;
    frame.origin.y += point.y;
    tmanager.mWindows.frame = frame;
    [pan setTranslation:CGPointMake(0, 0) inView:tmanager.mWindows];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGRect frame = tmanager.mWindows.frame;
        frame.origin.x = width-self.frame.size.width;
        frame.origin.y = [ycFunction ycheck: frame.origin.y h: tmanager.mWindows.frame.size.height];
        [UIView animateWithDuration: .3 animations: ^{
            tmanager.mWindows.frame = frame;
        }];
    }
}

//面板单击
-(void) clickOnce {
    CGRect frame = tmanager.mWindows.frame;
    if (frame.size.height > self.frame.size.height) {
        frame.size.height = self.frame.size.height;
    } else {
        frame.size.height = mViewHeight;
    }
    [UIView animateWithDuration: .2 animations: ^{
        tmanager.mWindows.frame = frame;
        [self superview].frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    } completion: ^(BOOL b) {
    }];
}

//双击
-(void) clickDouble {
    if (self.mDoubleFunc) {
        self.mDoubleFunc();
    }
}
@end
