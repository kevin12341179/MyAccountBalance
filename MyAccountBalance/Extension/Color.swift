//
//  Color.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import UIKit

extension UIColor {
    public class func rgbaColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
