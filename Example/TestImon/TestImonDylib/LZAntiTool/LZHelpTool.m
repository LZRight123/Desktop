//
//  LZLog.m
//  HookExampleDylib
//
//  Created by 梁泽 on 2019/6/24.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "LZHelpTool.h"


@interface LZLogTool()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableSet *loglist;//
@end
@implementation LZLogTool
+ (instancetype)manager{
    static LZLogTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
        tool.loglist = [NSMutableSet set];

    });
    return tool;
}

- (void)addLog:(NSString *)log{
    [self.loglist addObject:log];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fire) userInfo:nil repeats:true];
    }
}

- (void)fire{
    NSString *log = [self.loglist.allObjects componentsJoinedByString:@",\n"];
    NSLog(@"对方正在检测🔥🔥🔥🔥🔥🔥🔥🔥\n(\n%@\n)", log);
}
@end
