//
//  ViewController.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/2.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "ViewController.h"
#import "DemoOneViewController.h"
#import "DemoTwoViewController.h"
#import "MXDemoThreeViewController.h"
#import "MXFourViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

#pragma mark -- lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"入门";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"进阶";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"图文混排";
    } else {
        cell.textLabel.text = @"动态高度计算";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[DemoOneViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[DemoTwoViewController new] animated:YES];
    } else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[MXDemoThreeViewController new] animated:YES];
    } else {
        [self.navigationController pushViewController:[MXFourViewController new] animated:YES];
    }
}
@end
