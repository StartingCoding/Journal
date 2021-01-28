//
//  Journal.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import Foundation

struct Page: Decodable {
    var day: String
    var month: String
    var allYears: [Int]
    var allTexts: [String]
    var pageContent: [String: String]
}
