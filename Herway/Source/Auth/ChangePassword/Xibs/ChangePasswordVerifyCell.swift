//
//  ChangePasswordVerifyCell.swift
//  HerwayDriver
//
//  Created by Faizan Ali  on 2022/1/22.
//

import UIKit
import FlagPhoneNumber

class ChangePasswordVerifyCell: TableCell {
    
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var txtPhone: FPNTextField!

    var cellData: ChangePasswordVerifyCellData {get {return data as! ChangePasswordVerifyCellData}}
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    
    var thePhoneNo: String? = nil
    
    override func setupUI() {
        super.setupUI()
        
        txtPhone.delegate = self
        txtPhone.displayMode = .list
        txtPhone.setFlag(countryCode: FPNCountryCode.PK)
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            txtPhone.setFlag(countryCode: FPNCountryCode(rawValue: countryCode) ?? .PK)
        }
        listController.setup(repository: txtPhone.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.txtPhone.setFlag(countryCode: country.code)
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.layer.cornerRadius = 12
    }
    
    
    @IBAction func btnVerifyTapped(_ sender: Any) {
        
        if !cellData.viewModel.isVerified() {
            return
        }
        cellData.viewModel.checkForPhoneNumber { msg, success in
            
            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            } else {
                
                self.cellData.viewModel.getIdWithForgetPass { msg, success in
                    
                    if self.cellData.viewModel.isForgetPass {
                        
                       if UserDefaults.standard.showOtpScreen() {
                           let vc = ValidatePhoneVC.instantiateAuth()
                           vc.initialize(phone: self.cellData.thePhoneNo, type: .forgotPass) { success in
                               
                               if success {
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                       if self.cellData.viewModel.userId != nil {
                                           self.cellData.viewModel.showVerifyView = false
                                           self.cellData.viewModel.prepareData()
                                       } else {
                                           Utility.showLoaf(message: R.string.localizable.somethingWentWrong(), state: .error)
                                       }
                                   }
                               }
                           }
                           self.parentController.navigationController?.pushViewController(vc, animated: true)
                       } else {
                           
                           if self.cellData.viewModel.userId != nil {
                               self.cellData.viewModel.showVerifyView = false
                               self.cellData.viewModel.prepareData()
                           } else {
                               Utility.showLoaf(message: R.string.localizable.somethingWentWrong(), state: .error)
                           }
                       }
                    } else {
                        if self.cellData.viewModel.userId != nil {
                            self.cellData.viewModel.showVerifyView = false
                            self.cellData.viewModel.prepareData()
                        } else {
                            Utility.showLoaf(message: R.string.localizable.somethingWentWrong(), state: .error)
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    
}


extension ChangePasswordVerifyCell: FPNTextFieldDelegate{
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
        cellData.thePhoneNo = "\(textField.selectedCountry?.phoneCode ?? "")\(textField.text ?? "")"
        delegate?.cellWasTapped(cell: self, tag: "Phone")
        
        if isValid {
            cellData.thePhoneNo = textField.getFormattedPhoneNumber(format: .E164) ?? ""
            delegate?.cellWasTapped(cell: self, tag: "Phone")
        }
    }
    
    func fpnDisplayCountryList() {
        
        let navigationViewController = UINavigationController(rootViewController: listController)
           listController.title = R.string.localizable.countries()
           parentController.present(navigationViewController, animated: true, completion: nil)
            
    }
}

class ChangePasswordVerifyCellData: TableCellData {
    
    var viewModel: ChangePasswordVM {get {return model as! ChangePasswordVM}}
    var thePhoneNo: String
    
    init(thePhoneNo: String) {
        self.thePhoneNo = thePhoneNo
        super.init(nibId: "ChangePasswordVerifyCell")
    }
}
