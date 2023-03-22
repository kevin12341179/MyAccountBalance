//
//  APIInfo.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

struct APIInfo {
    static let domain : String = "https://willywu0201.github.io/data/"
    // Notification
    static let getEmptyNotificationList = domain + "emptyNotificationList.json"
    static let getNotificationList = domain + "notificationList.json"
    // Amount
    static let getFirstUSDSaving = domain + "usdSavings1.json"
    static let getFirstUSDFixed = domain + "usdFixed1.json"
    static let getFirstUSDDigital = domain + "usdDigital1.json"
    static let getFirstKHRSaving = domain + "khrSavings1.json"
    static let getFirstKHRFixed = domain + "khrFixed1.json"
    static let getFirstKHRDigital = domain + "khrDigital1.json"
    
    static let getPullUSDSaving = domain + "usdSavings2.json"
    static let getPullUSDFixed = domain + "usdFixed2.json"
    static let getPullUSDDigital = domain + "usdDigital2.json"
    static let getPullKHRSaving = domain + "khrSavings2.json"
    static let getPullKHRFixed = domain + "khrFixed2.json"
    static let getPullKHRDigital = domain + "khrDigital2.json"
    //Favorite
    static let getEmptyFavoriteList = domain + "emptyFavoriteList.json"
    static let getFavoriteList = domain + "favoriteList.json"
}
