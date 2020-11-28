//
//  ChattingVC.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

class ChattingVC: UIViewController {
    
    @IBOutlet var diseaseNameLabel: UILabel!
    @IBOutlet var chatInputTextField: UITextField! {
        didSet {
            chatInputTextField.delegate = self
        }
    }
    @IBOutlet var chatEnterButton: UIButton!
    
    @IBOutlet var chatTableview: UITableView! {
        didSet {
            chatTableview.dataSource = self
            chatTableview.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 10, right: 0)
        }
    }
    @IBOutlet var expandView: UIView!
    @IBOutlet var arrowBackgroundView: UIView!
    @IBOutlet var arrowImageView: UIImageView!
    @IBOutlet var quickQuestionLabel: UILabel!
    @IBOutlet var questionsContainerView: UIView!
    
    
    @IBOutlet var expandViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var textInputViewBottomConstraint: NSLayoutConstraint!
    var isExpand: Bool = false
    var diseaseName: String = "피부 두드러기"
    var chats: [Chat] = []
    var runCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        expandViewHeightConstraint.constant = 0
        arrowImageView.image = UIImage(named: "up")
        arrowImageView.tintColor = .brownGrey
        
        quickQuestionLabel.textColor = .brownGrey
        self.questionsContainerView.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    func initLayout() {
        diseaseNameLabel.text = diseaseName
        diseaseNameLabel.sizeToFit()
        
        arrowBackgroundView.layer.cornerRadius = 8
        arrowBackgroundView.clipsToBounds = true
//         .layerMaxXMinYCorner : 오른쪽 위
//         .layerMaxXMaxYCorner : 오른쪽 아래
//         .layerMinXMaxYCorner : 왼쪽 아래
//         .layerMinXMinYCorner : 왼쪽 위
        arrowBackgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    
        
        chatInputTextField.makeRounded(cornerRadius: 23)
        chatInputTextField.addLeftPadding(left: 15)
        chatInputTextField.autocorrectionType = .no
        chatEnterButton.makeRounded(cornerRadius: chatEnterButton.frame.width / 2)
        
        expandView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUpExpandView))
        expandView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setExpandStateTrue() {
        expandViewHeightConstraint.constant = 155
        arrowImageView.image = UIImage(named: "down")
        arrowImageView.tintColor = .greenblue
        
        quickQuestionLabel.textColor = .greenblue
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        } completion: { (finished) in
            if finished {
                self.questionsContainerView.isHidden = false
            }
        }
        
    }
    func setExpandStateFalse() {
        expandViewHeightConstraint.constant = 0
        arrowImageView.image = UIImage(named: "up")
        arrowImageView.tintColor = .brownGrey
        
        quickQuestionLabel.textColor = .brownGrey
        self.questionsContainerView.isHidden = true

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        } completion: { (finished) in
            if finished {
                
            }
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:
            UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:
            UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addChat(text: String) {
        let newChat = Chat(text: text, isMyCell: true, responseType: .myChat)
        chats.append(newChat)
        chatTableview.reloadData()
        chatTableview.scrollToRow(at: IndexPath(row: chats.count - 1, section: 0), at: .bottom, animated: true)
        chatInputTextField.text = ""
        
        var tmp = text.components(separatedBy: " ")
        var responseText = ""
        var responseType: CellType = .responseDefaultChat
        var medicineName: String? = nil
        
        if text.contains("약") && text.contains("언제") {
            responseText = "하루에 식후 30분,\n아침, 저녁으로 복용하시면 됩니다."
        }
        else if (text.contains("병원") && text.contains("언제")) || (text.contains("예약") && text.contains("언제")) {
            responseText = "2020년 12월 22일 오후 2시 예약입니다."
        }
        else if text.contains("예약") {
            responseText = ""
            responseType = .responseSpeacialChat
        }
        else if text.contains("음식") {
            responseText = "좋은음식\n검은깨,생강,양배추,결명자 차,꿀,무화과\n주의할 음식\n인스턴트음식,튀김류,술,고등어류,새우,게,가재"
            responseType = .responseDefaultChat
        }
        else if text.contains("약") && text.contains("정보") {
            responseText = "아디팜정\n코니솔론4정밀리그램\n맥스펜정\n뮤코트라정\n보송크림"
        }
        else if text.contains("아디팜 정") {
            responseText = "두드러기, 피부질환에 따른 가려움 증상 완화제"
            medicineName = "아디팜정"
            responseType = .responseMedicineInfo
        }
        else if text.contains("코니솔론") {
            responseText = "피부질환, 알레르기성 질환 효능"
            medicineName = "코니솔론"
            responseType = .responseMedicineInfo
        }
        else if text.contains("맥스펜정") {
            responseText = "염증, 통증 및 발열을 수반하는 감염증의 치료보조"
            medicineName = "맥스펜정"
            responseType = .responseMedicineInfo
        }
        else {
            responseText = "다시 한번 말씀해 주세요 !"
        }
        
        var responseChat = Chat(text: responseText, isMyCell: false, responseType: responseType)
        responseChat.medicineName = medicineName
        
        chats.append(responseChat)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.runCount += 1
            if self.runCount == 5 {
                self.chatTableview.reloadData()
                self.chatTableview.scrollToRow(at: IndexPath(row: self.chats.count - 1, section: 0), at: .bottom, animated: true)
                self.runCount = 0
                timer.invalidate()
            }
        }
    }
    
    // MARK:- @objc Method
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
            as? NSValue)?.cgRectValue {
            textInputViewBottomConstraint.constant = -keyboardSize.height + self.view.safeAreaInsets.bottom
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
    }
       
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
            as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
            as? UInt else {return}
        textInputViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve),
                       animations: {
                        self.view.layoutIfNeeded()
        })
        
        
    }
    
    @objc func touchUpExpandView() {
        isExpand = !isExpand
        
        if isExpand {
            setExpandStateTrue()
            if chats.count > 0 {
                chatTableview.scrollToRow(at: IndexPath(row: chats.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
        else {
            setExpandStateFalse()
        }
    }
    
    @IBAction func touchUpBack(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func touchUpEnter(_ sender: UIButton) {
        if let text = chatInputTextField.text,
           text.count > 0 {
            addChat(text: text)
            chatInputTextField.text = ""
        }
    }
    
    @IBAction func touchUpQucikQuestionButton(_ sender: UIButton) {
        if let text = sender.titleLabel?.text {
            let newChat = Chat(text: text, isMyCell: true, responseType: .myChat)
            
            chats.append(newChat)
            chatTableview.reloadData()
            chatTableview.scrollToRow(at: IndexPath(row: chats.count - 1, section: 0), at: .bottom, animated: true)

            
            var responseText = ""
            var responseType: CellType = .responseDefaultChat
            if text == "질병 정보" {
                responseText = "진단 받은 질병은 \(diseaseName)입니다."
            }
            else if text == "복용 약 정보" {
                responseText = "아디팜정\n코니솔론4정밀리그램\n맥스펜정\n뮤코트라정\n보송크림"
            }
            else if text == "약 복용 시간" {
                responseText = "하루에 식후 30분,\n아침, 저녁으로 복용하시면 됩니다."
            }
            else if text == "진료 예약 일정" {
                responseText = "2020년 12월 22일 오후 2시 예약입니다."
            }
            else if text == "예약 하기" {
                responseText = ""
                responseType = .responseSpeacialChat
            }
            else if text == "병원 정보" {
                responseText = ""
                responseType = .responseSpeacialChat
            }
            else if text == "의료진 정보" {
                responseText = "ㅇㅇㅇ전문의 입니다."
                responseType = .responseDefaultChat
            }
            else if text == "주의 해야 할 음식" {
                responseText = "인스턴트음식\n튀김류\n술\n고등어류\n새우\n게\n가재"
            }
            else if text == "좋은 음식" {
                responseText = "검은깨\n생강\n양배추\n결명자 차\n꿀\n무화과"
            }
            let responseChat = Chat(text: responseText, isMyCell: false, responseType: responseType)
            chats.append(responseChat)
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.runCount += 1
                if self.runCount == 5 {
                    self.chatTableview.reloadData()
                    self.chatTableview.scrollToRow(at: IndexPath(row: self.chats.count - 1, section: 0), at: .bottom, animated: true)
                    self.runCount = 0
                    timer.invalidate()
                }
            }
        }
    }
    
}

extension ChattingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let text = textField.text,
//           text.count > 0 {
//            addChat(text: text)
//        }
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        if let text = textField.text,
           text.count > 0 {
            addChat(text: text)
        }
    }
}

extension ChattingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chats[indexPath.row]
        
        switch chat.responseType {
        case .myChat:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTVCell.identifier) as? MyChatTVCell {
                cell.bindData(chat: chat)
                return cell
            }
        case .responseDefaultChat:
            if let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTVCell.identifier) as? YourChatTVCell {
                cell.bindData(chat: chat)
                return cell
            }
        case .responseSpeacialChat:
            if let cell = tableView.dequeueReusableCell(withIdentifier: YourChatSpeacialTVCell.identifier) as? YourChatSpeacialTVCell {
                
                return cell
            }
        
        case .responseMedicineInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MedicineInfoTVCell.identifier) as? MedicineInfoTVCell {
                cell.bindData(chat: chat)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

enum CellType {
    case myChat
    case responseDefaultChat
    case responseSpeacialChat
    case responseMedicineInfo
}
