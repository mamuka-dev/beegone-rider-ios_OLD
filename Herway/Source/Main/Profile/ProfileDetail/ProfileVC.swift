//
//  ProfileVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/25.
//

import UIKit

class ProfileVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: ProfileVM {get {return model as! ProfileVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ProfileVM()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.profileMainCell)
    }
    
    override func setupUI() {
        super.setupUI()
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnEditTapped(_ sender: Any) {
        let vc = EditProfileVC.instantiateHome()
        vc.initializeTheData(profileData: viewModel.profileData!, block: {
            self.viewModel.fetchData()
        })
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
    }

}

