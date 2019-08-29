//
//  LZBaseWebVC.m
//  wexingGitDylib
//
//  Created by 梁泽 on 2019/5/23.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "LZBaseWebVC.h"
#import <WebKit/WebKit.h>
#import "GlobalHeaderFile.h"

@interface LZBaseWebVC ()
@property (nonatomic, strong) WKWebView *webView ;//
@end

@implementation LZBaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[WKWebView alloc] init];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    @try {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
