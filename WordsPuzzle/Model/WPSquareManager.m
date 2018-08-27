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
@property CGSize matrixSize;
@property NSInteger columns;
@property NSInteger rows;

@end

@implementation WPSquareManager


- (instancetype)initWithSize:(CGSize)size InColumns:(NSInteger)columns AndRows:(NSInteger)rows
{
    self = [super init];
    if (self) {
        self.columns = columns;
        self.rows = rows;
        self.matrixSize = size;
        self.defaultWords = [[NSArray alloc] initWithObjects:@"臺",@"灣",@"人",@"需",@"要",@"消",@"波",@"塊",@"消",@"波",@"塊",@"需",@"要",@"臺",@"灣",@"人", nil];
        self.matrix = [[NSMutableArray alloc] init];
        [self _createMatrixInSize:self.matrixSize];
        [self _fillMatrixWithWords:self.defaultWords];
    }
    return self;
}

- (void)_createMatrixInSize:(CGSize)size;
{
    CGFloat squareWidth = size.width / self.columns;
    CGFloat squareHeight = size.height / self.rows;
    for (NSInteger x = 0; x < self.columns; x ++) {
        NSMutableArray *newColumn = [[NSMutableArray alloc] init];
        for (NSInteger y = 0; y < self.rows; y ++) {
            CGRect rect = CGRectMake(squareWidth * x, squareHeight * y , squareWidth, squareHeight);
            WPSquare *square = [[WPSquare alloc] init];
            square.rect = rect;
            [newColumn addObject: square];
        }
        [self.matrix addObject:newColumn];
    }
}

- (void)_fillMatrixWithWords:(NSArray*)words
{
    NSInteger k = 0;
    for (NSInteger y = 0; y < self.rows; y++) {
        for (NSInteger x = 0; x < self.columns; x++) {
            WPSquare *square = self.matrix[x][y];
            square.word = self.defaultWords[k];
            k = k < self.defaultWords.count - 1 ? k + 1 : 0;
        }
    }
}

- (NSArray*)_getAllMatrix
{
    return [self.matrix copy];
}

- (WPSquare*)getSquareOfColumn:(NSInteger)x AndRow:(NSInteger)y
{
    return self.matrix[x][y];
}

- (WPSquare*)getSquareOfCertainPoint:(CGPoint)point
{
    WPSquare *lastSquare = self.matrix[self.columns - 1][self.rows - 1];
    
    // + width(height)/2 to prevent xCount & yCount calculation result from dicreasing of 1 because of deviding with float.
    CGPoint fixedPoint = CGPointMake(
                                 point.x < 0 ? 0 : point.x > lastSquare.rect.origin.x ? lastSquare.rect.origin.x + (lastSquare.rect.size.width / 2) : point.x,
                                 point.y < 0 ? 0 : point.y > lastSquare.rect.origin.y ? lastSquare.rect.origin.y + (lastSquare.rect.size.height / 2) : point.y);
    
    NSInteger xCount = fixedPoint.x / lastSquare.rect.size.width;
    NSInteger yCount = fixedPoint.y / lastSquare.rect.size.height;
    return [self getSquareOfColumn:xCount AndRow:yCount];
}

- (void)setNewWord:(NSString*)word OnPoint:(CGPoint)point
{
    WPSquare *square = [self getSquareOfCertainPoint:point];
    square.word = word;
}

@end
