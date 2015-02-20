//
//  ViewController.swift
//  RailsRequestDos
//
//  Created by Bobby Towers on 2/20/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

/// where your games playing or create a game
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = User.currentUser().token {
            
            println(token)
            
        } else {
            
            // show login view controller
            
            var loginVC = LoginController()
            presentViewController(loginVC, animated: false, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // create by new game button
    func newGame() {
        
        
        
    }

}




class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // called by login button
    func login() {
        
        User.currentUser().login("jo@blah.com", password: "password")
        
    }
    
    // called by register button
    func register() {
        
        User.currentUser().register("swaglord", email: "jo@blah.com", password: "password")
        
    }
    
}
