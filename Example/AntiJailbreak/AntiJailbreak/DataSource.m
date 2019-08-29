//
//  DataSource.m
//  AntiJailbreak
//
//  Created by 梁泽 on 2019/6/19.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "DataSource.h"
@implementation Model
+ (instancetype)text:(NSString *)text color:(UIColor *)textColor{
    Model *m = [[Model alloc] init];
    m.text = text;
    m.textColor = textColor;
    return m;
}
@end

@interface DataSource()
@property (nonatomic, strong) NSMutableArray<Model *> *list;//
@end
@implementation DataSource
+ (instancetype)share{
    static DataSource *instacne = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instacne = [[self alloc]init];
        instacne.list = @[].mutableCopy;
    });
    return instacne;
}

- (void)addReason:(Model *)reason{
    [self.list addObject:reason];
    if (self.dataSourceRefresh) {
        self.dataSourceRefresh();
    }
}

- (NSArray<NSString *> *)reasons{
    return self.list.copy;
}

@end
