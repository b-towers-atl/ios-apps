//
//  API.swift
//  RailsRequest
//
//  Created by Bobby Towers on 2/17/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

// : sets the type, = sets the value

// block: () -> ()
//     parameter -> return

// (responseInfo: [String:AnyObject]) -> () )
// make sure you name your block parameters

// "https://pure-anchorage-3070.herokuapp.com/users"

// endpoints: users, games, user/signin

// asynchronous puts it in a background thread
// syncrhonous stops everything and executes like a block

// queue and threads are different


// a singleton is always the same instance object


import Foundation

// base url
let API_URL = "https://pure-anchorage-3070.herokuapp.com/"

// our singleton
private let _currentUser = User()

class User {
    
    // custom initializer
    init() {
    
        // when we run the app, this will check to see if token was previously set
        
        let defaults = NSUserDefaults.standardUserDefaults()
        token = defaults.objectForKey("token") as? String
    
    }
    
    // this is our singleton method
    class func currentUser() -> User { return _currentUser }
    
    var token: String? {
        
        didSet {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(token, forKey: "token")
            defaults.synchronize()
            
        }
        
    }
    
    func getUserToken() {
        
        let options: [String:AnyObject] = [
            
            "endpoint" : "users",
            "method" : "POST",
            "body" : [
                
                "user" : [ "email" : "blahblah@blah.com", "password" : "superswaglord"]
                
            ]
            
        ]
        
        // reponseInfo does not run yet
        // when its called, then the block runs
        // responseInfo is json
        // what we see in the console after println is the JSON
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            
            println(responseInfo)
            
            // do something here after request is done
            
            let dataInfo = responseInfo["data"] as [String:String]
            
            self.token = dataInfo["auth_token"]
            
        })
        
    }
    
}

class APIRequest {
    
    class func requestWithOptions(options: [String:AnyObject], andCompletion completion: (responseInfo: [String:AnyObject]) -> ()) {
        
        if var url = NSURL(string: API_URL + (options["endpoint"] as String)) {
        
            // force unwrap needs to be changed to if-let optional binding
            var request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = options["method"] as String
            
            
            ///// BODY
            let bodyInfo = options["body"] as [String:AnyObject]
            
            let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
            
            let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
            
            let postLength = "\(jsonString!.length)"
            
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            
            let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.HTTPBody = postData
            
            // hit the blue button
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                
                if error == nil {
                    
                    // do something with data
                    // convert data into JSON
                    // json is the actual response
                    
                    let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as [String:AnyObject]
                    
                    completion(responseInfo: json)
                    
                    // completion is the parameter name
                    // then we open up the time capsule after it is called
                    // responseInfo now equals json because that is the argument passed into the parameter
                    
                    
                } else {
                    
                    println(error)
                    
                }
                
            }
            
        }
        
    }
    
}
