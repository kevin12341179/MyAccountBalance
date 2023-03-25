//
//  ScrollView.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import UIKit

extension UIScrollView {
    func scrollToIndex(index:Int) {
        var frame = CGRect()
        frame.origin.x = self.frame.size.width * CGFloat(index)
        frame.origin.y = 0
        frame.size = self.frame.size
        
        self.scrollRectToVisible(frame, animated: true)
    }
}
