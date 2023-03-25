//
//  Amount.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import Foundation

struct SavingsList: Codable{
    var savingsList: [Amount]
}

struct FixedDepositList: Codable{
    var fixedDepositList: [Amount]
}

struct DigitalList: Codable{
    var digitalList: [Amount]
}

struct Amount: Codable{
    var account: String
    var curr: String
    var balance: Double
}
