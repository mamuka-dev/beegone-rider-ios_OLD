//
//  ManageCardDataCell.swift
//  HerwayDriver
//
//  Created by Faizan Ali  on 2022/4/6.
//

import UIKit
import Stripe

class ManageCardDataCell: TableCell {

    @IBOutlet weak var txtCardHolder: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var txtCardName: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var btnAddCard: UIButton!
    
    var cellData: ManageCardDataCellData {get {return data as! ManageCardDataCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        txtCardHolder.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtCardName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtCVV.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if textField == txtCardHolder {
            if let text = txtCardHolder.text {
                cellData.viewModel.cardHolderName = text
            }
        } else if textField == txtCardName {
            if let text = txtCardName.text {
                cellData.viewModel.cardNo = text
            }
        } else if textField == txtCVV {
            if let text = txtCVV.text {
                cellData.viewModel.cvv = text
            }
        }
    }
    
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    @IBAction func btnExpirationTapped(_ sender: Any) {
        datePicker = UIDatePicker.init()
            datePicker.backgroundColor = UIColor.white
                    
            datePicker.autoresizingMask = .flexibleWidth
            datePicker.datePickerMode = .date
                    
            datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
            datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.parentController.view.addSubview(datePicker)
                    
            toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: R.string.localizable.done(), style: .done, target: self, action: #selector(self.onDoneButtonClick))]
            toolBar.sizeToFit()
        self.parentController.view.addSubview(toolBar)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
            
        if let date = sender?.date {
            cellData.viewModel.cardExpiry = date
            txtYear.text = date.toString(format: DateFormat.MonthYear.rawValue)
            print("Picked the date \(dateFormatter.string(from: date))")
        }
    }

    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnAddCardTapped(_ sender: Any) {
        
        let stripeCardParams = STPCardParams()
        stripeCardParams.number = "4242424242424242"// txtCardName.text
//        let expiryParameters = txtYear.text?.components(separatedBy: "/")
        stripeCardParams.expMonth = 12// UInt(expiryParameters?.first ?? "0") ?? 0
        stripeCardParams.expYear = 23// UInt(expiryParameters?.last ?? "0") ?? 0
        stripeCardParams.cvc = "123"// txtCVV.text
        
//        let billingDetails = STPPaymentMethodBillingDetails()
//        billingDetails.name = "Luke"
        
        stripeCardParams.name = "Luke"
        
//        let paymentMethodParams =  STPPaymentMethodParams(card: cardParams, billingDetails: billingDetails, metadata: nil)
        
        
//        let config = STPPaymentConfiguration.shared
        let stpApiClient = STPAPIClient.init()
        stpApiClient.createToken(withCard: stripeCardParams) { (token, error) in

        if error == nil {

        //Success
//        DispatchQueue.main.async {
//        self.createPayment(token: token!.tokenId, amount: 2000)
//        }

            print(token)
        } else {

        //failed
            print("Failed\(error?.localizedDescription)")
        }
        }
    }
    
    
}


class ManageCardDataCellData: TableCellData {

    var viewModel: ManageCardsVM {get {return model as! ManageCardsVM}}
    init() {
        super.init(nibId: "ManageCardDataCell")
    }
}
