//
//  ChangePasswordVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/23.
//

import Foundation
import UIKit

class ChangePasswordVM: TableViewModel {
    
    var oldPass: String = ""
    var newPass: String = ""
    var newConfPass: String = ""
    var phone: String = ""
    var userEmail: String? = nil
    var userId: String? = nil
    var isForgetPass: Bool
    
    var showVerifyView: Bool = true
    init(isForgetPass: Bool) {
        self.isForgetPass = isForgetPass
        super.init()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        if !isForgetPass {
            section.addCell(cellData: ChangePasswordCellData())
        } else if showVerifyView {
            section.addCell(cellData: ChangePasswordVerifyCellData(thePhoneNo: self.phone))
        } else {
            section.addCell(cellData: ChangePasswordCellData())
        }

        
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func isVerified() -> Bool {
        
        if showVerifyView {
            if phone.isEmpty {
                Utility.showLoaf(message: R.string.localizable.kindlyEnterValidPhoneNumber() , state: .error)
                return false
            } else {
                return true
            }
        } else {
            
            if self.isForgetPass {
                if newPass.isEmpty || newConfPass.isEmpty {
                    Utility.showLoaf(message: R.string.localizable.kindlyFillAllFields(), state: .error)
                    return false
                } else if newPass != newConfPass {
                    Utility.showLoaf(message: R.string.localizable.newPasswordConfirmPasswordAreNotMatching(), state: .error)
                    return false
                }
                return true
            } else {
                
                if oldPass.isEmpty || newPass.isEmpty || newConfPass.isEmpty {
                    Utility.showLoaf(message: R.string.localizable.kindlyFillAllFields(), state: .error)
                    return false
                } else if newPass != newConfPass {
                    Utility.showLoaf(message: R.string.localizable.newPasswordConfirmPasswordAreNotMatching(), state: .error)
                    return false
                }
                return true
            }
        }
    }
    
    func changePass(block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.changePassword(password: self.newPass, password_confirmation: self.newPass, old_password: self.oldPass).send(verificationResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
            
                block(response.message, true)
            }
        }
    }
    
    
    func checkForPhoneNumber(block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.checkLoginNumExist(phone: self.phone).send(CheckForEmailResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if let email = response.user?.email {
                    self.userEmail = email
                    block(nil, true)
                    return
                }
                if let msg = response.message {
                    block(msg, false)
                    return
                }
                block(nil, false)
            }
        }
    }
    
    func getIdWithForgetPass(block: @escaping (String?, Bool)-> Void){
        
        guard let email = self.userEmail else {
            return
        }
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.forgetPassword(email: email).send(ForgetPassResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if let id = response.provider?.id {
                    self.userId = String(id)
                    block(nil, true)
                    return
                }
                if let msg = response.message {
                    block(msg, false)
                    return
                }
                block(nil, false)
            }
        }
    }
    
    
    func resetPass(block: @escaping (String?, Bool)-> Void){
        
        guard let id = self.userId else { return }
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.resetPassword(password: self.newPass, password_confirmation: self.newPass, id: id).send(verificationResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
            
                block(response.message, true)
            }
        }
    }
}

