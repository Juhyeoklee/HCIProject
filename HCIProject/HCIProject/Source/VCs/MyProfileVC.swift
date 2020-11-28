//
//  MyProfileVC.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

class MyProfileVC: UIViewController {

    @IBOutlet var profileEditButton: UIButton!
    
    @IBOutlet var selectViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectViews.forEach{
            $0.dropShadow(color: .black, offSet: CGSize(width: 0, height: 0), opacity: 0.1, radius: 4)
        }
        
        profileEditButton.makeRounded(cornerRadius: 7)
        profileEditButton.setBorder(borderColor: .white, borderWidth: 1.0)
    }

}
