//
//  ScribbleView.m
//  ScribbleTouch
//
//  Created by Bobby Towers on 1/14/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "ScribbleView.h"

@implementation ScribbleView

//    @[
//
//        @{
//            @"type":@"path",
//            @"fillColor":[UIColor greenColor],
//            @"strokeColor":[UIColor blackColor],
//            @"strokeWidth":@2,
//            @"points":@[CGPoint, CGPoint, CGPoint]
//        },
//
//        @{
//            @"type":@"path",
//            @"fillColor":[UIColor greenColor],
//            @"strokeColor":[UIColor blackColor],
//            @"strokeWidth":@2,
//            @"frame":CGRect
//        }
//
//
//    ];



- (NSMutableArray *)scribbles {
    
    // this makes sure it will never ever be nil
    if (_scribbles == nil) { _scribbles = [@[] mutableCopy]; }
    return _scribbles;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
//    // some examples
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    // setting a stroke, starts on the edge of your shape, then expands outwards
//    CGContextSetLineWidth(context, 30);
//    
////    [[UIColor lightGrayColor] set];
//    [[UIColor colorWithWhite: 0.0 alpha: 0.5] set];
//    
//    // merges the ellipses
//    CGContextAddEllipseInRect(context, CGRectMake(10, 10, 200, 200));
//    CGContextAddEllipseInRect(context, CGRectMake(10, 100, 200, 200));
//    CGContextFillPath(context);
//    
//    // adds another on top of the bottom ellipse
//    CGContextAddEllipseInRect(context, CGRectMake(10, 100, 200, 200));
//    CGContextFillPath(context);
//    
////    CGContextStrokePath(context);
//    
//    
//    // creates a venn diagram like pattern
//    CGContextFillEllipseInRect(context, CGRectMake(200, 10, 200, 200));
//    CGContextFillEllipseInRect(context, CGRectMake(200, 100, 200, 200));

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    for (NSDictionary * scribble in self.scribbles) {
     
        CGContextSetLineWidth(context, [scribble[@"strokeWidth"] floatValue]);
        
        UIColor * strokeColor = scribble[@"strokeColor"];
        [strokeColor set];
        
        CGContextSetAlpha(context, [scribble[@"strokeOpacity"] floatValue]);
        
        CGContextSetBlendMode(context, kCGBlendModeScreen);
        CGContextSetBlendMode(context, kCGBlendModeMultiply);
        
        CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
        
        for (NSValue * pointValue in scribble[@"points"]) {
            
            CGPoint point = [pointValue CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
            
        }
        
        CGContextStrokePath(context);
    }

}


@end
