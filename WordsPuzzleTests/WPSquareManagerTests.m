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
@property CGSize matrixSize;
@property NSInteger columns;
@property NSInteger rows;
- (void)_createMatrixInSize:(CGSize)size;
- (void)_fillMatrixWithWords:(NSArray*)words;
@end

@implementation WPSquareManagerTests

- (void)setUp
{
    [super setUp];
    self.manager = [[WPSquareManager alloc] init];
    self.manager.columns = 5;
    self.manager.rows = 8;
    self.manager.matrixSize = CGSizeMake(500, 800);
    self.manager.defaultWords = [[NSArray alloc] initWithObjects:@"臺",@"灣",@"人",@"需",@"要",@"消",@"波",@"塊", nil];
    self.manager.matrix = [[NSMutableArray alloc] init];
    [self.manager _createMatrixInSize:self.manager.matrixSize];
    [self.manager _fillMatrixWithWords:self.manager.defaultWords];

}

- (void)tearDown
{
    self.manager = nil;
    [super tearDown];
}

- (void)testManagerInitWithSize
{
    self.manager = [[WPSquareManager alloc] initWithSize:CGSizeMake(500, 800)];
    XCTAssertNotNil(self.manager.defaultWords);
    XCTAssertEqual(self.manager.matrix.count, self.manager.columns);
    XCTAssertEqual(self.manager.matrix[0].count, self.manager.rows);
    for (NSInteger x = 0; x < self.manager.columns; x++) {
        for (NSInteger y = 0; y < self.manager.rows; y++) {
            WPSquare *square = self.manager.matrix[x][y];
            XCTAssertTrue(square.rect.size.height);
            XCTAssertTrue(square.rect.size.width);
            XCTAssertNotNil(square.word);
        }
    }
}

- (void)testManagerGetAllMatrix
{
    for (NSInteger x = 0; x < self.manager.columns; x++) {
        for (NSInteger y = 0; y < self.manager.rows; y++) {
            NSInteger z = (x + y * self.manager.columns) % self.manager.defaultWords.count;
            WPSquare *square = self.manager.matrix[x][y];
            XCTAssertEqual(square.word, self.manager.defaultWords[z]);
            XCTAssertEqual(square.rect.size.width, 100);
            XCTAssertEqual(square.rect.size.height, 100);
            XCTAssertEqual(square.rect.origin.x, 500 / self.manager.columns * x);
            XCTAssertEqual(square.rect.origin.y, 800 / self.manager.rows * y);
        }
    }
}

- (void)testManagerGetSquareOfCertainPoint
{
    WPSquare *leftUp = [self.manager getSquareOfCertainPoint: CGPointMake(0, 0)];
    XCTAssertEqual(leftUp.rect.origin.x, 0);
    XCTAssertEqual(leftUp.rect.origin.y, 0);
    XCTAssertEqual(leftUp.rect.size.width, 100);
    XCTAssertEqual(leftUp.rect.size.height, 100);
    XCTAssertEqual(leftUp.word.description, @"臺");
    WPSquare *rightUp = [self.manager getSquareOfCertainPoint: CGPointMake(500, 0)];
    XCTAssertEqual(rightUp.rect.origin.x, 400);
    XCTAssertEqual(rightUp.rect.origin.y, 0);
    XCTAssertEqual(rightUp.rect.size.width, 100);
    XCTAssertEqual(rightUp.rect.size.height, 100);
    XCTAssertEqual(rightUp.word.description, @"要");
    WPSquare *leftDown = [self.manager getSquareOfCertainPoint: CGPointMake(0, 800)];
    XCTAssertEqual(leftDown.rect.origin.x, 0);
    XCTAssertEqual(leftDown.rect.origin.y, 700);
    XCTAssertEqual(leftDown.rect.size.width, 100);
    XCTAssertEqual(leftDown.rect.size.height, 100);
    XCTAssertEqual(leftDown.word.description, @"需");
    WPSquare *rightDown = [self.manager getSquareOfCertainPoint: CGPointMake(500, 800)];
    XCTAssertEqual(rightDown.rect.origin.x, 400);
    XCTAssertEqual(rightDown.rect.origin.y, 700);
    XCTAssertEqual(rightDown.rect.size.width, 100);
    XCTAssertEqual(rightDown.rect.size.height, 100);
    XCTAssertEqual(rightDown.word.description, @"塊");
    WPSquare *middle = [self.manager getSquareOfCertainPoint: CGPointMake(250, 400)];
    XCTAssertEqual(middle.rect.origin.x, 200);
    XCTAssertEqual(middle.rect.origin.y, 400);
    XCTAssertEqual(middle.rect.size.width, 100);
    XCTAssertEqual(middle.rect.size.height, 100);
    XCTAssertEqual(middle.word.description, @"波");
}

- (void)testManagerSetNewWord
{
    [self.manager setNewWord:@"B" OnPoint:CGPointMake(210, 110)];
    WPSquare *square = [self.manager getSquareOfCertainPoint: CGPointMake(210, 110)];
    XCTAssertEqual(square.word.description, @"B");
    [self.manager setNewWord:@"嗨" OnPoint:CGPointMake(-10, 999)];
    WPSquare *another = [self.manager getSquareOfCertainPoint: CGPointMake(-10, 999)];
    XCTAssertEqual(another.word.description, @"嗨");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
