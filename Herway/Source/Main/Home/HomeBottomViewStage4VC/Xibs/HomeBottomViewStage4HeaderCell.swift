//
//  HomeBottomViewStage4HeaderCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import UIKit
import Cosmos
import SDWebImage

class HomeBottomViewStage4HeaderCell: TableCell {
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblCarType: UILabel!
    @IBOutlet weak var imgRideType: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var cellData: HomeBottomViewStage4HeaderCellData {get {return data as! HomeBottomViewStage4HeaderCellData}}
    
    override func setupUI() {
        super.setupUI()
    
        let currentState = UserDefaults.standard.getHomeState()
        
        if let status = self.cellData.currentRequest.status {
            if status == "STARTED" {
                lblDesc.text = R.string.localizable.dueToPeakHours()
                lblTitle.text = R.string.localizable.driverAcceptedYourRequest()

            } else if status == "ARRIVED" {
                lblDesc.text = R.string.localizable.dueToPeakHours()
                lblTitle.text = R.string.localizable.driverHasArrivedAtYourLocation()

            } else {
                lblDesc.text = R.string.localizable.dueToPeakHours()
                lblTitle.text = R.string.localizable.enjoyTheRide()

            }
        }
        
        lblName.text = "\(cellData.currentRequest.provider?.firstName ?? "") \(cellData.currentRequest.provider?.lastName ?? "")"
        lblCarType.text = cellData.currentRequest.providerService?.service_model
        lblNumber.text = cellData.currentRequest.providerService?.service_number ?? ""
        let theRaing = Double((cellData.currentRequest.provider?.rating ?? "0"))
        vwRating.rating = theRaing ?? 0
        
        imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr1 =  cellData.currentRequest.provider?.avatar
        let url1 = URL(string: "\(IMAGE_BASE_URL)\(imgStr1 ?? "")")
        imgUser.sd_setImage(with: url1, placeholderImage: UIImage.init(named: "iconUserPlaceholder"))
        
        imgRideType.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr2 =  cellData.currentRequest.serviceType?.image
        let url2 = URL(string: "\(IMAGE_BASE_URL)\(imgStr2 ?? "")")
        imgRideType.sd_setImage(with: url2, placeholderImage: UIImage.init(named: "iconCar1"))
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        let vc = DriverProfileVC.instantiateHome()
        let name = "\(cellData.currentRequest.provider?.firstName ?? "") \(cellData.currentRequest.provider?.lastName ?? "")"
        let imgStr = cellData.currentRequest.provider?.avatar ?? ""
        let rating: Double = Double((cellData.currentRequest.provider?.rating ?? "0")) ?? 0
        let email = cellData.currentRequest.provider?.email ?? ""
        let phone = cellData.currentRequest.provider?.mobile ?? ""
        
        
        vc.initialize(name: name, imgStr: imgStr, rating: rating, email: email, phone: phone)
        if let parent = self.parentController as? HomeBottomViewStage4VC {
            parent.parentHome.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "")
    }
}

class HomeBottomViewStage4HeaderCellData: TableCellData {
    
    var currentRequest: RideDetailResponseData
    init(currentRequest: RideDetailResponseData) {
        self.currentRequest = currentRequest
        super.init(nibId: "HomeBottomViewStage4HeaderCell")
    }
}
