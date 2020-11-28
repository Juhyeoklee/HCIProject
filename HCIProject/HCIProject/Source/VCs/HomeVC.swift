//
//  HomeVC.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var treatCollectionView: UICollectionView!{
        didSet {
            treatCollectionView.delegate = self
            treatCollectionView.dataSource = self
        }
    }
    @IBOutlet var treatCountLabel: UILabel!
    @IBOutlet var qrexplainLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet var nameAttributeLabel: UILabel!
    
    var isQRVisited = false
    var treats: [Treat] = [Treat(hospitalName: "안호범 안과",
                                 diseaseName: "눈 다래끼",
                                 recentDate: "2020-07-22",
                                 isTreating: false)]
    
    let horizontalInset: CGFloat = 26
    let topInset: CGFloat = 23
    let bottomInset: CGFloat = 89
    let lineSpacing: CGFloat = 17
    
    override func viewDidLoad() {
        super.viewDidLoad()
//            for family: String in UIFont.familyNames {
//                print("\(family)")
//                for names: String in UIFont.fontNames(forFamilyName: family) {
//                    print("== \(names)")
//                }
//            }
        let attributedString = NSMutableAttributedString(string: "안녕하세요, 홍길동님!", attributes: [
          .font: UIFont(name: "NanumSquareR", size: 18.0)!,
          .foregroundColor: UIColor(white: 247.0 / 255.0, alpha: 1.0)
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "NanumSquareEB", size: 18.0)!, range: NSRange(location: 7, length: 3))
        nameAttributeLabel.attributedText = attributedString
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isQRVisited {
            treats.insert(Treat(hospitalName: "오아로피부과의원 노원점",
                                diseaseName: "피부 두드러기",
                                recentDate: "2020-11-15",
                                isTreating: true), at: 0)
            isQRVisited = false
            
            treatCountLabel.text = "\(treats.filter{ return $0.isTreating }.count)건"
            treatCollectionView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        if self.view.safeAreaInsets.bottom == 0 {
//            qrexplainLabelBottomConstraint.constant = 57
        }
    }
    // UIAlertController without handler
    func simpleAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func touchUpAlarmButton(_ sender: Any) {
        let alarmStoryboard = UIStoryboard(name: "Alarm", bundle: nil)
        let dvc = alarmStoryboard.instantiateViewController(identifier: "AlarmVC")
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chatStoryboard = UIStoryboard(name: "Chatting", bundle: nil)
        
        if let dvc = chatStoryboard.instantiateViewController(identifier: "ChattingVC") as? ChattingVC {
            dvc.diseaseName = treats[indexPath.item].diseaseName
            
            if treats[indexPath.item].isTreating {
                self.navigationController?.pushViewController(dvc, animated: true)
            }
            else {
                simpleAlert(title: "진료가 완료되었어요!", message: "")
            }
        }
    }
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return treats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TreatCVCell.identifier, for: indexPath) as? TreatCVCell {
            let treat = treats[indexPath.item]
            cell.setCell(treat: treat)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 2 * horizontalInset
        
        return CGSize(width: width, height: 114)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: topInset, left: horizontalInset, bottom: bottomInset, right: horizontalInset)
    }
}
