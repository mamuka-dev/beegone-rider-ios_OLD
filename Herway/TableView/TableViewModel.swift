//
//  TableViewModel.swift
//  FaizanTech
//
//  Created by Faizan Ali on 03/05/2020.
//  Copyright © 2020 com.Faizan.Technology. All rights reserved.
//

import Foundation

open class TableViewModel {
    
    public var tableData = Array<TableSectionData>()
    public weak var delegate: TableViewDataChangedprotocol!
    
    public init(){}
    
    open func prepareData()  {
        tableData.removeAll()
    }
    
    public func addCell(nibId: String){
        var d: TableSectionData
        if(tableData.count == 0){
            d = TableSectionData(model: self)
            tableData.append(d)
        } else {
            d = tableData[0]
        }
        
        d.addCell(nibId: nibId)
    }
    
    open func getTableCellData(at: IndexPath) -> TableCellData? {
       
        if tableData.count <= at.section { return nil }
        if tableData[at.section].cells.count <= at.row { return nil }
        
        return tableData[at.section].cells[at.row]
    
    }
}
