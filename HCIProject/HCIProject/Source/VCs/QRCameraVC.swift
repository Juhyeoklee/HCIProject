//
//  QRCameraVC.swift
//  HCIProject
//
//  Created by 이주혁 on 2020/11/24.
//

import UIKit
import AVFoundation

class QRCameraVC: UIViewController {

    @IBOutlet var helpLabel: UILabel!
    
    @IBOutlet var qrButton: UIButton!
    @IBOutlet var preview: UIView!
    
    var image: UIImage?
    var session: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helpLabel.makeRounded(cornerRadius: 32)
        qrButton.makeRounded(cornerRadius: qrButton.frame.width / 2)
        qrButton.setBorder(borderColor: .greenblue, borderWidth: 3)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setCameraSetting()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.session.stopRunning()
        if let navi = self.presentingViewController as? UINavigationController,
           let tabbar = navi.viewControllers[0] as? CarePlusTabBarC,
           let homeVC = tabbar.viewControllers?[1] as? HomeVC {
            homeVC.isQRVisited = true
        }
        
    }

    func setCameraSetting() {
        // session 생성. 세션이 디바이스 카메라의 입출력 데이타를 묶어준다.
        session = AVCaptureSession()
        session.sessionPreset = .medium

        // 후방 카메라를 사용할 수 있도록 추가해준다. 전면 카메라, 마이크 등의 장비를 추가할 수도 있다.
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
        // AVCaptureDeviceInput은 입력 장치인 후방 카메라를 세션에 연결하는 매개체
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            // AVCapturePhotoOutput을 사용하여 출력물을 세션에 첨부 할 수 있다.
            stillImageOutput = AVCapturePhotoOutput()

            // 오류가 없다면 계속해서 입출력물을 세션에 추가한다.
            if session.canAddInput(input) && session.canAddOutput(stillImageOutput) {
                session.addInput(input)
                session.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    // UIView인 previewView의 화면에 카메라가 실제로 보이는 것을 실제로 표시하기 위한 작업.
    func setupLivePreview() {
          
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)

        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        self.preview.layer.addSublayer(videoPreviewLayer)

        // Start the Session on the background thread
        // 라이브 뷰를 시작하려면 세션에서 -startRunning을 호출해야 하는데 -startRunning은 메인 스레드에서 실행 중인 경우 UI를 차단하는 블로킹 메소드. 따라서 background thread에서 실행시킨다.
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.session.startRunning()
            
            // Size the Preview Layer to fit the Preview View
            // 라이브 뷰가 시작되면 미리보기 레이어를 맞추고 메인 스레드로 돌아와야한다.
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.preview.bounds
            }
        }
    }
    @IBAction func touchUpQRButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension QRCameraVC: AVCapturePhotoCaptureDelegate {
    
}
