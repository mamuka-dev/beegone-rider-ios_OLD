//
//  LogInCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/22.
//

import UIKit
import FlagPhoneNumber

class LogInCell: TableCell {
    
    @IBOutlet weak var btnShowHidePass: UIButton!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var txtPhone: FPNTextField!

    var cellData: LogInCellData {get {return data as! LogInCellData}}
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    
    var thePhoneNo: String? = nil
    
    
    override func setupUI() {
        super.setupUI()
        self.setupPasswordUI()
        
        txtPass.text = cellData.password
        txtPhone.delegate = self
        txtPhone.displayMode = .list
        txtPhone.set(phoneNumber: cellData.thePhoneNo)
        txtPhone.setFlag(countryCode: FPNCountryCode.PK)
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            txtPhone.setFlag(countryCode: FPNCountryCode(rawValue: countryCode) ?? .PK)
        }
        listController.setup(repository: txtPhone.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.txtPhone.setFlag(countryCode: country.code)
        }
        
        txtPass.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if textField == txtPass {
            if let text = txtPass.text {
                cellData.viewModel.password = text
            }
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.layer.cornerRadius = 12
    }
    
    @IBAction func btnShowHidePassTapped(_ sender: Any) {
        
        cellData.showPassword = !cellData.showPassword
        self.setupPasswordUI()
    }
    
    func setupPasswordUI() {
        if(cellData.showPassword) {
            txtPass.isSecureTextEntry = false
            btnShowHidePass.setImage(R.image.iconHidePassword(), for: .normal)
        } else {
            txtPass.isSecureTextEntry = true
            btnShowHidePass.setImage(R.image.iconShowPassword(), for: .normal)
        }
    }
    
    @IBAction func btnLogInTapped(_ sender: Any) {
        
        delegate?.cellWasTapped(cell: self, tag: "login")
    }
    
    @IBAction func btnChangePassTapped(_ sender: Any) {
        
        let vc = ChangePasswordVC.instantiateAuth()
        vc.theInitialize(isForgetPass: true)
        parentController.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension LogInCell: FPNTextFieldDelegate{
    
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

class LogInCellData: TableCellData {
  
    var viewModel: LogInVM {get {return model as! LogInVM}}
    var thePhoneNo: String
    var password: String
    var showPassword = false
    
    init(thePhoneNo: String, password: String) {
        self.thePhoneNo = thePhoneNo
        self.password = password
        super.init(nibId: "LogInCell")
    }
}
