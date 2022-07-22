//
//  RideHistoryVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/31.
//

import Foundation
import UIKit
import Alamofire

class RideHistoryVM: TableViewModel {
    
    var historyRides: [RideHistoryResponse] = [RideHistoryResponse]()
    var showNoData: Bool = false
    
    override init() {
        super.init()
        fetchData()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        if historyRides.count == 0 && showNoData {
            section.addCell(cellData: EarningsNoDataCellData(img: R.image.iconNoData1()!, noDataTxt: R.string.localizable.noRidesCompleted(), topLayout: 64))
        } else {
            historyRides.forEach { ride in
                
                section.addCell(cellData: RideHistoryDataCellData(historyRide: ride))
            }
        }
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func fetchData() {
        
        self.getRideHistory { msg, success in
            self.showNoData = true
            self.prepareData()
            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
        }
    }
    
    func getRideHistory(block: @escaping (String?, Bool)-> Void){

        ActivityIndicator.shared.showLoadingIndicator()
        
        let urlString = AppURL.baseURL1.rawValue + "api/user/trips"

        let header:HTTPHeaders =
            [
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": AppURL.token.getValue
            ]
        
        AF.request(urlString, method: .get, headers: header).responseJSON(completionHandler: { data in
            
            switch data.result {
            case .success(let value as [[String: Any]]):
                self.historyRides.removeAll()
                value.forEach { v in
                    let theData: RideHistoryResponse = self.toRideHistoryResponse(data: v)
                    self.historyRides.append(theData)
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

    
    func toRideHistoryResponse(data: [String: Any]) -> RideHistoryResponse {
        
        var theData: [String: Any] = [String: Any]()
        if let d: [String: Any] = data["payment"] as? [String: Any] {
            theData = d
        }
        
        var serviceTypeData: [String: Any] = [String: Any]()
        if let d: [String: Any] = data["service_type"] as? [String: Any] {
            serviceTypeData = d
        }
        
        let payment = RideHistoryPayment(id: theData["id"] as? Int, requestID: theData["request_id"] as? Int, fixed: theData["fixed"] as? Double, distance: theData["distance"] as? Double, tPrice: theData["t_price"] as? Double, commision: theData["commision"] as? Double, discount: theData["discount"] as? Double, tax: theData["tax"] as? Double, wallet: theData["wallet"] as? Double, surge: theData["surge"] as? Double, total: theData["total"] as? Double, payable: theData["payable"] as? Double, providerCommission: theData["provider_commission"] as? Double, providerCommissionPaid: theData["provider_commission_paid"] as? String, providerPay: theData["provider_pay"] as? Double)
        
        let serviceType = RideHistoryServiceType(id: serviceTypeData["id"] as? Int, type: serviceTypeData["type"] as? String, name: serviceTypeData["name"] as? String, provider_name: serviceTypeData["provider_name"] as? String, image: serviceTypeData["image"] as? String)
        
        
        let res = RideHistoryResponse(id: data["id"] as? Int, bookingID: data["booking_id"] as? String, userID: data["user_id"] as? Int, providerID: data["provider_id"] as? Int, currentProviderID: data["current_provider_id"] as? Int, serviceTypeID: data["service_type_id"] as? Int, otp: data["otp"] as? Int, returntrip: data["returntrip"] as? Int, status: data["status"] as? String, paymentMode: data["payment_mode"] as? String, paid: data["paid"] as? Int, distance: data["distance"] as? Double, amount: data["amount"] as? Double, specialNote: data["specialNote"] as? String, sAddress: data["s_address"] as? String, sLatitude: data["s_latitude"] as? Double, sLongitude: data["s_longitude"] as? Double, dAddress: data["d_address"] as? String, dLatitude: data["d_latitude"] as? Double, dLongitude: data["d_longitude"] as? Double, assignedAt: data["assigned_at"] as? String, scheduleAt: data["schedule_at"] as? String, startedAt: data["started_at"] as? String, finishedAt: data["finished_at"] as? String, userRated: data["user_rated"] as? Int, providerRated: data["provider_rated"] as? Int, useWallet: data["use_wallet"] as? Int, surge: data["surge"] as? Int, routeKey: data["route_key"] as? String, createdAt: data["created_at"] as? String, updatedAt: data["updated_at"] as? String, isTrack: data["is_track"] as? String, travelTime: data["travel_time"] as? String, trackDistance: data["track_distance"] as? Int, trackLatitude: data["track_latitude"] as? Int, trackLongitude: data["track_longitude"] as? Int, staticMap: data["static_map"] as? String, payment: payment, serviceType: serviceType, user: nil, provider: nil, rating: nil)
        
        return res
    }
    
}




