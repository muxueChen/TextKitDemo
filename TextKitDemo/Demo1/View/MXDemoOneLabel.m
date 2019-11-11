//
//  MXDemoOneLabel.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/4.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXDemoOneLabel.h"
#import "MXTextStorage.h"
#import "MXLayoutManager.h"
#import "MXTextContainer.h"

#pragma mark --- 模型类
@interface _MXSubContainer : NSObject
@property (nonatomic, strong) NSAttributedString *attrbutedString;
@property (nonatomic, assign) NSRange range;
@property (nonatomic, copy) MXTextBlock clickedBlock;
@end

@implementation _MXSubContainer

@end

#pragma mark --
@interface MXDemoOneLabel ()
@property (nonatomic, strong) NSTextStorage *storage;
@property (nonatomic, strong) MXLayoutManager *layoutManager;
@property (nonatomic, strong) MXTextContainer *container;
@property (nonatomic, strong) NSMutableArray <_MXSubContainer *> *subContainers;
@end

@implementation MXDemoOneLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _subContainers = [NSMutableArray array];
        [self setupSystemTextKitConfiguration];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    NSInteger glyphIndex = [_layoutManager glyphIndexForPoint:point inTextContainer:_container];
    CGRect glyphRect = [_layoutManager boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1) inTextContainer:_container];
    if (CGRectContainsPoint(glyphRect, point)) {
        NSInteger charIndex = [_layoutManager characterIndexForGlyphAtIndex:glyphIndex];
        [_subContainers enumerateObjectsUsingBlock:^(_MXSubContainer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (NSLocationInRange(charIndex, obj.range)) {
                if (obj.clickedBlock) {
                    obj.clickedBlock(obj.attrbutedString);
                }
                *stop = YES;
            }
        }];
    }
}

- (void)drawTextInRect:(CGRect)rect {
    NSRange range = NSMakeRange(0, self.storage.length);
    [self.layoutManager drawBackgroundForGlyphRange:range atPoint:CGPointMake(0.0, 0.0)];
    [self.layoutManager drawGlyphsForGlyphRange:range atPoint:CGPointMake(0.0, 0.0)];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.container.size = self.bounds.size;
}

- (void)appendAttributedString:(NSAttributedString *)attrString clickedBlock:(MXTextBlock)clickedBlock {
    if (!attrString) {
        return;
    }
    _MXSubContainer *subContainer = [[_MXSubContainer alloc] init];
    subContainer.range = NSMakeRange(self.storage.length, attrString.length);
    subContainer.clickedBlock = clickedBlock;
    subContainer.attrbutedString = attrString;
    
    [self.subContainers addObject:subContainer];
    [self.storage appendAttributedString:attrString];
    [self setNeedsDisplay];
}

- (void)setupSystemTextKitConfiguration {
    self.storage = [[NSTextStorage alloc] init];
    self.layoutManager = [[MXLayoutManager alloc] init];
    self.container = [[MXTextContainer alloc] init];
    [self.storage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.container];
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
