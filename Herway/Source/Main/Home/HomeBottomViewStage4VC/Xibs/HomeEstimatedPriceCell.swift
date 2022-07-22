//
//  HomeEstimatedPriceCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/5/16.
//

import UIKit

class HomeEstimatedPriceCell: TableCell {

    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    var cellData: HomeEstimatedPriceCellData {get {return data as! HomeEstimatedPriceCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        lblDistance.text = ""
        if let distance = cellData.theData?.distance {
            lblDistance.text = R.string.localizable.distanceKm(String(format:"%.2f", distance))
        }
        lblTime.text = R.string.localizable.no_mins()
        if let travelTime = cellData.theData?.time {
            lblTime.text = "\(travelTime)"
        }
        
        lblPrice.text = "\(CURRENCY)0"
        if let fixed = cellData.theData?.estimatedFare {
            lblPrice.text = "\(CURRENCY)\(String(format:"%.2f", fixed))"
        }
        lblTax.text = "\(CURRENCY)0"
        if let distance = cellData.theData?.roundOff {
            lblTax.text = "\(CURRENCY)\(String(format:"%.2f", distance))"
        }
        
        lblTotal.text = "\(CURRENCY)0"
        if let total = cellData.theData?.eta_total {
            lblTotal.text = "\(CURRENCY)\(String(format:"%.2f", total))"
        }
        
    }
    
    @IBAction func btnCrossTapped(_ sender: Any) {
        
        delegate?.cellWasTapped(cell: self, tag: "reloadHome")
    }
    
    
    
}


class HomeEstimatedPriceCellData: TableCellData {

    var theData: EstimatedPriceResponse?
    init(theData: EstimatedPriceResponse?) {
        self.theData = theData
        super.init(nibId: "HomeEstimatedPriceCell")
    }
}
