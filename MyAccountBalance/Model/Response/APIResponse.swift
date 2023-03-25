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

struct Messages: Codable{
    var messages:[Message]?
}

struct Message: Codable{
    var status: Bool
    var updateDateTime: String
    var title: String
    var message: String
}

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

struct FavoriteList: Codable{
    var favoriteList: [Favorite]?
}

struct Favorite: Codable{
    var nickname: String
    var transType: String
}

struct BannerList: Codable{
    var bannerList: [Banner]
}

struct Banner: Codable{
    var adSeqNo: Int
    var linkUrl: String
}


