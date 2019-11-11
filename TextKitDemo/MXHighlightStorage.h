//
//  MXHighlightStorage.h
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/3.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXHighlightStorage : NSTextStorage
@property (nonatomic, strong) NSMutableAttributedString *mutableAttributedString;
@property (nonatomic, strong) NSRegularExpression *expression;
@end

NS_ASSUME_NONNULL_END
