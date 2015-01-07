//
//  Knee.m
//  Human
//
//  Created by Bobby Towers on 1/6/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "Knee.h"

@implementation Knee

{
    BOOL bendable;
    
}

- (BOOL)bend {
    
    bendable = true;
    
    return bendable;
    
}

- (BOOL)buckle:(int)angle {
    
    // if angle > n 
    bendable = false;
    
    return bendable;
    
}

@end
