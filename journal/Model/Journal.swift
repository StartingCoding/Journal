//
//  Journal.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import Foundation

struct Journal {
    var years: [Int]
    var texts: [String]
    
    init(years: [Int], texts:  [String]) {
        self.years = years
        self.texts = texts
    }
}
