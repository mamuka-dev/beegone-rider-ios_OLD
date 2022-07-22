//
//  RideDetailVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import UIKit

class RideDetailVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: RideDetailVM {get {return model as! RideDetailVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func initializeView(id: String) {
        self.model = RideDetailVM(id: id)
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.rideDetailDataCell)
    }
    
    override func setupUI() {
        super.setupUI()
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    
    @IBAction func btnReceiptTapped(_ sender: Any) {
        let vc = RideReceiptVC.instantiateHome()
        if let history = viewModel.historyRides {
            vc.theInitialize(historyRides: history)
            FilteredSheetManager.shared.show(parent: self, viewToShow: vc, inlineMode: false, percent: 0.6, dismissOnOverlayTap: true, dismissOnPull: true)
        }
        
        
//        let vc = RideReceiptVC.instantiateHome()
//        FilteredSheetManager.shared.show(parent: self, viewToShow: vc)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
    }

}




