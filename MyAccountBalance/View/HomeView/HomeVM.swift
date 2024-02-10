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
    
    private let favoriteRepository: FavoriteRepositoryInterFace
    private let notificationRepository: NotificationRepositoryInterFace
    private let amountRepository: AmountRepositoryInterFace
    private let bannerRepository: BannerRepositoryInterFace
    var cancellable = Set<AnyCancellable>()
    
    init(
        favoriteRepository: FavoriteRepositoryInterFace = FavoriteRepository.shared,
        notificationRepository: NotificationRepositoryInterFace = NotificationRepository.shared,
        amountRepository: AmountRepositoryInterFace = AmountRepository.shared,
        bannerRepository: BannerRepositoryInterFace = BannerRepository.shared)
    {
        self.favoriteRepository = favoriteRepository
        self.notificationRepository = notificationRepository
        self.amountRepository = amountRepository
        self.bannerRepository = bannerRepository
    }
    
    func getAllData(type: NowType){
        Publishers.CombineLatest4(_getNotificationList(type: type), _getAllUSDMoney(type: type), _getAllKHRMoney(type: type), _getFavoriteList(type: type))
            .handleEvents(
                receiveSubscription: { _ in
                    guard type == .After
                    else { return }
                    
                    self._getBannerList()
                        .assign(to: \._bannerList, on: self)
                        .store(in: &self.cancellable)
                })
            .delay(for: 1, scheduler: RunLoop.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { (messages, usdMoney, khMoney, favroiteList) in
                self._messagesList = messages
                self._usdPublisher = usdMoney
                self._khrPublisher = khMoney
                self._favoriteList = favroiteList
                self._refreshEnd = true
            })
            .store(in: &cancellable)
    }
    
    func _getBannerList() -> AnyPublisher<[Banner], Never> {
        bannerRepository.getBannerList()
            .map({ $0.bannerList })
            .catch({ error -> AnyPublisher<[Banner], Never> in
                self._errorMessage = error.localizedDescription
                return Just([]).eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
    
    func _getNotificationList(type: NowType) -> AnyPublisher<[Message], Never> {
        (type == .First ? notificationRepository.getEmptyNotificationList() : notificationRepository.getNotificationList())
            .map({ $0.messages ?? [] })
            .catch ({ error -> AnyPublisher<[Message], Never> in
                self._errorMessage = error.localizedDescription
                return Just([]).eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
    
    func _getAllUSDMoney(type: NowType) -> AnyPublisher<Double, Never> {
        return (type == .First ? Publishers.CombineLatest3(amountRepository.getFirstUSDSaving(), amountRepository.getFirstUSDFixed(), amountRepository.getFirstUSDDigital()) : Publishers.CombineLatest3(amountRepository.getPullUSDSaving(), amountRepository.getPullUSDFixed(), amountRepository.getPullUSDDigital()))
            .map {(savingsList, fixedDepositList, digitalList) in
                return (savingsList.savingsList + fixedDepositList.fixedDepositList + digitalList.digitalList).reduce(0, {$0 + $1.balance})
            }
            .catch ({ error -> AnyPublisher<Double, Never> in
                self._errorMessage = error.localizedDescription
                return Just(0).eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
    
    func _getAllKHRMoney(type: NowType) -> AnyPublisher<Double, Never> {
        return (type == .First ? Publishers.CombineLatest3(amountRepository.getFirstKHRSaving(), amountRepository.getFirstKHRFixed(), amountRepository.getFirstKHRDigital()) : Publishers.CombineLatest3(amountRepository.getPullKHRSaving(), amountRepository.getPullKHRFixed(), amountRepository.getPullKHRDigital()))
            .map {(savingsList, fixedDepositList, digitalList) in
                return (savingsList.savingsList + fixedDepositList.fixedDepositList + digitalList.digitalList).reduce(0, {$0 + $1.balance})
            }
            .catch ({ error -> AnyPublisher<Double, Never> in
                self._errorMessage = error.localizedDescription
                return Just(0).eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
    
    func _getFavoriteList(type: NowType) -> AnyPublisher<[Favorite], Never> {
        (type == .First ? favoriteRepository.getEmptyFavoriteList() : favoriteRepository.getFavoriteList())
            .map({ $0.favoriteList ?? [] })
            .catch ({ error -> AnyPublisher<[Favorite], Never> in
                self._errorMessage = error.localizedDescription
                return Just([]).eraseToAnyPublisher()
            })
            .eraseToAnyPublisher()
    }
}
