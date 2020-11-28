//
//  AlarmVC.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

class AlarmVC: UIViewController {

    @IBOutlet var pointViews: [UIView]!
    @IBOutlet var alarmSettingBackgroundView: UIView!
    
    @IBOutlet var alarmViews: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        // Do any additional setup after loading the view.
    }
    
    func initLayout() {
        pointViews.forEach {
            $0.makeRounded(cornerRadius: $0.frame.width / 2)
        }
        alarmSettingBackgroundView.dropShadow(color: .black,
                                              offSet: CGSize(width: 0, height: 0),
                                              opacity: 0.1, radius: 4)
        alarmViews.forEach {
            $0.dropShadow(color: .black,
                          offSet: CGSize(width: 0, height: 0),
                          opacity: 0.1,
                          radius: 4)
        }
        
        let tapGesureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUpAlarmSetting))
        alarmSettingBackgroundView.isUserInteractionEnabled = true
        alarmSettingBackgroundView.addGestureRecognizer(tapGesureRecognizer)
    }
    
    @objc func touchUpAlarmSetting() {
        let alarmSettingStoryboard = UIStoryboard(name: "AlarmSetting", bundle: nil)
        let dvc = alarmSettingStoryboard.instantiateViewController(identifier: "AlarmSettingVC")
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
