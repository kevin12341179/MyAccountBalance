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
    var collectionData: [Favorite] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        initCollectionView()
    }
    
    @IBAction func moreButtonClick(_ sender: Any) {
        // do something
    }
    
    func initCollectionView(){
        self.collectionView.register(UINib(nibName:
                                            "FavoriteCell", bundle:nil),
                                     forCellWithReuseIdentifier: "cell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setFavorite(data: [Favorite]){
        collectionData = data
        collectionView.isScrollEnabled = collectionData.count > 4
        
        if collectionData.isEmpty {
            self.noDataView.isHidden = false
        } else {
            self.noDataView.isHidden = true
        }
        
        self.collectionView.reloadData()
    }
}

extension MoreView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:80, height:self.collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FavoriteCell
        else { return UICollectionViewCell() }
        
        var image: UIImage?
        switch collectionData[indexPath.row].transType {
        case "CUBC":
            image = UIImage(named: "button00ElementScrollTree")
        case "Mobile":
            image = UIImage(named: "button00ElementScrollMobile")
        case "PMF":
            image = UIImage(named: "button00ElementScrollTree")
        case "CreditCard":
            image = UIImage(named: "button00ElementScrollCreditCard")
        default:
            break;
        }
        cell.setCellData(image: image, title: collectionData[indexPath.row].nickname)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// do something
    }
}
