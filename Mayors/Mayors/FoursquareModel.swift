//
//  FoursquareModel.swift
//  Mayors
//
//  Created by Bobby Towers on 3/11/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

private let _fsModel = FoursquareModel()

class FoursquareModel: NSObject {
    
    var token: String?
   
    class func mainModel() -> FoursquareModel { return _fsModel }
    
}



class User: NSObject {
    
    var userInfo: [String:AnyObject]! = [:] {
        
        // didSet is a listener
        didSet {
            // this isn't being run for some reason
            // *** didSet is not run when setting a property INSIDE an initializer ***
            
            println("hello")
            
            
            println(firstName)
            println(lastName)
        }
        
        willSet {
            println("willSet")
        }
        
    }
    
    var firstName: String!
    var lastName: String!
    
    init(resultInfo: [String:AnyObject]) {
        
        super.init()
        
        let responseInfo = resultInfo["response"] as [String: AnyObject]
        userInfo = responseInfo["user"] as [String:AnyObject]
        firstName = userInfo["firstName"] as String
        lastName = userInfo["lastName"] as String
        
        println(userInfo)
        println(userInfo["firstName"])
    }
    
}



// MORE CONDENSED
/*

class User: NSObject {
    
    var userInfo: [String: AnyObject]!
    var firstName: String!
    var lastName: String!
    
    init(resultInfo: [String:AnyObject]) {
        
        super.init()
        let responseInfo = resultInfo["response"] as [String: AnyObject]
        userInfo = responseInfo["user"] as [String:AnyObject]
        firstName = userInfo["firstName"] as String
        lastName = userInfo["lastName"] as String
    }
}

*/