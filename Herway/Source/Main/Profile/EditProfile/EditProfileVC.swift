//
//  EditProfileVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/26.
//

import UIKit

class EditProfileVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: EditProfileVM {get {return model as! EditProfileVM}}
    override var tableView: UITableView { return theTableView }
    var theBlock: (()->Void)? = nil
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func initializeTheData(profileData: ProfileResponse, block: @escaping ()-> Void) {
        let vm = EditProfileVM()
        vm.profileData = profileData
        self.theBlock = block
        model = vm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.editProfileCell)
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


