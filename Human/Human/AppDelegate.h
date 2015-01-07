//
//  AppDelegate.h
//  Human
//
//  Created by Bobby Towers on 1/6/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


/*
 
.h


 
@interface Toilet : NSObject

@property (nonatomic) int height;
@property (nonatomic) UIColor * color;
 
@property (nonatomic, readonly) BOOL isClogged;
// can't "tell" it to be clogged, but we can read if it is clogged
 
- (void)flush;
- (void)clean;
// void means does not return anything
 
- (void)leaveContents:(id)contents;

*/



/*
 
.m
 

@implementation Toilet

{
 
    BOOL selfClogged;
 
}
 
}
 
- (void)flush {
 
}
 
- (void)clean {
 
}
 
- (void)leaveContents:(NSDictionary *)contents {
 
    if ([contents[@"size"] intValue] > 100) {
 
        selfClogged = YES;
 
 
    }
 
}
 
// in the blueprint, self is going to be any instance object of the class
// self is the object that you are currently working with
 
*/