//
//  RideDetailDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import UIKit
import Cosmos
import SDWebImage

class RideDetailDataCell: TableCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var vwRatingUser: CosmosView!
    @IBOutlet weak var lblUserTime: UILabel!
    @IBOutlet weak var lblUserDate: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    @IBOutlet weak var lblPaymentMode: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    
    var cellData: RideDetailDataCellData {get {return data as! RideDetailDataCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        lblUserName.text = "\(cellData.historyRide.provider?.firstName ?? "") \(cellData.historyRide.provider?.lastName ?? "")"
        let theRaing = Double((cellData.historyRide.provider?.rating ?? 0))
        vwRatingUser.rating = theRaing
        
        if let time = cellData.historyRide.createdAt {
            lblUserDate.text = "\(Utility.getDate(from: time, toFormate: .defaultDate) ?? "")"
            lblUserTime.text = "\(Utility.getTime(from: time) ?? "")"
        }
        
        lblFrom.text = cellData.historyRide.sAddress
        lblTo.text = cellData.historyRide.dAddress
        
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr = cellData.historyRide.staticMap
        let theUrl = URL(string: imgStr?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        imgView.sd_setImage(with: theUrl, placeholderImage: UIImage.init(named: "iconMap"))
        
        lblBookingId.text = cellData.historyRide.bookingID
        lblPaymentMode.text = cellData.historyRide.paymentMode
        lblComments.text = R.string.localizable.noCommentAvailable()
        if let comments = cellData.historyRide.rating?.userComments {
            if !comments.isEmpty {
                lblComments.text = comments
            }
        }
        
        userImgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr1 =  cellData.historyRide.provider?.picture
        let url1 = URL(string: "\(IMAGE_BASE_URL)\(imgStr1 ?? "")")
        userImgView.sd_setImage(with: url1, placeholderImage: UIImage.init(named: "iconUserPlaceholder"))
    }
    
    override func setupTheme() {
        super.setupTheme()

    }
    
    
    @IBAction func btnDriverProfileTapped(_ sender: Any) {
//        let vc = DriverProfileVC.instantiateHome()
//        parentController.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

class RideDetailDataCellData: TableCellData {
    
    var viewModel: RideDetailVM {get {return model as! RideDetailVM}}
    var historyRide: RideHistoryResponse
    init(historyRide: RideHistoryResponse) {
        self.historyRide = historyRide
        super.init(nibId: "RideDetailDataCell")
    }
}
