//
//  RoundButton.m
//  ScribbleTouch
//
//  Created by Bobby Towers on 1/14/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "RoundButton.h"

@implementation RoundButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    self.layer.cornerRadius = self.cornerRadius / 2;
    self.layer.masksToBounds = YES;
    
}


@end
