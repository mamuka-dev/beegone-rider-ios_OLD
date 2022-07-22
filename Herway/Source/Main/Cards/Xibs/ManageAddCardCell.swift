//
//  ManageAddCardCell.swift
//  HerwayDriver
//
//  Created by Faizan Ali  on 2022/4/6.
//

import UIKit

class ManageAddCardCell: TableCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgCheckMark: UIImageView!
    
    var cellData: ManageAddCardCellData {get {return data as! ManageAddCardCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        imgCheckMark.isHidden = cellData.card.isDefault == 1 ? false : true
        btnDelete.isHidden = cellData.card.isDefault == 1 ? true : false
        lblTitle.text = "XXXX - XXXX -XXXX - \(cellData.card.lastFour ?? R.string.localizable.fourTwo())"
        
        imgView.image = cellData.card.brand?.lowercased() == "mastercard" ? R.image.masterCard_icon() : R.image.iconVisa()
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnDeleteTapped(_ sender: Any) {
        
        if let id = cellData.card.cardID {
            cellData.viewModel.deleteCreditCard(for: String(id)) { msg, success in
                
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .success)
                }
                self.cellData.viewModel.fetchData()
            }
        }
    }
    
    override func tapped() {
        super.tapped()
        
        if let id = cellData.card.cardID {
            UserDefaults.standard.saveDefaultCardId(cardId: id)
            cellData.viewModel.setCreditCardDefault(for: id) { msg, success in
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .success)
                }
                self.cellData.viewModel.fetchData()
            }
        }
        
    }
    
}


class ManageAddCardCellData: TableCellData {

    var card: CreditCardDetail
    var viewModel: ManageCardsVM {get {return model as! ManageCardsVM}}
    init(card: CreditCardDetail) {
        self.card = card
        super.init(nibId: "ManageAddCardCell")
    }
}
