//
//  MyView.h
//  Speaking
//
//  Created by Bobby Towers on 1/13/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyViewDelegate;

@interface MyView : UIView

@property (nonatomic) NSString * name;

@property (nonatomic, assign) id <MyViewDelegate> delegate;
// id is saying it does not care what type of class becomes its delegate
// as long as its an obj-c class type
// <MyViewDelegate> is saying even though you can be any class (id), you must conform to my protocol
// delegate is simply property name
// a protocol is a contract, here is some methods that you will listen to

//// this is a public method on myview
//- (void)doSomething;

@end


// this is where we define our protocol
// view is the child
// delegate is the parent
// protocol is the contract
@protocol MyViewDelegate <NSObject>

// this is something that the view can tell its delegate to do
// "this is what I tell you if you want to be my parent"
- (void)changeMyNameTo:(NSString *)name;


@end