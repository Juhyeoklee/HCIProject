//
//  YourChatSpeacialTVCell.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/25.
//

import UIKit

class YourChatSpeacialTVCell: UITableViewCell {
    static let identifier = "YourChatSpeacialTVCell"
    
    @IBOutlet var chatBackgroundView: UIView!
    
    @IBOutlet var callButton: UIButton!
    @IBOutlet var detailInfoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCellLayout()
        self.selectionStyle = .none
        // Initialization code
    }
    
    private func initCellLayout() {
        chatBackgroundView.layer.cornerRadius = 20
        chatBackgroundView.clipsToBounds = true
//        writeInThemeButton.backgroundColor = .softGreen
        // .layerMaxXMinYCorner : 오른쪽 위
        // .layerMaxXMaxYCorner : 오른쪽 아래
        // .layerMinXMaxYCorner : 왼쪽 아래
        // .layerMinXMinYCorner : 왼쪽 위
        chatBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        
        [callButton, detailInfoButton].forEach {
            $0?.makeRounded(cornerRadius: 8)
            $0?.setBorder(borderColor: .brownGreyTwo, borderWidth: 1)
        }
        callButton.setBorder(borderColor: .greenblue, borderWidth: 1)
    }
    
}
