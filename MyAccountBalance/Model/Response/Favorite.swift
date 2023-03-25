//
//  Favorite.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import Foundation

struct FavoriteList: Codable{
    var favoriteList: [Favorite]?
}

struct Favorite: Codable{
    var nickname: String
    var transType: String
}
