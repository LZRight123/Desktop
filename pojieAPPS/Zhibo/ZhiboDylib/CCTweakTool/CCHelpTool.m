//
//  CCLog.m
//  HookExampleDylib
//
//  Created by 梁泽 on 2019/6/24.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "CCHelpTool.h"


@interface CCLogTool()
@property (nonatomic, strong) NSMutableArray *__requestList;//
@property (nonatomic, strong) NSMutableArray *__JSONSerializationList;//
@property (nonatomic, strong) NSMutableArray *__wrietFilePathList;//


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableSet *loglist;//
@end
@implementation CCLogTool
+ (instancetype)manager{
    static CCLogTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
        tool.loglist = [NSMutableSet set];
        tool.__requestList = [NSMutableArray array];
        tool.__JSONSerializationList = [NSMutableArray array];
        tool.__wrietFilePathList = @[].mutableCopy;
    });
    return tool;
}

- (void)addLog:(NSString *)log{
    [self.loglist addObject:log];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fire) userInfo:nil repeats:true];
    }
}

- (void)addRequest:(NSString *)req{
    if (!req) {
        return;
    }
    [self.__requestList addObject:req];
}

- (void)addJSONSerialization:(NSString *)ser{
    if (!ser) {
        return;
    }
    [self.__JSONSerializationList addObject:ser];
}

- (void)addWriteFilePath:(NSString *)arg{
    if (!arg) {
        return;
    }
    [self.__wrietFilePathList addObject:arg];
}

- (void)fire{
    NSString *log = [self.loglist.allObjects componentsJoinedByString:@",\n"];
    NSLog(@"对方正在检测🔥🔥🔥🔥🔥🔥🔥🔥\n(\n%@\n)", log);
}

#pragma mark -
#pragma mark - getter
- (NSArray *)requestList{
    return self.__requestList.copy;
}

- (NSArray *)JSONSerializationList{
    return self.__JSONSerializationList.copy;
}

- (NSArray *)wrietFilePathList{
    return self.__wrietFilePathList.copy;
}

@end
