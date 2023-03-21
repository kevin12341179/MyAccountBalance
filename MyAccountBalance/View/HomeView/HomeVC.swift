//
//  MainVC.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/19.
//

import UIKit
import Combine

class HomeVC: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "Home", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Home init(coder:) has not been implemented")
    }
    
    // Main
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Account Balance
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var eyesButton: UIButton!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var khrLabel: UILabel!
    @IBOutlet weak var usdAnitmationView: UIView!
    @IBOutlet weak var khrAnitmationView: UIView!
    
    // Base
    var viewModel: HomeVMInterFace = HomeVM()
    var cancellable = Set<AnyCancellable>()
    
    // Pull Refresh
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    //Data
    var messagesList: [Notification] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.bounces = true
        scrollView.refreshControl = refreshControl
        scrollView.refreshControl?.addTarget(self, action:
                                                #selector(onRefresh),
                                             for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
        viewModel.getEmptyNotificationList()
    }
    
    func bindViewModel(){
        viewModel.errorMessageListPublisher
            .receive(on: DispatchQueue.main)
            .sink { errorMessage in
                ShowMessageView.shared.showMessage(errorMessage, completionHandler: { _ in
                    // do error things
                })
            }
            .store(in: &cancellable)
        
        viewModel.messagesListPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] messagesList in
                self?.messagesList = messagesList
                if messagesList.count > 0 {
                    self?.messageButton.setImage(UIImage(named: "iconBell02Active"), for: .normal)
                }
                self?.refreshControl.endRefreshing()
            }
            .store(in: &cancellable)
    }
    
    @objc func onRefresh() {
        viewModel.getNotificationList()
        usdAnitmationView.startCustomAnitmation()
        khrAnitmationView.startCustomAnitmation()
    }
    
    @IBAction func messageButtonClick(_ sender: Any) {
    }
    
    @IBAction func eyesButtonClick(_ sender: Any) {
    }
}
