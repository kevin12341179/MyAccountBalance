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
        Publishers.CombineLatest4(_getNotificationList(type: type), _getAllUSDMoney(type: type), _getAllKHRMoney(type: type), _getFavoriteList(type: type))
            .delay(for: 1, scheduler: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self._refreshEnd = true
            })
            .store(in: &cancellable)
    }
    
    func _getNotificationList(type: NowType) -> AnyPublisher<Bool, ErrorType> {
        (type == .First ? apiRepository.getEmptyNotificationList() : apiRepository.getNotificationList())
            .allSatisfy({ data in
                self._messagesList = data.messages ?? []
                return true
            })
            .catch ({ error in
                self._errorMessage = error.localizedDescription
                return Just(false).setFailureType(to: ErrorType.self)
            })
                .eraseToAnyPublisher()
    }
    
    func _getAllUSDMoney(type: NowType) -> AnyPublisher<Bool, ErrorType> {
        return (type == .First ? Publishers.CombineLatest3(apiRepository.getFirstUSDSaving(), apiRepository.getFirstUSDFixed(), apiRepository.getFirstUSDDigital()) : Publishers.CombineLatest3(apiRepository.getPullUSDSaving(), apiRepository.getPullUSDFixed(), apiRepository.getPullUSDDigital()))
            .allSatisfy {(savingsList, fixedDepositList, digitalList) in
                let total = (savingsList.savingsList + fixedDepositList.fixedDepositList + digitalList.digitalList).reduce(0, {$0 + $1.balance})
                self._usdPublisher = total
                
                return true
            }
            .catch ({ error in
                self._errorMessage = error.localizedDescription
                return Just(false).setFailureType(to: ErrorType.self)
            })
                .eraseToAnyPublisher()
    }
    
    func _getAllKHRMoney(type: NowType) -> AnyPublisher<Bool, ErrorType> {
        return (type == .First ? Publishers.CombineLatest3(apiRepository.getFirstKHRSaving(), apiRepository.getFirstKHRFixed(), apiRepository.getFirstKHRDigital()) : Publishers.CombineLatest3(apiRepository.getPullKHRSaving(), apiRepository.getPullKHRFixed(), apiRepository.getPullKHRDigital()))
            .allSatisfy {(savingsList, fixedDepositList, digitalList) in
                let total = (savingsList.savingsList + fixedDepositList.fixedDepositList + digitalList.digitalList).reduce(0, {$0 + $1.balance})
                self._khrPublisher = total
                
                return true
            }
            .catch ({ error in
                self._errorMessage = error.localizedDescription
                return Just(false).setFailureType(to: ErrorType.self)
            })
                .eraseToAnyPublisher()
    }
    
    func _getFavoriteList(type: NowType) -> AnyPublisher<Bool, ErrorType> {
        (type == .First ? apiRepository.getEmptyFavoriteList() : apiRepository.getFavoriteList())
            .allSatisfy({ favoriteList in
                self._favoriteListList = favoriteList.favoriteList ?? []
                return true
            })
            .catch ({ error in
                self._errorMessage = error.localizedDescription
                return Just(false).setFailureType(to: ErrorType.self)
            })
                .eraseToAnyPublisher()
    }
}
