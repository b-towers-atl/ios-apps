//
//  ViewController.swift
//  RailsRequest
//
//  Created by Bobby Towers on 2/17/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let token = User.currentUser().token {
            
            println(token)
            
        } else {
            
            User.currentUser().getUserToken()
            
        }
        
    }

}

