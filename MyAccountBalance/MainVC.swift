//
//  MainVC.swift
//  MyAccountBalance
//
//  Created by Kevin_Hsu on 2023/3/20.
//

import UIKit

enum PageType: Int{
    case Home = 0
    case Account = 1
    case Location = 2
    case Service = 3
}

class MainVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabarView: UIView!
    // Page Controller
    private var selectMode: PageType!
    private var subVC: UIViewController?
    private var homeVC : HomeVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabarView.layer.shadowColor = UIColor.black.cgColor
        tabarView.layer.shadowOpacity = 0.12
        tabarView.layer.shadowOffset =  CGSize(width: 4, height: 0)
        tabarView.layer.shadowRadius = 4
        setCurrentView(model: PageType.Home)
    }
    
    func setCurrentView(model: PageType){
        if selectMode == model { return }
        selectMode = model
        
        if self.subVC != nil {
            self.subVC?.view.removeFromSuperview()
            self.subVC?.removeFromParent()
            self.subVC = nil
        }
        
        switch self.selectMode {
        case .Home:
            if self.homeVC == nil {
                self.homeVC = HomeVC()
            }
            self.subVC = self.homeVC
        default:
            break
        }
        
        if self.subVC != nil {
            self.subVC?.view.frame = self.contentView.bounds
            self.addChild(self.subVC!)
            self.contentView.addSubview(self.subVC!.view)
            self.subVC?.didMove(toParent: self)
        }
    }
    
    @IBAction func tabarClick(_ sender: UIButton) {
        self.setCurrentView(model: PageType.init(rawValue: sender.tag) ?? .Home)
    }
    
}
