//
//  FunctionCollectionViewCell.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/21.
//

import UIKit

class FunctionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellData(data: FunctionCollectionData){
        imageView.image = data.image
        label.text = data.title
    }
}
