//
//  WPSquareView.h
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/24.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPSquareView;

@protocol WPSquareViewDataSource
- (NSInteger)numberOfColunmsForView:(UIView*)view;
- (NSInteger)numberOfRowsForView:(UIView*)view;
- (CGRect)rectOfSquareOnX:(NSInteger)x AndY:(NSInteger)y ForView:(UIView*)view;
- (NSString *)wordOfSquareOnX:(NSInteger)x AndY:(NSInteger)y ForView:(UIView*)view;
@end

@interface WPSquareView : UIView
@property (nonatomic,weak) id<WPSquareViewDataSource> dataSource;

@end
