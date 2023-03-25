//
//  Banner.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import Foundation

struct BannerList: Codable{
    var bannerList: [Banner]
}

struct Banner: Codable{
    var adSeqNo: Int
    var linkUrl: String
}
