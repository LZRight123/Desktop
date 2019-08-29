//
//  ImitateWechatCell.m
//  wexingGitDylib
//
//  Created by 梁泽 on 2019/5/23.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "ImitateWechatCell.h"
#import "GlobalHeaderFile.h"

@implementation ImitateWechatCell

+ (__kindof UITableViewCell *)cellWithTableView:(UITableView*)tableView{
    NSString *ID = NSStringFromClass(self);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[self class] alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupUI];
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView setFrame:CGRectMake(16, 16,24, 24)];
    [self.textLabel setFrame:CGRectMake(56, 0, CGRectGetWidth(self.textLabel.bounds), CGRectGetHeight(self.textLabel.bounds))];
}

@end
