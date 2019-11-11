//
//  MXTextAttachment.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/6.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXTextAttachment.h"

@interface MXTextAttachment ()
@property (nonatomic, strong) UIImage *viewImage;
@end

@implementation MXTextAttachment

- (nullable UIImage *)imageForBounds:(CGRect)imageBounds textContainer:(nullable NSTextContainer *)textContainer characterIndex:(NSUInteger)charIndex {
    if (_viewImage) {
        return _viewImage;
    } else {
        return [super imageForBounds:imageBounds textContainer:textContainer characterIndex:charIndex];
    }
}

+ (MXTextAttachment *)textAttachmentWithView:(UIView *)view {
    if (!view) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width, view.frame.size.height), NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    MXTextAttachment *attachment = [[MXTextAttachment alloc] init];
    attachment.viewImage = viewImage;
    attachment.bounds = view.bounds;
    return attachment;
}
@end

@implementation NSAttributedString (MXTextAttachment)

+ (NSAttributedString *)attributedStringWithView:(UIView *)view {
    MXTextAttachment *Attachment = [MXTextAttachment textAttachmentWithView:view];
    return [NSAttributedString attributedStringWithAttachment:Attachment];
}

+ (NSAttributedString *)attributedStringWithImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    MXTextAttachment *attachment = [[MXTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachment];
    return attributedString;
}
@end
