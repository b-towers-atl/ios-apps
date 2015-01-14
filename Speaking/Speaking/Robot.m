//
//  Robot.m
//  Speaking
//
//  Created by Bobby Towers on 1/13/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "Robot.h"

@implementation Robot
{
    int powerLevel;
}

- (void)cleanHouse {
    
    // find out from delegate how many rooms need to be cleaned
    int rooms = [self.delegate howManyRoomsDoIHaveToClean];
    
    NSLog(@"Robot starts cleaning %d rooms", rooms);
}

- (void)dance {
    
    // find out what type of jig to do
    NSString * danceStyle = [self.delegate whatTypeOfDance];
    
    // %@ is anything that is an objective c object
    NSLog(@"Robot starts to %@", danceStyle);
    
}

- (void)checkPower {
    // private method
    
    
}

@end
