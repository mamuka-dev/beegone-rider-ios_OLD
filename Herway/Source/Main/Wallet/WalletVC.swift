//
//  WalletVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import UIKit

class WalletVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var vwAddAmount: UIView!
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var lblCard: UILabel!
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: WalletVM {get {return model as! WalletVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = WalletVM()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.walletDataCell)
    }
    
    @IBAction func btnCloseAmountViewTapped(_ sender: Any) {
        self.vwAddAmount.isHidden = true
    }
    
    @IBAction func btnAddMoneyTapped(_ sender: Any) {
        if let cardId = UserDefaults.standard.getDefaultCardId() {
            viewModel.chargeAmount(for: cardId) { msg, success in
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .success)
                }
                self.viewModel.amountToBeCharge = 0
                self.viewModel.getProfileData()
                self.vwAddAmount.isHidden = true
            }
        } else {
            Utility.showLoaf(message: R.string.localizable.thereAreNoDefaultCardAvailable(), state: .error)
        }
    }
    
    @IBAction func btnChangeTapped(_ sender: Any) {
        let vc = ManageCardsVC.instantiateHome()
        vc.theInitialize { success in
            self.vwAddAmount.isHidden = true
            self.viewModel.fetchAllCardsData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.vwAddAmount.isHidden = true
        self.vwAddAmount.backgroundColor = .primaryColor.withAlphaComponent(0.50)
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
        if tag == "addAmount" {
            if viewModel.defaultCard == nil {
                lblCard.text = R.string.localizable.setAddDefaultCard()
                self.vwAddAmount.isHidden = false
                return
            }
            
            lblCard.text = "XXXX - XXXX -XXXX - \(viewModel.defaultCard?.lastFour ?? R.string.localizable.fourTwo())"
            self.vwAddAmount.isHidden = false
        }
    }

}




