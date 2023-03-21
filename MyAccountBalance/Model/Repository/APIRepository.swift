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
    func getFirstUSDSaving() -> AnyPublisher<SavingsList, Error>
    func getFirstUSDFixed() -> AnyPublisher<FixedDepositList, Error>
    func getFirstUSDDigital() -> AnyPublisher<DigitalList, Error>
    func getFirstKHRSaving() -> AnyPublisher<SavingsList, Error>
    func getFirstKHRFixed() -> AnyPublisher<FixedDepositList, Error>
    func getFirstKHRDigital() -> AnyPublisher<DigitalList, Error>
}

class APIRepository: APIRepositoryInterFace{
    static let shared = APIRepository()
    
    func getEmptyNotificationList() -> AnyPublisher<Message, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getEmptyNotificationList)
    }
    
    func getNotificationList() -> AnyPublisher<Message, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getNotificationList)
    }
    
    func getFirstUSDSaving() -> AnyPublisher<SavingsList, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFirstUSDSaving)
    }
    
    func getFirstUSDFixed() -> AnyPublisher<FixedDepositList, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFirstUSDFixed)
    }
    
    func getFirstUSDDigital() -> AnyPublisher<DigitalList, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFirstUSDDigital)
    }
    
    func getFirstKHRSaving() -> AnyPublisher<SavingsList, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFirstKHRSaving)
    }
    
    func getFirstKHRFixed() -> AnyPublisher<FixedDepositList, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFirstKHRFixed)
    }
    
    func getFirstKHRDigital() -> AnyPublisher<DigitalList, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFirstKHRDigital)
    }
}
