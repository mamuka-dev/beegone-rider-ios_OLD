//
//  HomeServiceDetailCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/17.
//

import UIKit
import SDWebImage

class HomeServiceDetailCell: TableCell {

    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblCapacity: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblKM: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblServiceType: UILabel!
    @IBOutlet weak var imgVehicle: UIImageView!
    
    var cellData: HomeServiceDetailCellData {get {return data as! HomeServiceDetailCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        lblServiceType.text = cellData.theData?.name
        
        if let fixedPrice = cellData.theData?.eta_total {
            lblPrice.text = "\(CURRENCY)\(String(format:"%.2f", fixedPrice))"
        }
        if let fixedPrice = cellData.theData?.price {
            lblKM.text = "\(CURRENCY)\(String(format:"%.2f", fixedPrice))"
        }
        
        lblType.text = cellData.theData?.calculator?.lowercased()
        lblCapacity.text = cellData.theData?.capacity
        lblSize.text = cellData.theData?.description
        
        imgVehicle.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr2 =  cellData.theData?.image
        let url2 = URL(string: "\(imgStr2 ?? "")")
        imgVehicle.sd_setImage(with: url2, placeholderImage: UIImage.init(named: "iconCar1"))
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "CloseServiceDetail")
    }
    
}

class HomeServiceDetailCellData: TableCellData {

    var theData: TaxiServicesResponse?
    init(theData: TaxiServicesResponse?) {
        self.theData = theData
        super.init(nibId: "HomeServiceDetailCell")
    }
}


