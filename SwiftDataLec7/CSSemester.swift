//
//  CSSemester.swift
//  SwiftDataLec7
//
//  Created by Justin Wong on 10/23/23.
//

import Foundation
import SwiftData

//TODO: Implement Models

@Model
class CSSemester {
    var name: String
    var startingDate: Date
    var endingDate: Date
    var classes: [CSClass]
    
    init(name: String, startingDate: Date, endingDate: Date, classes: [CSClass]) {
        self.name = name
        self.startingDate = startingDate
        self.endingDate = endingDate
        self.classes = classes
    }
}

@Model
class CSClass {
    var name: String
    var difficulty: Int
    
    init(name: String, difficulty: Int) {
        self.name = name
        self.difficulty = difficulty
    }
}
