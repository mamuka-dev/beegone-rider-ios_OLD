//
//  WalletAndCouponVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import Foundation
import UIKit
import Alamofire

class WalletAndCouponVM: TableViewModel {
    
    var walletHistory: [WalletHistoryResponse] = [WalletHistoryResponse]()
    var couponHistory: [CouponHistoryResponse] = [CouponHistoryResponse]()
    var showNoData: Bool = false
    var showNoCouponData: Bool = false
    var isWalletHistorySelected: Bool = true
    
//    func showNoData() -> Bool {
//
//        if isWalletHistorySelected {
//            return walletHistory.count == 0
//        } else {
//            return couponHistory.count == 0
//        }
//    }
    override init() {
        super.init()
        fetchData()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        if isWalletHistorySelected {
            if walletHistory.count == 0 && showNoData {
                section.addCell(cellData: EarningsNoDataCellData(img: R.image.iconNoData1()!, noDataTxt: R.string.localizable.noHistoryAvailable(), topLayout: 64))
            } else {
                walletHistory.forEach { wallet in
                    
                    section.addCell(cellData: WalletHistoryDataCellData(walletHistory: wallet))
                }
            }
            
        } else {
            if couponHistory.count == 0 && showNoCouponData {
                section.addCell(cellData: EarningsNoDataCellData(img: R.image.iconNoData1()!, noDataTxt: R.string.localizable.noHistoryAvailable(), topLayout: 64))
            } else {
                couponHistory.forEach { coupon in
                    
                    section.addCell(cellData: WalletHistoryCouponCellData(coupon: coupon))
                }
            }
            
            
        }
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func updateStatus(status: Bool) {
        self.isWalletHistorySelected = status
        self.prepareData()
    }
    
    func fetchData() {
        
        self.getWalletHistory { msg, success in
            self.showNoData = true
            self.prepareData()
            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
            
            self.getCouponHistory { msg, success in
                self.showNoCouponData = true
                self.prepareData()
                if !success {
                    if let msg = msg {
                        Utility.showLoaf(message: msg, state: .error)
                    }
                }
            }
        }
    }
    
    func getWalletHistory(block: @escaping (String?, Bool)-> Void){

        ActivityIndicator.shared.showLoadingIndicator()
        
        let urlString = AppURL.baseURL1.rawValue + "api/user/wallet/passbook"

        let header:HTTPHeaders =
            [
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": AppURL.token.getValue
            ]
        
        AF.request(urlString, method: .get, headers: header).responseJSON(completionHandler: { data in
            
            switch data.result {
            case .success(let value as [[String: Any]]):
                self.walletHistory.removeAll()
                value.forEach { v in
                    let theData: WalletHistoryResponse = self.toWalletHistoryResponse(theData: v)
                    self.walletHistory.append(theData)
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

    
    func toWalletHistoryResponse(theData: [String: Any]) -> WalletHistoryResponse {
        
        let wallet = WalletHistoryResponse(id: theData["id"] as? Int, userID: theData["user_id"] as? Int, amount: theData["amount"] as? Int, status: theData["status"] as? String, via: theData["via"] as? String, type: theData["type"] as? String, createdAt: theData["created_at"] as? String)
        
        return wallet
    }
    
    
    func getCouponHistory(block: @escaping (String?, Bool)-> Void){

        ActivityIndicator.shared.showLoadingIndicator()
        let urlString = AppURL.baseURL1.rawValue + "api/user/promo/passbook"

        let header:HTTPHeaders =
            [
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": AppURL.token.getValue
            ]
        
        AF.request(urlString, method: .get, headers: header).responseJSON(completionHandler: { data in
            
            switch data.result {
            case .success(let value as [[String: Any]]):
                self.couponHistory.removeAll()
                value.forEach { v in
                    let theData: CouponHistoryResponse = self.toCouponHistoryResponse(theData: v)
                    self.couponHistory.append(theData)
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

    
    func toCouponHistoryResponse(theData: [String: Any]) -> CouponHistoryResponse {
        
        var data: [String: Any] = [String: Any]()
        if let d: [String: Any] = theData["promocode"] as? [String: Any] {
            data = d
        }
        
        let cd = CouponHistoryResponseData(id: data["id"] as? Int, promoCode: data["promo_code"] as? String, discount: data["discount"] as? Int, discountType: data["discount_type"] as? String, expiration: data["expiration"] as? String, maxCount: data["max_count"] as? Int, status: data["id"] as? String)
        
        let coupon = CouponHistoryResponse(id: theData["id"] as? Int, userID: theData["user_id"] as? Int, promocodeID: theData["promocode_id"] as? Int, status: theData["status"] as? String, createdAt: theData["created_at"] as? String, promocode: cd)
        
        return coupon
    }
    
}




