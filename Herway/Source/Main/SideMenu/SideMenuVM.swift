//
//  SideMenuVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/25.
//

import Foundation

class SideMenuVM: TableViewModel {
    
    var currentItem: SideMenuItem
    
     init(currentItem: SideMenuItem) {
        self.currentItem = currentItem
        super.init()
        prepareData()
    }
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        SideMenuItem.allCases.forEach { (item) in

            if item != .profile {
                section.addCell(cellData: SideMenuCellData(menuItem: item,   isSelected: item == currentItem, nibId: "SideMenuCell"))
            }
        }
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
}

