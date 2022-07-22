//
//  HomeBottomViewStage3VM.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import Foundation
import UIKit

class HomeBottomViewStage3VM: TableViewModel {
    
    override init() {
        super.init()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: HomeBottomViewStage3CellData())
        
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
}


