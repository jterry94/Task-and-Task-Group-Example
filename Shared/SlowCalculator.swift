//
//  SlowCalculator.swift
//  SlowCalculator
//
//  Created by Jeff_Terry on 1/25/22.
//

import Foundation

class SlowCalculator :ObservableObject {
    
    /// slowSum
    /// - Parameters:
    ///   - i: interation of the Looop
    ///   - addend1: Double to be added
    ///   - addend2: Second Double to be added
    ///   - randomSleep: Time to sleep to delay the function
    func slowSum(i: Int, addend1: Double, addend2: Double, randomSleep: UInt32) async -> String {
        
        let sum = addend1 + addend2
        
        sleep(randomSleep)
        
        let returnText = "The sum of the \(i)th addition \(addend1) and \(addend2) is \(sum) with sleep time \(randomSleep) sec.\n"
        
        return returnText
        
        
    }
    
}
