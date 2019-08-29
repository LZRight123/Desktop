//
//  SwitchCell.m
//  wexingGitDylib
//
//  Created by 梁泽 on 2019/5/23.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "SwitchCell.h"
#import "GlobalHeaderFile.h"

@interface SwitchCell()
@property (nonatomic, strong) UISwitch *swit;//
@end

@implementation SwitchCell

- (void)setupUI{
    [super setupUI];
    self.imageView.image = [UIImage imageNamed:@"zytcellicon"];
    self.textLabel.text = @"自动抢红包";
    [self.contentView addSubview:self.swit];
    [self.swit setOn:RedPageManager.isAutoRed];
    
    [self.swit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-13);
    }];
    self.indentationLevel = 2;
    self.indentationWidth = 20;
}

- (UISwitch *)swit{
    if (!_swit) {
        _swit = [[UISwitch alloc] init];
        _swit.onTintColor = [UIColor orangeColor];
        [_swit addTarget:self action:@selector(switChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _swit;
}

#pragma mark -
#pragma mark - events
- (void)switChange:(UISwitch *)sender{
    RedPageManager.isAutoRed = !RedPageManager.isAutoRed;
    [sender setOn:RedPageManager.isAutoRed animated:true];
}


@end
