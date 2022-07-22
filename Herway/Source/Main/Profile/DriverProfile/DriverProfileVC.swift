//
//  DriverProfileVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import UIKit

class DriverProfileVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: DriverProfileVM {get {return model as! DriverProfileVM}}
    override var tableView: UITableView { return theTableView }
    
    func initialize(name: String, imgStr: String, rating: Double, email: String, phone: String) {
        model = DriverProfileVM(name: name, imgStr: imgStr, rating: rating, email: email, phone: phone)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.driverProfileDataCell)
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




