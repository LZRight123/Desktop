//
//  ViewController.m
//  runtime-dic_to_model
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "Model.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Model *m = [[Model alloc] initWithDic:@{@"property1":@"value1",@"property2":@"value2",@"property3":@"value4"}];
    
    NSDictionary *dic = [m convertModelToDic];
    NSLog(@"%@",dic);
}


@end
