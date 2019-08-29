//
//  ImitateWechatCell.h
//  wexingGitDylib
//
//  Created by 梁泽 on 2019/5/23.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImitateWechatCell : UITableViewCell
+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView;

- (void)setupUI;
@end

NS_ASSUME_NONNULL_END
