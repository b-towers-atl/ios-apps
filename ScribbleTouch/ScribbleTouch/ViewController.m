//
//  ViewController.m
//  ScribbleTouch
//
//  Created by Bobby Towers on 1/14/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "ViewController.h"
#import "ScribbleView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableDictionary * currentScribble;
    UIColor * selectedColor;
    int selectedStrokeWidth;
    float selectedAlpha;
    
    ScribbleView * sView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    selectedColor = [UIColor blackColor];
    selectedStrokeWidth = 4;
    selectedAlpha = 1;
    
}

- (IBAction)changeColor:(UIButton *)sender {
    
    // sender is the button that we tapped
    selectedColor = sender.backgroundColor;
    
}

- (IBAction)changeStrokeWidth:(UISlider *)sender {
    
    // value contains the sender's current value
    selectedStrokeWidth = sender.value;
    
}

- (IBAction)changeOpacity:(UISlider *)sender {
    
    selectedAlpha = sender.value;
    
}

- (IBAction)clearPage:(UIButton *)sender {

    [sView.scribbles removeAllObjects];
    
    [self.view setNeedsDisplay];

}

- (IBAction)eraser:(UIButton *)sender {
    
    selectedColor = sender.backgroundColor;
    selectedAlpha = 1;
    
}

- (IBAction)scribbleUndo:(UIButton *)sender {
    
    [sView.scribbles removeObjectIdenticalTo:currentScribble];
    
    currentScribble = sView.scribbles.lastObject;
    
    [self.view setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // this will get the first touch within that NSSet touches
    UITouch * touch = touches.allObjects.firstObject;
    
    // self.view because we set our View on storyboard which was based off ViewController class
    // self.view type is ScribbleView
    // we told it in storyboard that the UIView Custom Class in attributes is ScribbleView
    // we can pass any view we want in locationInView
    // it is based on the location where you want touches to be accepted
    // for instance, if you only want the bottom third of your screen to accept touches, you create a view for it
    CGPoint location = [touch locationInView: self.view];
    
    NSLog(@"x %f y %f", location.x, location.y);
    
    currentScribble = [@{
                         
                         @"type":@"path",
                         @"fillColor":selectedColor,
                         @"strokeColor":selectedColor,
                         @"strokeWidth": @(selectedStrokeWidth),
                         @"strokeOpacity": @(selectedAlpha),
                         @"points": [@[[NSValue valueWithCGPoint:location]] mutableCopy]
                         // NSValue is the class, takes the
                         // NSValue is the carrier ship, but can only contain specific types of cargo
                         // needs a specific container to fit that cargo hole
                         // like liquid, we need a special container to hold that liquid
                         // NSValue is the container, it is an Obj-C object that contains CGPoint location
                         // it allows a c type to be entered the NSArray
                         
                         } mutableCopy];
    
    // previously, self.view would not work alone since it does not think it is a ScribbleView yet
    // then we need to cast (ScribbleView *)self.view to make them compatible
    // it is warning you that "I think it is UIView type, but you want ScribbleView type"
    sView = (ScribbleView *)self.view;
    
    // sView.scribbles is running the getter method
    // addObject currentScribble to the scribbles array
    [sView.scribbles addObject:currentScribble];
    
//    [((ScribbleView *)self.view).scribbles addObject:currentScribble];
    // the above two all in one line
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = touches.allObjects.firstObject;
    CGPoint location = [touch locationInView: self.view];
    
    [currentScribble[@"points"] addObject:[NSValue valueWithCGPoint:location]];
    
    [self.view setNeedsDisplay];
    
}

@end
