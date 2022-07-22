//
//  HomeBottomViewStage1VM.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/4.
//

import Foundation
import UIKit

class HomeBottomViewStage1VM: TableViewModel {
    
    override init() {
        super.init()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: HomeBottomViewStage1CellData())
        
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
}
