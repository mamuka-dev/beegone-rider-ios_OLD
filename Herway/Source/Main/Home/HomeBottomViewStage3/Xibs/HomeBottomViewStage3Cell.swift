//
//  HomeBottomViewStage3Cell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import UIKit

class HomeBottomViewStage3Cell: TableCell {
    
    @IBOutlet weak var txtView: UITextField!
    
    
    var cellData: HomeBottomViewStage3CellData {get {return data as! HomeBottomViewStage3CellData}}
    
    override func setupUI() {
        super.setupUI()
        
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnApplyTapped(_ sender: Any) {
        if self.txtView.text == nil || self.txtView.text == "" {
            Utility.showLoaf(message: "Kindly add promo code first", state: .error)
        } else {
            self.cellData.promoCode = self.txtView.text
            delegate?.cellWasTapped(cell: self, tag: "applyPromo")
        }
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "closePromo")
    }
}

class HomeBottomViewStage3CellData: TableCellData {
    
    var promoCode: String? = nil
    init() {
        super.init(nibId: "HomeBottomViewStage3Cell")
    }
}
