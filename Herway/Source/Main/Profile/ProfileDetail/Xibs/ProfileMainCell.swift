//
//  ProfileMainCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/25.
//

import UIKit
import SDWebImage

class ProfileMainCell: TableCell {
    
    @IBOutlet weak var lblWork: UILabel!
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNam: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var vwMain: UIView!

    var cellData: ProfileMainCellData {get {return data as! ProfileMainCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr = cellData.profileData.picture
        let url = URL(string: "\(IMAGE_BASE_URL)\(imgStr ?? "")")
        imgProfile.sd_setImage(with: url, placeholderImage: UIImage.init(named: "iconUserPlaceholder"))
        
        lblEmail.text = cellData.profileData.email
        lblPhone.text = cellData.profileData.mobile
        lblNam.text = "\(cellData.profileData.firstName ?? "") \(cellData.profileData.lastName ?? "")"
        
        lblHome.text = cellData.viewModel.homeAddress?.address
        lblWork.text = cellData.viewModel.workAddress?.address
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.layer.cornerRadius = 12
    }
    
    
}

class ProfileMainCellData: TableCellData {
    
    var viewModel: ProfileVM {get {return model as! ProfileVM}}
    var profileData: ProfileResponse
    init(profileData: ProfileResponse) {
        self.profileData = profileData
        super.init(nibId: "ProfileMainCell")
    }
}
