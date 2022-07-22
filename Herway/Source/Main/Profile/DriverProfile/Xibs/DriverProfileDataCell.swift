//
//  DriverProfileDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import UIKit
import Cosmos
import SDWebImage

class DriverProfileDataCell: TableCell {
    
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhoneNum: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var vwMain: UIView!
    
    var cellData: DriverProfileDataCellData {get {return data as! DriverProfileDataCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        lblEmail.text = cellData.viewModel.email
        lblName.text = cellData.viewModel.name
        lblPhoneNum.text = cellData.viewModel.phone
        vwRating.rating = cellData.viewModel.rating
        
        imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr = cellData.viewModel.imgStr
        let url = URL(string: "\(IMAGE_BASE_URL)\(imgStr)")
        imgProfile.sd_setImage(with: url, placeholderImage: UIImage.init(named: "iconUserPlaceholder"))
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.layer.cornerRadius = 12
    }
    
    
    
    
}

class DriverProfileDataCellData: TableCellData {
    
    
    var viewModel: DriverProfileVM {get {return model as! DriverProfileVM}}
    init() {
        super.init(nibId: "DriverProfileDataCell")
    }
}
