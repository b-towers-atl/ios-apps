//
//  ViewController.swift
//  Archive
//
//  Created by Bobby Towers on 2/26/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

private let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)[0] as String

class ViewController: UIViewController {

    @IBAction func clearButton(sender: UIButton) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println(documentsDirectoryPath)
        
        loadDots()
        
        NSNotificationCenter.defaultCenter().addObserverForName("appIsClosing", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.saveDots()
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // clears the screen by creating a new documents directory path
    let dotsData = documentsDirectoryPath + "/dot7s.data"
    
    func saveDots() {
        // get the dots from boardview
        // archive dots to file path
        
        println("save")
        
        let bView = self.view as BoardView
        
        // we have a custom class, but it is not based to be encoded
        NSKeyedArchiver.archiveRootObject(bView.dots, toFile: dotsData)
        
        // original dots.data path
        //NSKeyedArchiver.archiveRootObject(bView.dots, toFile: documentsDirectoryPath + "/dots.data")
        
    }
    
    func loadDots() {
        // get file path for dots archive
        // unarchive file path to dots
        // set boardview dots
        
        println("load")
        
        let bView = self.view as BoardView
        
        // prints false (pre-encoding)
        println(NSFileManager.defaultManager().fileExistsAtPath(dotsData))
        
        // prints nil (pre-encoding)
        println(NSKeyedUnarchiver.unarchiveObjectWithFile(dotsData))
        
        if let unarchivedDots = NSKeyedUnarchiver.unarchiveObjectWithFile(dotsData) as? [Dot] {
            
            println(unarchivedDots.count)
            
            bView.dots = unarchivedDots
            bView.setNeedsDisplay()
            
        }
    }
}

