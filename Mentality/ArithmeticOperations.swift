//
//  ArithmeticOperations.swift
//  Mentality
//
//  Created by Ербол Каршыга on 8/1/16.
//  Copyright © 2016 Ербол Каршыга. All rights reserved.
//

import Foundation
import UIKit

enum ArithmeticOperation {
    case Sum
    case Substract
    case Multiplication
    case Division
    
    func operation(a: Int, b: Int) -> (() -> Int) {
        switch self {
        case .Sum:
            func sum() -> Int {
                return a + b
            }
            return sum
        case .Substract:
            func substract() -> Int {
                return a - b
            }
            return substract
        case .Multiplication:
            func multiply() -> Int {
                return a * b
            }
            return multiply
        case .Division:
            func divide() -> Int {
                return a / b
            }
            return divide
        }
    }
}
