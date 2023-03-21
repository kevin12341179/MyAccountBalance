//
//  MainVM.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import Foundation
import Combine

protocol HomeVMInterFace {
    var messagesListPublisher: Published<[Notification]>.Publisher { get }
    func getEmptyNotificationList()
    func getNotificationList()
}

class HomeVM: HomeVMInterFace {
    
    @Published private var _messagesList: [Notification] = []
    var messagesListPublisher: Published<[Notification]>.Publisher { $_messagesList }

    var errorMessage = ""
    private let apiRepository: APIRepositoryInterFace
    var cancellable = Set<AnyCancellable>()

    init(apiRepository: APIRepositoryInterFace = APIRepository.shared) {
        self.apiRepository = apiRepository
    }

    func getEmptyNotificationList() {
        apiRepository.getEmptyNotificationList()
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    self._messagesList = []
                }
            } receiveValue: {[weak self] data in
                guard let `self` = self else {return}
                self._messagesList = data.messages
            }
            .store(in: &cancellable)
    }
    
    func getNotificationList() {
        apiRepository.getNotificationList()
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: {[weak self] data in
                guard let `self` = self else {return}
                self._messagesList = data.messages
            }
            .store(in: &cancellable)
    }
}
