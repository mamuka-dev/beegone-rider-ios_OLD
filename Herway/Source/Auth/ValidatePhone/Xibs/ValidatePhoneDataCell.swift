//
//  ValidatePhoneDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/11.
//

import UIKit
import SVPinView

class ValidatePhoneDataCell: TableCell {

    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var vwPin: SVPinView!
    @IBOutlet weak var vwMain: UIView!
    
    var otpTimer: Timer?
    var theTime: Int = 25
    
    var cellData: ValidatePhoneDataCellData {get {return data as! ValidatePhoneDataCellData}}
    
    func startTimer() {
        theTime = 25
        btnResend.isUserInteractionEnabled = false
        otpTimer?.invalidate()
        otpTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerDidFire(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func timerDidFire(_ timer: Timer) {

        if theTime <= 0 {
            lblTime.text = "0"
            otpTimer?.invalidate()
            btnResend.isUserInteractionEnabled = true
            return
        }
        theTime -= 1
        lblTime.text = "\(theTime)"
        print(timer.timeInterval)
    }
    
    override func setupUI() {
        super.setupUI()
        startTimer()
        vwPin.style = .box
        vwPin.placeholder = "------"
        
        vwPin.didFinishCallback = { [weak self] pin in
            
            self?.cellData.viewModel.validateCode(code: pin, block: { success in
                
                if success {
                    if let parent = self?.parentController as? ValidatePhoneVC {
                        parent.theBlock?(true)
                        parent.navigationController?.popViewController(animated: true)
                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            parent.theBlock?(true)
//                        }
                    }
                }
            })
        }
    }
            
//            if self?.cellData.viewModel.type == .forgotPass {
//
//                self?.cellData.viewModel.verifyResetCode(code: pin) { (msg, success) in
//
//                    if success {
//
//                        if let parent = self?.parentController as? ValidatePhoneVC {
//                            parent.navigationController?.popViewController(animated: true)
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                parent.theBlock?(true)
//                            }
//                        }
//
//                        if let msg = msg {
//                            Utility.showLoaf(message: msg, state: .success)
//                        }
//                    } else if let msg = msg {
//                        Utility.showLoaf(message: msg, state: .error)
//                    }
//                }
//                return
//            }
//
//            self?.cellData.viewModel.verifySignUpCode(code: pin) { (msg, success) in
//
//                if success {
//
//                    if let parent = self?.parentController as? ValidatePhoneVC {
//                        parent.navigationController?.popViewController(animated: true)
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            parent.theBlock?(true)
//                        }
//                    }
//
//                    if let msg = msg {
//                        Utility.showLoaf(message: msg, state: .success)
//                    }
//                } else if let msg = msg {
//                    Utility.showLoaf(message: msg, state: .error)
//                }
//            }
//
//            print("The pin entered is \(pin)")
//        }
//    }
    
    
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.cornerRadius = 12
    }
    
    @IBAction func btnResendTapped(_ sender: Any) {
        
        if self.theTime > 0 {
            Utility.showLoaf(message: R.string.localizable.kindlyWaitForSomeTimeBeforeSendingTheOtpAgain(), state: .error)
            return
        }
        startTimer()
        cellData.viewModel.reSendOtpCode()
    }
//        if cellData.viewModel.type == .forgotPass {
//            self.cellData.viewModel.resendVerificationResetPassCode { (msg, success) in
//
//                if success {
//                    if let msg = msg {
//                        Utility.showLoaf(message: msg, state: .success)
//                    }
//                } else if let msg = msg {
//                    Utility.showLoaf(message: msg, state: .error)
//                }
//            }
//            return
//        }
//
//        self.cellData.viewModel.resendVerificationCode { (msg, success) in
//
//            if success {
//                if let msg = msg {
//                    Utility.showLoaf(message: msg, state: .success)
//                }
//            } else if let msg = msg {
//                Utility.showLoaf(message: msg, state: .error)
//            }
//        }
//    }
    
}

class ValidatePhoneDataCellData: TableCellData {
    
    var viewModel: ValidatePhoneVM {get {model as! ValidatePhoneVM}}
    init() {
        super.init(nibId: "ValidatePhoneDataCell")
    }
}
