//
//  RegisterVerifyPhoneCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/23.
//

import UIKit
import FlagPhoneNumber

class RegisterVerifyPhoneCell: TableCell {
    
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var txtPhone: FPNTextField!

    var cellData: RegisterVerifyPhoneCellData {get {return data as! RegisterVerifyPhoneCellData}}
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
                
                if UserDefaults.standard.showOtpScreen() {
                    let vc = ValidatePhoneVC.instantiateAuth()
                    vc.initialize(phone: self.cellData.thePhoneNo, type: .forgotPass) { success in
                        
                        if success {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            let vc = RegisterUserDetailVC.instantiateAuth()
                            vc.theInitialise(phone: self.cellData.thePhoneNo)
                            self.parentController.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                    self.parentController.navigationController?.pushViewController(vc, animated: true)
                    
                } else {
                    let vc = RegisterUserDetailVC.instantiateAuth()
                    vc.theInitialise(phone: self.cellData.thePhoneNo)
                    self.parentController.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    

    
}


extension RegisterVerifyPhoneCell: FPNTextFieldDelegate{
    
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

class RegisterVerifyPhoneCellData: TableCellData {
    
    var viewModel: RegisterVerifyPhoneVM {get {return model as! RegisterVerifyPhoneVM}}
    var thePhoneNo: String
    
    init(thePhoneNo: String) {
        self.thePhoneNo = thePhoneNo
        super.init(nibId: "RegisterVerifyPhoneCell")
    }
}
