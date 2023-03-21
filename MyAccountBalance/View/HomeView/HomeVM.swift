//
//  MainVM.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import Foundation
import Combine

protocol HomeVMInterFace {
    // error
    var errorMessageListPublisher: Published<String>.Publisher { get }
    // Notification
    var messagesListPublisher: Published<[Notification]>.Publisher { get }
    
    func getEmptyNotificationList()
    func getNotificationList()
}

class HomeVM: HomeVMInterFace {
    @Published private var _errorMessage: String = ""
    var errorMessageListPublisher: Published<String>.Publisher { $_errorMessage }
    
    @Published private var _messagesList: [Notification] = []
    var messagesListPublisher: Published<[Notification]>.Publisher { $_messagesList }

    private let apiRepository: APIRepositoryInterFace
    var cancellable = Set<AnyCancellable>()

    init(apiRepository: APIRepositoryInterFace = APIRepository.shared) {
        self.apiRepository = apiRepository
    }

    func getEmptyNotificationList() {
        apiRepository.getEmptyNotificationList()
            .sink(receiveCompletion: { [weak self] completion in
                guard let `self` = self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self._errorMessage = error.localizedDescription
                    self._messagesList = []
                }
            }, receiveValue: { [weak self] data in
                guard let `self` = self else {return}
                self._messagesList = data.messages
            })
            .store(in: &cancellable)
    }
    
    func getNotificationList() {
        apiRepository.getNotificationList()
            .sink(receiveCompletion: { [weak self] completion in
                guard let `self` = self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self._errorMessage = error.localizedDescription
                    self._messagesList = []
                }
            }, receiveValue: { [weak self] data in
                guard let `self` = self else {return}
                self._messagesList = data.messages
            })
            .store(in: &cancellable)
    }
}
