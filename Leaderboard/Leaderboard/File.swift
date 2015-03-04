//
//  File.swift
//  Leaderboard
//
//  Created by Bobby Towers on 3/4/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import Foundation

enum AgeGroupType {
    
    case Baby
    case Toddler
    case Child
    case Teen
    case Adult
    case Senior
    
}

class User {
    
    var age: Int = 0
    
    func getAgeGroup() -> AgeGroupType {
        
        switch age {
        
        case 0,1:
            return AgeGroupType.Baby
        case 2...4:
            return AgeGroupType.Toddler
        case 5...12:
            return AgeGroupType.Child
        case 13...19:
            return AgeGroupType.Teen
        case 20...65:
            return AgeGroupType.Adult
        default:
            return AgeGroupType.Senior
            
        }
    }
}
