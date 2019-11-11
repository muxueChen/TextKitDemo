//
//  MXDemoThreeViewController.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/6.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXDemoThreeViewController.h"
#import "MXEmojiModel.h"
#import "MXEmojiCell.h"
#import "MXTextStorage.h"
#import "MXLayoutManager.h"
#import "MXTextContainer.h"
#import "MXTextAttachment.h"
#import "MXEmojiKeyBoard.h"
#import "MXLabelKeyBoard.h"
#import "MXTextManager.h"

@interface MXDemoThreeViewController () <MXEmojiKeyBoardDelegate, UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) MXTextStorage *storage;
@property (nonatomic, strong) MXLayoutManager *layoutManager;
@property (nonatomic, strong) MXTextContainer *container;
@property (nonatomic, strong) MXEmojiKeyBoard *emojiKeyboard;
@property (nonatomic, strong) MXLabelKeyBoard *labelKeyboard;
//@property (nonatomic, strong) UIButton *;

@end

@implementation MXDemoThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"图文混排";
    [self.storage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.container];
    [self.view addSubview:self.textView];
    [self createKeyboardLabel];
}

#pragma mark -- events
- (void)changetoTextKeyboard {
    self.textView.inputView = nil;
    [self.textView reloadInputViews];
    if (!self.textView.isFirstResponder) {
        [self.textView becomeFirstResponder];
    }
}

- (void)changetoLabelKeyboard {
    self.textView.inputView = self.labelKeyboard;
    [self.textView reloadInputViews];
    if (!self.textView.isFirstResponder) {
        [self.textView becomeFirstResponder];
    }
}

- (void)changetoEmojiKeyboard {
    self.textView.inputView = self.emojiKeyboard;
    [self.textView reloadInputViews];
    if (!self.textView.isFirstResponder) {
        [self.textView becomeFirstResponder];
    }
}

#pragma mark -- delegate
- (void)emojiKeyBoard:(MXEmojiKeyBoard *)emojiKeyBoard touchClickeKey:(MXEmojiModel *)emoji emojiImage:(UIImage *)emojiImage {
    NSInteger textSelectLoc = _textView.selectedRange.location + _textView.selectedRange.length;
    NSAttributedString *attributedString = [[MXTextManager shareManager] attributedStringWithItem:emoji font:[UIFont systemFontOfSize:17]];
    if (attributedString) {
        [_storage appendAttributedString:attributedString];
        _textView.selectedRange = NSMakeRange(textSelectLoc + attributedString.length, 0);
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"%@", textView.attributedText.string);
}

#pragma mark -- create UI
- (void)createKeyboardLabel {
    CGFloat Y = CGRectGetMaxY(self.textView.frame) + 10;
    CGFloat X = 10;
    CGFloat W = 100;
    CGFloat H = 50;
    UIButton *textKeyboardBtn = [[UIButton alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    [textKeyboardBtn setTitle:@"文本键盘" forState:UIControlStateNormal];
    [textKeyboardBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [textKeyboardBtn addTarget:self action:@selector(changetoTextKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    X += 120;
    UIButton *lableKeyboardBtn = [[UIButton alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    [lableKeyboardBtn setTitle:@"标签键盘" forState:UIControlStateNormal];
    [lableKeyboardBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [lableKeyboardBtn addTarget:self action:@selector(changetoLabelKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    X += 120;
    UIButton *emojiKeyboardBtn = [[UIButton alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    [emojiKeyboardBtn setTitle:@"表情键盘" forState:UIControlStateNormal];
    [emojiKeyboardBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [emojiKeyboardBtn addTarget:self action:@selector(changetoEmojiKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:textKeyboardBtn];
    [self.view addSubview:lableKeyboardBtn];
    [self.view addSubview:emojiKeyboardBtn];
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
        _textView.delegate = self;
        // textDragInteraction 直接设置为NO就能禁止掉NSTextAttachment的拖拽交互。
        _textView.textDragOptions = UITextDragOptionsNone;
        if (@available(iOS 11.0, *)) {
             _textView.textDragInteraction.enabled = NO;
        }
    }
    return _textView;
}

- (MXTextStorage *)storage {
    if (!_storage) {
        _storage = [[MXTextStorage alloc] init];
    }
    return _storage;
}

- (MXLayoutManager *)layoutManager {
    if (!_layoutManager) {
        _layoutManager = [[MXLayoutManager alloc] init];
    }
    return _layoutManager;
}

- (MXTextContainer *)container {
    if (!_container) {
        _container = [[MXTextContainer alloc] init];
    }
    return _container;
}

- (MXEmojiKeyBoard *)emojiKeyboard {
    if (!_emojiKeyboard) {
        _emojiKeyboard = [MXEmojiKeyBoard emojiKeyBoardWithDelegate:self];
    }
    return _emojiKeyboard;
}

- (MXLabelKeyBoard *)labelKeyboard {
    if (!_labelKeyboard) {
        _labelKeyboard = [MXLabelKeyBoard labelKeyBoard];
    }
    return _labelKeyboard;
}
@end
