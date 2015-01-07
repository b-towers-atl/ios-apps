//
//  Human.m
//  Human
//
//  Created by Bobby Towers on 1/6/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "Human.h"
#import "Body.h"

@implementation Human

{
    NSString * myFullName;
    
    //    NSString * _firstName;
    
    NSString * myPersonalFirstName;
    
}

@synthesize firstName = _firstName;

- (NSString *)firstName {
    
    //    return _firstName;
    
    return myPersonalFirstName;
    
}

- (void)setFirstName:(NSString *)firstName {
    
    //    _firstName = firstName;
    
    myPersonalFirstName = firstName;
    
}



/*
- (void)setLastName:(NSString *)lastName {
    
    
}
*/

- (NSString *)lastName {

    return _lastName;
    
}

- (NSString *)fullName {
    
    return [NSString stringWithFormat:@"%@ %@", myPersonalFirstName, _lastName];
    
}

@end





//{
//    NSString * myFullName;
     /*
     can only be accessed by myself, it is private for your instance object
     local instance variables
     */
    
//    NSString * myPersonalFirstName;
//}



//@synthesize firstName = _firstName;
/*
 _ indicates it is a local instance variable
*/



//- (void)setFirstName:(NSString *)firstName {

    /*
     if this line is not in here, it will not set the local instance variable
     properties are connected by their getters and setters methods
    */
     
//    myPersonalFirstName = firstName;
//}

