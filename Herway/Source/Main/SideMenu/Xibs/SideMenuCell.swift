//
//  SideMenuCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/25.
//

import UIKit

class SideMenuCell: TableCell {
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var cellData: SideMenuCellData {get {return data as! SideMenuCellData}}
    
    override func setupUI() {
        super.setupUI()
        self.lblTitle.text = cellData.menuItem.title
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        
        if cellData.isSelected {
            self.lblTitle.textColor =  .primaryColor
            self.imgView.image = cellData.menuItem.selectedImg
        } else {
            self.lblTitle.textColor =  .primaryColor
            self.imgView.image = cellData.menuItem.img
        }
    }
    
    override func tapped() {
        super.tapped()
        
         delegate?.cellWasTapped(cell: self, tag: "")
        
    }

}

class SideMenuCellData: TableCellData {

    var menuItem: SideMenuItem
    var isSelected: Bool
    
     init(menuItem: SideMenuItem, isSelected: Bool, nibId: String) {
        self.menuItem = menuItem
        self.isSelected = isSelected
        super.init(nibId: nibId)
    }
}
