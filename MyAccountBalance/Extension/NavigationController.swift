//
//  NavigationController.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/22.
//

import Foundation
import UIKit

extension UINavigationController {
    func setBackgroundColor(_ color: UIColor) {
        self.navigationBar.barTintColor = .white
    }
    
    func setTitle(_ title: String, _ color: UIColor? = nil) {
        //        self.navigationBar.topItem?.title = title
        self.visibleViewController?.navigationItem.titleView = nil
        self.visibleViewController?.navigationItem.title = title
        if (color != nil) {
            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color!]
        }
    }

    func setLeftBackButton(){
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "iconArrowWTailBack"), for: .normal)
        leftButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        leftButton.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        let leftItem = UIBarButtonItem(customView: leftButton)
        
        self.visibleViewController?.navigationItem.leftBarButtonItems = [leftItem]
    }
    
    @objc private func clickBack(sender:UIButton) {
        popViewController(animated: true)
    }
}
