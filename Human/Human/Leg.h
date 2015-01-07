//
//  Leg.h
//  Human
//
//  Created by Bobby Towers on 1/6/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Knee;
@class Foot;

@interface Leg : NSObject

@property (nonatomic) Knee * leftKnee;
@property (nonatomic) Knee * rightKnee;

@property (nonatomic) Foot * leftFoot;
@property (nonatomic) Foot * rightFoot;

@end
