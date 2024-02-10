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
    @IBOutlet weak var bannerView: BannerView!
    
    // Base
    var viewModel: HomeVMInterFace = HomeVM()
    var cancellable = Set<AnyCancellable>()
    var isSecurity = false
    var usdString = ""
    var khrString = ""
    // Pull Refresh
    var refreshControl: UIRefreshControl = UIRefreshControl()
    //Data
    var messagesList: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.bounces = true
        scrollView.refreshControl = refreshControl
        scrollView.refreshControl?.addTarget(self, action:
                                                #selector(onRefresh),
                                             for: .valueChanged)
        self.usdAnitmationView.isHidden = false
        self.khrAnitmationView.isHidden = false
        bindViewModel()
        viewModel.getAllData(type: .First)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        DispatchQueue.main.async {
            self.usdAnitmationView.startCustomAnitmation()
            self.khrAnitmationView.startCustomAnitmation()
        }
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
                guard close
                else { return }
                
                self?.refreshControl.endRefreshing()
                self?.usdAnitmationView.isHidden = true
                self?.khrAnitmationView.isHidden = true
            }
            .store(in: &cancellable)
        
        viewModel.messagesListPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] messagesList in
                self?.messagesList = messagesList
                
                guard messagesList.count > 0
                else { return }
                
                self?.messageButton.setImage(UIImage(named: "iconBell02Active"), for: .normal)
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
        
        viewModel.favoriteListPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] favoriteList in
                self?.moreView.setFavorite(data: favoriteList)
            }
            .store(in: &cancellable)
        
        viewModel.bannerListPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] bannerList in
                self?.bannerView.setBannerData(bannerData: bannerList)
            }
            .store(in: &cancellable)
    }
    
    @objc func onRefresh() {
        usdAnitmationView.isHidden = false
        khrAnitmationView.isHidden = false
        viewModel.getAllData(type: .After)
    }
    
    @IBAction func messageButtonClick(_ sender: Any) {
        guard let vc =  UIStoryboard(name: "MessageView", bundle: nil).instantiateInitialViewController() as? MessageView
        else { return }
        
        vc.setMessageData(messages: messagesList)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func eyesButtonClick(_ sender: UIButton) {
        self.isSecurity = !self.isSecurity
        sender.setImage(self.isSecurity ? UIImage(named: "iconEye02Off") : UIImage(named: "iconEye01On"), for: .normal)
        self.usdLabel.text = self.isSecurity ? "********" : self.usdString
        self.khrLabel.text = self.isSecurity ? "********" : self.khrString
    }
}
