//
//  MainVC.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import UIKit

class MainVC: UIViewController {
    // Main
    @IBOutlet weak var scrollView: UIScrollView!
    // Account Balance
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var eyesButton: UIButton!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var khrLabel: UILabel!
    @IBOutlet weak var usdAnitmationView: UIView!
    @IBOutlet weak var khrAnitmationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.bounces = true
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action:
                                                #selector(onRefresh),
                                             for: .valueChanged)
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = usdAnitmationView.bounds
        gradientLayer.colors = [UIColor.rgbaColor(r: 251, g: 251, b: 251), UIColor.rgbaColor(r: 240, g: 240, b: 240)]
        usdAnitmationView.layer.addSublayer(gradientLayer)
    }
    
    @objc func onRefresh() {
        
    }
    
    @IBAction func messageButtonClick(_ sender: Any) {
        
    }
    
    @IBAction func eyesButtonClick(_ sender: Any) {
    }
}
