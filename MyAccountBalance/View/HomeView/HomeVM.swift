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
    var messagesListPublisher: Published<[Message]>.Publisher { get }
    //USD & KHR
    var usdPublisher: Published<Double>.Publisher { get }
    var khrPublisher: Published<Double>.Publisher { get }
    // Favorite
    var favoriteListPublisher: Published<[Favorite]>.Publisher { get }
    // Banner
    var bannerListPublisher: Published<[Banner]>.Publisher { get }
}

class HomeVM: HomeVMInterFace {
    // Error
    @Published private var _errorMessage: String = ""
    var errorMessageListPublisher: Published<String>.Publisher { $_errorMessage }
    // RefreshEnd
    @Published private var _refreshEnd: Bool = false
    var refreshEndPublisher: Published<Bool>.Publisher { $_refreshEnd }
    // Message
    @Published private var _messagesList: [Message] = []
    var messagesListPublisher: Published<[Message]>.Publisher { $_messagesList }
    // USD & KHR
    @Published private var _usdPublisher: Double = 0.0
    var usdPublisher: Published<Double>.Publisher { $_usdPublisher }
    @Published private var _khrPublisher: Double = 0.0
    var khrPublisher: Published<Double>.Publisher { $_khrPublisher }
    // Favorite
    @Published private var _favoriteList: [Favorite] = []
    var favoriteListPublisher: Published<[Favorite]>.Publisher { $_favoriteList }
    // Banner
    @Published private var _bannerList: [Banner] = []
    var bannerListPublisher: Published<[Banner]>.Publisher { $_bannerList }
    
    private let apiRepository: APIRepositoryInterFace
    var cancellable = Set<AnyCancellable>()
    
    init(apiRepository: APIRepositoryInterFace = APIRepository.shared) {
        self.apiRepository = apiRepository
    }
    
    func getAllData(type: NowType){
        Publishers.CombineLatest4(_getNotificationList(type: type), _getAllUSDMoney(type: type), _getAllKHRMoney(type: type), _getFavoriteList(type: type))
            .handleEvents(
                receiveSubscription: { _ in
                    if type == .After {
                        self._getBannerList()
                            .sink { _ in
                            } receiveValue: { _ in
                            }
                            .store(in: &self.cancellable)
                    }
                })
            .delay(for: 1, scheduler: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { _ in
                self._refreshEnd = true
            })
            .store(in: &cancellable)
    }
    
    func _getBannerList() -> AnyPublisher<Bool, ErrorType> {
        apiRepository.getBannerList()
            .allSatisfy({ data in
                self._bannerList = data.bannerList
                return true
            })
            .catch ({ error in
                self._errorMessage = error.localizedDescription
                return Just(false).setFailureType(to: ErrorType.self)
            })
                .eraseToAnyPublisher()
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
                self._favoriteList = favoriteList.favoriteList ?? []
                return true
            })
            .catch ({ error in
                self._errorMessage = error.localizedDescription
                return Just(false).setFailureType(to: ErrorType.self)
            })
                .eraseToAnyPublisher()
    }
}
