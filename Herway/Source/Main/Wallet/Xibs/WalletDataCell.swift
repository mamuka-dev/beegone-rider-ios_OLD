//
//  WalletDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import UIKit

class WalletDataCell: TableCell {
    
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var vwMain3: UIView!
    @IBOutlet weak var vwMain2: UIView!
    @IBOutlet weak var lbl50: UILabel!
    @IBOutlet weak var lbl20: UILabel!
    @IBOutlet weak var lbl10: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var vwMain: UIView!
//    @IBOutlet weak var vwMain2: UIView!
    @IBOutlet weak var txtAmount: UITextField!
    
    var cellData: WalletDataCellData {get {return data as! WalletDataCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        self.lblCurrency.text = CURRENCY

        self.lblAmount.text = "\(CURRENCY) 0"
        if let wallet = UserSession.shared.user?.wallet {
            if let amount = Double(wallet) {
                self.lblAmount.text = "\(CURRENCY) \(String(format:"%.2f", amount))"
            }
        }
        txtAmount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        self.lbl10.text = "\(CURRENCY)10"
        self.lbl20.text = "\(CURRENCY)20"
        self.lbl50.text = "\(CURRENCY)50"
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if textField == txtAmount {
            if let text = txtAmount.text {
                cellData.viewModel.amountToBeCharge = Int(text) ?? 0
            }
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.layer.cornerRadius = 12
        vwMain2.layer.cornerRadius = 12
        vwMain3.layer.cornerRadius = 12
    }
    
    
    @IBAction func btn50Tapped(_ sender: Any) {
        txtAmount.text = R.string.localizable.fifty()
        cellData.viewModel.amountToBeCharge = 50
    }
    @IBAction func btn20Tapped(_ sender: Any) {
        txtAmount.text = R.string.localizable.twenty()
        cellData.viewModel.amountToBeCharge = 20
    }
    @IBAction func btn10Tapped(_ sender: Any) {
        txtAmount.text = R.string.localizable.ten()
        cellData.viewModel.amountToBeCharge = 10
    }
    
//    @IBAction func btnSupportTapped(_ sender: Any) {
//
//
//    }
    
    @IBAction func btnAddAmountTapped(_ sender: Any) {
        if cellData.viewModel.amountToBeCharge <= 0 || txtAmount.text == "" {
            Utility.showLoaf(message: R.string.localizable.kindlyEnterAnAmount(), state: .error)
            return
        }
        delegate?.cellWasTapped(cell: self, tag: "addAmount")
        txtAmount.text = ""
    }
    
}

class WalletDataCellData: TableCellData {
    
    var viewModel: WalletVM {get {return model as! WalletVM}}
    init() {
        super.init(nibId: "WalletDataCell")
    }
}
//33.65631107,+73.19584938
