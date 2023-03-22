//
//  String.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/22.
//

import Foundation

extension String {
    var toCurrency: String {
        let doubleValue = NSDecimalNumber(string: self).doubleValue
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.roundingMode = .down
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? ""
    }
}
