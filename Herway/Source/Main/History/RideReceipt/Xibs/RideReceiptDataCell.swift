//
//  RideReceiptDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/3.
//

import UIKit

class RideReceiptDataCell: TableCell {
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblDistanceFare: UILabel!
    @IBOutlet weak var lblFare: UILabel!
    @IBOutlet weak var lblTimeTaken: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    
    var cellData: RideReceiptDataCellData {get {return data as! RideReceiptDataCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        lblBookingId.text = cellData.historyRide.bookingID
        lblDistance.text = ""
        if let distance = cellData.historyRide.distance {
            lblDistance.text = R.string.localizable.distanceKm(String(format:"%.2f", distance))
        }
        lblTimeTaken.text = R.string.localizable.no_mins()
        if let travelTime = cellData.historyRide.travelTime {
            lblTimeTaken.text = R.string.localizable.total_mins(travelTime)
        }
        
        lblFare.text = "\(CURRENCY)0"
        if let fixed = cellData.historyRide.payment?.fixed {
            lblFare.text = "\(CURRENCY)\(String(format:"%.2f", fixed))"
        }
        lblDistanceFare.text = "\(CURRENCY)0"
        if let distance = cellData.historyRide.payment?.distance {
            lblDistanceFare.text = "\(CURRENCY)\(String(format:"%.2f", distance))"
        }
        lblTax.text = "\(CURRENCY)0"
        if let tax = cellData.historyRide.payment?.tax {
            lblTax.text = "\(CURRENCY)\(String(format:"%.2f", tax))"
        }
        
        lblTotal.text = "\(CURRENCY)0"
        if let total = cellData.historyRide.payment?.total {
            lblTotal.text = "\(CURRENCY)\(String(format:"%.2f", total))"
        }
        
        
    }
    
    override func setupTheme() {
        super.setupTheme()
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.parentController.dismiss(animated: true, completion: nil)
    }
}

class RideReceiptDataCellData: TableCellData {
    
    var historyRide: RideHistoryResponse
    init(historyRide: RideHistoryResponse) {
        self.historyRide = historyRide
        super.init(nibId: "RideReceiptDataCell")
    }
}
