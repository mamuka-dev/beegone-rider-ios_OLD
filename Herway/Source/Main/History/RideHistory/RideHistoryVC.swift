//
//  RideHistoryVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import UIKit

class RideHistoryVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: RideHistoryVM {get {return model as! RideHistoryVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = RideHistoryVM()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.rideHistoryDataCell)
        theTableView.register(R.nib.earningsNoDataCell)
    }
    
    override func setupUI() {
        super.setupUI()
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
    }

}




