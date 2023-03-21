//
//  MoreView.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/21.
//

import UIKit

@IBDesignable class MoreView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    @IBAction func moreButtonClick(_ sender: Any) {
        // do something
    }
    
    func setMoreView(){
        
    }
}
