//
//  APIResponse.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import Foundation

struct APIResponse<T:Codable>: Codable{
    var msgCode: String?
    var msgContent:String?
    var result: T
}


