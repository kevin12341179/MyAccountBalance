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
    @IBOutlet weak var moreView: MoreView!
    
    // Base
    var viewModel: HomeVMInterFace = HomeVM()
    var cancellable = Set<AnyCancellable>()
    
    var isSecurity = false
    var usdString = ""
    var khrString = ""
    
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
        DispatchQueue.main.async {
            self.usdAnitmationView.startCustomAnitmation()
            self.khrAnitmationView.startCustomAnitmation()
        }
        bindViewModel()
        viewModel.getAllData(type: .First)
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
        
        viewModel.refreshEndPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] close in
                if close {
                    self?.refreshControl.endRefreshing()
                    self?.usdAnitmationView.isHidden = true
                    self?.khrAnitmationView.isHidden = true
                }
            }
            .store(in: &cancellable)
        
        viewModel.messagesListPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] messagesList in
                self?.messagesList = messagesList
                if messagesList.count > 0 {
                    self?.messageButton.setImage(UIImage(named: "iconBell02Active"), for: .normal)
                }
            }
            .store(in: &cancellable)
        
        viewModel.usdPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] usd in
                self?.usdString = String(usd).toCurrency
                self?.usdLabel.text = self?.isSecurity ?? false ? "********" : self?.usdString
            }
            .store(in: &cancellable)
        
        viewModel.khrPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] khr in
                self?.khrString = String(khr).toCurrency
                self?.khrLabel.text = self?.isSecurity ?? false ? "********" : self?.khrString
            }
            .store(in: &cancellable)
        
        viewModel.favoriteListListPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] favoriteList in
                self?.moreView.setFavorite(data: favoriteList)
            }
            .store(in: &cancellable)
    }
    
    @objc func onRefresh() {
        usdAnitmationView.isHidden = false
        khrAnitmationView.isHidden = false
        viewModel.getAllData(type: .After)
    }
    
    @IBAction func messageButtonClick(_ sender: Any) {
    }
    
    @IBAction func eyesButtonClick(_ sender: UIButton) {
        self.isSecurity = !self.isSecurity
        sender.setImage(self.isSecurity ? UIImage(named: "iconEye02Off") : UIImage(named: "iconEye01On"), for: .normal)
        self.usdLabel.text = self.isSecurity ? "********" : self.usdString
        self.khrLabel.text = self.isSecurity ? "********" : self.khrString
    }
}
