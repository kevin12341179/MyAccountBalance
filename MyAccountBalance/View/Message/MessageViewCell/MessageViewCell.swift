//
//  MessageViewCell.swift
//  MyAccountBalance
//
//  Created by YU TSEN LIN on 2023/3/22.
//

import UIKit

class MessageViewCell: UITableViewCell {
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var updateDateTime: UILabel!
    @IBOutlet weak var message: UILabel!
    
    func setCellData(data: Notification){
        statusView.isHidden = !data.status
        title.text = data.title
        updateDateTime.text = data.updateDateTime
        message.text = data.message
    }
}
