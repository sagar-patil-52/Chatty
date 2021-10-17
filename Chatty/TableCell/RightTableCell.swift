//
//  RightTableCell.swift
//  Chatty
//
//  Created by mmt on 17/10/21.
//

import Foundation
import UIKit

class RightTableCell: UITableViewCell {

    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var textMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageContainerView.rounded(radius: 12)
        messageContainerView.backgroundColor = UIColor(hexString: Constants.HEXColorString.rightCellBgColor)
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    func configureCell(message: Message) {
        textMessageLabel.text = message.message
    }
}
