//
//  RideHistoryDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import UIKit
import SDWebImage

class RideHistoryDataCell: TableCell {
    
    @IBOutlet weak var lblTaxiType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgTaxiType: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDrop: UILabel!
    @IBOutlet weak var lblPickup: UILabel!
    @IBOutlet weak var lblBookingID: UILabel!
    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwMain: UIView!

    var cellData: RideHistoryDataCellData {get {return data as! RideHistoryDataCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        lblBookingID.text = R.string.localizable.bookingID(cellData.historyRide.bookingID ?? "")
        lblPickup.text = "\(cellData.historyRide.sAddress ?? "")"
        lblDrop.text = "\(cellData.historyRide.dAddress ?? "")"
        
        if let time = cellData.historyRide.assignedAt {
            lblDate.text = "\(Utility.getDate(from: time) ?? "")"
            lblTime.text = "\(Utility.getTime(from: time) ?? "")"
        }
        
        imgTaxiType.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr = cellData.historyRide.serviceType?.image
        let url = URL(string: "\(IMAGE_BASE_URL)\(imgStr ?? "")")
        imgTaxiType.sd_setImage(with: url, placeholderImage: UIImage.init(named: "iconCar1"))
        
        self.lblPrice.text = "\(CURRENCY) 0"
        if let payable = cellData.historyRide.payment?.payable {
                self.lblPrice.text = "\(CURRENCY) \(String(format:"%.2f", payable))"
        }
        
        lblTaxiType.text = cellData.historyRide.serviceType?.name ?? ""
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwTop.roundCorners(with: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 12)
        vwMain.layer.cornerRadius = 12
    }
    
    
    @IBAction func btnSupportTapped(_ sender: Any) {
        
        
    }
    
    override func tapped() {
        super.tapped()
        
        if let id = cellData.historyRide.id {
            let vc = RideDetailVC.instantiateHome()
            vc.initializeView(id: String(id))
            parentController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

class RideHistoryDataCellData: TableCellData {
    
    var viewModel: RideHistoryVM {get {return model as! RideHistoryVM}}
    var historyRide: RideHistoryResponse
    init(historyRide: RideHistoryResponse) {
        self.historyRide = historyRide
        super.init(nibId: "RideHistoryDataCell")
    }
}
