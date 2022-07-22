//
//  LogInVM.swift
//  Cherwell
//
//  Created by Faizan Ali  on 2021/5/11.
//

import Foundation
import UIKit

class LogInVM: TableViewModel {
    
    var phone: String = "+921122334455"
    var email: String = ""
    var password: String = "1122334455"
    
    
    override init() {
        super.init()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: LogInCellData(thePhoneNo: self.phone, password: password))
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    
    func isVerified() -> Bool {
        
        if phone.isEmpty {
            Utility.showLoaf(message: R.string.localizable.phoneNumberRequired(), state: .error)
            return false
        } else if password.isEmpty {
            Utility.showLoaf(message: R.string.localizable.passwordRequired(), state: .error)
            return false
        } else if password.count < 6 {
            Utility.showLoaf(message: R.string.localizable.passwordShouldBe6Characters(), state: .error)
            return false
        }
        return true
    }
    
    func loginUser(block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.login(email: self.email, password: self.password).send(LoginModelResponseData.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                UserSession.shared.user = response
                
                block(nil, true)
            }
        }
    }
    
    func checkForEmail(block: @escaping (String?, Bool)-> Void){

        ActivityIndicator.shared.showLoadingIndicator()
        Routes.checkLoginNumExist(phone: self.phone).send(CheckForEmailResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if (response.error != nil && response.error == true) {
                    if let msg = response.message {
                        block(msg, false)
                        return
                    }
                    block(nil, false)
                    return
                }
                
                guard let user = response.user else {
                    block(nil, false)
                    return
                }
                
                if let email = user.email {
                    self.email = email
                    self.loginUser { msg, success in
                        
                        if !success {
                            if let msg = msg {
                                Utility.showLoaf(message: msg, state: .error)
                            }
                        } else {
                            self.gotoHome()
                        }
                        
                    }
                    block(nil, true)
                    return
                }
                
                block(nil, false)
            }
        }
    }
    
    func gotoHome() {
        
        let redirect = RedirectHelper(window: nil)
        redirect.determineRoutes()
        UIView.transition(with: UIApplication.window(),
                                 duration: 0.5,
                                 options: .transitionFlipFromLeft,
                                 animations: nil,
                                 completion: nil)
    }
    
    
    
}
