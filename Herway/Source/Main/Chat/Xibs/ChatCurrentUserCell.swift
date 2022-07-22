//
//  ChatCurrentUserCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/10.
//

import UIKit

class ChatCurrentUserCell: TableCell {

    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var vwBubble: UIView!
    
    var cellData: ChatCurrentUserCellData {get {return data as! ChatCurrentUserCellData}}
    
    override func setupUI() {
        super.setupUI()
        lblText.text = cellData.text
    }
    
    override func setupTheme() {
        super.setupTheme()

        vwBubble.layer.cornerRadius = 20
        vwBubble.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    override func tapped() {
        super.tapped()
        
    }
}

class ChatCurrentUserCellData: TableCellData {
    
    var text: String
    init(text: String) {
        self.text = text
        super.init(nibId: "ChatCurrentUserCell")
    }
}

