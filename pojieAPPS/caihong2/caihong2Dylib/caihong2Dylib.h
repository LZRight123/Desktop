//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  caihong2Dylib.h
//  caihong2Dylib
//
//  Created by 梁泽 on 2019/8/3.
//  Copyright (c) 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__ ((always_inline)) static NSString *newpathWith(NSString *oldPath) {
    NSURLComponents *components = [NSURLComponents componentsWithString:oldPath];
    if (!components) {
        return oldPath;
    }
    if ([components.host containsString:@"mxyl520.cn"]){
          components.scheme = @"http";
          components.host = @"103.216.154.254";
          components.port = @8889;
        NSString *path = components.path;
        components.path = [NSString stringWithFormat:@"test/%@",path];

    }
    return components.string;
}

//https://ioscccccccc.mxyl520.cn
//http://45.248.10.215

//        components.scheme = @"http";
//        components.host = @"45.248.10.215";
//        components.port = @81;
