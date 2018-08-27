//
//  WPSquareView.m
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/24.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "WPSquareView.h"

@interface WPSquareView()
@end

@implementation WPSquareView

- (void)drawRect:(CGRect)rect {
    
    NSInteger columns = [self.dataSource numberOfColunmsForView:self];
    NSInteger rows = [self.dataSource numberOfRowsForView:self];
    
    for (NSInteger x = 0; x < columns; x++) {
        for (NSInteger y = 0; y < rows; y++) {
            CGRect inputRect = [self.dataSource rectOfSquareOnX:x AndY:y ForView:self];
            NSString *inputText = [self.dataSource wordOfSquareOnX:x AndY:y ForView:self];
            [self _drawSquareWithRect:inputRect];
            [self _drawText:inputText InRect:inputRect];
        }
    }
}

- (void)_drawSquareWithRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextAddRect(context, rect);
    CGContextSetLineWidth(context, 2.0);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)_drawText:(NSString *)text InRect:(CGRect)rect
{
    NSMutableParagraphStyle* textStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.alignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont fontWithName: @"Helvetica" size: 15];
    NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
    rect.origin.y = rect.origin.y + ((rect.size.height - [text sizeWithAttributes:@{NSFontAttributeName:font}].height) / 2);
    [text drawInRect: rect withAttributes: textFontAttributes];
}

@end
