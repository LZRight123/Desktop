//
//  LZRedPageManager.m
//  wexingGitDylib
//
//  Created by 梁泽 on 2019/5/23.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "LZRedPageManager.h"

@interface LZRedPageManager()
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSLock *lock;//
@end
@implementation LZRedPageManager
+(instancetype) sharedInstance{
    static LZRedPageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LZRedPageManager alloc] init];
    });
    return instance;
}

-(instancetype)init{
    if (self = [super init]){
        _list = @[].mutableCopy;
        _lock = [[NSLock alloc] init];
        _lock.name = @"lz_wc_redpage";
    }
    return self;
}

- (void)addRedModel:(LZRedPageModel *)model{
    [self.lock lock];
    [self.list addObject:model];
    [self.lock unlock];
}

- (LZRedPageModel *)getModel:(NSString *)sendId{
    @synchronized(self) {
        NSInteger resultIndex = -1;
        for (NSInteger index = 0 ; index < self.list.count ; index++) {
            LZRedPageModel *amodel = self.list[index];
            if ([amodel.sendId isEqualToString:sendId]){ //找到了
                resultIndex = index;
            }
        }
        if (resultIndex != -1 ){
            LZRedPageModel *amodel = self.list[resultIndex];
            [self.list removeObjectAtIndex:resultIndex];
            return amodel;
        }
        return nil;
    }
}

- (void)handleRedSwitch{
    self.isAutoRed = !self.isAutoRed;
}

- (void)setIsAutoRed:(BOOL)isAutoRed {
    [[NSUserDefaults standardUserDefaults] setBool:isAutoRed forKey:@"lz_isAutoRed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isAutoRed{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"lz_isAutoRed"];
}

@end
