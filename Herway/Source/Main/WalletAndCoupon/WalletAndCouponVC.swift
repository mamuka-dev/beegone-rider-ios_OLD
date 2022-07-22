//
//  WalletAndCouponVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import UIKit

class WalletAndCouponVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var vwWalletHistoryBottom: UIView!
    @IBOutlet weak var vwCouponHistoryBottom: UIView!
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: WalletAndCouponVM {get {return model as! WalletAndCouponVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = WalletAndCouponVM()
        self.setupTopSegmentVw()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.walletHistoryDataCell)
        theTableView.register(R.nib.earningsNoDataCell)
        theTableView.register(R.nib.walletHistoryCouponCell)
        
    }
    
    override func setupUI() {
        super.setupUI()
        
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnCouponHistoryTapped(_ sender: Any) {
        self.viewModel.updateStatus(status: false)
        self.setupTopSegmentVw()
    }
    @IBAction func btnWalletHistoryTapped(_ sender: Any) {
        self.viewModel.updateStatus(status: true)
        self.setupTopSegmentVw()
    }
    
    func setupTopSegmentVw() {
        if viewModel.isWalletHistorySelected {
            vwWalletHistoryBottom.backgroundColor = .primaryColor
            vwCouponHistoryBottom.backgroundColor = .clear
        } else {
            vwWalletHistoryBottom.backgroundColor = .clear
            vwCouponHistoryBottom.backgroundColor = .primaryColor
        }
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
    }

}




