//
//  HomeVehicleViewStage2HeaderCollectionCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/5/31.
//

import UIKit

class HomeVehicleViewStage2HeaderCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwBottom: UIView!
    
    func setupUI(title: String, showBottomView: Bool) {
        self.lblTitle.text = title
        self.vwBottom.isHidden = !showBottomView
    }

}
