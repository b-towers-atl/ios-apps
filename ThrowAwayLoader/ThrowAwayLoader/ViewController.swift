//
//  ViewController.swift
//  ThrowAwayLoader
//
//  Created by Bobby Towers on 2/27/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var loader = Loader(frame: CGRectMake(20, 20, 200, 200))
        
        // .clearColor is better than .whiteColor() in case background color changes
        // no longer need this because we init with frame that sets background color for us
//        loader.backgroundColor = UIColor.clearColor()
        
        view.addSubview(loader)
        loader.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

