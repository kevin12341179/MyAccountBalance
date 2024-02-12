//
//  BannerRepository.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import Foundation
import Combine

protocol BannerRepositoryInterFace {
    // Banner
    func getBannerList() -> AnyPublisher<BannerList, Error>
}

class BannerRepository: BannerRepositoryInterFace{
    static let shared = BannerRepository()

    func getBannerList() -> AnyPublisher<BannerList, Error> {
        return APIManager.shared.request(endpoint: .getBannerList)
    }
}
