//
//  ViewController.h
//  WordsPuzzle
//
//  Created by Tingwei Hsu on 2018/8/24.
//  Copyright © 2018年 Tingwei Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


//setup: VC send View Size to Model to generate 8X8 NSArray of drawing area.
//1. ViewDrawingDelegate
//1+. VC add observer on Keyboard notification
//2. VC will send modle to View via ViewDrawingDelegate
//2+.View draws squares and words via drawRect.
//3. VC.view add GestureRecognizer(tap) >> get X,Y >> send X,Y to model to get NSArray[a] of drawing area.
//4. VC addSubview UITextField on NSArray[a] of drawing area.\
//5. textField become first responder.
//6. Keyboard post notification.
//7. VC change View position. (view.enableUserActivity = false)
//8. handle textField delegate (allowing only one word)
//9. textField resign first responder. > keyboard post noti..
//10.VC change View position.  (view.enableUserActivity = true).










@end

