//
//  ValidatePhoneVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/6/11.
//

import UIKit

class ValidatePhoneVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var theTableView: UITableView!
    

    override var tableView: UITableView { return theTableView }
    
    var theBlock: ((Bool)-> Void)? = nil
    
    override init() {
        super.init()
    }
    
    func initialize(phone: String, type: verificationType, block: @escaping (Bool)-> Void) {
        self.theBlock = block
        model = ValidatePhoneVM(phone: phone, type: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func registerXibs() {
        super.registerXibs()
        
        theTableView.register(R.nib.validatePhoneDataCell)
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
        
        if tag == "validate" {
            
        }
    }
    
    

}
