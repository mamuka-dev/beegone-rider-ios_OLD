//
//  ManageAddCardButtonCell.swift
//  HerwayDriver
//
//  Created by Faizan Ali  on 2022/4/6.
//

import UIKit
import Stripe

class ManageAddCardButtonCell: TableCell {
    

    @IBOutlet weak var btnAddPayments: UIButton!
    var viewModel: ManageCardsVM {get {return data.model as! ManageCardsVM}}
    
    override func setupUI() {
        super.setupUI()
        
    }
    
    @IBAction func btnAddPaymentsTapped(_ sender: Any) {
        
        let addCardViewController = STPAddCardViewController()
            addCardViewController.delegate = self
            let navigationController = UINavigationController(rootViewController: addCardViewController)
        
        
//        let config = STPPaymentConfiguration()
//        config.requiredBillingAddressFields = .none// .full
//        let viewController = STPAddCardViewController(configuration: config, theme: .defaultTheme)
//        viewController.delegate = self
//        let navigationController = UINavigationController(rootViewController: viewController)
        parentController.present(navigationController, animated: true, completion: nil)
        
//        delegate?.cellWasTapped(cell: self, tag: "BtnAddCardTapped")
    }
    
//    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
//
//
//    }
//
//
//
//    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
//
//        print(paymentMethod.stripeId)
//
//
//    }
    
//    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
//
//        }
    
//    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: (Error?) -> Void) {
//
//        print(token)
//    }
    
}


extension ManageAddCardButtonCell: STPAddCardViewControllerDelegate {
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        addCardViewController.dismiss(animated: true, completion: nil)
    }
    
    
    
  
//    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
//
//        print(paymentMethod.stripeId)
//    }
//
//    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
////        navigationController?.popViewController(animated: true)
//    }
//
    internal func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        
        addCardViewController.dismiss(animated: true, completion: nil)
        print(token)
        viewModel.addCreditCard(for: token.tokenId) { msg, success in
            if let msg = msg {
                Utility.showLoaf(message: msg, state: .success)
            }
            self.viewModel.fetchData()
        }
        
    }
//
//        print(token)
//    }
}
