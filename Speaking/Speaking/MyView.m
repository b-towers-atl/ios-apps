//
//  MyView.m
//  Speaking
//
//  Created by Bobby Towers on 1/13/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "MyView.h"

@implementation MyView

- (void)setName:(NSString *)name {
    
    if (![name isEqualToString:@"BOSS"]) {
        
        
        // target is on the left, method performed on target is on the right
        [self.delegate changeMyNameTo:@"BOSS"];
        return; // return stops the pointer getting assigned
        
        
    }
    
    _name = name;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
