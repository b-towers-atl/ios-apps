//
//  Arm.h
//  Human
//
//  Created by Bobby Towers on 1/6/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hand;

@interface Arm : NSObject

@property (nonatomic) Hand * leftHand;

@property (nonatomic) Hand * rightHand;

@end


// class Hand;
/* 
 forward declaration, it's saying "we're gonna use this class here"
 this is a promise that you will import the Hand class in the .m file
 use this instead of the importing in .h
 #import "Hand.h"
*/


// @interface Arm : NSObject
/*
 interface scope, name of the class, then its superclass
 everything between interface and end is the opening and ending of the scope
*/

// @property (nonatomic) Hand * leftHand;
/*
Hand is project class from Hand.h
*/