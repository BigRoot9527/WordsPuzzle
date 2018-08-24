//
//  WPSquare.h
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/24.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WPSquare : NSObject

@property (nonatomic) CGRect rect;
@property (nonatomic) NSString *word;

- (instancetype)initWithCGRect:(CGRect)rect AndWord:(NSString*)word;
@end
