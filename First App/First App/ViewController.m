//
//  ViewController.m
//  First App
//
//  Created by Bobby Towers on 1/5/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "ViewController.h"

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

- (IBAction)bigButtonPressed:(id)sender {
    
//    self.myLabel.text = self.myTextField.text;
    self.myLabel.text = @"Pressed";
    
}

@end






/*
 - (void)myMethodAndParameter:(NSString *)parameter {
 }
 */
