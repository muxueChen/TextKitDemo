//
//  MXFourViewController.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/12.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXFourViewController.h"
#import "MXLayoutManager.h"
@interface MXFourViewController ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSTextContainer *container;
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) MXLayoutManager *layoutManager;
@end

@implementation MXFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"TextKit 高度计算";
    NSString *container = @"iOS 7提供了通过增加字体权重来";
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:container attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}];
    MXLayoutManager *layout = [[MXLayoutManager alloc] init];

    [textStorage addLayoutManager:layout];
    [layout addTextContainer:self.container];
    self.textStorage = textStorage;
    self.layoutManager = layout;
    [self.view addSubview:self.textView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *container = @"iOS 7提供了通过增加字体权重来增";
    [self.textStorage replaceCharactersInRange:NSMakeRange(self.textStorage.length, 0) withString:container];
    CGRect rect = [self.layoutManager usedRectForTextContainer:self.container];
    NSLog(@"textH = %.2f", rect.size.height);
}

#pragma mark -- lazy 懒加载
- (UITextView *)textView {
    if (!_textView) {
        CGFloat w = self.view.frame.size.width - 20;
        CGFloat h = 300;
        CGFloat y = 50;
        CGFloat x = 10;
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, w, h) textContainer:self.container];
        _textView.font = [UIFont systemFontOfSize:17];
        // textDragInteraction 直接设置为NO就能禁止掉NSTextAttachment的拖拽交互。
        _textView.textDragOptions = UITextDragOptionsNone;
        if (@available(iOS 11.0, *)) {
             _textView.textDragInteraction.enabled = NO;
        }
    }
    return _textView;
}

- (NSTextContainer *)container {
    if (!_container) {
        CGFloat W = [UIScreen mainScreen].bounds.size.width;
        _container = [[NSTextContainer alloc] initWithSize:CGSizeMake(W, MAXFLOAT)];
        _container.maximumNumberOfLines = 2; // 设置最大行数
        _container.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _container;
}
@end
