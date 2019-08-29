//
//  DataSource.h
//  AntiJailbreak
//
//  Created by 梁泽 on 2019/6/19.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Model: NSObject
@property (nonatomic, strong) NSString *text;//
@property (nonatomic, strong) UIColor *textColor;//

+ (instancetype)text:(NSString *)text color:(UIColor *)textColor;
@end

@interface DataSource : NSObject
@property (nonatomic, strong) NSArray<Model *> *reasons;//
@property (nonatomic, copy  ) dispatch_block_t dataSourceRefresh;
#define DataSourceManager [DataSource share]
+ (instancetype)share;
- (void)addReason:(Model *)reason;
@end

