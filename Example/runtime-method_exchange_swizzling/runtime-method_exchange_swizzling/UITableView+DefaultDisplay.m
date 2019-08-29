//
//  UITableView+DefaultDisplay.m
//  runtime-method_exchange_swizzling
//
//  Created by 梁泽 on 2019/6/22.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "UITableView+DefaultDisplay.h"
#import <objc/message.h>
@implementation UITableView (DefaultDisplay)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method orig_method = class_getInstanceMethod(self, @selector(reloadData));
        Method new_method  = class_getInstanceMethod(self, @selector(lz_reloadData));
        method_exchangeImplementations(orig_method, new_method);
    });
}

- (void)lz_reloadData{
    [self lz_reloadData];
    [self fillDefaultView];
}

- (void)fillDefaultView{
    id<UITableViewDataSource> dataSource = self.dataSource;
    NSInteger section  = [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)] ? [dataSource numberOfSectionsInTableView:self] : 1;
    
    NSInteger rows = 0;
    for (NSInteger i = 0; i < section; i++) {
        rows = [dataSource tableView:self numberOfRowsInSection:i];
    }
    
    if (!rows) {
        self.defaultView = [[UIView alloc] initWithFrame:self.bounds];
        self.defaultView.backgroundColor = [UIColor redColor];
        [self addSubview:self.defaultView];
    } else {
        [self.defaultView removeFromSuperview];
    }
}

//MARK:- getter and setter
const char *defaultViewKey = "ss";
- (void)setDefaultView:(UIView *)defaultView{
    objc_setAssociatedObject(self, &defaultViewKey, defaultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)defaultView{
    return objc_getAssociatedObject(self, &defaultViewKey);
}

@end
