//
//  MXTextManager.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/11.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXTextManager.h"
#import "MXTextAttachment.h"

static NSString *MXTextAttributeNameKey = @"MXAttributeNameKey";
static NSString *MXEmoji_Expression_bundleName = @"MXEmoji_Expression.bundle";

@interface MXTextManager ()
// 方便查找，提高查找效率，采用哈希表来存储
@property (nonatomic, strong) NSMutableDictionary <NSString *, MXEmojiModel *>*emojiDic;
@end

@implementation MXTextManager

static MXTextManager *manager = nil;
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MXTextManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _expression = [NSRegularExpression regularExpressionWithPattern:@"\\[.+?\\]" options:0 error:NULL];
    }
    return self;
}

- (NSMutableDictionary<NSString *,MXEmojiModel *> *)emojiDic {
    if (!_emojiDic) {
        [self emojiModels];
    }
    return _emojiDic;
}

- (NSArray<MXEmojiModel *> *)emojis {
    if (!_emojis) {
        [self emojiModels];
    }
    return _emojis;
}

- (NSString *)removeAttributeWithAttributeString:(NSAttributedString *)attributeString range:(NSRange)range {
    if (range.location == NSNotFound || range.length == NSNotFound) {
        return nil;
    }

    NSMutableString *result = [[NSMutableString alloc] init];
    if (range.length == 0) {
        return result;
    }

    NSString *string = attributeString.string;
    [attributeString enumerateAttribute:MXTextAttributeNameKey inRange:range options:kNilOptions usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        MXEmojiModel *item = value;
        if (item && item.unicode) {
            [result appendString:item.unicode];
        } else {
            [result appendString:[string substringWithRange:range]];
        }
    }];
    return result;
}

- (NSAttributedString *)attributedString:(NSString *)string range:(NSRange)range font:(UIFont *)font {
//    NSMutableAttributedString *
//    [_expression enumerateMatchesInString:string options:0 range:range usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        
//    }];
    return nil;
}

//
- (NSAttributedString *)attributedStringWithItem:(MXEmojiModel *)item font:(UIFont *)font {
    CGFloat emojiH = font.lineHeight;
    CGFloat emojiW = emojiH;
    UIImage *image = [UIImage imageWithContentsOfFile:item.imagePath];
    if (!image) {
        return nil;
    }
    
    NSTextAttachment *textAlignment = [[NSTextAttachment alloc] init];
    textAlignment.image = image;
    textAlignment.bounds = CGRectMake(0, font.descender, emojiW, emojiH);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:textAlignment]];
    [attributedString addAttribute:MXTextAttributeNameKey value:item range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}

- (void)emojiModels {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:MXEmoji_Expression_bundleName ofType:nil];
    if (!path) {
        return ;
    }
    // 获取表情包
    NSBundle *emojiBundle = [NSBundle bundleWithPath:path];
    if (!emojiBundle) {
        return ;
    }
    // plist
    NSString *emojiNamePath = [bundle pathForResource:@"MXEmoji_Expression.plist" ofType:nil];
    NSString *emojiImagePath = [bundle pathForResource:@"MXEmoji_ExpressionImage.plist" ofType:nil];
    if (!emojiNamePath || !emojiImagePath) {
        return ;
    }
    //
    NSArray *emojiNameArray = [NSArray arrayWithContentsOfFile:emojiNamePath];
    NSDictionary *emojiImageDictionary = [NSDictionary dictionaryWithContentsOfFile:emojiImagePath];
    NSLog(@"%@", emojiNameArray);
    NSLog(@"%@", emojiImageDictionary);
    
    NSMutableArray <MXEmojiModel *>*emojis = [NSMutableArray array];
    NSMutableDictionary *emojiDic = [NSMutableDictionary dictionary];
    
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
        [emojiDic setValue:emoji forKey:emojiUnicode];
    }
    _emojiDic = emojiDic;
    _emojis = emojis;
}
@end
