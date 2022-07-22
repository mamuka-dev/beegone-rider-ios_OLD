//
//  HomeBookingInvoiceCell.swift
//  HerwayDriver
//
//  Created by Faizan Ali  on 2022/1/30.
//

import UIKit
import Cosmos

class HomeBookingInvoiceCell: TableCell {

    @IBOutlet weak var btnAmount: UIButton!
    @IBOutlet weak var lblCash: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblWaitingCharges: UILabel!
    @IBOutlet weak var lblFare: UILabel!
    @IBOutlet weak var lblTimeTaken: UILabel!
    @IBOutlet weak var lblDistanceTravel: UILabel!
    @IBOutlet weak var lblToAddress: UILabel!
    @IBOutlet weak var lblFromAddress: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    
    var cellData: HomeBookingInvoiceCellData {get {return data as! HomeBookingInvoiceCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        lblBookingId.text = "\(cellData.request.bookingID ?? "")"
        lblFromAddress.text = cellData.request.sAddress
        lblToAddress.text = cellData.request.dAddress
        
        lblDistanceTravel.text = ""
        if let distance = cellData.request.distance {
            lblDistanceTravel.text = R.string.localizable.distanceKm(String(format:"%.2f", distance))
        }
        
        
        lblTimeTaken.text = R.string.localizable.total_mins(cellData.request.travel_time ?? "0")
        let theDistanceFare = cellData.request.payment?.distance ?? 0
        lblFare.text = "\(CURRENCY)\(String(format:"%.2f", theDistanceFare))"
        lblWaitingCharges.text = "\(CURRENCY)0"
        let theTax = cellData.request.payment?.tax ?? 0
        lblTax.text = "\(CURRENCY)\(String(format:"%.2f", theTax))"
        lblCash.text = cellData.request.paymentMode
        
        let payable = cellData.request.payment?.payable ?? 0
        btnAmount.setTitle("\(CURRENCY)\(String(format:"%.2f", payable))", for: .normal)
        
        
//        btnAmount.setTitle("", for: .normal)
//        if let amount = cellData.request.amount {
//            btnAmount.setTitle("\(CURRENCY)\(amount)", for: .normal)
//        }
        

    }
    
    @IBAction func btnAmountTapped(_ sender: Any) {
//        delegate?.cellWasTapped(cell: self, tag: "cancelRide")
    }
    
    override func setupTheme() {
        super.setupTheme()
    }
    
    @IBAction func btnDroppedTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "gotoRating")
    }
    
    @IBAction func btnPayOnlineTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "payOnline")
    }
    
    
}

class HomeBookingInvoiceCellData: TableCellData {
    
    var request: RideDetailResponseData
    init(currentRequest: RideDetailResponseData) {
        self.request = currentRequest
        super.init(nibId: "HomeBookingInvoiceCell")
    }
}
