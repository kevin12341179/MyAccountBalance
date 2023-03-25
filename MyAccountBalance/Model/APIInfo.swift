//
//  APIInfo.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

struct APIInfo {
    static let domain : String = "https://willywu0201.github.io"
    // Notification
    static let getEmptyNotificationList = domain + "/data/emptyNotificationList.json"
    static let getNotificationList = domain + "/data/notificationList.json"
    // Amount
    static let getFirstUSDSaving = domain + "/data/usdSavings1.json"
    static let getFirstUSDFixed = domain + "/data/usdFixed1.json"
    static let getFirstUSDDigital = domain + "/data/usdDigital1.json"
    static let getFirstKHRSaving = domain + "/data/khrSavings1.json"
    static let getFirstKHRFixed = domain + "/data/khrFixed1.json"
    static let getFirstKHRDigital = domain + "/data/khrDigital1.json"
    
    static let getPullUSDSaving = domain + "/data/usdSavings2.json"
    static let getPullUSDFixed = domain + "/data/usdFixed2.json"
    static let getPullUSDDigital = domain + "/data/usdDigital2.json"
    static let getPullKHRSaving = domain + "/data/khrSavings2.json"
    static let getPullKHRFixed = domain + "/data/khrFixed2.json"
    static let getPullKHRDigital = domain + "/data/khrDigital2.json"
    // Favorite
    static let getEmptyFavoriteList = domain + "/data/emptyFavoriteList.json"
    static let getFavoriteList = domain + "/data/favoriteList.json"
    // Banner
    static let getBannerList = domain + "/data/banner.json"
}
