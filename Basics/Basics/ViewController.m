//
//  ViewController.m
//  Basics
//
//  Created by Bobby Towers on 1/5/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "ViewController.h"

//  Create 2 View Controllers

//  View Controller 1
//  - 2 buttons (one will clear textfields, one will log all textfields)
//  - 3 textfields (username, email, password)
//  - password field should look like one by hiding the text with dots (look in the right panel)
//  - email field should use email keyboard (also in right panel)

//  View Controller 2
//  - 4 buttons with different color backgrounds
//  - each button changes the main view controller's background color
//  - one method, all 4 buttons trigger the method

//  Add constraints
//  Make the button on view controller 2 circles



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearButtonPressed:(id)sender {
    
    self.usernameField.text = @"";
    self.passwordField.text = @"";
    self.emailField.text = @"";
    
}

- (IBAction)logButtonPressed:(id)sender {
    
    NSLog(@"%@\n", self.usernameField.text);
    NSLog(@"%@\n", self.passwordField.text);
    NSLog(@"%@\n", self.emailField.text);
    //_usernameField.text
    
}



- (IBAction)colorButtonPressed:(id)sender {
    
    // obtain color from the button itself and set it to background
    UIButton * button = (UIButton *)sender;
    self.view.backgroundColor = button.backgroundColor;
}



/*
- (IBAction)redButtonPressed:(id)sender {

    self.view.backgroundColor = [UIColor redColor];
    
}

- (IBAction)blueButtonPressed:(id)sender {
    
    self.view.backgroundColor = [UIColor blueColor];
    
}

- (IBAction)greenButtonPressed:(id)sender {
    
    self.view.backgroundColor = [UIColor greenColor];

}

- (IBAction)whiteButtonPressed:(id)sender{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}
*/

@end
