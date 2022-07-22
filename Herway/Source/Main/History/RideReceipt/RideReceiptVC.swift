//
//  RideReceiptVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/3.
//

import UIKit

class RideReceiptVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: RideReceiptVM {get {return model as! RideReceiptVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func theInitialize(historyRides: RideHistoryResponse) {
        model = RideReceiptVM(historyRides: historyRides)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.rideReceiptDataCell)
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupTheme() {
        super.setupTheme()
    }

    override func cellWasTapped(cell: TableCell, tag: String) {
        
    }

}




