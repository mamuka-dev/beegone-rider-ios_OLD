//
//  LogInVC.swift
//  Cherwell
//
//  Created by Faizan Ali  on 2021/5/9.
//

import UIKit


class LogInVC: TableViewController, Storyboarded {
    
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: LogInVM {get {return model as! LogInVM}}
    override var tableView: UITableView { return theTableView }
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = LogInVM()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.logInCell)
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
        
        if tag == "login" {
            
            if viewModel.isVerified() {
                viewModel.checkForEmail(block: { error, success in
                    if let error = error {
                        Utility.showLoaf(message: error, state: .error)
                        return
                    } else if success {
                        return
                    }
                    Utility.showLoaf(message: R.string.localizable.somethingWentWrong(), state: .error)
                }
            )}
            return
        }
        if let cellData = cell.data as? LogInCellData {
            
            viewModel.phone = cellData.thePhoneNo
            
            return
        }
    }
    
    func gotoHome() {
        
        let redirect = RedirectHelper(window: nil)
        redirect.determineRoutes()
        UIView.transition(with: UIApplication.window(),
                                 duration: 0.5,
                                 options: .transitionFlipFromLeft,
                                 animations: nil,
                                 completion: nil)
    }

}
