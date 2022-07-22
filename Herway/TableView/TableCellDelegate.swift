//
//  TableCellDelegate.swift
//  FaizanTech
//
//  Created by Faizan Ali on 03/05/2020.
//  Copyright © 2020 com.Faizan.Technology. All rights reserved.
//

import Foundation
import UIKit

public protocol TableCellDelegate{
    func cellWasTapped(cell: TableCell, tag: String)
}
