//
//  MainVC.swift
//  MyAccountBalance
//
//  Created by Kevin_Hsu on 2023/3/20.
//

import UIKit

enum PageType {
    case Home
}

class MainVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    // Page Controller
    private var selectMode: PageType!
    private var subVC: UIViewController?
    private var homeVC : HomeVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
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
}
