//
//  ViewController.m
//  Speaking
//
//  Created by Bobby Towers on 1/13/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController () <MyViewDelegate>

@end

@implementation ViewController
{
    
    MyView * view1;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    view1 = [[MyView alloc] init];
 
    // as the VC, I'm going to be your delegate
    view1.delegate = self;
    
    view1.name = @"Bob";

    NSLog(@"view1 name = %@", view1.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// this method won't show up until you include <MyViewDelegate> protocol above
- (void)changeMyNameTo:(NSString *)name {
    
    NSLog(@"%@", name);

//    view1.name = name;  // view1.name = @"Bob" would create an infinite loop between two methods
                                    // between MyView setName and ViewController changeMyNameTo
    
    NSLog(@"view1 new name = %@", view1.name);
    
}

@end
