//
//  Human.m
//  Speaking
//
//  Created by Bobby Towers on 1/13/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "Human.h"
#import "Robot.h"

// <RobotDelegate is private in Human interface
@interface Human () <RobotDelegate>

@end

@implementation Human

- (void)makeRobot {
    
    // talk straight to the robot
    Robot * oldRustyRobot = [[Robot alloc] init];
    
    // now allowing the robot to talk to us
    oldRustyRobot.delegate = self;
    
    [oldRustyRobot cleanHouse];
    
    [oldRustyRobot dance];
}

- (NSString *)whatTypeOfDance {
    
    return @"The Robot";
    
}

- (int)howManyRoomsDoIHaveToClean {
    
    return 1000000;
    
}

@end
