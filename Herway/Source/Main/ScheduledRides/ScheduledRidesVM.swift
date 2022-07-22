//
//  ScheduledRidesVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/31.
//

import Foundation
import UIKit
import Alamofire

class ScheduledRidesVM: TableViewModel {
    
    var scheduleList: [ScheduleDataResponse] = [ScheduleDataResponse]()
    var showNoData: Bool = false
    
    override init() {
        super.init()
        fetchData()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        if scheduleList.count == 0 && showNoData {
            section.addCell(cellData: EarningsNoDataCellData(img: R.image.iconNoData1()!, noDataTxt: R.string.localizable.noRidesAvailable(), topLayout: 64))
        } else {
            scheduleList.forEach { ride in
                
                section.addCell(cellData: ScheduledRidesDataCellData(scheduleList: ride))
            }
        }
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func cancelScheduleRide(for id: String, block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.cancelScheduleRide(request_id: id, cancel_reason: "").send(normalResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                block(response.message, true)
            }
        }
    }
    
    func fetchData() {
        
        self.getScheduleRides { msg, success in
            self.showNoData = true
            self.prepareData()
            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
        }
    }
    
    func getScheduleRides(block: @escaping (String?, Bool)-> Void){

        ActivityIndicator.shared.showLoadingIndicator()
        let urlString = AppURL.baseURL1.rawValue + "api/user/upcoming/trips"

        let header:HTTPHeaders =
            [
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": AppURL.token.getValue
            ]
        
        AF.request(urlString, method: .get, headers: header).responseJSON(completionHandler: { data in
            
            switch data.result {
            case .success(let value as [[String: Any]]):
                self.scheduleList.removeAll()
                value.forEach { v in
                    let theData: ScheduleDataResponse = self.toScheduleResponse(theData: v)
                    self.scheduleList.append(theData)
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

    
    func toScheduleResponse(theData: [String: Any]) -> ScheduleDataResponse {
        
        var serviceTypeData: [String: Any] = [String: Any]()
        if let d: [String: Any] = theData["service_type"] as? [String: Any] {
            serviceTypeData = d
        }
        let serviceType = ScheduleDataServiceType(id: serviceTypeData["id"] as? Int, type: serviceTypeData["type"] as? String, name: serviceTypeData["name"] as? String, providerName: serviceTypeData["provider_name"] as? String, image: serviceTypeData["image"] as? String, mapIcon: serviceTypeData["map_icon"] as? String, capacity: serviceTypeData["capacity"] as? String, fixed: serviceTypeData["fixed"] as? Int, price: serviceTypeData["price"] as? Double, applyAfter1: serviceTypeData["apply_after_1"] as? Int, applyAfter2: serviceTypeData["apply_after_2"] as? Double, applyAfter3: serviceTypeData["apply_after_3"] as? Int, after1_Price: serviceTypeData["after_1_price"] as? Double, after2_Price: serviceTypeData["after_2_price"] as? Double, after3_Price: serviceTypeData["after_3_price"] as? Int, after1_Minute: serviceTypeData["after_1_minute"] as? Int, after2_Minute: serviceTypeData["after_2_minute"] as? Int, after3_Minute: serviceTypeData["after_3_minute"] as? Int, phourfrom: serviceTypeData["phourfrom"] as? String, phourto: serviceTypeData["phourto"] as? String, pextra: serviceTypeData["pextra"] as? String, minute: serviceTypeData["minute"] as? Double, distance: serviceTypeData["distance"] as? Int, calculator: serviceTypeData["calculator"] as? String, serviceTypeDescription: serviceTypeData["description"] as? String, status: serviceTypeData["status"] as? Int)
        
        
        var providerData: [String: Any] = [String: Any]()
        if let d: [String: Any] = theData["provider"] as? [String: Any] {
            providerData = d
        }
        let provider = ScheduleDataProvider(id: providerData["id"] as? Int, firstName: providerData["first_name"] as? String, lastName: providerData["last_name"] as? String, email: providerData["email"] as? String, mobile: providerData["mobile"] as? String, wallet: providerData["wallet"] as? String, avatar: providerData["avatar"] as? String, rating: providerData["rating"] as? String, status: providerData["status"] as? String, fleet: providerData["fleet"] as? Int, latitude: providerData["latitude"] as? Double, longitude: providerData["longitude"] as? Double, otp: providerData["otp"] as? Int, stripeCustID: providerData["stripe_cust_id"] as? String, createdAt: providerData["created_at"] as? String, updatedAt: providerData["updated_at"] as? String, loginBy: providerData["login_by"] as? String)
        
        
        let schedule = ScheduleDataResponse(id: theData["id"] as? Int, bookingID: theData["booking_id"] as? String, userID: theData["user_id"] as? Int, providerID: theData["provider_id"] as? Int, currentProviderID: theData["current_provider_id"] as? Int, serviceTypeID: theData["service_type_id"] as? Int, otp: theData["otp"] as? Int, returntrip: theData["returntrip"] as? Int, status: theData["status"] as? String, cancelledBy: theData["cancelled_by"] as? String, paymentMode: theData["payment_mode"] as? String, paid: theData["paid"] as? Int, distance: theData["distance"] as? Double, amount: theData["amount"] as? Double, specialNote: theData["specialNote"] as? String, sAddress: theData["s_address"] as? String, sLatitude: theData["s_latitude"] as? Double, sLongitude: theData["s_longitude"] as? Double, dAddress: theData["d_address"] as? String, dLatitude: theData["d_latitude"] as? Double, dLongitude: theData["d_longitude"] as? Double, assignedAt: theData["assigned_at"] as? String, scheduleAt: theData["schedule_at"] as? String, userRated: theData["user_rated"] as? Int, providerRated: theData["provider_rated"] as? Int, useWallet: theData["use_wallet"] as? Int, surge: theData["surge"] as? Int, routeKey: theData["route_key"] as? String, createdAt: theData["created_at"] as? String, updatedAt: theData["updated_at"] as? String, isTrack: theData["is_track"] as? String, trackDistance: theData["track_distance"] as? Int, trackLatitude: theData["track_latitude"] as? Int, trackLongitude: theData["track_longitude"] as? Int, staticMap: theData["static_map"] as? String, serviceType: serviceType, provider: provider)
        
        return schedule
    }
    
}





