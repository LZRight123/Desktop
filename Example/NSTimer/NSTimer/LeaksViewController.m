//
//  LeaksViewController.m
//  NSTimer
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "LeaksViewController.h"
#import <objc/message.h>
#import "LeaksViewController.h"
#import "CustomProxy.h"
@interface LeaksViewController ()
@property (nonatomic, strong) NSTimer *timer;//
@property (nonatomic, strong) NSObject *target;//
@end

@implementation LeaksViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.title = @"Leaks";
//
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fire) userInfo:nil repeats:true];
////    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(fire) userInfo:nil repeats:ture];
////    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//}

- (void)fire{
    NSLog(@"----fire......");
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"LeaksViewController dealloc");
}

#pragma mark - 针对timer不释放的处理方法
#pragma mark - 第一种
//- (void)didMoveToParentViewController:(UIViewController *)parent{
//    if (parent == nil) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}

#pragma mark -
#pragma mark - 第二种
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.title = @"Leaks";
//
//    self.target = [NSObject new];
//    class_addMethod(self.target.class, @selector(fire), (IMP)fireImp, "v@:");
//
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.target selector:@selector(fire) userInfo:nil repeats:true];
//}
//
//void fireImp(id self, SEL _cmd){
//    NSLog(@"----fireImp......");
//}

#pragma mark - 第三种
#pragma mark - NSProxy  CustomProxy
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Leaks";
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[CustomProxy proxyWithTarget:self] selector:@selector(fire) userInfo:nil repeats:true];
}
@end
