//
//  ShowMessageView.swift
//  MyAccountBalance
//
//  Created by Kevin_Hsu on 2023/3/21.
//

import UIKit

class ShowMessageView :UIView{
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var timer = Timer()
    private var hiddenTimer = Timer()
    private static var _shared:ShowMessageView?
    static var shared: ShowMessageView!{
        if _shared == nil{
            _shared = UINib(nibName: "ShowMessageView", bundle: Bundle.main).instantiate(withOwner: nil, options: nil).first as? ShowMessageView
        }
        return _shared
    }

    func showMessage(_ message: String, second: TimeInterval? = 3, completionHandler: @escaping (Bool) -> Void) {
        guard !message.isEmpty else {return}
        timer.invalidate()
        hiddenTimer.invalidate()
        self.isHidden = false
        if self.superview != nil{
            self.removeFromSuperview()
        }
        self.messageLabel.text = message
        
        UIApplication.shared.keyWindow?.addSubview(self)
        self.frame = UIApplication.shared.keyWindow?.frame ?? CGRect.zero
        self.center = UIApplication.shared.keyWindow?.center ?? CGPoint.zero
        
        UIView.animate(withDuration: 0.31, animations: {
            self.bgView.alpha = 1
        })
        timer = Timer.scheduledTimer(withTimeInterval: second!, repeats: false, block: { (_timer) in
            self.dismissMessageView()
            completionHandler(true)
        })
    }
    
    private func dismissMessageView() {
        hiddenTimer = Timer.scheduledTimer(withTimeInterval: 0.31, repeats: false, block: { (_timer) in
            self.isHidden = true
        })
        UIView.animate(withDuration: 0.31, animations: {
            self.bgView.alpha = 0
        })
    }
}
