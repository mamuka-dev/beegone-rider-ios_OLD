//
//  HomeBottomViewStage4PromoCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import UIKit

class HomeBottomViewStage4PromoCell: TableCell {
    
    @IBOutlet weak var btnOtp: UIButton!
    
    var cellData: HomeBottomViewStage4PromoCellData {get {return data as! HomeBottomViewStage4PromoCellData}}
    
    override func setupUI() {
        super.setupUI()
        btnOtp.setTitle("\(cellData.currentRequest.otp ?? 0)", for: .normal)
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "")
    }
}

class HomeBottomViewStage4PromoCellData: TableCellData {
    
    var currentRequest: RideDetailResponseData
    init(currentRequest: RideDetailResponseData) {
        self.currentRequest = currentRequest
        super.init(nibId: "HomeBottomViewStage4PromoCell")
    }
}
