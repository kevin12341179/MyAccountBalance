//
//  APIRepository.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import Foundation
import Combine

protocol APIRepositoryInterFace {
    func getEmptyNotificationList() -> AnyPublisher<Message, Error>
    func getNotificationList() -> AnyPublisher<Message, Error>
}

class APIRepository: APIRepositoryInterFace{
    static let shared = APIRepository()
    
    func getEmptyNotificationList() -> AnyPublisher<Message, Error> {
        let publisher: AnyPublisher<Message, Error> = APIManager.shared.requestAPI(urlstring: APIInfo.getEmptyNotificationList)
        return publisher.eraseToAnyPublisher()
    }
    
    func getNotificationList() -> AnyPublisher<Message, Error> {
        let publisher: AnyPublisher<Message, Error> = APIManager.shared.requestAPI(urlstring: APIInfo.getNotificationList)
        return publisher.eraseToAnyPublisher()
    }
}
