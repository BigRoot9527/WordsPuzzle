//
//  WordsPuzzleTests.m
//  WordsPuzzleTests
//
//  Created by Tingwei Hsu on 2018/8/24.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WPSquareManager.h"

@interface WPSquareManagerTests : XCTestCase
@property (nonatomic, strong) WPSquareManager *manager;
@end

@interface WPSquareManager(Testing)
@property (nonatomic,strong) NSMutableArray<NSMutableArray* > *matrix;
@property (nonatomic,strong) NSArray<NSString *> *defaultWords;
@property NSInteger columns;
@property NSInteger rows;
- (void)_createMatrixOfWordsInSize:(CGSize)size;
@end

@implementation WPSquareManagerTests

- (void)setUp
{
    [super setUp];
    self.manager = [[WPSquareManager alloc] initWithSize:CGSizeMake(500, 800)];
    self.manager.columns = 5;
    self.manager.rows = 8;
    self.manager.matrix = [[NSMutableArray alloc] init];
    [self.manager _createMatrixOfWordsInSize:CGSizeMake(500, 800)];
}

- (void)tearDown
{
    self.manager = nil;
    [super tearDown];
}

- (void)testManagerInit
{
    XCTAssertEqual(self.manager.matrix.count, self.manager.columns);
    XCTAssertEqual(self.manager.matrix[0].count, self.manager.rows);
}

- (void)testManagerGetAllMatrix
{
    for (NSInteger x = 0; x < self.manager.columns; x++) {
        for (NSInteger y = 0; y < self.manager.rows; y++) {
            NSInteger z = (x*self.manager.rows + y) % self.manager.defaultWords.count;
            WPSquare *square = self.manager.matrix[x][y];
            XCTAssertEqual(square.word, self.manager.defaultWords[z]);
            XCTAssertEqual(square.rect.size.width, 100);
            XCTAssertEqual(square.rect.size.height, 100);
            XCTAssertEqual(square.rect.origin.x, 500 / self.manager.columns * x);
            XCTAssertEqual(square.rect.origin.y, 800 / self.manager.rows * y);
        }
    }
}






//- (instancetype)initWithSize:(CGSize)size;
//- (NSArray*)getAllMatrix;
//- (WPSquare*)getSquareOfCertainPoint:(CGPoint)point;
//- (void)setNewWord:(NSString*)word OnSqareRect:(CGRect)rect;





- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
