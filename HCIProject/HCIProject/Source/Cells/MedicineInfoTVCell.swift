//
//  MedicineInfoTVCell.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/28.
//

import UIKit

class MedicineInfoTVCell: UITableViewCell {
    static let identifier = "MedicineInfoTVCell"
    
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var chatBackgroundView: UIView!
    
    @IBOutlet var medicineTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        initCellLayout()
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
    }
    
    func bindData(chat: Chat) {
        medicineTitleLabel.text = chat.medicineName
        chatLabel.text = chat.text
    }

}
