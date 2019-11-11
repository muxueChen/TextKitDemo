//
//  MXLabel.h
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/2.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MXTextKitStringBlock)(NSAttributedString *attributeString);

@interface MXLabel : UILabel
//字符串更新并添加回调
- (void)appendString:(NSAttributedString *)attributeString block:(MXTextKitStringBlock)block;

@end

NS_ASSUME_NONNULL_END
