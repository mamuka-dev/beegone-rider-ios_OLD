//
//  TableSectionData.swift
//  FaizanTech
//
//  Created by Faizan Ali on 03/05/2020.
//  Copyright © 2020 com.Faizan.Technology. All rights reserved.
//

import Foundation

open class TableSectionData{
    
    public var sectionKey: String? = nil
    open var headerView: TableHeaderView? {get {return nil}}
    open var footerView: TableFooterView? {get {return nil}}
    
    public var headerViewHeight : Int = 0
    public var footerViewHeight: Int = 0
    
    public var model: TableViewModel
    public var cells: [TableCellData] = [TableCellData]()
    
    public init(model: TableViewModel){
        self.model = model
    }
    
    public func addCell(nibId: String){
        let c = TableCellData(nibId: nibId, model: model)
        cells.append(c)
    }
    
    public func addCell(cellData: TableCellData){
        cellData.model = model
        cells.append(cellData)
    }
}
