//
//  WalletHistoryDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/5/7.
//

import UIKit
import SDWebImage

class WalletHistoryDataCell: TableCell {
    
    @IBOutlet weak var lblPaymentType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCreditedBy: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var vwMain: UIView!

    var cellData: WalletHistoryDataCellData {get {return data as! WalletHistoryDataCellData}}
    
    override func setupUI() {
        super.setupUI()

        if let time = cellData.walletHistory.createdAt {
            lblDate.text = "\(Utility.getDate(from: time, toFormate: .defaultDate) ?? "")"
        }
        if cellData.walletHistory.status == "CREDITED" {
            lblPrice.textColor = UIColor.systemBlue
            lblCreditedBy.text = R.string.localizable.creditedBy()
        } else {
            lblPrice.textColor = UIColor.systemRed
            lblCreditedBy.text = R.string.localizable.debitedBy()
        }

        lblPaymentType.text = cellData.walletHistory.via
        lblPrice.text = "\(CURRENCY)\(cellData.walletHistory.amount ?? 0)"
        
    }
    
    override func setupTheme() {
        super.setupTheme()

        vwMain.layer.cornerRadius = 12
        
        
    }
    
    override func tapped() {
        super.tapped()
        
    }
    
    
}

class WalletHistoryDataCellData: TableCellData {
    
    var viewModel: WalletAndCouponVM {get {return model as! WalletAndCouponVM}}
    var walletHistory: WalletHistoryResponse
    init(walletHistory: WalletHistoryResponse) {
        self.walletHistory = walletHistory
        super.init(nibId: "WalletHistoryDataCell")
    }
}

