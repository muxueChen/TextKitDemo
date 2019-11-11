//
//  MXTextAttachment.h
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/6.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXTextAttachment : NSTextAttachment

+ (MXTextAttachment *)textAttachmentWithView:(UIView *)view;

@end

@interface NSAttributedString (NSTextAttachment)

/** 通过一个 UIView 创建一个 NSAttributedString 对象 */
+ (NSAttributedString *)attributedStringWithView:(UIView *)view;

/** 通过一个 UIImage 对象 创建一个 NSAttributedString 对象 */
+ (NSAttributedString *)attributedStringWithImage:(UIImage *)image;
@end
NS_ASSUME_NONNULL_END
