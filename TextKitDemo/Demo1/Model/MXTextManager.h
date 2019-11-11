//
//  MXTextManager.h
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/11.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MXEmojiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXTextManager : NSObject

@property (nonatomic, strong) NSRegularExpression *expression;
@property (nonatomic, strong) NSArray <MXEmojiModel *>*emojis;

+ (instancetype)shareManager;
/**
 * 移除属性字符串的所有属性
 */
- (NSString *)removeAttributeWithAttributeString:(NSAttributedString *)attributeString range:(NSRange)range;

/**
 * 通过一个无格式的字符串生成一个 属性字符串
 *
 */
- (NSAttributedString *)attributedString:(NSString *)string range:(NSRange)range font:(UIFont *)font;

/**
 * 通过一个
 */
- (NSAttributedString *)attributedStringWithItem:(MXEmojiModel *)item font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
