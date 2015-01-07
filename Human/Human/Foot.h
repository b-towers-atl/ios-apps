//
//  Foot.h
//  Human
//
//  Created by Bobby Towers on 1/6/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Toe;

@interface Foot : NSObject

@property (nonatomic) Toe * firstToe;
@property (nonatomic) Toe * secondToe;
@property (nonatomic) Toe * thirdToe;
@property (nonatomic) Toe * fourthToe;
@property (nonatomic) Toe * fifthToe;

@property (nonatomic) NSString * footPrint;

@end
