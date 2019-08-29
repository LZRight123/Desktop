//
//  AppDelegate.h
//  AntiJailbreak
//
//  Created by 梁泽 on 2019/6/19.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString *str;//

@end

static UIColor *randomColor(){
    CGFloat r = (arc4random() % 255 / 255.0 );
    CGFloat g = (arc4random() % 128 / 255.0 );
    CGFloat b = (arc4random() % 128 / 255.0 );
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

