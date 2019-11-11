//
//  MXLabel.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/2.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXLabel.h"

@interface MXLabel ()
// 子标签
@property (nonatomic, strong) NSMutableArray <NSAttributedString *> *subAttributedStringsArrM;
// 子标签对应的范围
@property (nonatomic, strong) NSMutableArray <NSValue *> *subAttributedStringRangesArrM;
// 子标签的回调
@property (nonatomic, strong) NSMutableArray <MXTextKitStringBlock> *stringOptionsArrM;
// 内容数据源
@property (nonatomic, strong) NSTextStorage *textStorage;
// 布局管理
@property (nonatomic, strong) NSLayoutManager *layoutManager;
//
@property (nonatomic, strong) NSTextContainer *textContainer;
@end

@implementation MXLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.subAttributedStringsArrM = [NSMutableArray array];
        self.subAttributedStringRangesArrM = [NSMutableArray array];
        self.stringOptionsArrM = [NSMutableArray array];
        [self setupSystemTextKitConfiguration];
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    NSRange range = NSMakeRange(0, self.textStorage.length);
    [self.layoutManager drawBackgroundForGlyphRange:range atPoint:CGPointMake(0.0, 0.0)];
    [self.layoutManager drawGlyphsForGlyphRange:range atPoint:CGPointMake(0.0, 0.0)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textContainer.size = self.bounds.size;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    //根据点来获取该位置glyph的index
    NSInteger glythIndex = [self.layoutManager glyphIndexForPoint:point inTextContainer:self.textContainer];
    //获取改glyph对应的rect
    CGRect glythRect = [self.layoutManager boundingRectForGlyphRange:NSMakeRange(glythIndex, 1) inTextContainer:self.textContainer];
    //最终判断该字形的显示范围是否包括点击的location
    if (CGRectContainsPoint(glythRect, point)) {
        NSInteger characterIndex = [self.layoutManager characterIndexForGlyphAtIndex:glythIndex];
        [self.subAttributedStringRangesArrM enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = obj.rangeValue;
            if (NSLocationInRange(characterIndex, range)) {
                MXTextKitStringBlock block = self.stringOptionsArrM[idx];
                block(self.subAttributedStringsArrM[idx]);
            }
        }];
    }
}

- (void)appendString:(NSAttributedString *)attributeString block:(MXTextKitStringBlock)block {
    [self.subAttributedStringsArrM addObject:attributeString];
    
    NSRange range = NSMakeRange(self.textStorage.length, attributeString.length);
    [self.subAttributedStringRangesArrM addObject:[NSValue valueWithRange:range]];

    [self.stringOptionsArrM addObject:block];
    [self.textStorage appendAttributedString:attributeString];
}


#pragma mark -  Object Private Function

- (void)setupSystemTextKitConfiguration {
    self.textStorage = [[NSTextStorage alloc] init];
    self.layoutManager = [[NSLayoutManager alloc] init];
    self.textContainer = [[NSTextContainer alloc] init];
    
    [self.textStorage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.textContainer];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self setupSystemTextKitConfiguration];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self setupSystemTextKitConfiguration];
}

@end
