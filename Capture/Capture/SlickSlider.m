//
//  SlickSlider.m
//  Capture
//
//  Created by Bobby Towers on 1/21/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "SlickSlider.h"

@implementation SlickSlider
{
    
    float sliderPosition;
    
    
}

- (void)setStartPosition:(float)startPosition {
    
    sliderPosition = startPosition * self.frame.size.width;
    
    [self setNeedsDisplay];
    
    _startPosition = startPosition;
    
}

- (UIColor *)sliderColor {
    
    if (_sliderColor == nil) {
        _sliderColor = [UIColor whiteColor];
    }
    
    return _sliderColor;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // context is the workbench, but it's a layer that you can draw on
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    self.startPosition = self.frame.size.width;
    
    [self.sliderColor set];
    
    CGContextSetLineWidth(context, 1);
    
    CGRect insetRect = CGRectInset(rect, 5, 5);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:insetRect cornerRadius:rect.size.height / 2];
    
    CGContextAddPath(context, path.CGPath);
    
    if (self.reverseColor) {
        
        CGContextFillPath(context);
        
    } else {
        
        CGContextStrokePath(context);
        
    }

    
    CGRect circleRect = CGRectInset(insetRect, 4, 4);
    circleRect.size.width = circleRect.size.height;
    
    float minX = circleRect.origin.x;
    float maxX = rect.size.width - minX - circleRect.size.width;
    
    sliderPosition -= circleRect.size.width / 2;
    
    if (sliderPosition > maxX) sliderPosition = maxX;
    if (sliderPosition < minX) sliderPosition = minX;
    
    circleRect.origin.x = sliderPosition;
    
    float value = (sliderPosition - minX) / (maxX - minX);
    
    [self.delegate sliderDidFinishUpdatingWithValue:value];
    
    if (self.reverseColor) {
        
//        CGContextSetBlendMode(context, kCGBlendModeClear);
        [self.backgroundColor set];
        
    }
    
    CGContextFillEllipseInRect(context, circleRect);
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self updateSliderWithTouches:touches];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self updateSliderWithTouches:touches];
    
    
}

- (void)updateSliderWithTouches:(NSSet *)touches {
    
    // same thing as
    // UITouch * touch = touches.allObjects.firstObject; (this uses . notation properties)
    // thiis is using getter method
    UITouch *touch = [[touches allObjects] firstObject];
    
    CGPoint location = [touch locationInView:self];
    
    sliderPosition = location.x;
    
    [self setNeedsDisplay];
    
}

@end
