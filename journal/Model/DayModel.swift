//
//  Journal.swift
//  journal
//
//  Created by Loris on 12/17/20.
//

import Foundation

struct DayModel {
    var content: [[String]]
}

struct CalModel {
    var name: String
    var subCalModel: [CalModel]?
}
