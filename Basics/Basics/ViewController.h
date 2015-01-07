//
//  ViewController.h
//  Basics
//
//  Created by Bobby Towers on 1/5/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// labels
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;


// text fields
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *emailField;


@property (nonatomic) IBOutlet UIButton * colorButtonPressed;


// buttons

- (IBAction)clearButtonPressed:(id)sender;

- (IBAction)logButtonPressed:(id)sender;

- (IBAction)colorButtonPressed:(id)sender;

/*

- (IBAction)redButtonPressed:(id)sender;

- (IBAction)blueButtonPressed:(id)sender;

- (IBAction)greenButtonPressed:(id)sender;

- (IBAction)whiteButtonPressed:(id)sender;
*/

@end

