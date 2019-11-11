//
//  DemoTwoViewController.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/5.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "DemoTwoViewController.h"
#import "MXTextStorage.h"
#import "MXLayoutManager.h"
#import "MXTextContainer.h"
#import "MXHighlightStorage.h"

@interface DemoTwoViewController ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) MXTextStorage *storage;
@property (nonatomic, strong) MXLayoutManager *layoutManager;
@property (nonatomic, strong) MXTextContainer *container;
@end

@implementation DemoTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    self.container = [[MXTextContainer alloc] init];
    self.storage = [[MXTextStorage alloc] init];
    self.layoutManager = [[MXLayoutManager alloc] init];
    [self.storage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.container];
    [self.view addSubview:self.textView];
    self.textView.center = self.view.center;
    [self.storage replaceCharactersInRange:NSMakeRange(0, 0) withString:@"波浪线引起来的字符都会被~变为蓝色~，对，是这样的"];
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) textContainer:self.container];
    }
    return _textView;
}

@end
