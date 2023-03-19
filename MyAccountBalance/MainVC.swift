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
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.bounces = true
        scrollView.refreshControl = refreshControl
        scrollView.refreshControl?.addTarget(self, action:
                                                #selector(onRefresh),
                                             for: .valueChanged)
    }
    
    @objc func onRefresh() {
    }
    
    @IBAction func messageButtonClick(_ sender: Any) {
    }
    
    @IBAction func eyesButtonClick(_ sender: Any) {
    }
}
