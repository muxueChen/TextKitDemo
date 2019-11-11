//
//  DemoOneViewController.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/4.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "DemoOneViewController.h"
#import "MXDemoOneLabel.h"
#import "MXLabel.h"

@interface DemoOneViewController ()
@property (nonatomic, strong) MXDemoOneLabel *label;

@end

@implementation DemoOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"TextKit 入门";
    [self.view addSubview:self.label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSInteger R = arc4random() % 255;
    NSInteger G = arc4random() % 255;
    NSInteger B = arc4random() % 255;
    UIColor *color = [[UIColor alloc] initWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"哈哈哈" attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    [self.label appendAttributedString:attributedString clickedBlock:^(NSAttributedString * _Nonnull attributedString) {
        NSLog(@">>>>%@", attributedString.string);
    }];
}

- (MXDemoOneLabel *)label {
    if (!_label) {
        _label = [[MXDemoOneLabel alloc] initWithFrame:CGRectMake(50, 200, self.view.frame.size.width - 100, 200)];
        _label.userInteractionEnabled = YES;
    }
    return _label;
}

@end
