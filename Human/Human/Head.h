//
//  Head.h
//  Human
//
//  Created by Bobby Towers on 1/6/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Mouth;
@class Ear;
@class Nose;
@class Eye;
@class Hair;


@interface Head : NSObject

@property (nonatomic) Mouth * mouth;
@property (nonatomic) Ear * ear;
@property (nonatomic) Nose * nose;
@property (nonatomic) Eye * eye;
@property (nonatomic) Hair * hair;

@end
