//
//  HomeBottomViewStage1Cell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/4.
//

import UIKit

class HomeBottomViewStage1Cell: TableCell {
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var vwHome: UIView!
    @IBOutlet weak var vwPickup: UIView!
    @IBOutlet weak var vwWork: UIView!
    
    var cellData: HomeBottomViewStage1CellData {get {return data as! HomeBottomViewStage1CellData}}
    
    override func setupUI() {
        super.setupUI()
        
        let type = UserDefaults.standard.getHomeState()
        
        if type == .initial {
            lblName.isHidden = false
            lblDesc.isHidden = false
            vwSearch.isHidden = false
        } else {
            lblName.isHidden = true
            lblDesc.isHidden = true
            vwSearch.isHidden = true
        }
        
        Utility.getCurrentTimeTitle { text in
            lblName.text = "\(text), \(UserSession.shared.user?.name ?? "")"
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwSearch.cornerRadius = 12
        vwHome.cornerRadius = 22
        vwWork.cornerRadius = 22
        vwPickup.cornerRadius = 22
    }
    
    @IBAction func btnSearchTapped(_ sender: Any) {
        
        delegate?.cellWasTapped(cell: self, tag: "")
    }
    
    @IBAction func btnWorkTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "work")
    }
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "home")
    }
    
    @IBAction func btnPickupTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "pickup")
    }
}

class HomeBottomViewStage1CellData: TableCellData {
    
    init() {
        super.init(nibId: "HomeBottomViewStage1Cell")
    }
}


