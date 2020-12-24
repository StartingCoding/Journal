//
//  Page.swift
//  journal
//
//  Created by Loris on 12/22/20.
//

import Foundation

struct Page: Decodable {
    var id: Int
    var name: String
    var day: Int
    var year: Int
    var body: String
}
