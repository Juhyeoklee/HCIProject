//
//  TreatCVCell.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

class TreatCVCell: UICollectionViewCell {
    static let identifier = "TreatCVCell"
    
    @IBOutlet var cellWhiteBackgroundView: UIView!
    @IBOutlet var hospitalLabel: UILabel!
    @IBOutlet var diseaseLabel: UILabel!
    @IBOutlet var recentDateLabel: UILabel!
    @IBOutlet var recenDateTitleLabel: UILabel!
    
    @IBOutlet var treatStateBackgroundView: UIView!
    
    @IBOutlet var treatStateInnerView: UIView!
    
    @IBOutlet var treatStateLabel: UILabel!
    
    override func awakeFromNib() {
        initCell()
    }
    
    func initCell() {
        treatStateBackgroundView.makeRounded(cornerRadius: treatStateBackgroundView.frame.width / 2)
        treatStateInnerView.makeRounded(cornerRadius: treatStateInnerView.frame.width / 2)
        
        
        cellWhiteBackgroundView.makeRounded(cornerRadius: 15)
        
        self.makeRounded(cornerRadius: 15)
        self.dropShadow(color: .blue,
                        offSet: CGSize(width: 2, height: 5),
                        opacity: 0.04,
                        radius: 10)
        
    }
    
    func setCell(treat: Treat) {
        hospitalLabel.text = treat.hospitalName
        diseaseLabel.text = treat.diseaseName
        recentDateLabel.text = treat.recentDate
        
        if treat.isTreating {
            setTreatStateTrue()
        }
        else {
            setTreatStateFalse()
        }
    }
    
    private func setTreatStateTrue() {
        treatStateBackgroundView.backgroundColor = .greenblue
        treatStateLabel.textColor = .greenblue
        recenDateTitleLabel.textColor = .greenblue
        self.backgroundColor = .greenblue
        treatStateLabel.text = "진료중"
    }
    
    private func setTreatStateFalse() {
        treatStateBackgroundView.backgroundColor = .veryLightPink
        treatStateLabel.textColor = .veryLightPinkTwo
        recenDateTitleLabel.textColor = .veryLightPinkThree
        self.backgroundColor = .veryLightPink
        treatStateLabel.text = "완료"

    }
}
