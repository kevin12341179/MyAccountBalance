//
//  FavoriteCell.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/22.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setCellData(image: UIImage?, title: String){
        self.image.image = image
        self.title.text = title
    }
}
