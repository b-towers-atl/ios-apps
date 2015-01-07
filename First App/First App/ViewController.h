//
//  ViewController.h
//  First App
//
//  Created by Bobby Towers on 1/5/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel * myLabel;
//@property (nonatomic) IBOutlet UILabel * myLabel;

@property (weak, nonatomic) IBOutlet UITextField * myTextField;

- (IBAction)bigButtonPressed:(id)sender;
// parameter is id, allows for any type (wildcard)
// sender is what is the object that is sending this message, triggering this method, the button is the sender
// bigButtonPressed is the name of the method

@end


















//@property (nonatomic) UIView * myView;
// UIView is the class type, * is the pointer, myView is the name of it

//- (void)myMethodAndParameter:(NSString *)parameter;
// - means an instance method, + means a class method
// myMethodAndParameter is name of the method
// NSString is type of parameter

