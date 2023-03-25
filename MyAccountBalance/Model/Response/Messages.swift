//
//  Message.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import Foundation

struct Messages: Codable{
    var messages:[Message]?
}

struct Message: Codable{
    var status: Bool
    var updateDateTime: String
    var title: String
    var message: String
}
