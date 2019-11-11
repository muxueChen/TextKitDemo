//
//  MXHighlightStorage.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/3.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXHighlightStorage.h"

@implementation MXHighlightStorage

#pragma mark -  Override Base Function

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableAttributedString = [[NSMutableAttributedString alloc] init];
        self.expression = [NSRegularExpression regularExpressionWithPattern:@"(\\~\\w+(\\s*\\w+)*\\s*\\~)" options:0 error:NULL];
    }
    return self;
}

- (NSString *)string {
    return self.mutableAttributedString.string;
}

- (NSDictionary<NSString *,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [self.mutableAttributedString attributesAtIndex:location effectiveRange:range];
}

- (void)setAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range {
    [self beginEditing];
    [self.mutableAttributedString setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

// Sends out -textStorage:willProcessEditing, fixes the attributes, sends out -textStorage:didProcessEditing, and notifies the layout managers of change with the -processEditingForTextStorage:edited:range:changeInLength:invalidatedRange: method.  Invoked from -edited:range:changeInLength: or -endEditing.
- (void)processEditing {
    [super processEditing];
    
    //去除当前段落的颜色属性
    NSRange paragaphRange = [self.string paragraphRangeForRange: self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragaphRange];
    //根据正则匹配，添加新属性
    [self.expression enumerateMatchesInString:self.string options:NSMatchingReportProgress range:paragaphRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:result.range];
    }];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    [self beginEditing];
    [self.mutableAttributedString replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:(NSInteger)str.length - (NSInteger)range.length];
    [self endEditing];
}

@end
