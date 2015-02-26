//
//  BoardView.swift
//  Archive
//
//  Created by Bobby Towers on 2/26/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

class BoardView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        addDot(touches)
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        addDot(touches)
        
    }
    
    func addDot(touches: NSSet) {
        
        if let touch = touches.allObjects.last as? UITouch {
         
            let location = touch.locationInView(self)
            
        }
    }
}
