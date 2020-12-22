//
//  Journal.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import Foundation

struct Journal {
    var day: Int
    var years: [Int]
    var texts: [String]
    
    init(years: [Int], texts:  [String], day: Int) {
        self.years = years
        self.texts = texts
        self.day = day
    }
}
