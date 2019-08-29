//
//  Model.h
//  runtime-dic_to_model
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject
@property (nonatomic, strong) NSString *property1;//
@property (nonatomic, strong) NSString *property2;//
@property (nonatomic, strong) NSString *property3;//
@property (nonatomic, strong) NSString *property4;//



- (instancetype)initWithDic:(NSDictionary *)dic;
- (NSDictionary *)convertModelToDic;
@end

//NS_ASSUME_NONNULL_END
