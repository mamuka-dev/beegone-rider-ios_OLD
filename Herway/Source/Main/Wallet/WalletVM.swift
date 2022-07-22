//
//  WalletVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import Foundation
import UIKit
import Alamofire

class WalletVM: TableViewModel {
    
    var defaultCard: CreditCardDetail? = nil
    var amountToBeCharge: Int = 0
    
    override init() {
        super.init()
        fetchAllCardsData()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: WalletDataCellData())
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    
    func chargeAmount(for cardId: String, block: @escaping (String?, Bool)-> Void){
        
        if amountToBeCharge <= 0 {
            Utility.showLoaf(message: R.string.localizable.kindlyEnterAnAmount(), state: .error)
            return
        }
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.chargeCardForWallet(card_id: cardId, amount: String(self.amountToBeCharge)).send(verificationResponse.self) { (result) in
            
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
    
    
    func getProfileData() {

        ActivityIndicator.shared.showLoadingIndicator()
        Routes.getProfile.send(ProfileResponse.self) { (result) in

            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                UserSession.shared.user?.wallet = String(response.walletBalance ?? 0)
                self.prepareData()
            }
        }
    }
    
    
    func fetchAllCardsData() {

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
        
        let urlString = AppURL.baseURL1.rawValue + "/api/user/card"

        let header:HTTPHeaders =
            [
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": AppURL.token.getValue
            ]
        
        AF.request(urlString, method: .get, headers: header).responseJSON(completionHandler: { data in
            
            switch data.result {
            case .success(let value as [[String: Any]]):
                
                value.forEach { dics in
                    
                    let theData = self.toCreditCardDetail(theData: dics)
                    if theData.isDefault == 1 {
                        self.defaultCard = theData
                        if let id = theData.cardID {
                            UserDefaults.standard.saveDefaultCardId(cardId: id)
                        }
                        
                    }
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
    
}




