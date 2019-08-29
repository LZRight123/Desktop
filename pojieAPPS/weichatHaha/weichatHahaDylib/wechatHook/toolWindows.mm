//
//  toolWindows.m
//  wechatHook
//
//  Created by antion on 16/11/12.
//
//

#import "toolWindows.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ycFunction.h"
#import "wxFunction.h"
#import "toolManager.h"
#import "niuniuRobotViewController.h"
#import "niuniu.h"

//摇一摇隐藏视图－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
@interface UIWindow (Motion)
- (BOOL)canBecomeFirstResponder;
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
@end

@implementation UIWindow (Motion)
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (!tmanager.mWindows) {
        return;
    }
    if (tmanager.mWindows.alpha > 0) {
        tmanager.mWindows.alpha = 0;
    } else {
        tmanager.mWindows.alpha = 1;
    }
}
@end
//－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

static int btnsize = 64;

@implementation toolWindows {
    CGRect mSourceFrame;
    UIButton* mBtn;
    NSTimer* mBtnTimer;
    UIView* mMenu;
    UITapGestureRecognizer* mMenuOutsideTap;
    niuniuRobotViewController* robotViewController;
}

-(id) init {
    self = [super initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-btnsize, 200, btnsize, btnsize)];
    if (self) {
        mBtn = nil;
        mBtnTimer = nil;
        
        self.windowLevel = UIWindowLevelAlert+1;
        [self makeKeyAndVisible];//关键语句,显示window
        
        //btn
        mBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        mBtn.backgroundColor = [UIColor clearColor];
        [mBtn setImage:[UIImage imageNamed: @"niuniuRobot"] forState: UIControlStateNormal];
        mBtn.frame = CGRectMake(0, 0, btnsize, btnsize);
        [self addSubview: mBtn];

        //出生动画
        mBtn.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [UIView animateWithDuration: .5 animations: ^{
            mBtn.transform = CGAffineTransformMakeScale(1, 1);
        } completion: ^(BOOL b) {
            //点击事件
            [mBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
            
            //拖动手势
            UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(btnChangePos:)];
            [mBtn addGestureRecognizer:pan];
            [pan release];
            
            //定时器
            [self btnTimer: YES];
        }];
//        UIDevice *device = [UIDevice currentDevice]; //Get the device object
//        [device beginGeneratingDeviceOrientationNotifications]; //Tell it to start monitoring the accelerometer for orientation
//        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter]; //Get the notification centre for the app
//        [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:device];
    }
    return self;
}

//#pragma mark- 自动旋转
//-(void)rotationWindow:(float)n {
//    NSLog(@"rotationWindow: %.2f", n);
//    self.transform = CGAffineTransformMakeRotation(n*M_PI/180.0);
//}
//
//- (void)orientationChanged:(NSNotification *)note  {      UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
//    switch (o) {
//        case UIDeviceOrientationPortrait:            // Device oriented vertically, home button on the bottom
//            [self rotationWindow:0.0];
//            break;
//        case UIDeviceOrientationPortraitUpsideDown:  // Device oriented vertically, home button on the top
//            [self rotationWindow:180.0];
//            break;
//        case UIDeviceOrientationLandscapeLeft:      // Device oriented horizontally, home button on the right
//            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
//            
//            [self rotationWindow:90.0];
//            break;
//        case UIDeviceOrientationLandscapeRight:      // Device oriented horizontally, home button on the left
//            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
//            
//            [self rotationWindow:90.0*3];
//            break;
//        default:
//            break;
//    }   
//}

#pragma mark- button

//按钮拖动
-(void)btnChangePos:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView: self];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect originalFrame = self.frame;
    if (originalFrame.origin.x >= -btnsize/2 && originalFrame.origin.x+originalFrame.size.width <= width+btnsize/2) {
        originalFrame.origin.x += point.x;
    }
    if (originalFrame.origin.y >= -btnsize/2 && originalFrame.origin.y+originalFrame.size.height <= height+btnsize/2) {
        originalFrame.origin.y += point.y;
    }
    self.frame = originalFrame;
    [pan setTranslation:CGPointMake(0, 0) inView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        mBtn.enabled = NO;
        [self btnTimer: NO];
    } else if (pan.state == UIGestureRecognizerStateChanged){
        
    } else {
        CGRect frame = self.frame;
        if (frame.origin.y+btnsize/2 < btnsize) {
            frame.origin.x = [ycFunction xcheck: frame.origin.x w: self.frame.size.width];
            frame.origin.y = 0;
        } else if (frame.origin.y+btnsize/2 > height-btnsize) {
            frame.origin.x = [ycFunction xcheck: frame.origin.x w: self.frame.size.width];
            frame.origin.y = height-btnsize;
        } else if(frame.origin.x+btnsize/2 < width/2) {
            frame.origin.x = 0;
            frame.origin.y = [ycFunction ycheck: frame.origin.y h: self.frame.size.height];
        } else {
            frame.origin.x = width-btnsize;
            frame.origin.y = [ycFunction ycheck: frame.origin.y h: self.frame.size.height];
        }
        
        [UIView animateWithDuration: .3 animations: ^{
            self.frame = frame;
        } completion: ^(BOOL b) {
            mBtn.enabled = YES;
            [self btnTimer: YES];
        }];
    }
}

//按钮点击
- (void)clickBtn {
    mSourceFrame = self.frame;

    [self btnTimer: NO];
    mBtn.hidden = YES;

    [self loadMenu];

    //动画
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration: .2 animations: ^{
        self.frame = CGRectMake(0, 0, width, height);
        mMenu.frame = CGRectMake((width-300)/2, (height-300)/2, 300, 300);
    } completion: ^(BOOL b) {
        [self menuOutsideTap: YES];
    }];
}

//按钮定时器
-(void) btnTimer:(BOOL)open {
    mBtn.alpha = 1;
    if (mBtnTimer) {
        [mBtnTimer invalidate];
        mBtnTimer = nil;
    }
    if(open) {
        mBtnTimer = [NSTimer scheduledTimerWithTimeInterval: 5 target: self selector: @selector(btnAlpha) userInfo:nil repeats:NO];
    }
}

//按钮半透明
-(void) btnAlpha {
    mBtn.alpha = .3;
    if (mBtnTimer) {
        [mBtnTimer invalidate];
        mBtnTimer = nil;
    }
}

#pragma mark- menu

-(void) loadMenu {
    mMenu = [[UIView alloc] initWithFrame: mBtn.frame];
    mMenu.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha: .8];
    mMenu.layer.cornerRadius = 20;
    mMenu.layer.masksToBounds = YES;
    [mMenu addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMenu)] autorelease]];
    [self addSubview: mMenu];
    [mMenu release];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed: @"niuniuRobot.png"] forState: UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = CGPointMake(140, 100);
    [button addTarget:self action:@selector(clickRobotBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mMenu addSubview: button];
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 100, 30)];
    label.center = CGPointMake(button.center.x+4, button.center.y+70);
    label.text = @"点击启动";
    label.font = [UIFont fontWithName:@"Helvetica" size:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [mMenu addSubview: label];
    [label release];
    
    button.tag = (NSInteger)label;
}

-(void) removeMenu {
    if (mMenu) {
        [mMenu removeFromSuperview];
        mMenu = nil;
    }
}

-(void) menuOutsideTap: (BOOL)open {
    if (mMenuOutsideTap) {
        [self removeGestureRecognizer: mMenuOutsideTap];
        mMenuOutsideTap = nil;
    }
    if (open) {
        mMenuOutsideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMenuOutside)];
        [self addGestureRecognizer: mMenuOutsideTap];
        [mMenuOutsideTap release];
    }
}

//点击菜单背景
-(void) clickMenu {}

//点击菜单以外的区域
-(void) clickMenuOutside {
    [self menuOutsideTap: NO];
    
    if (!mMenu) {
        return;
    }
    
    [UIView animateWithDuration: .2 animations: ^{
        self.frame = mSourceFrame;
        mMenu.frame = mBtn.frame;
    } completion: ^(BOOL b) {
        mBtn.hidden = NO;
        [self btnTimer: YES];
        [self removeMenu];
    }];
}

//点击菜单按钮
-(void) clickRobotBtn:(UIButton*)sender {
    UILabel* label = (UILabel*)sender.tag;
    label.text = @"正在加载";
    label.textColor = [UIColor greenColor];
    [self performSelector: @selector(loadNiuniuRobot) withObject:nil afterDelay:.1];
}

#pragma mark- niuniuRobot

-(void) loadNiuniuRobot  {
    robotViewController = [[niuniuRobotViewController alloc] init];
    robotViewController.mFunc = ^{
        [UIView animateWithDuration: .2 animations: ^{
            self.frame = mSourceFrame;
            robotViewController.view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion: ^(BOOL b) {
            mBtn.hidden = NO;
            [self btnTimer: YES];
            
            if (robotViewController) {
                [robotViewController.view removeFromSuperview];
                [robotViewController release];
//                robotViewController = nil;
            }
        }];
    };
    [self addSubview: robotViewController.view];
    
    CGRect frame = robotViewController.view.frame;
    robotViewController.view.frame = mMenu.frame;
    
    [self menuOutsideTap: NO];
    [self removeMenu];
    
    //动画
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    [UIView animateWithDuration: .2 animations: ^{
        self.frame = CGRectMake(width-frame.size.width, 64, frame.size.width, frame.size.height);
        robotViewController.view.frame = frame;
    } completion: ^(BOOL b) {
    }];
}

-(id) getRobotVC {
    return robotViewController;
}

@end
