//
//  WalletHistoryCouponCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/5/9.
//

import UIKit

class WalletHistoryCouponCell: TableCell {
  
    @IBOutlet weak var lblCouponStatus: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCouponType: UILabel!
    @IBOutlet weak var vwMain: UIView!
    
    var cellData: WalletHistoryCouponCellData {get {return data as! WalletHistoryCouponCellData}}
    
    override func setupUI() {
        super.setupUI()

        if let time = cellData.coupon.createdAt {
            lblDate.text = "\(Utility.getDate(from: time, toFormate: .defaultDate) ?? "")"
        }
        lblCouponStatus.textColor = UIColor.systemBlue
        lblCouponType.text = cellData.coupon.promocode?.promoCode
        lblOffer.text = cellData.coupon.promocode?.discountType
        lblCouponStatus.text = cellData.coupon.status
        
    }
    
    override func setupTheme() {
        super.setupTheme()

        vwMain.layer.cornerRadius = 12
        
        
    }
    
    override func tapped() {
        super.tapped()
        
    }
    
    
}

class WalletHistoryCouponCellData: TableCellData {
    
    var viewModel: WalletAndCouponVM {get {return model as! WalletAndCouponVM}}
    var coupon: CouponHistoryResponse
    init(coupon: CouponHistoryResponse) {
        self.coupon = coupon
        super.init(nibId: "WalletHistoryCouponCell")
    }
}

