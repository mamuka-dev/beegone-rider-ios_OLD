//
//  HomeBottomViewStage2Cell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import UIKit

class HomeBottomViewStage2Cell: TableCell {
    
    @IBOutlet weak var btnWalletSwitch: UISwitch!
        @IBOutlet weak var lblPromoCode: UILabel!
//    @IBOutlet weak var lblVehicle1: UILabel!
//    @IBOutlet weak var imgVehicle2: UIImageView!
//    @IBOutlet weak var imgVehicle1: UIImageView!
//    @IBOutlet weak var vwTaxi2: UIView!
//    @IBOutlet weak var vwTaxi1: UIView!
    
//    @IBOutlet weak var vwBottom: UIView!
//    @IBOutlet var theButtons: [UIButton]!
     
    var cellData: HomeBottomViewStage2CellData {get {return data as! HomeBottomViewStage2CellData}}
    
    override func setupUI() {
        super.setupUI()
        
        self.lblPromoCode.text = R.string.localizable.addPromoCode()
        if let vc = self.parentController as? HomeBottomViewStage2VC {
            if let promoCode = vc.parentHome.promoCode {
                self.lblPromoCode.text = promoCode
            }
        }
        
        btnWalletSwitch.isOn = cellData.viewModel.isWalletSelected
//        var i = 0
//        theButtons.forEach { btn in
//            btn.tag = i
//            i += 1
//        }
//
//        self.setupVehicles()
        
    }
    
//    func setupVehicles() {
//        if cellData.viewModel.selectedType == .transportation {
//            lblVehicle1.text = "Taxi"
//            lblVehicle2.text = "Luxury"
//            imgVehicle1.image = R.image.iconCar1()
//            imgVehicle2.image = R.image.iconCar2()
//        } else if cellData.viewModel.selectedType == .delivery {
//            lblVehicle1.text = "Delivery Van"
//            lblVehicle2.text = "Delivery Bike"
//            imgVehicle1.image = R.image.iconTruck()
//            imgVehicle2.image = R.image.iconDeliveryBike()
//        } else {
//            lblVehicle1.text = "Truck"
//            lblVehicle2.text = "Big Truck"
//            imgVehicle1.image = R.image.iconTruck()
//            imgVehicle2.image = R.image.iconTruck()
//        }
//    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
//    @IBAction func btnTypeTapped(_ sender: UIButton) {
//
//        if sender.tag == 0{
//            cellData.viewModel.typeChanged(type: .transportation)
//
//        } else if sender.tag == 1{
//            cellData.viewModel.typeChanged(type: .delivery)
//
//        } else if sender.tag == 2{
//            cellData.viewModel.typeChanged(type: .truck)
//
//        }
//        self.changeUnderlinePosition(for: cellData.viewModel.selectedType)
//
//        self.setupVehicles()
//    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        self.changeUnderlinePosition(for: .transportation)
//    }
    
//    func changeUnderlinePosition(for type: VehicleType){
//
//        vwBottom.backgroundColor = .primaryColor
//            var i = 0
//            theButtons.forEach { (btn) in
//                btn.tag = i
//                btn.setTitleColor(.secondaryColor, for: .normal)
//                i = i + 1
//            }
//
//            var underlineFinalXPosition = theButtons[0].frame.origin.x
//
//        if type == .transportation{
//            theButtons[0].setTitleColor(.primaryColor, for: .normal)
//               underlineFinalXPosition = theButtons[0].frame.origin.x
//
//        } else if type == .delivery{
//                theButtons[1].setTitleColor(.primaryColor, for: .normal)
//               underlineFinalXPosition = theButtons[1].frame.origin.x
//
//        } else if type == .truck{
//                theButtons[2].setTitleColor(.primaryColor, for: .normal)
//               underlineFinalXPosition = theButtons[2].frame.origin.x
//            }
//
//            UIView.animate(withDuration: 0.1, animations: {
//                self.vwBottom.frame.origin.x = underlineFinalXPosition
//            })
//        }
    
//    @IBAction func btnTaxi2Tapped(_ sender: Any) {
//        vwTaxi1.backgroundColor = nil
//        vwTaxi2.backgroundColor = .tint2
//        delegate?.cellWasTapped(cell: self, tag: "showEstimatedPrice")
//    }
//    
//    @IBAction func btnTaxi1Tapped(_ sender: Any) {
//        vwTaxi1.backgroundColor = .tint2
//        vwTaxi2.backgroundColor = nil
//        
//    }
    
    
    @IBAction func switchUseWalletTapped(_ sender: Any) {
        
        cellData.viewModel.isWalletSelected = btnWalletSwitch.isOn
        delegate?.cellWasTapped(cell: self, tag: "walletSelected")
    }
    
    @IBAction func btnScheduleTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "showSchedulePopUp")
    }
    
    @IBAction func btnPromoTapped(_ sender: Any) {
        
        delegate?.cellWasTapped(cell: self, tag: "promo")
    }
    
    @IBAction func btnBookTapped(_ sender: Any) {
        
        delegate?.cellWasTapped(cell: self, tag: "book")
    }
}

class HomeBottomViewStage2CellData: TableCellData {
    
    var viewModel: HomeBottomViewStage2VM {get {return model as! HomeBottomViewStage2VM}}
    init() {
        super.init(nibId: "HomeBottomViewStage2Cell")
    }
}


enum VehicleType: String {
    
    case transportation = "economy"
    case delivery = "luxury"
    case truck = "extra_seat"
    
    
    var title: String {
        switch self {
        case .transportation:
            return R.string.localizable.transportatioN()
        case .delivery:
            return R.string.localizable.deliverY()
        case .truck:
            return R.string.localizable.trucK()
        }
    }
}
