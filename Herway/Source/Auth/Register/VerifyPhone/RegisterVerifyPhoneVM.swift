//
//  RegisterVerifyPhoneVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/23.
//

import Foundation
import UIKit

class RegisterVerifyPhoneVM: TableViewModel {
    
    var phone: String = ""
    
    override init() {
        super.init()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: RegisterVerifyPhoneCellData(thePhoneNo: self.phone))
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func isVerified() -> Bool {
        
        if phone.isEmpty {
            Utility.showLoaf(message: R.string.localizable.phoneNumberRequired(), state: .error)
            return false
        }
        return true
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
                
                if (response.error != nil && response.error == false) {
                    block(R.string.localizable.pleaseLoginUserAlreadyRegistered(), false)
                    return
                }
                
                block(nil, true)
            }
        }
    }
    
}

