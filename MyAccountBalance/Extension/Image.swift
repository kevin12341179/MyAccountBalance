//
//  Image.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import Foundation
import UIKit

extension UIImageView {
    private static var cache = NSCache<NSString, UIImage>()
    
    static func loadImage(urlString: String, callBack: @escaping (UIImage?) -> Void){
        if let image = cache.object(forKey: urlString as NSString) {
            callBack(image)
            return
        }

        DispatchQueue.global(qos: .default).async {
            if let url = URL(string: urlString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    callBack(image)
                }
            } else {
                DispatchQueue.main.async {
                    callBack(nil)
                }
            }
        }
    }
}
