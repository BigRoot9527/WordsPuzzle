//
//  ViewController.m
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/24.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "ViewController.h"
#import "WPSquareManager.h"
#import "WPSquareView.h"
#import "UIView+AutoLayout.h"

@interface ViewController ()
@property(nonatomic, strong) WPSquareManager *manager;
@property(nonatomic, strong) WPSquareView *matrixView;
@property(nonatomic) NSInteger inputColumns;
@property(nonatomic) NSInteger inputRows;
@end

@interface ViewController (WPSquareViewDataSource) <WPSquareViewDataSource>
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.inputColumns = 8;
    self.inputRows = 8;
    self.matrixView = [[WPSquareView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.matrixView.dataSource = self;
    [self.view addSubview: self.matrixView];
    [self _setupConstraint];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.manager = [[WPSquareManager alloc] initWithSize:self.matrixView.bounds.size InColumns:self.inputColumns AndRows:self.inputRows];
}

- (void)_setupConstraint
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    [self.matrixView setupConstraintToWidth:screenSize.width * 0.9 toHeight:screenSize.height * 0.9];
    [self.matrixView setupCenterConstrainTo:self.view withCenterX:YES withCenterY:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

@implementation ViewController (WPSquareViewDataSource)
- (NSInteger)numberOfColunmsForView:(UIView *)view
{
    return self.inputColumns;
}

- (NSInteger)numberOfRowsForView:(UIView *)view
{
    return self.inputRows;
}

- (CGRect)rectOfSquareOnX:(NSInteger)x AndY:(NSInteger)y ForView:(UIView *)view
{
    return [self.manager getSquareOfColumn:x AndRow:y].rect;
}

- (NSString *)wordOfSquareOnX:(NSInteger)x AndY:(NSInteger)y ForView:(UIView *)view
{
    return [self.manager getSquareOfColumn:x AndRow:y].word;
}

@end
