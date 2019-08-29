//
//  SuspendBall.m
//  MDSettingCenter
//
//  Created by AloneMonkey on 2017/10/25.
//  Copyright (c) 2017年 MonkeyDev. All rights reserved.
//

#import "MDSuspendBall.h"

@implementation MDSuspendBall

+ (instancetype)sharedInstance {
    static MDSuspendBall *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MDSuspendBall alloc] initWithFrame:CGRectMake(0, 64, 40, 40)];
    });
    return instance;
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.zPosition = 10;
        self.layer.cornerRadius = self.bounds.size.width / 2;
        self.bgColor = [UIColor grayColor];
        //背景颜色
        self.backgroundColor = [self.bgColor colorWithAlphaComponent:0.6];
        
        //点击事件
        [self addTarget:self action:@selector(clickSelf) forControlEvents:UIControlEventTouchUpInside];
        
        //移动事件
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureMove:)];
        [self addGestureRecognizer:pan];
        
    }
    return self;
}

-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = [bgColor colorWithAlphaComponent:0.6];
}

-(void)addToWindow:(UIWindow*) window{
    if(!window){
        window = [[UIApplication sharedApplication].windows firstObject];
    }
    MDSuspendBall *suspendBall = [MDSuspendBall sharedInstance];
    [suspendBall removeFromSuperview];
    [window addSubview:suspendBall];
    [window bringSubviewToFront:suspendBall];
}

//点击悬浮球事件
- (void)clickSelf{
    if (self.didClick) {
        self.didClick();
    }
}

- (void)gestureMove:(UIPanGestureRecognizer *)pan{
    
}



#pragma mark -
#pragma mark - 辅助方法
+(UIViewController *)getCurrentViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //1、通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        //2、通过navigationcontroller弹出VC
        NSLog(@"subviews == %@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
        if(![nextResponder isKindOfClass:[UIViewController class]])
        {
            nextResponder = window.rootViewController;
        }
    }
    //1、tabBarController
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //或者 UINavigationController * nav = tabbar.selectedViewController;
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        //2、navigationController
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{//3、viewControler
        result = nextResponder;
    }
    return result;
    
}
@end
