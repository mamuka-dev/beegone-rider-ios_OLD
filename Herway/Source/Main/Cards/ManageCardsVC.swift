//
//  ManageCardsVC.swift
//  HerwayDriver
//
//  Created by Faizan Ali  on 2022/4/6.
//

import UIKit

class ManageCardsVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: ManageCardsVM {get {return model as! ManageCardsVM}}
    override var tableView: UITableView { return theTableView }
    
    var onCompletion: ((Bool)-> Void)? = nil
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ManageCardsVM()
        lblTitle.text = viewModel.showCardsList ? R.string.localizable.manageCards() : R.string.localizable.addCardForPayments()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.manageAddCardButtonCell)
        theTableView.register(R.nib.manageAddCardCell)
        theTableView.register(R.nib.manageCardDataCell)
    }
    
    func theInitialize(block: @escaping (Bool)-> Void) {
        self.onCompletion = block
    }
    
    override func setupUI() {
        super.setupUI()
        
        
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        if viewModel.showCardsList {
            self.onCompletion?(true)
            self.navigationController?.popViewController(animated: true)
        } else {
            viewModel.gotoCardsList()
        }
        
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
        if tag == "BtnAddCardTapped" {
            viewModel.gotoAddCardsVw()
        }
    }

}






