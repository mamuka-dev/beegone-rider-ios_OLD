//
//  DatePickerProtocol.swift
//  imagePickerTask
//
//  Created by Faizan Ali on 25/10/2018.
//  Copyright © 2018 Faizan Ali. All rights reserved.
//

import UIKit

class SingleValuePickerCell: UITableViewCell {

    @IBOutlet weak var lblleadingLayout: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblValue: UILabel!
    
    func setupUI(value: String, unit: String?, isSelected: Bool, isAllowMultipleSelection: Bool){
        
        lblleadingLayout.constant = isAllowMultipleSelection ? 56 : 32
        imgView.image = isSelected ? UIImage.init(named: "checkMarkBrand") : UIImage.init(named: "mcq")
        
        imgView.isHidden = !isAllowMultipleSelection
        
        if unit == nil{
            self.lblValue.text = value
        } else{
            self.lblValue.text = "\(value) \(unit!)"
        }
        setUpTheme()
    }
    
    func setUpTheme(){
        imgView.tintColor = .primaryColor
        lblValue.textColor = .primaryColor
    }
    
}
