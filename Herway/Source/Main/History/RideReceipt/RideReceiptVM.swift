//
//  RideReceiptVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/3.
//

import Foundation
import UIKit

class RideReceiptVM: TableViewModel {
    
    var historyRides: RideHistoryResponse
    
    init(historyRides: RideHistoryResponse) {
        self.historyRides = historyRides
        super.init()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: RideReceiptDataCellData(historyRide: historyRides))
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
}
