//
//  Finger.m
//  Human
//
//  Created by Bobby Towers on 1/6/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "Finger.h"

@implementation Finger

@synthesize fingerPrint = _fingerPrint;

- (NSString *)fingerPrint {
    
    return _fingerPrint;
}

- (void)setFingerPrint:(NSString *)fingerPrint {
    
    _fingerPrint = fingerPrint;
}

@end



// @synthesize fingerPrint = _fingerPrint;
/*
_fingerPrint is a local instance variable
 fingerPrint is the property
*/



//- (NSString *)fingerPrint {
    /* 
    when you access a property with dot notation, it will run the getter method
    NSString * fingerPrint = finger.fingerPrint;
    getter method
    */
    
//    return _fingerPrint;
//}



//- (void)setFingerPrint:(NSString *)fingerPrint {
    /*
    when you are telling a property to equal a value, the setter method gets called
    finger.fingerPrint = @"fingerprint";
    setter method, indicated by = sign
    */
    
//    _fingerPrint = fingerPrint;
//}

