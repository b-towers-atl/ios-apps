//
//  ViewController.swift
//  NavigationPractice
//
//  Created by Bobby Towers on 3/15/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func toView2(sender: AnyObject) {
        let view2 = self.storyboard?.instantiateViewControllerWithIdentifier("view2") as ViewController2
        self.navigationController?.pushViewController(view2, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

