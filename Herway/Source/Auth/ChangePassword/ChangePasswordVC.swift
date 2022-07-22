//
//  ChangePasswordVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/23.
//

import UIKit

class ChangePasswordVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: ChangePasswordVM {get {return model as! ChangePasswordVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func theInitialize(isForgetPass: Bool) {
        model = ChangePasswordVM(isForgetPass: isForgetPass)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.logInCell)
        theTableView.register(R.nib.changePasswordCell)
        theTableView.register(R.nib.changePasswordVerifyCell)
        
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
        
        if tag == "verifyTapped" {
            self.view.endEditing(true)
            viewModel.showVerifyView = false
            viewModel.prepareData()
            
        } else if let cellData = cell.data as? ChangePasswordVerifyCellData {
            viewModel.phone = cellData.thePhoneNo
        }
    }

}
