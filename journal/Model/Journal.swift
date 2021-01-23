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
    
    struct Page: Decodable {
        var id: Int
        var name: String
        var day: Int
        var year: Int
        var body: String
    }
}
