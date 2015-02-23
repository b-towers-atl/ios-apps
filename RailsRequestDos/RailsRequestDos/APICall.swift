//
//  APICall.swift
//  RailsRequestDos
//
//  Created by Bobby Towers on 2/20/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

// using Ninja checkers API

import Foundation

// base url
let API_URL = "https://pure-anchorage-3070.herokuapp.com/"


typealias ResponseBlock = (responseInfo: [String:AnyObject]) -> ()


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
    
    
    func register(username: String, email: String, password: String) {
        
        let options: [String:AnyObject] = [
            
            "endpoint" : "users",
            "method" : "POST",
            "body" : [
                
                "user" : [ "username" : username, "email" : email, "password" : password]
                
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
    
    func login(email: String, password: String) {
        
        let options: [String:AnyObject] = [
            
            "endpoint" : "users/sign_in",
            "method" : "POST",
            "body" : [
                
                "user" : [ "email" : email, "password" : password]
                
            ]
            
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            
            println(responseInfo)
            
            // do something here after request is done
            
            let dataInfo = responseInfo["data"] as [String:String]
            
            self.token = dataInfo["auth_token"]
            
        })
        
    }
    
}

class APIRequest {
    
    // (responseInfo: [String:AnyObject]) -> ()
    
    class func requestWithEndpoint(endpoint: String, method: String, completion: ResponseBlock) {
    
        var options = [
        
            "endpoint" : endpoint,
            "method" : method,
            "body" : [
                
                "user" : [ "authentication_token" : User.currentUser().token! ]
            
            ]
            
        ] as [String: AnyObject]
        
        requestWithOptions(options, andCompletion: completion)
        
    }
    
    class func requestWithOptions(options: [String:AnyObject], andCompletion completion: ResponseBlock) {
        
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