//
//  MXDemoOneLabel.h
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/4.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MXTextBlock)(NSAttributedString *attributedString);

@interface MXDemoOneLabel : UILabel

- (void)appendAttributedString:(NSAttributedString *)attrString clickedBlock:(MXTextBlock)clickedBlock;
@end

NS_ASSUME_NONNULL_END
