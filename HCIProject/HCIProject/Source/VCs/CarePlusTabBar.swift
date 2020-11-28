//
//  CarePlusTabBar.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

@IBDesignable
class CarePlusTabBar: UITabBar {

    @IBInspectable var height: CGFloat = 83

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayoutTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initLayoutTabBar()
    }
    
    func initLayoutTabBar(){
        let appearance = self.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundEffect = nil
        // need to set background because it is black in standardAppearance
        appearance.backgroundColor = .white
        
        self.standardAppearance = appearance
    }

}
