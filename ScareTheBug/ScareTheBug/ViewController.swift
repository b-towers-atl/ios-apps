//
//  ViewController.swift
//  ScareTheBug
//
//  Created by Bobby Towers on 1/27/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

//let touch = touches.anyObject() as UITouch
//let point = touch.locationInView(self.view)

//let pointX = point.x
//let pointY = point.y

import UIKit

// jo using VC as frame
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height


//typealias Distance = (CGFloat, CGFloat)


class ViewController: UIViewController {
    
    var bug = UIImageView(frame: CGRectMake(0, 0, 54, 45))
    
//    var foot: CGFloat = 1
//    var lastFootPrint = CGPointZero

    @IBOutlet weak var gameFrameView: UIView!
    
    @IBOutlet weak var bigBug: UIImageView!
    
    func moveBug() {
        
        UIView.animateWithDuration(1.0,
            delay: 2.0,
            options: .CurveEaseInOut,
            animations: {
//                let point = touch.locationInView(self.view)
//                self.bigBug.center = CGPoint(x: -point.x, y: -point.y)
            },
            completion: { finished in
                println("Bug moved!")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // my shitty ass code
        let gameFrame = UIView(frame: CGRectMake(0, 0, 414, 736))
        gameFrame.backgroundColor = UIColor.clearColor()
        gameFrameView.addSubview(gameFrame)
        
//        CGRect bugFrame = [gameFrameView convertRect:bugFrame.frame fromView:secondView];
        
        
        
        
        
        // jo's method
        bug.image = UIImage(named: "bug")
        bug.center = view.center
        view.addSubview(bug)
        
        // timer to add foot prints
//        NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("footPrints"), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        tapScreen(touches)
        
        // jo's code
        
        // the first touch is optional, touches.allObjects is the array of all touches
        // if there is no touch, .first may not be there, thus it is optional
        // .first doesn't know what it is yet, so we use as? 
        
        // if let touch = unwraps it
        if let touch = touches.allObjects.first as? UITouch {
            
            let location = touch.locationInView(view)
            
            // this is a tuple
            var (x,y) = (bug.center.x - location.x, bug.center.y - location.y)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                // fabs gives absolute value
                // makes the bug run away to a certain extent by checking distance
                if (fabs(x) > fabs(y)) {
                    self.bug.center.x += (SCREEN_WIDTH / x)
                } else {
                    self.bug.center.x += (SCREEN_WIDTH / x / 2)
                }
                if (fabs(x) < fabs(y)) {
                    self.bug.center.y += (SCREEN_HEIGHT / y)
                } else {
                    self.bug.center.y += (SCREEN_HEIGHT / y / 2)
                }
                
            })
            
        }
    
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        tapScreen(touches)
        
    }
    
    func tapScreen(touches:NSSet!) {
        
        let touch = touches.anyObject() as UITouch
        
        let touchLocation = touch.locationInView(self.view)
        
        // game frame to view controller coords
        let frame = self.view.convertRect(gameFrameView.frame, fromView: gameFrameView.superview)
        
        // check for touch is inside the game view
        if CGRectContainsPoint(frame, touchLocation) {
            
            println("\(touch.locationInView(self.view))")
            moveBug()
//            bugLocation = touchLocation - 10.0
            
        }
        
    }
    
    func footPrint() {
        
    }
    
}

