//
//  ViewController.swift
//  FirstSwiftApp
//
//  Created by Bobby Towers on 1/26/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

// constant property, constant variables
// since this is outside of the class, it is a constant throughout the WHOLE app
let RED = UIColor.redColor()

// UIScreen is class, mainScreen() is singleton method, bounds property, height property
// missing size
// still read only (notice option click says get)
// if you want to change value, you have to do size.height
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height

// UIViewController is super class
class ViewController: UIViewController {
    
    // before, in Obj-C, we could only declare properties, but set it later, now we can declare AND set
    // viewColor is a property because we used var or let
    var viewColor: UIColor = UIColor.grayColor()
    
    var viewColor2 = RED
    
    var firstName = ""
    var lastName = ""
    
    var fullName: String {
        
        get {
            
            return firstName + " " + lastName
            
        }
        
    }
    
    
    
    
    var name: String {
        
        get {
            
            return self.name
            
        }
        
//        set(v) {
        set {
            
//            self.name = v
            self.name = newValue
            
        }
        
        
    }

    
    // ? is an optional
    var name2: String? {
        
        // adding observers, we are listening to when it is set
        willSet {
            // before it is set
            
            println(newValue)
            
        }
        
        didSet {
            // after it is set

            println(name)
            
        }
        
        
    }
    
    // this is read only
    var name3: String {
        
        get {
            
            return "name"
            
        }
        
    }
    
    
    
    // instance method
    func method() {
        
        
        
    }
    
    
    // - (int)addNumbers:(int)number1 :(int)number2 {
    // -> means returns and its type
    func addNumbers(number1: Int, number2: Int) -> Int {
        
        return number1 + number2
        
    }
    
    
    // + (void)sayWord:(NSString *)word1 andWord:(NSString *)word2 {
    class func sayWord(#word: String, andWord word2: String) {
        
        
        
    }
    
    // class method
    class func classMethod() {
        
        
        
    }
    
    
    // override overrides a method defined in the super class
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        viewColor = UIColor.redColor()
        
        firstName = "Bobby"
        lastName = "Towers"
        println(fullName)

        
        
        // instance method
        self.method()
        
        // [self addNumbers:5 :3];
        self.addNumbers(5, number2: 3)
        
        // no longer need to do self
        addNumbers(5, number2: 3)
        
        
        
        // class is the DNA of the instance object
        // self is the actual instance object of that class
        
        
        
        // class method
        ViewController.classMethod()
        
        ViewController.sayWord(word: "hi", andWord: "hello")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

