//
//  HomeVehicleViewStage2Cell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/5/17.
//

import UIKit
import SDWebImage

class HomeVehicleViewStage2Cell: TableCell {

    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var btnEstimate: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTotalSeats: UILabel!
    @IBOutlet weak var lblVehicleName: UILabel!
    @IBOutlet weak var imgVehicle: UIImageView!
    
    var cellData: HomeVehicleViewStage2CellData {get {return data as! HomeVehicleViewStage2CellData}}
    
    override func setupUI() {
        super.setupUI()
        
        imgVehicle.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imgStr2 =  cellData.service.image
        let url2 = URL(string: "\(imgStr2 ?? "")")
        imgVehicle.sd_setImage(with: url2, placeholderImage: UIImage.init(named: "iconCar1"))
        
        lblVehicleName.text = cellData.service.name
        lblTotalSeats.text = cellData.service.capacity
        lblPrice.text = "\(CURRENCY) \(String(format:"%.2f", cellData.service.price ?? 0))"
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        
        
        if cellData.isSelected {
            vwMain.backgroundColor = .tint2
            return
        }
        vwMain.backgroundColor = nil
        
    }
    
    @IBAction func btnEstimateTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "showEstimatedPrice")
    }
    
    override func tapped() {
        super.tapped()
        
        if cellData.isSelected {
            delegate?.cellWasTapped(cell: self, tag: "showTheDetailOfService")
        } else {
            delegate?.cellWasTapped(cell: self, tag: "")
        }
        
        
    }
    
    
}


class HomeVehicleViewStage2CellData: TableCellData {
    
    var service: TaxiServicesResponse
    var isSelected: Bool
    var viewModel: HomeBottomViewStage2VM {get {return model as! HomeBottomViewStage2VM}}
    
    init(service: TaxiServicesResponse, isSelected: Bool) {
        self.service = service
        self.isSelected = isSelected
        super.init(nibId: "HomeVehicleViewStage2Cell")
    }
}
