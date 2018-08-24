//
//  WPSquareManager.m
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/24.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "WPSquareManager.h"

@interface WPSquareManager()
@property (nonatomic,strong) NSMutableArray<NSMutableArray* >* matrix;
@property (nonatomic,strong) NSArray<NSString *>* defaultWords;
@property NSInteger columns;
@property NSInteger rows;

@end

@implementation WPSquareManager


- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.columns = 8;
        self.rows = 8;
        self.defaultWords = [[NSArray alloc] initWithObjects:@"臺",@"灣",@"人",@"需",@"要",@"消",@"波",@"塊", nil];
        self.matrix = [[NSMutableArray alloc] init];
        [self _createMatrixOfWordsInSize:size];
    }
    return self;
}

- (void)_createMatrixOfWordsInSize:(CGSize)size
{
    CGFloat squareWidth = size.width / self.columns;
    CGFloat squareHeight = size.height / self.rows;
    NSInteger k = 0;
    for (NSInteger x = 0; x < self.columns; x ++) {
        NSMutableArray *newColumn = [[NSMutableArray alloc] init];
        for (NSInteger y = 0; y < self.rows; y ++) {
            CGRect rect = CGRectMake(squareWidth * x, squareHeight * y , squareWidth, squareHeight);
            [newColumn addObject:[[WPSquare alloc] initWithCGRect:rect AndWord:self.defaultWords[0]]];
            k = k == self.defaultWords.count - 1 ? 0 : k + 1;
        }
        [self.matrix addObject:newColumn];
    }
}

- (NSArray*)getAllMatrix
{
    return [self.matrix copy];
}

- (WPSquare*)getSquareOfCertainPoint:(CGPoint)point
{
    WPSquare *firstPoint = self.matrix[0][0];
    NSInteger xCount = firstPoint.rect.size.width;
    NSInteger yCount = firstPoint.rect.size.height;
    return self.matrix[xCount][yCount];
}

- (void)setNewWord:(NSString*)word OnSqareRect:(CGRect)rect
{
    for(NSMutableArray *oneColumn in self.matrix) {
        for(WPSquare *square in oneColumn) {
            if (square.rect.origin.x == rect.origin.x && square.rect.origin.y == rect.origin.y) {
                square.word = word;
            }
        }
    }
}

@end
