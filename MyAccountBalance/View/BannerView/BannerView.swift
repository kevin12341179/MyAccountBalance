//
//  BannerView.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/25.
//

import UIKit

class BannerView: UIView, NibOwnerLoadable{
    
    @IBOutlet weak var scorllView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var emptyView: UIView!
    
    var bannerData: [Banner] = []
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        
        self.scorllView.delegate = self
    }
    
    func setBannerData(bannerData: [Banner]){
        self.bannerData = bannerData
        self.pageControl.numberOfPages = bannerData.count
        self.pageControl.currentPage = 0
        self.scorllView.contentSize = CGSize(width: scorllView.frame.size.width * CGFloat(bannerData.count), height: scorllView.frame.size.height)
        
        emptyView.isHidden = bannerData.count > 0
        if bannerData.count > 0  && timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(changePage), userInfo: nil, repeats: true)
        }
        for (i, data) in bannerData.enumerated() {
            var frame = CGRect()
            frame.origin.x = scorllView.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = scorllView.frame.size
            let bannerView = UIImageView(frame: frame)
            UIImageView.loadImage(urlString: data.linkUrl) { image in
                bannerView.image = image
            }
            
            self.scorllView.addSubview(bannerView)
        }
    }
    
    @objc func changePage(){
        if pageControl.currentPage < bannerData.count - 1 {
            pageControl.currentPage = pageControl.currentPage + 1
        }else {
            pageControl.currentPage = 0
        }
        self.scorllView.scrollToIndex(index: pageControl.currentPage)
    }
}

extension BannerView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}
