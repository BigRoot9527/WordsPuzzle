//
//  UIView+AutoLayout.h
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/27.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

-(void)setupConstraintToWidth:(CGFloat)width toHeight:(CGFloat)height;

-(void)setupCenterConstrainTo:(UIView *)view withCenterX:(BOOL)isCenteredX withCenterY:(BOOL)isCenteredY;

@end
