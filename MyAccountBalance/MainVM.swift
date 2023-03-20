//
//  MainVM.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import Foundation
import Combine

protocol MainVMInterFace {
    var messagesListPublisher: Published<[Notification]>.Publisher { get }
    func getEmptyNotificationList()
    func getNotificationList()
}

class MainVM: MainVMInterFace {
    
    @Published var messagesList: [Notification] = []
    var messagesListPublisher: Published<[Notification]>.Publisher { $messagesList }

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
                    self.messagesList = []
                }
            } receiveValue: {[weak self] data in
                guard let `self` = self else {return}
                self.messagesList = data.messages
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
                self.messagesList = data.messages
            }
            .store(in: &cancellable)
    }
}
