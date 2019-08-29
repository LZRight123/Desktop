//
//  ViewController.m
//  runtime-custom_kvo
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
@interface ViewController ()
@property (nonatomic, strong) Person *p1;//
@property (nonatomic, strong) Person *p2;//
@end

@implementation ViewController

/*
 kvo 基于 runtime
 A监听B ，b是被观察的对像， 系统会创建子类 NSKVONotification_B
 B的isa指针 指向 ---- NSKVONotifying_B
 重写set方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _p1 = [Person new];
    _p2 = [Person new];
    
    _p2.name = @"p2";
    NSLog(@"监听之前 ---- p1:%p, p2:%p",[_p1 methodForSelector:@selector(setName:)],[_p2 methodForSelector:@selector(setName:)]);
    
    [_p1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"监听之后 ---- p1:%p, p2:%p",[_p1 methodForSelector:@selector(setName:)],[_p2 methodForSelector:@selector(setName:)]);
    _p1.name = @"p1";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"change === %@", change);
    
//    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}


@end
