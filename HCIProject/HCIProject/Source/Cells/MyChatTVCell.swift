//
//  MyChatTVCell.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

class MyChatTVCell: UITableViewCell {
    static let identifier = "MyChatTVCell"
    
    @IBOutlet var chatBackgroundView: UIView!
    @IBOutlet var chatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCellLayout()
        self.selectionStyle = .none
        // Initialization code
    }
    
    
    private func initCellLayout() {
        chatBackgroundView.layer.cornerRadius = 20
        chatBackgroundView.clipsToBounds = true
        // .layerMaxXMinYCorner : 오른쪽 위
        // .layerMaxXMaxYCorner : 오른쪽 아래
        // .layerMinXMaxYCorner : 왼쪽 아래
        // .layerMinXMinYCorner : 왼쪽 위
        chatBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func bindData(chat: Chat) {
        chatLabel.text = chat.text
    }
}
