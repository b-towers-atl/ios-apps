//
//  ViewController.swift
//  Mayors
//
//  Created by Bobby Towers on 3/11/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

// need to import Crashylitics.framework and Fabric.framework and libsPods.a
// also need a Pods folder along with the Framework folder
// also Podfile in main Mayors folder + Mayors-Briding-Header.h
// need to import AFNetworking

import UIKit

class ViewController: UIViewController {
    
    let AUTH_URL = "https://api.foursquare.com" // + whatever
    
    @IBAction func fourSquareConnect(sender: AnyObject) {
        if let url = NSURL(string: AUTH_URL) {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("load \(FoursquareModel.mainModel().token)")
        
//        let manager = AFHTTPRequestOperationManager()
//        
//        mangaer.GET("http://jo2.co/twitter.json", parameters: nil, success: { (operation, responseObject) -> Void in
//            
//                println(responseObject)
//            
//            }) { (operation, error) -> Void in
//                println(error)
//        }
        
        // observer that watches for "FSConnectWithToken", this is what is actually run when the event trigger is called
        // these are the racers waiting for the gun to fire
        NSNotificationCenter.defaultCenter().addObserverForName("FSConnectWithToken", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            // code is ran AFTER token is set

//            println(FoursquareModel.mainModel().token)
            // prints optional(QBZXVO10ZGHASUGL12)
            
            let ME_URL = "https://api.foursquare.com/v2/users/self"
            
            // Requires import from AFNetworking
            let rManager = AFHTTPRequestOperationManager()
            
            rManager.GET(ME_URL, parameters: ["oauth_token":FoursquareModel.mainModel().token!,"v": "20150311","m":"foursquare"], success: { (operation, response) -> Void in
                
                println(response)
                
                
                
                
                
//                let resultInfo = response as [String: AnyObject]
                
                // moved into FoursquareModel custom init
//                let responseInfo = resultInfo["response"] as [String: AnyObject]
//                let userInfo = responseInfo["user"] as [String:AnyObject]
                
                // dont need anymore because we set them in our didSet in FoursquareModel
//                let firstName = userInfo["firstName"] as String
//                let lastName = userInfo["lastName"] as String
                
//                self.welcomeLabel.text = "Welcome \(firstName) \(lastName)"
                
                
                
                
                
                // instead of using resultInfo constant, we just pass in response as...
                let user = User(resultInfo: response as [String: AnyObject])
                
                let user2 = User(resultInfo: response as [String: AnyObject])
                
                user2.change
                
                self.welcomeLabel.text = "Welcome \(user.firstName) \(user.lastName)"
                
                }, failure: { (operation, error) -> Void in
                    
                println(error)
            })
        
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        println("appear \(FoursquareModel.mainModel().token)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

