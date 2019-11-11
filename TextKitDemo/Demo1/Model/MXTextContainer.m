//
//  MXTextContainer.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/4.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXTextContainer.h"

@implementation MXTextContainer
// 通过继承NSTextContainer，我们可以使得textView不再是一个规规矩矩的矩形。NSTextContainer负责回答这个问题：对于给定的矩形，哪个部分可以放文字，这个问题由下面这个方法来回答：
- (CGRect)lineFragmentRectForProposedRect:(CGRect)proposedRect atIndex:(NSUInteger)characterIndex writingDirection:(NSWritingDirection)baseWritingDirection remainingRect:(nullable CGRect *)remainingRect {
    CGRect rect = [super lineFragmentRectForProposedRect:proposedRect atIndex:characterIndex writingDirection:baseWritingDirection remainingRect:remainingRect];
    CGSize size = self.size;
    return rect;
}
@end
