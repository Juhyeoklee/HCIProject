//
//  AlarmSettingVC.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit

class AlarmSettingVC: UIViewController {

    @IBOutlet var settingViews: [UIView]!
    @IBOutlet var timeSettingView: UIView!
    @IBOutlet var mornintTimeTextField: UITextField! {
        didSet {
            mornintTimeTextField.inputView = timePicker
        }
    }
    @IBOutlet var affternoonTimeTextField: UITextField! {
        didSet {
            affternoonTimeTextField.inputView = timePicker
        }
    }
    
    @IBOutlet var eveningTimeTextField: UITextField! {
        didSet {
            eveningTimeTextField.inputView = timePicker
        }
    }
    
    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        // Do any additional setup after loading the view.
    }
    
    func initLayout() {
        settingViews.forEach {
            $0.dropShadow(color: .black,
                          offSet: CGSize(width: 0, height: 0),
                          opacity: 0.1,
                          radius: 4)
        }
        timeSettingView.makeRounded(cornerRadius: 10)
        timeSettingView.dropShadow(color: .black,
                                   offSet: CGSize(width: 0, height: 0),
                                   opacity: 0.1,
                                   radius: 4)
        [mornintTimeTextField,
         affternoonTimeTextField,
         eveningTimeTextField].forEach {
            $0?.makeRounded(cornerRadius: 6)
        }
        
        createToolBar()
    }
    
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([flexibleSpace,doneBtn], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        
        mornintTimeTextField.tintColor = UIColor.clear
        mornintTimeTextField.inputAccessoryView = toolBar
        
        affternoonTimeTextField.tintColor = UIColor.clear
        affternoonTimeTextField.inputAccessoryView = toolBar
        
        eveningTimeTextField.tintColor = UIColor.clear
        eveningTimeTextField.inputAccessoryView = toolBar
    }
    
    @objc func pickerValueChanged() {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
        let date = dateformatter.string(from: timePicker.date)
        
        if mornintTimeTextField.isEditing {

            mornintTimeTextField.text = date

        }
        else if affternoonTimeTextField.isEditing {
            affternoonTimeTextField.text = date
        }
        else {
            eveningTimeTextField.text = date
        }
    }
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func takingMedicineTimeAlarmSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            timeSettingView.isHidden = false
        }
        else {
            timeSettingView.isHidden = true
        }
    }
    
    @IBAction func touchUpBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
