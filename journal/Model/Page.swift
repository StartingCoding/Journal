//
//  Journal.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import Foundation

struct Page: Codable {
    var day: String
    var month: String
    var allYears: [Int]
    var allTexts: [String]
    var pageContent: [String: String]
}
