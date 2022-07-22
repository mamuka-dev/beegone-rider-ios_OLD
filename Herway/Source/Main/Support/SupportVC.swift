//
//  SupportVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/28.
//

import UIKit

class SupportVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: SupportVM {get {return model as! SupportVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = SupportVM()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.supportDataCell)
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



