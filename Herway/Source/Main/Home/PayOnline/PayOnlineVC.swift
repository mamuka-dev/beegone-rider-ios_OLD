//
//  PayOnlineVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/16.
//

import UIKit

class PayOnlineVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: PayOnlineVM {get {return model as! PayOnlineVM}}
    override var tableView: UITableView { return theTableView }
    var parentHome: HomeVC!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = PayOnlineVM()
    }
    
    override func registerXibs() {
        super.registerXibs()
        theTableView.register(R.nib.payOnlineDataCell)
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupTheme() {
        super.setupTheme()
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
        if tag == "closeTapped" {
            self.parentHome.hidePayOnlineView()
        } else if tag == "payTapped" {
            self.parentHome.showWalletCard()
        }
    }
}
