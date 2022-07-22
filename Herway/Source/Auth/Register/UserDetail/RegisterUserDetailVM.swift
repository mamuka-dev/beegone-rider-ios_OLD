//
//  RegisterUserDetailVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/23.
//

import Foundation
import UIKit

class RegisterUserDetailVM: TableViewModel {
    
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var phone: String
    
    init(phone: String) {
        self.phone = phone
        super.init()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: RegisterUserDetailCellData(firstName: firstName, lastName: lastName, email: email, password: password))
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func isVerified() -> Bool {
        
        if firstName.isEmpty {
            Utility.showLoaf(message: R.string.localizable.firstNameRequired(), state: .error)
            return false
        } else if lastName.isEmpty {
            Utility.showLoaf(message: R.string.localizable.lastNameRequired(), state: .error)
            return false
        } else if email.isEmpty {
            Utility.showLoaf(message: R.string.localizable.emailRequired(), state: .error)
            return false
        } else if !email.isValidEmail {
            Utility.showLoaf(message: R.string.localizable.validEmailRequired(), state: .error)
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
    
    func registerUser(block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.register(firstName: firstName, secondName: lastName, email: email, password: password, mobile: phone).send(RegisterResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
            
                if response.email != nil {
                    
                    self.loginUser { msg, success in
                        
                        if success {
                            block(nil, true)
                        } else {
                            block("gotoLogin", false)
                        }
                    }
                    return
                }
                
                block(SOMETHING_WENT_WRONG, false)
            }
        }
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
    
    
}


