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
-make a circle change size  from 0 to half the width of the rect over time
*/
import UIKit

class Loader: UIView {

    var timer = NSTimer()
    var count = 0
    var renderView = UIView()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        
        var context = UIGraphicsGetCurrentContext()
    }
    
    func timerGo() {
        // this function can connect to a button
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerTick"), userInfo: nil, repeats: true)
        
        let sampleCircle = CGRectMake(0, 0, 10, 10)
        
        for i in 0...100 {
            self.addSubview(renderView)
            //reloadInputViews() 
        }
    }
    
    func timerTick() {
        count++
    }

}
