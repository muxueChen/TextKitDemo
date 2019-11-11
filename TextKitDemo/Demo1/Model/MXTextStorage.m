//
//  MXTextStorage.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/4.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXTextStorage.h"

@implementation MXTextStorage

#pragma mark -- super

- (instancetype)init {
    self = [super init];
    if (self) {
        self.originString = [[NSMutableAttributedString alloc] init];
        self.expression = [NSRegularExpression regularExpressionWithPattern:@"(\\~\\w+(\\s*\\w+)*\\s*\\~)" options:0 error:NULL];
        self.font = [UIFont systemFontOfSize:17];
    }
    return self;
}

- (NSString *)string {
    return self.originString.string;
}

 - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self beginEditing];
    [self.originString replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:(NSInteger)str.length - (NSInteger)range.length];
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range {
    [self beginEditing];
    [self.originString setAttributes:attrs range:range];
    //不支持系统表情的输入
    if (![[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
        [self.originString addAttribute:NSFontAttributeName value:self.font range:range];
    }
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

- (NSDictionary<NSString *,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [self.originString attributesAtIndex:location effectiveRange:range];
}

- (void)processEditing {
    [super processEditing];
    NSRange paragraphRange = [self.string paragraphRangeForRange:self.editedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:paragraphRange];
    [self.expression enumerateMatchesInString:self.string options:NSMatchingReportProgress range:paragraphRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [self addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:result.range];
    }];
}
@end
