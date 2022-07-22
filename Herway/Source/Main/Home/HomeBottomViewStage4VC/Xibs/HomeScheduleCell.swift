//
//  HomeScheduleCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/5.
//

import UIKit

class HomeScheduleCell: TableCell {

    @IBOutlet weak var lblScheduleRide: UILabel!
    
    var viewModel: HomeBottomViewStage4VM {get {return data.model as! HomeBottomViewStage4VM}}
    
    override func setupUI() {
        super.setupUI()
        lblScheduleRide.text = viewModel.scheduleDate == nil ? R.string.localizable.selectDateTime() : viewModel.scheduleDate
    }
    
    @IBAction func btnScheduleDateTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "scheduleDate")
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "scheduleDone")
        
    }
}
