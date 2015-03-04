// Playground - noun: a place where people can play

import UIKit

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
    
    // instance method
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

class Car {
    
    var age = 0

    // class method (run any time on the class itself)
    class func seatsInModel(model: String) -> Int {
        
        return 4
        
    }
}

Car.seatsInModel("4 door")

var mack = User()

mack.age = 21

var mackAgeGroup = mack.getAgeGroup().hashValue


func howManyWeeksOld(age: Int) -> Int {
    return age * 52
}

func monthsOld(age: Int) -> Int {
    return age * 12
}



howManyWeeksOld(mack.age)
monthsOld(mack.age)

var mustang = Car()
mustang.age = 10
howManyWeeksOld(mustang.age)