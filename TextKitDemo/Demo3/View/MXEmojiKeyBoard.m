//
//  MXEmojiKeyBoard.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/6.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXEmojiKeyBoard.h"
#import "MXEmojiCell.h"

// UIInputViewAudioFeedback 键盘声音协议类，官方文档 https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/InputViews/InputViews.html
@interface MXEmojiKeyBoard () <UICollectionViewDataSource, UICollectionViewDelegate, UIInputViewAudioFeedback>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <MXEmojiModel *>*dataSource;
@property (nonatomic, weak) id<MXEmojiKeyBoardDelegate>delegate;
@end

@implementation MXEmojiKeyBoard

+ (MXEmojiKeyBoard *)emojiKeyBoardWithDelegate:(id<MXEmojiKeyBoardDelegate>)delegate {
    MXEmojiKeyBoard *board = [[MXEmojiKeyBoard alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400)];
    board.backgroundColor = UIColor.redColor;
    board.delegate = delegate;
    return board;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MXEmojiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MXEmojiCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.grayColor;
    cell.model = _dataSource[indexPath.row];
    return cell;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MXEmojiCell *cell = (MXEmojiCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([_delegate respondsToSelector:@selector(emojiKeyBoard:touchClickeKey:emojiImage:)]) {
        [_delegate emojiKeyBoard:self touchClickeKey:_dataSource[indexPath.row] emojiImage:cell.imageView.image];
    }
    [[UIDevice currentDevice] playInputClick];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50, 50);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.orangeColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.contentInset = UIEdgeInsetsMake(50, 10, 50, 10);
        [_collectionView registerClass:MXEmojiCell.class forCellWithReuseIdentifier:@"MXEmojiCell"];
    }
    return _collectionView;
}

- (NSMutableArray<MXEmojiModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [MXEmojiModel emojiModels];
    }
    return _dataSource;
}

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}
@end
