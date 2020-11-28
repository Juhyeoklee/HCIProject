//
//  CarePlusTabBarC.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

class CarePlusTabBarC: UITabBarController {

    
    var homeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 94, height: 94))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "qrCode"), for: .normal)
        button.addTarget(self, action: #selector(touchUpHome), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
//        initLayoutTabBar()
        setTabs()
//        makeHomeButton()
        homeStateButtonLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        makeHomeButton()
        let horizonInset: CGFloat = 11
        let verticalInset: CGFloat = 20
        var insets: [UIEdgeInsets] = [.init(top: verticalInset, left: horizonInset, bottom: -verticalInset, right: -horizonInset),
                                      .init(top: 0, left: 0, bottom: 0, right: 0),
                                      .init(top: verticalInset, left: -horizonInset, bottom: -verticalInset, right: horizonInset)]
        
        if self.view.safeAreaInsets.bottom == 0 {
            insets = insets.compactMap{ return UIEdgeInsets(top: 5, left: $0.left, bottom: -5, right: $0.right) }
        }
        
        for i in 0..<self.viewControllers!.count {
            self.viewControllers![i].tabBarItem.imageInsets = insets[i]
        }
        
    }
    func setTabs() {
        print(self.view.safeAreaInsets)
        
        let calendarStoryboard = UIStoryboard(name: "Calendar", bundle: nil)
        
        guard let calendarTab = calendarStoryboard.instantiateViewController(identifier: "CalendarVC") as? CalendarVC else {
            return
        }
        calendarTab.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        calendarTab.tabBarItem.image = UIImage(named: "calendar3")?.withRenderingMode(.alwaysOriginal)
        calendarTab.tabBarItem.selectedImage = UIImage(named: "calendar2")?.withRenderingMode(.alwaysOriginal)
        
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeTab = homeStoryboard.instantiateViewController(identifier: "HomeVC")

        
        let myProfileStoryboard = UIStoryboard(name: "MyProfile", bundle: nil)
        guard let myProfileTab = myProfileStoryboard.instantiateViewController(identifier: "MyProfileVC") as? MyProfileVC else {
            return
        }
        myProfileTab.tabBarItem.image = UIImage(named: "user1")?.withRenderingMode(.alwaysOriginal)
        myProfileTab.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        setViewControllers([calendarTab, homeTab, myProfileTab], animated: true)
        
//        tabBar.tintColor = .greenblue
        selectedIndex = 1
    }
    
    func initLayoutTabBar(){
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundEffect = nil
        // need to set background because it is black in standardAppearance
        appearance.backgroundColor = .white
        
        tabBar.standardAppearance = appearance
        
        
    }
    
    func makeHomeButton() {
        self.view.addSubview(homeButton)
        var height: CGFloat = 94
        var width: CGFloat = 94
        var bottom: CGFloat = -11
        
        if self.view.safeAreaInsets.bottom == 0 {
//            height = 73
//            width = 73
//            bottom = -5
//            homeButton.imageEdgeInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        }
        else {
            height = 94
            width = 94
            bottom = -11
        }
        NSLayoutConstraint.activate([
            homeButton.widthAnchor.constraint(equalToConstant: width),
            homeButton.heightAnchor.constraint(equalToConstant: height),
            homeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: bottom),
            homeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        homeButton.backgroundColor = .white
        homeButton.makeRounded(cornerRadius: homeButton.frame.width / 2)
        
        homeButton.dropShadow(color: .brownGrey16,
                              offSet: CGSize(width: 0, height: 3),
                              opacity: 0.16, radius: 14)
        print(homeButton.imageEdgeInsets)
    }
    
    func homeStateButtonLayout() {
        homeButton.setImage(UIImage(named: "qrCode"), for: .normal)
        homeButton.setBorder(borderColor: .greenblue, borderWidth: 3)
//        homeButton.removeTarget(self, action: #selector(touchUpHome), for: .allEvents)
        
        homeButton.addTarget(self, action: #selector(touchUpQR), for: .touchUpInside)
        print(#function)
    }
    
    func otherStateButtonLayout() {
        homeButton.setImage(UIImage(named: "home"), for: .normal)
        homeButton.setBorder(borderColor: .clear, borderWidth: 0)
        homeButton.removeTarget(self, action: #selector(touchUpQR), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(touchUpHome), for: .touchUpInside)
        print(#function)
    }
    
    @objc func touchUpHome() {
        print(#function)
        selectedIndex = 1
        
        homeStateButtonLayout()
    }
    
    @objc func touchUpQR() {
        print(#function)
        let cameraStoryboard = UIStoryboard(name: "QRCamera", bundle: nil)
        
        let dvc = cameraStoryboard.instantiateViewController(identifier: "QRCameraVC")
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)
    }

}

extension CarePlusTabBarC: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController is HomeVC {
            return false
        }
        
        return true
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if viewController is CalendarVC || viewController is MyProfileVC {
            otherStateButtonLayout()
        }
    }
}
