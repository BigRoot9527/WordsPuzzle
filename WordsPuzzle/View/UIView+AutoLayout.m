//
//  UIView+AutoLayout.m
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/27.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

-(void)setupConstraintToWidth:(CGFloat)width toHeight:(CGFloat)height {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [[NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:width] setActive:YES];
    
    [[NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:height] setActive:YES];
}

-(void)setupCenterConstrainTo:(UIView *)view withCenterX:(BOOL)isCenteredX withCenterY:(BOOL)isCenteredY {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [[NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:0] setActive: isCenteredX];
    
    [[NSLayoutConstraint constraintWithItem:self
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0] setActive: isCenteredY];
}

@end
