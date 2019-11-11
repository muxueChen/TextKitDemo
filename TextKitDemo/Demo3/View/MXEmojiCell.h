//
//  MXEmojiCell.h
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/6.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXEmojiModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MXEmojiCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) MXEmojiModel *model;
@end

NS_ASSUME_NONNULL_END
