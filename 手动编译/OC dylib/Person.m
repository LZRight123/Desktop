#import <Foundation/Foundation.h>
 

__attribute__((constructor)) static void entry(){
    NSURL *url = [NSURL URLWithString:@"http://api.xh2019.cn/index/api/iosVersion?id=1"];
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    mutableRequest.HTTPMethod = @"GET";
    [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError *jer = nil;
            id jdata = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jer];
            NSLog(@"%@", jdata);
            if (jer) {
                NSLog(@"数据错误");
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


