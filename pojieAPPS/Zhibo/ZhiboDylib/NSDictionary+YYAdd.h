//
//  NSDictionary+YYAdd.h
//  ZhiboDylib
//
//  Created by 周光 on 2019/7/14.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (YYAdd)
- (NSString *)jsonPrettyStringEncoded;


- (NSString *)jsonStringEncoded;
@end

NS_ASSUME_NONNULL_END
