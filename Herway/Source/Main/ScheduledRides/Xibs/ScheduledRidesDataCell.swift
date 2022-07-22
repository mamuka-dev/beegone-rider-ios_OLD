//
//  ScheduledRidesDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/31.
//

import UIKit
import SDWebImage

class ScheduledRidesDataCell: TableCell {
    
    @IBOutlet weak var lblTaxiType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblDrop: UILabel!
    @IBOutlet weak var lblPickup: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    @IBOutlet weak var vwCancel: UIView!
    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwMain: UIView!

    var cellData: ScheduledRidesDataCellData {get {return data as! ScheduledRidesDataCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        vwCancel.roundCorners(with: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 12)
        
        lblBookingId.text = R.string.localizable.bookingID(cellData.scheduleList.bookingID ?? "")
        lblPickup.text = "\(cellData.scheduleList.sAddress ?? "")"
        lblDrop.text = "\(cellData.scheduleList.dAddress ?? "")"
        
        if let time = cellData.scheduleList.assignedAt {
            lblDate.text = "\(Utility.getDate(from: time) ?? "")"
            lblTime.text = "\(Utility.getTime(from: time) ?? "")"
        }
        
        imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr = cellData.scheduleList.serviceType?.image
        let url = URL(string: "\(IMAGE_BASE_URL)\(imgStr ?? "")")
        imgUser.sd_setImage(with: url, placeholderImage: UIImage.init(named: "iconCar1"))
        
        self.lblPrice.text = "\(CURRENCY) 0"
        if let payable = cellData.scheduleList.amount {
                self.lblPrice.text = "\(CURRENCY) \(String(format:"%.2f", payable))"
        }
        
        lblTaxiType.text = cellData.scheduleList.serviceType?.name ?? ""
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwTop.roundCorners(with: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 12)
        vwMain.layer.cornerRadius = 12
    }
    
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        
        guard let id = cellData.scheduleList.id else {
            return
        }
        
        cellData.viewModel.cancelScheduleRide(for: String(id)) { msg, success in
            
            if success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .success)
                }
            } else {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
            self.cellData.viewModel.fetchData()
        }
    }
    
    override func tapped() {
        super.tapped()
    }
    
    
}

class ScheduledRidesDataCellData: TableCellData {
    
    var viewModel: ScheduledRidesVM {get {return model as! ScheduledRidesVM}}
    var scheduleList: ScheduleDataResponse
    init(scheduleList: ScheduleDataResponse) {
        self.scheduleList = scheduleList
        super.init(nibId: "ScheduledRidesDataCell")
    }
}
