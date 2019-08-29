//
//  ViewController.m
//  framework_compile
//
//  Created by 梁泽 on 2019/6/23.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "ViewController.h"
#import <Test_f/Test_f.h>
#import "TwoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickBtn:(id)sender {
    TwoViewController *nextVC = [[TwoViewController alloc] init];
    [self presentViewController:nextVC animated:true completion:nil];
}

@end
