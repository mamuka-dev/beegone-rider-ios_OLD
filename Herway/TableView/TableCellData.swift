//
//  TableCellData.swift
//  FaizanTech
//
//  Created by Faizan Ali on 03/05/2020.
//  Copyright © 2020 com.Faizan.Technology. All rights reserved.
//

import Foundation
import UIKit

open class TableCellData{
    
    public var nibId: String
    public var nibHight: Double? = nil
    public var model: TableViewModel!
    
    public init(nibId: String, model: TableViewModel){
        self.nibId = nibId
        self.model = model
    }
    
    public init(nibId: String){
        self.nibId = nibId
    }
    
    open func tapped(parent: UIViewController){}
    
}
