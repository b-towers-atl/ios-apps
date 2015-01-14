//
//  Robot.h
//  Speaking
//
//  Created by Bobby Towers on 1/13/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RobotDelegate;

@interface Robot : NSObject

- (void)cleanHouse;

- (void)dance;

@property (nonatomic, assign) id <RobotDelegate> delegate;

@end

@protocol RobotDelegate <NSObject>

// think of delegate methods as a request

- (int)howManyRoomsDoIHaveToClean;

- (NSString *)whatTypeOfDance;

@optional

- (int)howMuchPowerCanIHave; // number is returning to the Robot

@end
