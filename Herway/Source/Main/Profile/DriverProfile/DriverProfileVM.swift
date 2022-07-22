//
//  DriverProfileVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import Foundation
import UIKit

class DriverProfileVM: TableViewModel {
    
    var name: String
    var imgStr: String
    var rating: Double
    var email: String
    var phone: String
    
    init(name: String, imgStr: String, rating: Double, email: String, phone: String) {
        self.name = name
        self.imgStr = imgStr
        self.rating = rating
        self.email = email
        self.phone = phone
        
        super.init()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: DriverProfileDataCellData())
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
}



