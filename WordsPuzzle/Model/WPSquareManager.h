//
//  WPSquareManager.h
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/24.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPSquare.h"

@interface WPSquareManager : NSObject
- (instancetype)initWithSize:(CGSize)size InColumns:(NSInteger)columns AndRows:(NSInteger)rows;
- (WPSquare*)getSquareOfColumn:(NSInteger)x AndRow:(NSInteger)y;
- (WPSquare*)getSquareOfCertainPoint:(CGPoint)point;
- (void)setNewWord:(NSString*)word OnPoint:(CGPoint)point;
@end
