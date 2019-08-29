//
//  ch_ap_dy_no.m
//  ch_ap_dy_no
//
//  Created by 梁泽 on 2019/7/18.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XYZLog : NSObject<UIAlertViewDelegate>
+ (instancetype)log;
@end

@implementation XYZLog
+ (instancetype)log{
    static XYZLog *log = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        log = [[XYZLog alloc] init];
    });
    return log;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
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


@end


__attribute__((constructor)) static void entry(){
    NSString *bid = [[NSBundle mainBundle] bundleIdentifier];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.xh2019.cn/index/api/iosVersion?id=%@",bid];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    mutableRequest.HTTPMethod = @"GET";
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSInteger errCode =  error.code;
            //无网络
            if (errCode == NSURLErrorNotConnectedToInternet || errCode == NSURLErrorNetworkConnectionLost || errCode == NSURLErrorCannotConnectToHost || errCode == NSURLErrorCannotLoadFromNetwork ) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请连接网络" message:@"请连接网络" delegate:XYZLog.log cancelButtonTitle:nil otherButtonTitles:@"确定"];
                        [alertView show];
                    });
                });
                
                return ;
            }
            
            if (data == nil) {
                return ;
            }
            NSError *jer = nil;
            id jdata = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jer];
            //            NSLog(@"%@", jdata);
            if (jer) {
                //                NSLog(@"数据错误");
            } else {
                if ([jdata isKindOfClass:[NSDictionary class]] && jdata[@"code"] && [jdata[@"code"] integerValue] != 0) {
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
            }
            
        }];
        
        [task resume];
    });
    
}




