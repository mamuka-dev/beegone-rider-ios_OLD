//
//  ScheduledRidesVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/31.
//

import UIKit

class ScheduledRidesVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: ScheduledRidesVM {get {return model as! ScheduledRidesVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ScheduledRidesVM()
    }
    
    override func registerXibs() {
        super.registerXibs()

        
        theTableView.register(R.nib.earningsNoDataCell)
        theTableView.register(R.nib.scheduledRidesDataCell)
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





