//
//  MXEmojiModel.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/6.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXEmojiModel.h"

static NSString *MXEmoji_Expression_bundleName = @"MXEmoji_Expression.bundle";

@implementation MXEmojiModel

+ (NSMutableArray <MXEmojiModel *>*)emojiModels {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:MXEmoji_Expression_bundleName ofType:nil];
    if (!path) {
        return nil;
    }
    // 获取表情包
    NSBundle *emojiBundle = [NSBundle bundleWithPath:path];
    if (!emojiBundle) {
        return nil;
    }
    // plist
    NSString *emojiNamePath = [bundle pathForResource:@"MXEmoji_Expression.plist" ofType:nil];
    NSString *emojiImagePath = [bundle pathForResource:@"MXEmoji_ExpressionImage.plist" ofType:nil];
    if (!emojiNamePath || !emojiImagePath) {
        return nil;
    }
    //
    NSArray *emojiNameArray = [NSArray arrayWithContentsOfFile:emojiNamePath];
    NSDictionary *emojiImageDictionary = [NSDictionary dictionaryWithContentsOfFile:emojiImagePath];
    NSLog(@"%@", emojiNameArray);
    NSLog(@"%@", emojiImageDictionary);
    
    NSMutableArray <MXEmojiModel *>*emojis = [NSMutableArray array];
    for (NSInteger i = 0; i < emojiNameArray.count; i++) {
    
        NSString *emojiUnicode = emojiNameArray[i];
        if (!emojiImageDictionary[emojiUnicode]) {
            continue;
        }
        NSString *imageName = [emojiImageDictionary[emojiUnicode] stringByAppendingString:@"@2x.png"];
        NSString *imagePath = [emojiBundle pathForResource:imageName ofType:nil];
        if (!imagePath) {
            continue;
        }
        MXEmojiModel *emoji = [[MXEmojiModel alloc] init];
        emoji.unicode = emojiUnicode;
        emoji.imagePath = imagePath;
        [emojis addObject:emoji];
    }
    return emojis;
}
@end
