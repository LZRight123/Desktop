//
//  ViewController.m
//  程序退出方法
//
//  Created by 梁泽 on 2019/5/28.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

static __attribute__((always_inline)) void asm_exit() {
#ifdef __arm64__
    __asm__("mov X0, #0\n"
            "mov w16, #1\n"
            "svc #0x80\n"
            
            "mov x1, #0\n"
            "mov sp, x1\n"
            "mov x29, x1\n"
            "mov x30, x1\n"
            "ret");
#endif
    exit(-1);
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickExit0:(id)sender{
    exit(0);
}

- (IBAction)clickExit1:(id)sender{
    exit(1);
}

- (IBAction)clickNSThreadexit:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSThread exit];
    });
}

- (IBAction)clickAssert:(id)sender{
    assert(0);
}

- (IBAction)clickTerminateWithSuccess:(id)sender{
    [[UIApplication sharedApplication] performSelector:NSSelectorFromString(@"terminateWithSuccess")];
}

- (IBAction)clickAbort:(id)sender{
    abort();
}

- (IBAction)clickAssembly:(id)sender{
    asm_exit();
}

/* debug状态下依旧可以强行退出，且会在退出前调用方法
 - (void)applicationWillTerminate:(UIApplication *)application */
//if ([[UIApplication sharedApplication] respondsToSelector:@selector(terminateWithSuccess)]){
//    [[UIApplication sharedApplication] performSelector:@selector(terminateWithSuccess)];
//}
//
///* debug状态下依旧可以强行退出，但不会调用任何方法 */
//exit(1); 或 exit(0);
//
///* debug状态下会断点，效果类似数组越界等会造成应用闪退的Bug */
//assert(0); 或 abort();


@end
