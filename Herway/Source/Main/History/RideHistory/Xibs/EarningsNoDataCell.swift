//
//  EarningsNoDataCell.swift
//  HerwayDriver
//
//  Created by Faizan Ali  on 2022/3/16.
//

import UIKit

class EarningsNoDataCell: TableCell {

    @IBOutlet weak var imgTopLayout: NSLayoutConstraint!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var cellData: EarningsNoDataCellData {get {return data as! EarningsNoDataCellData}}
    
    override func setupUI() {
        super.setupUI()
        self.imgView.image = cellData.img
        self.lblNoData.text = cellData.noDataTxt
        
        self.imgTopLayout.constant = cellData.topLayout
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    
    
}

class EarningsNoDataCellData: TableCellData {
    
    var topLayout: CGFloat
    var img: UIImage
    var noDataTxt: String
    init(img: UIImage, noDataTxt: String, topLayout: CGFloat = 32) {
        self.img = img
        self.noDataTxt = noDataTxt
        self.topLayout = topLayout
        super.init(nibId: "EarningsNoDataCell")
    }
}
