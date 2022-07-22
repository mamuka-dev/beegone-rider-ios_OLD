//
//  ChangePasswordCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/23.
//

import UIKit

class ChangePasswordCell: TableCell {

    @IBOutlet weak var btnChangePass: UIButton!
    @IBOutlet weak var txtConfNewPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtOldPass: UITextField!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var vwOldPass: UIView!
    
    var cellData: ChangePasswordCellData {get {return data as! ChangePasswordCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        vwOldPass.isHidden = false
        if cellData.viewModel.isForgetPass {
            vwOldPass.isHidden = true
        }
        
        txtOldPass.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtNewPass.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtConfNewPass.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if textField == txtOldPass {
            if let text = txtOldPass.text {
                cellData.viewModel.oldPass = text
            }
        } else if textField == txtNewPass {
            if let text = txtNewPass.text {
                cellData.viewModel.newPass = text
            }
        } else if textField == txtConfNewPass {
            if let text = txtConfNewPass.text {
                cellData.viewModel.newConfPass = text
            }
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        vwMain.layer.cornerRadius = 12
    }
    
    @IBAction func btnChangePassTapped(_ sender: Any) {
        
        if cellData.viewModel.isVerified() {
            if cellData.viewModel.isForgetPass {
    
                cellData.viewModel.resetPass { msg, success in
                    if !success {
                        if let msg = msg {
                            Utility.showLoaf(message: msg, state: .error)
                        }
                    } else {
                        if let msg = msg {
                            Utility.showLoaf(message: msg, state: .success)
                        }
                        self.parentController.navigationController?.popViewController(animated: true)
                    }
                }
                
            } else {
                cellData.viewModel.changePass { msg, success in
                    if !success {
                        if let msg = msg {
                            Utility.showLoaf(message: msg, state: .error)
                        }
                    } else {
                        if let msg = msg {
                            Utility.showLoaf(message: msg, state: .success)
                        }
                        self.parentController.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
}


class ChangePasswordCellData: TableCellData {
    
    var viewModel: ChangePasswordVM {get {return model as! ChangePasswordVM}}
    init() {
        super.init(nibId: "ChangePasswordCell")
    }
}
