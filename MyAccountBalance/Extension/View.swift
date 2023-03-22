//
//  View.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import UIKit

extension UIView {
    func startCustomAnitmation() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [UIColor.rgbaColor(r: 240, g: 240, b: 240).cgColor, UIColor.rgbaColor(r: 251, g: 251, b: 251).cgColor, UIColor.rgbaColor(r: 240, g: 240, b: 240).cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]

        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientChangeAnimation.fromValue = [-1.0, -0.5, 0.0]
        gradientChangeAnimation.toValue = [1.0, 1.5, 2.0]
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.duration = 0.9
        gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
        
        self.layer.addSublayer(gradientLayer)

    }
}
