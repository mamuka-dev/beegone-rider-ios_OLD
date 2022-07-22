//
//  ManageCardsVM.swift
//  HerwayDriver
//
//  Created by Faizan Ali  on 2022/4/6.
//


import Foundation
import UIKit
import Alamofire
import Stripe

class ManageCardsVM: TableViewModel {
    
    var cardHolderName: String = ""
    var cardNo: String = ""
    var cvv: String = ""
    var cardExpiry: Date? = nil
    
    var allCards: [CreditCardDetail] = [CreditCardDetail]()

    var showCardsList: Bool = true
    
    override init() {
        super.init()
        fetchData()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        if showCardsList {
            self.allCards.forEach { card in
                section.addCell(cellData: ManageAddCardCellData(card: card))
            }
            
            section.addCell(nibId: "ManageAddCardButtonCell")
        } else {
            section.addCell(cellData: ManageCardDataCellData())
        }
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func gotoAddCardsVw() {
        showCardsList = false
        self.prepareData()
    }
    
    func gotoCardsList() {
        showCardsList = true
        self.prepareData()
    }
    
//    func createToken() {
//
//        let cardParams = STPCardParams()
//        cardParams.name = "Jenny Rosen"
//        cardParams.number = "4242424242424242"
//        cardParams.expMonth = 12
//        cardParams.expYear = 18
//        cardParams.cvc = "424"
//    }
    
    
    func fetchData() {

        self.getAllCards { msg, success in

            self.prepareData()
            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
        }
    }
    
    
    func getAllCards(block: @escaping (String?, Bool)-> Void){

        ActivityIndicator.shared.showLoadingIndicator()
        
        let urlString = AppURL.baseURL1.rawValue + "api/user/card"

        let header:HTTPHeaders =
            [
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": AppURL.token.getValue
            ]
        
        AF.request(urlString, method: .get, headers: header).responseJSON(completionHandler: { data in
            
            switch data.result {
            case .success(let value as [[String: Any]]):
                
                self.allCards.removeAll()
                value.forEach { dics in
                    
                    let theData = self.toCreditCardDetail(theData: dics)
                    if theData.isDefault == 1 {
                        if let id = theData.cardID {
                            UserDefaults.standard.saveDefaultCardId(cardId: id)
                        }
                    }
                    
                    self.allCards.append(theData)
                }
                block(nil, true)
            case .failure(let error):
                print(error.localizedDescription)
                block(error.localizedDescription, false)
            default:
                block(nil, false)
            }
            ActivityIndicator.shared.hideLoadingIndicator()
            
        })
    }
    
    func toCreditCardDetail(theData: [String: Any]) -> CreditCardDetail {
        
        let cardDetail = CreditCardDetail(id: theData["id"] as? Int, userID: theData["user_id"] as? Int, lastFour: theData["last_four"] as? String, cardID: theData["card_id"] as? String, token: theData["token"] as? String, brand: theData["brand"] as? String, type: theData["type"] as? String, isDefault: theData["is_default"] as? Int)
        
        return cardDetail
    }
    
    func deleteCreditCard(for cardId: String, block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.deleteCard(card_id: cardId).send(verificationResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if let msg = response.message {
                    block(msg, true)
                }
                block(nil, true)
            }
        }
    }
    
    func addCreditCard(for token: String, block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.addCardToRiderAccount(stripe_token: token).send(verificationResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if let msg = response.message {
                    block(msg, true)
                }
                block(nil, true)
            }
        }
    }
    
    func setCreditCardDefault(for cardId: String, block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.changeDefaultCard(card_id: cardId).send(verificationResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if let msg = response.message {
                    block(msg, true)
                }
                block(nil, true)
            }
        }
    }
    
}





