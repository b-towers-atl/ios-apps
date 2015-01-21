//
//  SlickSlider.h
//  Capture
//
//  Created by Bobby Towers on 1/21/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlickSliderDelegate;

IB_DESIGNABLE
@interface SlickSlider : UIView

@property (nonatomic) IBInspectable float startPosition;
@property (nonatomic) IBInspectable UIColor * sliderColor;
@property (nonatomic) IBInspectable BOOL reverseColor;

// listening object is what a delegate is
@property (nonatomic, assign) id <SlickSliderDelegate> delegate;

@end

@protocol SlickSliderDelegate <NSObject>

- (void)sliderDidFinishUpdatingWithValue:(float)value;

@end