//
//  ValidatePhoneVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/11.
//

import Foundation
import UIKit
import FirebaseAuth
import FlagPhoneNumber

class ValidatePhoneVM: TableViewModel {
    
    var type: verificationType
    var phone: String
    var verificationId: String? = nil
    
    
    init(phone: String, type: verificationType) {
        self.phone = phone
        self.type = type
        super.init()
        self.sendOtpCode()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: ValidatePhoneDataCellData())
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }

    
    func verifySignUpCode(code: String, block: @escaping (String?, Bool)-> Void){
        
    }
    
    func verifyResetCode(code: String, block: @escaping (String?, Bool)-> Void){
        
        block("", true)
    }
    
    
    func resendVerificationCode(block: @escaping (String?, Bool)-> Void){
        
    }
    
    func resendVerificationResetPassCode(block: @escaping (String?, Bool)-> Void){
        
    }
    
    func sendOtpCode() {
        
        ActivityIndicator.shared.showLoadingIndicator()
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
            ActivityIndicator.shared.hideLoadingIndicator()
              
              self.verificationId = verificationID
          }
    }
    
    func reSendOtpCode() {
        
        ActivityIndicator.shared.showLoadingIndicator()
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
            ActivityIndicator.shared.hideLoadingIndicator()
              
              self.verificationId = verificationID
            Utility.showLoaf(message: R.string.localizable.codeHasBeenSent(), state: .success)
          }
    }
    
    func validateCode(code: String, block: @escaping (Bool)-> Void) {
        
//        block(true)
//
//        return
        guard let verID = self.verificationId else {
            self.sendOtpCode()
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verID,
        verificationCode: code)
        
        ActivityIndicator.shared.showLoadingIndicator()
        Auth.auth().signIn(with: credential) { (authResult, error) in
        
            ActivityIndicator.shared.hideLoadingIndicator()
            if error != nil {
                Utility.showLoaf(message: R.string.localizable.invalidCode() , state: .error)
                return
            }
            
            if authResult?.user.uid != nil{
                Utility.showLoaf(message: R.string.localizable.phoneNumberHasBeenVerified(), state: .success)
                try? Auth.auth().signOut()
                block(true)
            } else {
                Utility.showLoaf(message: R.string.localizable.somethingWentWrong(), state: .error)
            }
        }
    }

    
    

}


enum verificationType {
    case signUp, forgotPass
}

