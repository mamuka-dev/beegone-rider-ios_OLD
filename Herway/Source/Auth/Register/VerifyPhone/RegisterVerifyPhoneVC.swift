//
//  RegisterVerifyPhoneVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/23.
//

import UIKit

class RegisterVerifyPhoneVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: RegisterVerifyPhoneVM {get {return model as! RegisterVerifyPhoneVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = RegisterVerifyPhoneVM()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.registerVerifyPhoneCell)
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
        
        if let cellData = cell.data as? RegisterVerifyPhoneCellData {
            
            viewModel.phone = cellData.thePhoneNo
            
            return
        }
        
    }
    
}

