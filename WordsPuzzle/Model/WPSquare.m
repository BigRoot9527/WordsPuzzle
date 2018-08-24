//
//  WPSquare.m
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/24.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPSquare.h"

@implementation WPSquare

- (instancetype)initWithCGRect:(CGRect)rect AndWord:(NSString*)word
{
    self = [super init];
    if (self) {
        self.rect = rect;
        self.word = word;
    }
    return self;
}

@end

