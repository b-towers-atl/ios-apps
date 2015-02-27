//
//  Dot.swift
//  Archive
//
//  Created by Bobby Towers on 2/26/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

class Dot: NSObject, NSCoding {
    // NSObject is the base building block of Obj-C and Swift, like an atom
    // everything is built off the atom
    // AnyObject is like a wildcard, allow any type to go through
   
    var _center: CGPoint!
    var _diameter: CGFloat = 1
    var _color: UIColor = UIColor.blackColor()
    
    required init(coder aDecoder: NSCoder) {
        // unencode an encoded object
        // unarchive
        
        _center = aDecoder.decodeCGPointForKey("center")
        _diameter = CGFloat(aDecoder.decodeFloatForKey("diameter"))
        
        if let c = aDecoder.decodeObjectForKey("color") as? UIColor {
            _color = c
        }
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        // encode an unencoded object
        // archive
        
        // we give the aCoder the encodings
        aCoder.encodeCGPoint(_center, forKey: "center")
        aCoder.encodeFloat(Float(_diameter), forKey: "diameter")
        aCoder.encodeObject(_color, forKey: "color")
        
    }
    
    // main init
    init(center: CGPoint) {
    
        super.init()
        _center = center
        
    }
    
    // convenience inits
    convenience init(center: CGPoint, color: UIColor) {
        
        self.init(center: center)
        _color = color
        
    }
    
    convenience init(center: CGPoint, diameter: CGFloat) {
        
        self.init(center: center)
        _diameter = diameter
        
    }
    
    convenience init(center: CGPoint, color: UIColor, diameter: CGFloat) {
        // calls main init with self.init(center: center)
        
        self.init(center: center, color: color)
        _diameter = diameter
        
    }
}
