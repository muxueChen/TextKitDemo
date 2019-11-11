//
//  MXEmojiModel.h
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/6.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXEmojiModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *unicode;
@property (nonatomic, copy) NSString *imagePath;

+ (NSMutableArray <MXEmojiModel *>*)emojiModels;
@end

NS_ASSUME_NONNULL_END
