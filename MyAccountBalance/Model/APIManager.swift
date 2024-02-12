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

    func request<T: Codable>(endpoint: APIEndpoint) -> AnyPublisher<T, Error> {
        var urlString = endpoint.url
        guard let url = URL(string: urlString)
        else {
            return Fail(error: ErrorType.UrlError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        if endpoint.httpMethod == .POST,
           let body = endpoint.body {
            
            let bodyData = try? JSONSerialization.data(
                withJSONObject: body,
                options: []
            )
            request.httpBody = bodyData
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map({ $0.result })
            .eraseToAnyPublisher()
    }
}

