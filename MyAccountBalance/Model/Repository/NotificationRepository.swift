//
//  NotificationRepository.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import Foundation
import Combine

protocol NotificationRepositoryInterFace {
    // Notification
    func getEmptyNotificationList() -> AnyPublisher<Messages, Error>
    func getNotificationList() -> AnyPublisher<Messages, Error>
}

class NotificationRepository: NotificationRepositoryInterFace{
    static let shared = NotificationRepository()
    
    func getEmptyNotificationList() -> AnyPublisher<Messages, Error> {
        return APIManager.shared.request(endpoint: .getEmptyNotificationList)
    }
    
    func getNotificationList() -> AnyPublisher<Messages, Error> {
        return APIManager.shared.request(endpoint: .getNotificationList)
    }
}
