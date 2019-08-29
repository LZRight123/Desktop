//
//  ViewController.m
//  AntiJailbreak
//
//  Created by 梁泽 on 2019/6/19.
//  Copyright © 2019 梁泽. All rights reserved.
//

#import "ViewController.h"
#import "DataSource.h"



@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    __weak typeof(self) weakSelf = self;
    [DataSourceManager setDataSourceRefresh:^{
        [weakSelf.tableView reloadData];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataSourceManager.reasons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.numberOfLines = 0;
    }
    Model *m = DataSourceManager.reasons[indexPath.row];
    cell.textLabel.text = m.text;
    cell.textLabel.textColor = m.textColor;
    return cell;
}

@end
