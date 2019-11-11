//
//  MXEmojiKeyBoard.h
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/6.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXEmojiModel.h"
NS_ASSUME_NONNULL_BEGIN
@class MXEmojiKeyBoard;
@protocol MXEmojiKeyBoardDelegate <NSObject>
@required
/** 点击表情键盘中的某一个键 */
- (void)emojiKeyBoard:(MXEmojiKeyBoard *)emojiKeyBoard touchClickeKey:(MXEmojiModel *)emoji emojiImage:(UIImage *)emojiImage;

@end
/** 表情键盘 */
@interface MXEmojiKeyBoard : UIView

+ (MXEmojiKeyBoard *)emojiKeyBoardWithDelegate:(id<MXEmojiKeyBoardDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
