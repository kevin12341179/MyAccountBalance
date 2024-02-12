//
//  APIEndpoint.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2024/2/11.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var url: String { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
}

enum APIEndpoint {
    // Notification
    case getEmptyNotificationList
    case getNotificationList
    // Amount
    case getFirstUSDSaving
    case getFirstUSDFixed
    case getFirstUSDDigital
    case getFirstKHRSaving
    case getFirstKHRFixed
    case getFirstKHRDigital
    
    case getPullUSDSaving
    case getPullUSDFixed
    case getPullUSDDigital
    case getPullKHRSaving
    case getPullKHRFixed
    case getPullKHRDigital
    // Favorite
    case getEmptyFavoriteList
    case getFavoriteList
    // Banner
    case getBannerList
}

extension APIEndpoint: Endpoint {
    var url: String {
        return baseURLString + path
    }
    
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    var baseURLString: String {
        return "https://willywu0201.github.io"
    }
    
    var path: String {
        switch self {
            // Notification
        case .getEmptyNotificationList: return "/data/emptyNotificationList.json"
        case .getNotificationList: return "/data/notificationList.json"
            // Amount
        case .getFirstUSDSaving: return "/data/usdSavings1.json"
        case .getFirstUSDFixed: return "/data/usdFixed1.json"
        case .getFirstUSDDigital: return "/data/usdDigital1.json"
        case .getFirstKHRSaving: return "/data/khrSavings1.json"
        case .getFirstKHRFixed: return "/data/khrFixed1.json"
        case .getFirstKHRDigital: return "/data/khrDigital1.json"
            
        case .getPullUSDSaving: return "/data/usdSavings2.json"
        case .getPullUSDFixed: return "/data/usdFixed2.json"
        case .getPullUSDDigital: return "/data/usdDigital2.json"
        case .getPullKHRSaving: return "/data/khrSavings2.json"
        case .getPullKHRFixed: return "/data/khrFixed2.json"
        case .getPullKHRDigital: return "/data/khrDigital2.json"
            // Favorite
        case . getEmptyFavoriteList: return "/data/emptyFavoriteList.json"
        case . getFavoriteList: return "/data/favoriteList.json"
            // Banner
        case . getBannerList: return "/data/banner.json"
        }
    }
    
    var headers: [String : Any]? {
        return [:]
    }
    
    var body: [String: Any]? {
        return [:]
    }
}

