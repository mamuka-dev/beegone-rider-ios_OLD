//
//  HomeVCHelpingFunc.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/5/28.
//
import Foundation
import CoreLocation
import Alamofire
import GoogleMaps
import GooglePlacesSearchController

extension HomeVC {
    
    func bookTaxi(block: @escaping (String?, Bool)-> Void){
        
        if destinationLat == nil || destinationLng == nil {
            Utility.showLoaf(message: R.string.localizable.kindlySelectDestination(), state: .error)

        } else {
            let serviceid = self.selectedService?.id ?? 0
            UserDefaults.standard.setRideRequestId(ID: "")
            ActivityIndicator.shared.showLoadingIndicator()
            Routes.sendBookingRide(s_latitude: "\(currentLat)", s_longitude: "\(currentLng)", d_latitude: "\(destinationLat!)", d_longitude: "\(destinationLng!)", s_address: self.lblPickup.text ?? "", d_address: self.lblDestination.text ?? "", service_type: String(serviceid), distance: "4", eta_total: "45", specialNote: "", use_wallet: self.useWalletAmount ? "1" : "0", return_trip: "0", payment_mode: "CASH", schedule_date: self.selectedScheduleDate, schedule_time: self.selectedScheduleTime).send(RideRequestResponse.self) { (result) in
                
                ActivityIndicator.shared.hideLoadingIndicator()
                switch result {
                case .failure(let error):
                    block(error.localizedDescription, false)
                    print(error.localizedDescription)
                case .success(let response):
                    
                    if let id = response.requestID {
                        UserDefaults.standard.setRideRequestId(ID: String(id))
                        block(nil, true)

                    } else if let msg = response.message {
                        block(msg, false)

                    }
                    block(nil, false)
                }
            }
        }
    }
    
    func getProfileData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.getProfile.send(ProfileResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                
                self.profileData = response
                UserSession.shared.user?.id = self.profileData?.id
                UserSession.shared.user?.firstName = self.profileData?.firstName
                UserSession.shared.user?.lastName = self.profileData?.lastName
                UserSession.shared.user?.photo = self.profileData?.picture
                UserSession.shared.user?.wallet = String(self.profileData?.walletBalance ?? 0)
                UserSession.shared.user?.name = "\(self.profileData?.firstName ?? "") \(self.profileData?.lastName ?? "")"
            }
        }
        }
    }
    
    func cancelTheRide() {
        
        let reqId = UserDefaults.standard.getRideRequestId()
        if reqId != "" {
            
            ActivityIndicator.shared.showLoadingIndicator()
            Routes.cancelRide(request_id: reqId, cancel_reason: "Reason") .send(normalResponse.self) { (result) in
                
                ActivityIndicator.shared.hideLoadingIndicator()
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let response):
                    
                    UserDefaults.standard.setHomeState(state: .search)
                    self.setupStates()
                    if let msg = response.message {
                        Utility.showLoaf(message: msg, state: .success)
                    }
                }
            }
        }
    }
    
    func getFavoriteLocations() {
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.getFavoriteLocations.send(FavoriteLocationResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                
                if let home = response.home {
                    if home.count > 0 {
                        UserSession.shared.user?.homeAddress = home.last
                    }
                }
                if let work = response.work {
                    if work.count > 0 {
                        UserSession.shared.user?.workAddress = work.last
                    }
                }
            }
        }
    }
    
    
    func checkForRideRequest() {
        
        
        let reqId = UserDefaults.standard.getRideRequestId()
        if reqId == "" { return }
        
        Routes.checkRideStatus(request_id: reqId).send(RideDetailResponse.self) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                
                print("")
                if response.data?.count ?? 0 > 0 {
                    let topRequest = response.data![0]
                    if let id = topRequest.id {
                        UserDefaults.standard.setRideRequestId(ID: String(id))
                    }
                    
                    self.currentRequest = topRequest
                    if self.shouldUpdateData() {
                        self.handleRequest()
                    }

                } else {
                    self.currentRequest = nil
                    if self.currentState != .initial && self.currentState != .search {
                        UserDefaults.standard.setHomeState(state: .initial)
                        self.setupStates()
                    }

                }
            }
        }
    }
    
    func shouldUpdateData() -> Bool {
        
        guard let status = self.currentRequest?.status else { return true }


        if status == "SEARCHING" && self.currentState == .findingRide {
            return false

        } else if status == "STARTED" && self.currentState == .acceptedRide  {
            return false

        } else if status == "ARRIVED" && self.currentState == .acceptedRide {
            return false

        } else if status == "PICKEDUP" && self.currentState == .rideInProgress {
            return false

        } else if status == "DROPPED" && self.currentState == .showInvoice {
            return false

        } else if status == "COMPLETED" && self.currentState == .rating {
            return false

        }
        return true
    }
    
    func handleRequest() {
        
        guard let status = self.currentRequest?.status else { return }

        if status == "SEARCHING" {
            UserDefaults.standard.setHomeState(state: .findingRide)
            self.setupStates()

        } else if status == "STARTED" {
            UserDefaults.standard.setHomeState(state: .acceptedRide)
            self.setupStates()
            self.setupMaps()

        } else if status == "ARRIVED" {
            UserDefaults.standard.setHomeState(state: .acceptedRide)
            self.setupStates()
            self.setupMaps()

        } else if status == "PICKEDUP" {
            UserDefaults.standard.setHomeState(state: .rideInProgress)
            self.setupStates()
            self.setupMaps()

        } else if status == "DROPPED" {
            UserDefaults.standard.setHomeState(state: .showInvoice)
            self.setupStates()
            self.googleMapView.clear()

        } else if status == "COMPLETED" {
            UserDefaults.standard.setHomeState(state: .rating)
            self.setupStates()
            self.googleMapView.clear()

        }
    }
    
    
    func rateTheRide(rating: Int, comment: String) {
        
        guard let requestId = self.currentRequest?.id else { return }
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.rateJob(tripId: "\(requestId)", rating: "\(rating)", comment: comment).send(normalResponse.self) { (result) in
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(_):
                break
            }
        }
    }
    
    func showEstimatedPrice() {
        self.getEstimatedAmount { msg, success in
            self.showPopupState = .estimatedPrice
            self.setupStates()
        }
    }
    
    func showServiceDetailView() {
        self.showPopupState = .serviceDetail
        self.setupStates()
    }
    
    func showPromoCodeView() {
        self.showPopupState = .promo
        self.setupStates()
    }
    
    func showSchedulePopUp() {
        self.showPopupState = .schedulePicker
        self.setupStates()
    }
    
    func removePopups() {
        self.showPopupState = .none
        self.setupStates()
    }
    
    func getEstimatedAmount(block: @escaping (String?, Bool)-> Void){
        
        
        let urlString = AppURL.baseURL1.rawValue + "api/user/estimated/fare?s_latitude=\(self.currentLat)&s_longitude=\(self.currentLng)&d_latitude=\(self.destinationLat ?? 33.4)&d_longitude=\(self.destinationLng ?? 73.5)&service_type=\(self.selectedService?.id ?? 1)"

            let header:HTTPHeaders =
                [
                    "X-Requested-With": "XMLHttpRequest",
                    "Authorization": AppURL.token.getValue
                ]
            
        ActivityIndicator.shared.showLoadingIndicator()
            AF.request(urlString, method: .get, headers: header).responseJSON(completionHandler: { data in
                ActivityIndicator.shared.hideLoadingIndicator()
                switch data.result {
                case .success(let value as [String: Any]):
                    
                    let theData = self.toEstimatesModel(theData: value)
                    self.estimatedPrice = theData
                    block(nil, true)
                case .failure(let error):
                    print(error.localizedDescription)
                    block(error.localizedDescription, false)
                default:
                    print("")
                    block(nil, false)
                }
                
            })
        
//        ActivityIndicator.shared.showLoadingIndicator()
//        Routes.getEstimates(s_latitude: String(self.currentLat), s_longitude: String(self.currentLng), d_latitude: String(self.destinationLat ?? 33.45), d_longitude: String(self.destinationLng ?? 73.44), service_type: "\(self.selectedService?.id ?? 1)").send(EstimatedPriceResponse.self) { (result) in
//
//            ActivityIndicator.shared.hideLoadingIndicator()
//            switch result {
//            case .failure(let error):
//                block(error.localizedDescription, false)
//                print(error.localizedDescription)
//            case .success(let response):
//
//                self.estimatedPrice = response
//                block(nil, true)
//            }
//        }
    }
    
    func toEstimatesModel(theData: [String: Any]) -> EstimatedPriceResponse {
        
        let data = EstimatedPriceResponse(estimatedFare: theData["estimated_fare"] as? Double, distance: theData["distance"] as? Double, time: theData["time"] as? String, roundOff: theData["round_off"] as? Double, total: theData["total"] as? Double, eta_total: theData["eta_total"] as? Double)
        
        return data
    }
    
    func updateServiceType(for type: String) {
        
        let services = self.taxiServices.filter({ s in
            s.type == type
        })
        
        if services.count > 0 {
            if self.selectedService?.type != services[0].type {
                self.selectedService = services[0]
//                self.setupStates()
            }
        }
    }
    
    func updateService(for id: Int) {
        
        let service = self.taxiServices.first (where: { s in
            s.id == id
        })
        
        if service != nil {
            if self.selectedService?.id != service!.id {
                self.selectedService = service!
//                self.setupStates()
            }
            
        }
    }
    
    func getRideServices(block: @escaping (String?, Bool)-> Void){

        ActivityIndicator.shared.showLoadingIndicator()
        
        let urlString = AppURL.baseURL1.rawValue + "api/user/servicesWithEstimate"

        let header:HTTPHeaders =
            [
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": AppURL.token.getValue
            ]
        
        let parameters: [String: Any] = ["s_latitude": "\(self.currentLat)", "s_longitude": "\(self.currentLng)", "d_latitude": "\(self.destinationLat ?? 33.4)", "d_longitude": "\(self.destinationLng ?? 73.4)"]
        
        AF.request(urlString, method: .get, parameters: parameters, headers: header).responseJSON(completionHandler: { data in
            
            switch data.result {
            case .success(let value as [[String: Any]]):
                self.taxiServices.removeAll()
                value.forEach { v in
                    let theData: TaxiServicesResponse = self.toServiceResponse(data: v)
                    self.taxiServices.append(theData)
                }
                if self.taxiServices.count > 0 {
                    self.selectedService = self.taxiServices[0]
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

    
    func toServiceResponse(data: [String: Any]) -> TaxiServicesResponse {
        
        let service = TaxiServicesResponse(id: data["id"] as? Int, type: data["type"] as? String, name: data["name"] as? String, image: data["image"] as? String, capacity: data["capacity"] as? String, price: data["eta_total"] as? Double, calculator: data["calculator"] as? String, description: data["description"] as? String, fixed: data["fixed"] as? Double, eta_total: data["eta_total"] as? Double)
        
        return service
    }
 
    
    func getConstData(block: @escaping (String?, Bool)-> Void){
        
        Routes.getTermsAndPrivacyURl.send(RequiredURlsResponse.self) { (result) in

            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if let data = response.data {
                    
                    let c = data.first { d in
                        d.key == "currency"
                    }
                    if c != nil {
                        CURRENCY = c?.value ?? "USD"
                    }
                    
                    block(nil, true)
                    return
                }
                
                block(nil, false)
            }
        }
    }
    
    
    ///MARK: Nearby Drivers
    func getNearbyDrivers() {
            
        let urlString = AppURL.baseURL1.rawValue + "api/user/show/providers?latitude=\(self.currentLat)&longitude=\(self.currentLng)"

            let header:HTTPHeaders =
                [
                    "X-Requested-With": "XMLHttpRequest",
                    "Authorization": AppURL.token.getValue
                ]
            
            AF.request(urlString, method: .get, headers: header).responseJSON(completionHandler: { data in
                
                switch data.result {
                case .success(let value as [[String: Any]]):
                    
                    self.nearDrivers.removeAll()
                    value.forEach { dics in
                        
                        let theData = self.toNearbyDrivers(theData: dics)
                        self.nearDrivers.append(theData)
                    }
                    self.setupNearbyDriversOnMap()
                    print(self.nearDrivers)
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    print("")
                }
                
            })
    }
    
    func toNearbyDrivers(theData: [String: Any]) -> NearDriversResponse {
        
        let data = NearDriversResponse(id: theData["id"] as? Int, latitude: theData["latitude"] as? Double, longitude: theData["longitude"] as? Double, avatar: theData["avatar"] as? String)
        
        return data
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
    
    
    
    func payByCard(cardId: String, block: @escaping (String?, Bool)-> Void){
        
        guard let requestID = self.currentRequest?.id else {
            block(SOMETHING_WENT_WRONG_TEXT, false)
            return
        }
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.payBycard(request_id: String(requestID), payment_mode: "CARD", card_id: cardId).send(normalResponse.self) { (result) in

            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(_):
                block(nil, true)
            }
        }
    }
    
    
    func applyPromoCode(promoCode: String, block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.applyPromoCode(promocode: promoCode).send(promoCodeResponse.self) { (result) in

            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
            
                self.promoCode = nil
                if response.amount != nil {
                    self.promoCode = "\(promoCode) \(Int(response.amount ?? 0))%"
                    block(response.message, true)
                    return
                }
                
                block(response.message, false)
            }
        }
    }
    
    
    func calculateTrip() {
        
        guard let requestID = self.currentRequest?.id else {
            return
        }
        
        guard let status = self.currentRequest?.status else { return }
        
        if (status != "RATE" && status != "COMPLETED") {
            
            Routes.calculateTrip(id: String(requestID), latitude: "\(self.currentLat)", longitude: "\(self.currentLng)").send(normalResponseWithMsg.self) { (result) in
            
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(_):
                    
                    print("Abc")
                    break
                }
            }
        }
    }
    
    
}
