//
//  PayOnlineVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/16.
//

import Foundation
import UIKit

class PayOnlineVM: TableViewModel {
    
    
    override init() {
        super.init()
        prepareData()
    }
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: PayOnlineDataCellData())
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    

    
}
