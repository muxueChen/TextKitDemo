//
//  MXEmojiCell.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/6.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXEmojiCell.h"

@implementation MXEmojiCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setModel:(MXEmojiModel *)model {
    _model = model;
    self.imageView.image = [UIImage imageWithContentsOfFile:model.imagePath];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}
@end
