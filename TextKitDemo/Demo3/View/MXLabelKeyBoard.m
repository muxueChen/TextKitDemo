//
//  MXLabelKeyBoard.m
//  TextKitDemo
//
//  Created by 陈学明 on 2019/11/8.
//  Copyright © 2019 陈学明. All rights reserved.
//

#import "MXLabelKeyBoard.h"

@implementation MXLabelKeyBoard

+ (MXLabelKeyBoard *)labelKeyBoard {
    MXLabelKeyBoard *board = [[MXLabelKeyBoard alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400)];
    board.backgroundColor = UIColor.orangeColor;
    return board;
}

@end
