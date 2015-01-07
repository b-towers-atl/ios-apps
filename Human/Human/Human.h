//
//  Human.h
//  Human
//
//  Created by Bobby Towers on 1/6/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//


/*
 Create a Body Class and add it as a property to Human
 
 Create Leg, Head Classes and add them and Arm as properties on the Body 
 
 Add 10 additional Classes for other parts
 
 Create 2 methods on each class (EX: Mouth will have - (void)chewFood:(id)food; )
 
 Add 2 properties per class that define the part (not including properties like finger)
*/



#import <Foundation/Foundation.h>

@class Body;

@interface Human : NSObject

@property (nonatomic) NSString * firstName;
@property (nonatomic) NSString * lastName;

@property (nonatomic) Body * body;

- (NSString *)fullName;

@end
