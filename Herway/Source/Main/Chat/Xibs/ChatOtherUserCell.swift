//
//  ChatOtherUserCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/10.
//

import UIKit

class ChatOtherUserCell: TableCell {

    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var vwBubble: UIView!
    
    var cellData: ChatOtherUserCellData {get {return data as! ChatOtherUserCellData}}
    
    override func setupUI() {
        super.setupUI()
        lblText.text = cellData.text
    }
    
    override func setupTheme() {
        super.setupTheme()

        vwBubble.layer.cornerRadius = 20
        vwBubble.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    override func tapped() {
        super.tapped()
        
    }
}

class ChatOtherUserCellData: TableCellData {
    
    var text: String
    init(text: String) {
        self.text = text
        super.init(nibId: "ChatOtherUserCell")
    }
}
