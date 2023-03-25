//
//  APIRepository.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import Foundation
import Combine

protocol FavoriteRepositoryInterFace {
    // Favorite
    func getEmptyFavoriteList() -> AnyPublisher<FavoriteList, Error>
    func getFavoriteList() -> AnyPublisher<FavoriteList, Error>
}

class FavoriteRepository: FavoriteRepositoryInterFace{
    static let shared = FavoriteRepository()

    func getEmptyFavoriteList() -> AnyPublisher<FavoriteList, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getEmptyFavoriteList)
    }
    
    func getFavoriteList() -> AnyPublisher<FavoriteList, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFavoriteList)
    }
}
