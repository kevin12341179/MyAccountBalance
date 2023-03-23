//
//  APIManager.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import Foundation
import Combine

enum ErrorType: Error{
    case UrlError
    case ApiError
}

class APIManager {
    static let shared = APIManager()

    func requestAPI<T: Codable>(urlstring: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlstring) else {
            return Fail(error: ErrorType.UrlError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map({$0.result})
            .eraseToAnyPublisher()
    }
}

