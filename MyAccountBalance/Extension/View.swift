//
//  View.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import UIKit

extension UIView {
    func startCustomAnitmation() {
        var gradientSet = [[CGColor]]()
        let gradientLayer = CAGradientLayer()
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        
        let colorOne = UIColor.rgbaColor(r: 240, g: 240, b: 240).cgColor
        let colorTwo = UIColor.rgbaColor(r: 251, g: 251, b: 251).cgColor
        gradientSet = [
            [colorOne, colorTwo],
            [colorTwo, colorOne],
        ]
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [colorOne, colorTwo]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientChangeAnimation.duration = 0.5
        gradientChangeAnimation.fromValue = gradientSet[0]
        gradientChangeAnimation.toValue = gradientSet[1]
        gradientChangeAnimation.repeatCount = .greatestFiniteMagnitude
        gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
        
        self.isHidden = false
        self.layer.addSublayer(gradientLayer)
    }
    
    func stopCustomAnitmation(){
        self.isHidden = true
        self.layer.removeAnimation(forKey: "colorChange")
    }
}
