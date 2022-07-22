//
//  PayOnlineDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/16.
//

import UIKit

class PayOnlineDataCell: TableCell {
    
    var cellData: PayOnlineDataCellData {get {return data as! PayOnlineDataCellData}}
    
    override func setupUI() {
        super.setupUI()
        
    }
    
    @IBAction func btnCrossTapped(_ sender: Any) {
        
        delegate?.cellWasTapped(cell: self, tag: "closeTapped")
    }
    
    @IBAction func btnPayTapped(_ sender: Any) {
        
        delegate?.cellWasTapped(cell: self, tag: "payTapped")
    }
}


class PayOnlineDataCellData: TableCellData {

    init() {
        super.init(nibId: "PayOnlineDataCell")
    }
}
