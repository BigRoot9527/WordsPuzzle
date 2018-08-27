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
@property(nonatomic, strong) UITextField *blackTextField;
@end

@interface ViewController (WPSquareViewDataSource) <WPSquareViewDataSource>
@end

@interface ViewController (UITextFieldDelegate) <UITextFieldDelegate>
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
    [self _setupGesture];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (!self.manager) {
        self.manager = [[WPSquareManager alloc] initWithSize:self.matrixView.bounds.size InColumns:self.inputColumns AndRows:self.inputRows];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_setupConstraint
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    [self.matrixView setupConstraintToWidth:screenSize.width * 0.9 toHeight:screenSize.height * 0.9];
    [self.matrixView setupCenterConstrainTo:self.view withCenterX:YES withCenterY:YES];
}

- (void)_setupGesture
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.requiresExclusiveTouchType = 1;
    [self.matrixView addGestureRecognizer:gesture];
}

- (void)handleGesture:(UITapGestureRecognizer *)recognizer
{
    WPSquare *tappedSquare = [self.manager getSquareOfCertainPoint:[recognizer locationInView:recognizer.view]];
    self.blackTextField = [[UITextField alloc] initWithFrame: tappedSquare.rect];
    self.blackTextField.backgroundColor = [UIColor blackColor];
    self.blackTextField.text = tappedSquare.word;
    self.blackTextField.textAlignment = NSTextAlignmentCenter;
    self.blackTextField.textColor = [UIColor whiteColor];
    self.blackTextField.delegate = self;
    [self.matrixView addSubview:self.blackTextField];
    [self.blackTextField becomeFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat keyboardY = [[UIScreen mainScreen] bounds].size.height - keyboardSize.height;
    NSInteger duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    CGFloat  heightBelowKeyboard = [self.blackTextField convertPoint:CGPointMake(self.blackTextField.bounds.origin.x, self.blackTextField.bounds.size.height) toView:nil].y - keyboardY ;
    CGFloat fixedHeight = round(heightBelowKeyboard * 100) / 100;
    if (fixedHeight == 0) {
        return;
    }
    if (fixedHeight > 0) {
        [UIView animateWithDuration:duration animations:^{
            CGRect newFrame = self.view.frame;
            newFrame.origin.y = -fixedHeight;
            self.view.frame = newFrame;
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            CGRect newFrame = self.view.frame;
            newFrame.origin.y = newFrame.origin.y - fixedHeight >= 0 ? 0 : newFrame.origin.y - fixedHeight;
            self.view.frame = newFrame;
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSInteger duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect newFrame = self.view.frame;
        newFrame.origin.y = 0;
        self.view.frame = newFrame;
    }];
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

@implementation ViewController (UITextFieldDelegate)

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger newTextLength = [textField.text length] - range.length + [string length];
    return newTextLength <= 1;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text length] > 0) {
        [self.manager setNewWord:textField.text OnPoint:textField.center];
        [self.matrixView setNeedsDisplay];
    }
    [textField removeFromSuperview];
    textField = nil;
}

@end
