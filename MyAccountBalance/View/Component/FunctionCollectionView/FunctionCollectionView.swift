//
//  FunctionCollectionView.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/21.
//

import UIKit

struct FunctionCollectionData {
    var image: UIImage
    var title: String
}

@IBDesignable class FunctionCollectionView: UIView, NibOwnerLoadable{
    @IBOutlet weak var collectionView: UICollectionView!
    private var collectionData: [FunctionCollectionData] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        initCollectionView()
    }
    
    func initCollectionView(){
        self.collectionView.register(UINib(nibName:
                                            "FunctionCollectionViewCell", bundle:nil),
                                     forCellWithReuseIdentifier: "cell")
        collectionData = [
            FunctionCollectionData(image: UIImage(named: "button00ElementMenuTransfer") ?? UIImage(), title: "Transfer"),
            FunctionCollectionData(image: UIImage(named: "button00ElementMenuPayment") ?? UIImage(), title: "Payment"),
            FunctionCollectionData(image: UIImage(named: "button00ElementMenuUtility") ?? UIImage(), title: "Utility"),
            FunctionCollectionData(image: UIImage(named: "button01Scan") ?? UIImage(), title: "QR pay scan"),
            FunctionCollectionData(image: UIImage(named: "button00ElementMenuQRcode") ?? UIImage(), title: "My QR code"),
            FunctionCollectionData(image: UIImage(named: "button00ElementMenuTopUp") ?? UIImage(), title: "Top up")
        ]
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
}

extension FunctionCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.bounds.size.width/3
        return CGSize(width:width, height:96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FunctionCollectionViewCell {
            cell.setCellData(data: collectionData[indexPath.row])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// do something
    }
}
