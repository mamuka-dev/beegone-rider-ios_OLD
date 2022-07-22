//
//  TableCell.swift
//  FaizanTech
//
//  Created by Faizan Ali on 03/05/2020.
//  Copyright © 2020 com.Faizan.Technology. All rights reserved.
//

import Foundation
import UIKit

open class TableCell: UITableViewCell{
    
       public var parentController: UIViewController!
       public var tableView: UITableView!
       public var data: TableCellData!
       public var delegate: TableCellDelegate? = nil
    
    open func setupUI(){
        setupTheme()
    }
    
    open func setupTheme(){}
    
    open func tapped(){
        data.tapped(parent: parentController)
    }
    
}
