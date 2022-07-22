//
//  RegisterUserDetailCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/23.
//

import UIKit

class RegisterUserDetailCell: TableCell {
    
    @IBOutlet weak var vwPolicySub: UIView!
    @IBOutlet weak var vwMain: UIView!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnShowHidePass: UIButton!

    var cellData: RegisterUserDetailCellData {get {return data as! RegisterUserDetailCellData}}
    
    override func setupUI() {
        super.setupUI()
        setupPolicyView()
        self.setupPasswordUI()
        
        txtFirstName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtLastName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @IBAction func btnShowHidePassTapped(_ sender: Any) {
        
        cellData.showPassword = !cellData.showPassword
        self.setupPasswordUI()
    }
    
    func setupPasswordUI() {
        if(cellData.showPassword) {
            txtPassword.isSecureTextEntry = false
            btnShowHidePass.setImage(R.image.iconHidePassword(), for: .normal)
        } else {
            txtPassword.isSecureTextEntry = true
            btnShowHidePass.setImage(R.image.iconShowPassword(), for: .normal)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if textField == txtFirstName {
            if let text = txtFirstName.text {
                cellData.viewModel.firstName = text
            }
        } else if textField == txtLastName {
            if let text = txtLastName.text {
                cellData.viewModel.lastName = text
            }
        } else if textField == txtEmail {
            if let text = txtEmail.text {
                cellData.viewModel.email = text
            }
        } else if textField == txtPassword {
            if let text = txtPassword.text {
                cellData.viewModel.password = text
            }
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.layer.cornerRadius = 12
    }
    
    @IBAction func btnTermsTapped(_ sender: Any) {
        
        delegate?.cellWasTapped(cell: self, tag: "terms")
    }
    
    @IBAction func btnPrivacyTapped(_ sender: Any) {
        
        delegate?.cellWasTapped(cell: self, tag: "privacy")
    }
    
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        
        if !cellData.viewModel.isVerified() {
            return
        } else if !cellData.policySelected {
            Utility.showLoaf(message: R.string.localizable.kindlySelectTermsCondition(), state: .error)
            return
        }
        cellData.viewModel.registerUser { msg, success in
            
            if success {
                Utility.showLoaf(message: R.string.localizable.userCreateSuccessfully(), state: .success)
                self.gotoHome()
//                let vc = UserDocumentsVC.instantiateAuth()
//                vc.setInitialization(isFromHome: false)
//                self.parentController.navigationController?.pushViewController(vc, animated: true)
                return
            } else if msg == "gotoLogin" {
                Utility.showLoaf(message: R.string.localizable.userCreateSuccessfully(), state: .success)
                self.parentController.navigationController?.popToRootViewController(animated: true)
                return
            }
            
            if let msg = msg {
                Utility.showLoaf(message: msg, state: .error)
            }
        }
    }
    
    @IBAction func btnIAgreeTapped(_ sender: Any) {
        cellData.policySelected = !cellData.policySelected
        setupPolicyView()
    }
    
    func setupPolicyView() {
        vwPolicySub.isHidden = !cellData.policySelected
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

class RegisterUserDetailCellData: TableCellData {
    
    var viewModel: RegisterUserDetailVM {get {return model as! RegisterUserDetailVM}}
    
    var showPassword = false
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var policySelected: Bool = false
    
    init(firstName: String, lastName: String, email: String, password: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        
        super.init(nibId: "RegisterUserDetailCell")
    }
}
