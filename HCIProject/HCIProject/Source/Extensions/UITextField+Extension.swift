//
//  UITextField+Extension.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

extension UITextField{
    func addLeftPadding(left: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
      }
}
