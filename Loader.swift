//
//  Loader.swift
//  
//
//  Created by Bobby Towers on 2/27/15.
//
//

/*
-create simple loop using nstimer
-render view on each loop
-make a circle change size from 0 to half the width of the rect over time

homework:
-add a variable to set circle color
-makes circles 50% alpha
-make 3 circles (means you need 3 directions & circlePercentages)
-also means you need to update all three circles on runLoop
*/
import UIKit

class Loader: UIView {

    var timer: NSTimer?
    var count = 0
    var alphaValue: CGFloat = 0.0
    var circlePercentage: CGFloat = 1.00   // 0 = 0%, 1 = 100%
    var direction: CGFloat = 0.01
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // drawRect is a single frame of our animation
        // run a frame animation
        
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        
        var half = rect.width > rect.height ? rect.height / 2 : rect.width / 2
        
        half *= circlePercentage
        
        // Drawing code
        var context = UIGraphicsGetCurrentContext()
        
        // talks to the background of the view, thus sets it to white because we set it
//        UIColor.whiteColor().set()
//        CGContextFillRect(context, rect)
        
        // clear background, defaults to black
//        CGContextClearRect(context, rect)
        
        UIColor.redColor().colorWithAlphaComponent(alphaValue).set()
        
        let circleRect = CGRectMake(center.x - (half / 2), center.y - (half / 2), half, half)
        
        CGContextFillEllipseInRect(context, circleRect)
        
//        CGContextFillRect(context, rect)
    }
    
    func runLoop() {
        
//        alphaValue += 0.01
        alphaValue += direction
        if alphaValue < 0 { direction = 0.01 }
        if alphaValue > 1 { direction = -0.01 }
//        if alphaValue > 1.0 { alphaValue = 0 }
        
        circlePercentage -= direction
        if circlePercentage < 0 { direction = -0.01 }
        if circlePercentage > 1 { direction = 0.01 }
//        if circlePercentage < 0 { circlePercentage = 1 }
        
        // renders out our screen
        setNeedsDisplay()
        
    }
    
    func startAnimating() {
        
        if timer == nil {
            
            // 0.1 for a tenth of a second
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("runLoop"), userInfo: nil, repeats: true)
        }
    }
    
    func stopAnimating() {
        // stops
        timer?.invalidate()
        
        // kills the timer
        timer = nil
    }
    
    
    
    ///////// my shitty ass code
    
    func timerGo() {
        // this function can connect to a button
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerTick"), userInfo: nil, repeats: true)
        
        let sampleCircle = CGRectMake(0, 0, 10, 10)
        
        for i in 0...100 {
            self.addSubview(self)
            //reloadInputViews() 
        }
    }
    
    func timerTick() {
        count++
    }

}
