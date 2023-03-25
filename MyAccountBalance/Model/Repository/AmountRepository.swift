//
//  AmountRepository.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import Foundation
import Combine

protocol AmountRepositoryInterFace {
    // Amount
    func getFirstUSDSaving() -> AnyPublisher<SavingsList, Error>
    func getFirstUSDFixed() -> AnyPublisher<FixedDepositList, Error>
    func getFirstUSDDigital() -> AnyPublisher<DigitalList, Error>
    func getFirstKHRSaving() -> AnyPublisher<SavingsList, Error>
    func getFirstKHRFixed() -> AnyPublisher<FixedDepositList, Error>
    func getFirstKHRDigital() -> AnyPublisher<DigitalList, Error>
    func getPullUSDSaving() -> AnyPublisher<SavingsList, Error>
    func getPullUSDFixed() -> AnyPublisher<FixedDepositList, Error>
    func getPullUSDDigital() -> AnyPublisher<DigitalList, Error>
    func getPullKHRSaving() -> AnyPublisher<SavingsList, Error>
    func getPullKHRFixed() -> AnyPublisher<FixedDepositList, Error>
    func getPullKHRDigital() -> AnyPublisher<DigitalList, Error>
}

class AmountRepository: AmountRepositoryInterFace{
    static let shared = AmountRepository()
    
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
    
    func getPullUSDSaving() -> AnyPublisher<SavingsList, Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getPullUSDSaving)
    }
    
    func getPullUSDFixed() -> AnyPublisher<FixedDepositList, Error>{
        return APIManager.shared.requestAPI(urlstring: APIInfo.getPullUSDFixed)
    }
    
    func getPullUSDDigital() -> AnyPublisher<DigitalList, Error>{
        return APIManager.shared.requestAPI(urlstring: APIInfo.getPullUSDDigital)
    }
    
    func getPullKHRSaving() -> AnyPublisher<SavingsList, Error>{
        return APIManager.shared.requestAPI(urlstring: APIInfo.getPullKHRSaving)
    }
    
    func getPullKHRFixed() -> AnyPublisher<FixedDepositList, Error>{
        return APIManager.shared.requestAPI(urlstring: APIInfo.getPullKHRFixed)
    }
    
    func getPullKHRDigital() -> AnyPublisher<DigitalList, Error>{
        return APIManager.shared.requestAPI(urlstring: APIInfo.getPullKHRDigital)
    }
}
