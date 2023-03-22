//
//  MainVM.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import Foundation
import Combine

enum NowType {
    case First
    case After
}

protocol HomeVMInterFace {
    func getAllData(type: NowType)
    // error
    var errorMessageListPublisher: Published<String>.Publisher { get }
    // Refresh
    var refreshEndPublisher: Published<Bool>.Publisher { get }
    // Notification
    var messagesListPublisher: Published<[Notification]>.Publisher { get }
    //USD & KHR
    var usdPublisher: Published<Double>.Publisher { get }
    var khrPublisher: Published<Double>.Publisher { get }
    // Favorite
    var favoriteListListPublisher: Published<[Favorite]>.Publisher { get }
}

class HomeVM: HomeVMInterFace {
    @Published private var _errorMessage: String = ""
    var errorMessageListPublisher: Published<String>.Publisher { $_errorMessage }
    
    @Published private var _refreshEnd: Bool = false
    var refreshEndPublisher: Published<Bool>.Publisher { $_refreshEnd }
    
    @Published private var _messagesList: [Notification] = []
    var messagesListPublisher: Published<[Notification]>.Publisher { $_messagesList }
    
    @Published private var _usdPublisher: Double = 0.0
    var usdPublisher: Published<Double>.Publisher { $_usdPublisher }
    @Published private var _khrPublisher: Double = 0.0
    var khrPublisher: Published<Double>.Publisher { $_khrPublisher }
    
    @Published private var _favoriteListList: [Favorite] = []
    var favoriteListListPublisher: Published<[Favorite]>.Publisher { $_favoriteListList }
    
    private let apiRepository: APIRepositoryInterFace
    var cancellable = Set<AnyCancellable>()
    
    init(apiRepository: APIRepositoryInterFace = APIRepository.shared) {
        self.apiRepository = apiRepository
    }
    
    func getAllData(type: NowType){
        _getNotificationList(type: type)
            .delay(for: 1, scheduler: RunLoop.main)
            .flatMap { _ -> AnyPublisher<Bool, Error> in
                return self._getAllUSDMoney(type: type)
            }
            .flatMap { _ -> AnyPublisher<Bool, Error> in
                return self._getAllKHRMoney(type: type)
            }
            .flatMap { _ -> AnyPublisher<Bool, Error> in
                return self._getFavoriteList(type: type)
            }
            .sink(receiveCompletion: { [weak self] completion in
                guard let `self` = self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self._errorMessage = error.localizedDescription
                    self._refreshEnd = true
                }
            }, receiveValue: { _ in
                self._refreshEnd = true
            })
            .store(in: &cancellable)
    }
    
    func _getNotificationList(type: NowType) -> AnyPublisher<Bool, Error> {
        (type == .First ? apiRepository.getEmptyNotificationList() : apiRepository.getNotificationList())
            .allSatisfy({ data in
                self._messagesList = data.messages ?? []
                return true
            })
            .eraseToAnyPublisher()
    }
    
    func _getAllUSDMoney(type: NowType) -> AnyPublisher<Bool, Error> {
        return (type == .First ? Publishers.CombineLatest3(apiRepository.getFirstUSDSaving(), apiRepository.getFirstUSDFixed(), apiRepository.getFirstUSDDigital()) : Publishers.CombineLatest3(apiRepository.getPullUSDSaving(), apiRepository.getPullUSDFixed(), apiRepository.getPullUSDDigital()))
            .allSatisfy {(savingsList, fixedDepositList, digitalList) in
                let total = (savingsList.savingsList + fixedDepositList.fixedDepositList + digitalList.digitalList).reduce(0, {$0 + $1.balance})
                self._usdPublisher = total
                
                return true
            }
            .eraseToAnyPublisher()
    }
    
    func _getAllKHRMoney(type: NowType) -> AnyPublisher<Bool, Error> {
        return (type == .First ? Publishers.CombineLatest3(apiRepository.getFirstKHRSaving(), apiRepository.getFirstKHRFixed(), apiRepository.getFirstKHRDigital()) : Publishers.CombineLatest3(apiRepository.getPullKHRSaving(), apiRepository.getPullKHRFixed(), apiRepository.getPullKHRDigital()))
            .allSatisfy {(savingsList, fixedDepositList, digitalList) in
                let total = (savingsList.savingsList + fixedDepositList.fixedDepositList + digitalList.digitalList).reduce(0, {$0 + $1.balance})
                self._khrPublisher = total
                
                return true
            }
            .eraseToAnyPublisher()
    }
    
    func _getFavoriteList(type: NowType) -> AnyPublisher<Bool, Error> {
        (type == .First ? apiRepository.getEmptyFavoriteList() : apiRepository.getFavoriteList())
            .allSatisfy({ data in
                self._favoriteListList = data.favoriteList ?? []
                return true
            })
            .eraseToAnyPublisher()
    }
}
