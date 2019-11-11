//
//  MXTextStorage.h
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/4.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXTextStorage : NSTextStorage
@property (nonatomic, strong) NSMutableAttributedString *originString;
@property (nonatomic, strong) NSRegularExpression *expression;
@property (nonatomic, strong) UIFont *font;
@end

NS_ASSUME_NONNULL_END
