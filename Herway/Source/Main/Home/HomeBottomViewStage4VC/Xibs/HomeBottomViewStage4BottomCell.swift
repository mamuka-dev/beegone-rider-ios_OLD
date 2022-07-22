//
//  HomeBottomViewStage4BottomCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import UIKit

class HomeBottomViewStage4BottomCell: TableCell {
    
    @IBOutlet weak var vwPhone: UIView!
    @IBOutlet weak var vwChat: UIView!
    @IBOutlet weak var vwCancel: UIView!
    @IBOutlet weak var vwShare: UIView!
    
    
    var cellData: HomeBottomViewStage4BottomCellData {get {return data as! HomeBottomViewStage4BottomCellData}}
    
    override func setupUI() {
        super.setupUI()
        
        
        
        if let status = self.cellData.currentRequest.status {
            vwPhone.isHidden = true
            vwChat.isHidden = true
            vwCancel.isHidden = true
            vwShare.isHidden = true
            
            if status == "STARTED" {
                vwPhone.isHidden = false
                vwChat.isHidden = false
                vwCancel.isHidden = false

            } else if status == "ARRIVED" {
                vwPhone.isHidden = false
                vwChat.isHidden = false
                vwCancel.isHidden = false

            } else {
                vwPhone.isHidden = false
                vwChat.isHidden = false
                vwCancel.isHidden = true
//                vwShare.isHidden = false

            }
        }
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnCallTapped(_ sender: Any) {
        if let number = cellData.currentRequest.provider?.mobile {
            Utility.dialNumber(number: number)
        }
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "cancelRide")
    }
    
    @IBAction func btnChatTapped(_ sender: Any) {
        let theVc = ChatVC.instantiateHome()
        theVc.initiaizeData(request: cellData.currentRequest)
        if let vc = parentController as? HomeBottomViewStage4VC {
            vc.parentHome.navigationController?.pushViewController(theVc, animated: true)
        }
        print("Chat")
    }
    
    @IBAction func btnShareTapped(_ sender: Any) {
        print("Share")
    }
    
}

class HomeBottomViewStage4BottomCellData: TableCellData {
    
    var currentRequest: RideDetailResponseData
    init(currentRequest: RideDetailResponseData) {
        self.currentRequest = currentRequest
        super.init(nibId: "HomeBottomViewStage4BottomCell")
    }
}
