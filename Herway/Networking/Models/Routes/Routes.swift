//
//  Routes.swift
//  OffSide
//
//  Created by Faizan Ali  on 2020/11/23.
//

import Foundation
import Alamofire


enum Routes: URLRequestBuilder {

    case login(email: String, password: String)
    case register(firstName: String, secondName: String, email: String, password: String, mobile: String)
    case checkLoginNumExist(phone: String)
    case sendBookingRide(s_latitude: String, s_longitude: String, d_latitude: String, d_longitude: String, s_address: String, d_address: String, service_type: String, distance: String, eta_total: String, specialNote: String, use_wallet: String, return_trip: String, payment_mode: String, schedule_date: String?, schedule_time: String? = nil)
    case cancelRide(request_id: String, cancel_reason: String)
    case checkRideStatus(request_id: String)
    case getProfile
    case editProfile(first_name: String, last_name: String, email: String, mobile: String)
    case resetPassword(password: String, password_confirmation: String, id: String)
    case forgetPassword(email: String)
    case changePassword(password: String, password_confirmation: String, old_password: String)
    case logout(id: String)
    case addMoneyToRiderWallet(amount: String)
    case chargeCardForWallet(card_id: String, amount: String)
    case getWalletBallence(card_id: String, amount: String)
    case getCards
    case addCardToRiderAccount(stripe_token: String)
    case changeDefaultCard(card_id: String)
    case deleteCard(card_id: String)
    case getRideHistory
    case getRideDetail(request_id: String)
    case upcomingRides
    case cancelScheduleRide(request_id: String, cancel_reason: String)
    case getWalletHistory
    case coponHistory
    case getSupportInfo
    case getFavoriteLocations
    case updateFavoriteLocations(type: String, latitude: String, longitude: String, address: String)
    case deleteFavoriteLocation(id: String)
    case getTermsAndPrivacyURl
    case rateJob(tripId: String, rating: String, comment: String)
    case getEstimates(s_latitude: String, s_longitude: String, d_latitude: String, d_longitude: String, service_type: String)
    case getTaxiServices(s_latitude: String, s_longitude: String, d_latitude: String, d_longitude: String)
    case getAllDrivers(latitued: String, longitude: String)
    case sendChatMessage(booking_id: String, uid: String, pid: String, message: String, type: String)
    case getChat(requestId: String)
    case payBycard(request_id: String, payment_mode: String, card_id: String)
    case applyPromoCode(promocode: String)
    case calculateTrip(id: String, latitude: String, longitude: String)
    
    internal var path: String {
        switch self {
        case .login:
            return "oauth/token"
        case .register:
            return "api/user/signup"
        case .checkLoginNumExist:
            return "staffloginbyphone"
        case .sendBookingRide:
            return "api/user/send/request"
        case .cancelRide:
            return "api/user/cancel/request"
        case .checkRideStatus:
            return "api/user/request/check"
        case .getProfile:
            return "api/user/details"
        case .editProfile:
            return "api/user/update/profile"
        case .resetPassword:
            return "api/user/reset/password"
        case .forgetPassword:
            return "api/user/forgot/password"
        case .changePassword:
            return "api/user/change/password"
        case .logout:
            return "api/user/logout"
        case .addMoneyToRiderWallet:
            return "api/user/add/money_new"
        case .chargeCardForWallet:
            return "api/user/add/money"
        case .getWalletBallence:
            return "api/user/add/money"
        case .getCards:
            return "/api/user/card"
        case .addCardToRiderAccount:
            return "/api/user/card"
        case .changeDefaultCard:
            return "/api/user/card/set-default"
        case .deleteCard:
            return "/api/user/card/destroy"
        case .getRideHistory:
            return "api/user/trips"
        case .getRideDetail(let request_id):
            return "api/user/trip/details?request_id=\(request_id)"
        case .upcomingRides:
            return "api/user/upcoming/trips"
        case .cancelScheduleRide:
            return "api/user/cancel/request"
        case .getWalletHistory:
            return "api/user/wallet/passbook"
        case .coponHistory:
            return "api/user/promo/passbook"
        case .getSupportInfo:
            return "api/user/help"
        case .getFavoriteLocations:
            return "api/user/location"
        case .updateFavoriteLocations:
            return "api/user/location"
        case .deleteFavoriteLocation:
            return "deletefav"
        case .getTermsAndPrivacyURl:
            return "getconstdata"
        case .rateJob:
            return "api/user/rate/provider"
        case .getEstimates(let s_latitude, let s_longitude, let d_latitude, let d_longitude, let service_type):
            
            return "api/user/estimated/fare?s_latitude=\(s_latitude)&s_longitude=\(s_longitude)&d_latitude=\(d_latitude)&d_longitude=\(d_longitude)&service_type=\(service_type)"
        case .getTaxiServices:
            return "api/user/servicesWithEstimate"
        case .getAllDrivers(let latitued, let longitude):
            return "api/user/show/providers?latitude=\(latitued)&longitude=\(longitude)"
        case .sendChatMessage:
            return "addchat"
        case .getChat(let reqId):
            return "getchat/\(reqId)"
        case .payBycard:
            return "api/user/payment"
        case .applyPromoCode:
            return "api/user/promocode/add"
        case .calculateTrip(let id, _, _):
            return "api/provider/trip/\(id)/calculate"
        }
    }
    
    internal var theRouteType: Routes {
        return self
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = Parameters.init()
        switch self {
        
        case .login(let email, let password):
            params["device_type"] = "ios"
            params["device_id"] = Constants.deviceId
            params["device_token"] = Constants.Static.notificationToken
            params["username"] = email
            params["password"] = password
            params["grant_type"] = "password"
            params["client_id"] = "12"
            params["client_secret"] = "Vlpw7zY8wRTCxBBZtf0jEvSMaNa2WKYTpQBLub3f"
        
        case .register(let firstName, let secondName, let email, let password, let mobile):
            params["first_name"] = firstName
            params["last_name"] = secondName
            params["email"] = email
            params["password"] = password
            params["mobile"] = mobile
            params["device_type"] = "ios"
            params["device_id"] = Constants.deviceId
            params["device_token"] = Constants.Static.notificationToken
            params["login_by"] = "manual"
            
        case .checkLoginNumExist(let phone):
            params["phone"] = phone
            
        case .sendBookingRide(let s_latitude, let s_longitude, let d_latitude, let d_longitude, let s_address, let d_address, let service_type, let distance, let eta_total, let specialNote, let use_wallet, let return_trip, let payment_mode, let schedule_date, let schedule_time):
            params["s_latitude"] = s_latitude
            params["s_longitude"] = s_longitude
            params["d_latitude"] = d_latitude
            params["d_longitude"] = d_longitude
            params["s_address"] = s_address
            params["d_address"] = d_address
            params["service_type"] = service_type
            params["distance"] = "4" // distance
            params["eta_total"] = "45"// eta_total
            params["specialNote"] = ""// specialNote
            params["use_wallet"] = use_wallet
            params["return_trip"] = "0"// return_trip
            params["payment_mode"] = "CASH"// payment_mode
            
            if schedule_date != nil {
                params["schedule_date"] = schedule_date
            }
            if schedule_time != nil {
                params["schedule_time"] = schedule_time
            }
            
        case .cancelRide(let request_id, let cancel_reason):
            params["request_id"] = request_id
            params["cancel_reason"] = cancel_reason
            
        case .checkRideStatus(let request_id):
            params["request_id"] = request_id
        case .getProfile:
            params["device_type"] = "ios"
            params["device_token"] = Constants.Static.notificationToken
            break
            
        case .editProfile(let first_name, let last_name, let email, let mobile):
            params["first_name"] = first_name
            params["last_name"] = last_name
            params["email"] = email
            params["mobile"] = mobile
            
        case .resetPassword(let password, let password_confirmation, let id):
            params["password"] = password
            params["password_confirmation"] = password_confirmation
            params["id"] = id
            
        case .forgetPassword(let email):
            params["email"] = email
            
        case .changePassword(let password, let password_confirmation, let old_password):
            params["password"] = password
            params["password_confirmation"] = password_confirmation
            params["old_password"] = old_password
            
        case .logout(let id):
            params["id"] = id
            
        case .addMoneyToRiderWallet(let amount):
            params["amount"] = amount
            
        case .chargeCardForWallet(let card_id, let amount):
            params["card_id"] = card_id
            params["amount"] = amount
            
        case .getWalletBallence(let card_id, let amount):
            params["card_id"] = card_id
            params["amount"] = amount
            
        case .getCards:
            break
            
        case .addCardToRiderAccount(let stripe_token):
            params["stripe_token"] = stripe_token
            
        case .changeDefaultCard(let card_id):
            params["card_id"] = card_id
            
        case .deleteCard(let card_id):
            params["card_id"] = card_id
            
        case .getRideHistory:
            break
        case .getRideDetail:
            break
        case .upcomingRides:
            break
        case .cancelScheduleRide(let request_id, let cancel_reason):
            params["request_id"] = request_id
            params["cancel_reason"] = cancel_reason
            
        case .getWalletHistory:
            break
        case .coponHistory:
            break
        case .getSupportInfo:
            break
        case .getFavoriteLocations:
            break
        case .updateFavoriteLocations(let type, let latitude, let longitude, let address):
            params["type"] = type
            params["latitude"] = latitude
            params["longitude"] = longitude
            params["address"] = address
            
        case .deleteFavoriteLocation(let id):
            params["id"] = id
            
        case .getTermsAndPrivacyURl:
            break
        case .rateJob(let reqId, let rating, let comment):
            params["rating"] = rating
            params["comment"] = comment
            params["request_id"] = reqId
            
        case .getEstimates:
            break
//            params["s_latitude"] = s_latitude
//            params["s_longitude"] = s_longitude
//            params["d_latitude"] = d_latitude
//            params["d_longitude"] = d_longitude
//            params["service_type"] = service_type
            
        case .getTaxiServices(let s_latitude, let s_longitude, let d_latitude, let d_longitude):
            params["s_latitude"] = s_latitude
            params["s_longitude"] = s_longitude
            params["d_latitude"] = d_latitude
            params["d_longitude"] = d_longitude
            break
            
        case .getAllDrivers:
            break
        case .sendChatMessage(let booking_id, let uid, let pid, let message, let type):
            params["booking_id"] = booking_id
            params["uid"] = uid
            params["pid"] = pid
            params["message"] = message
            params["type"] = type
            
        case .getChat:
            break
            
        case .payBycard(let request_id, let payment_mode, let card_id):
            params["request_id"] = request_id
            params["payment_mode"] = payment_mode
            params["card_id"] = card_id
            
        case .applyPromoCode(let promocode):
            params["promocode"] = promocode
            
        case .calculateTrip(let id, let latitude, let longitude):
            params["id"] = id
            params["latitude"] = latitude
            params["longitude"] = longitude
            
        }
        
        print(params)
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .checkRideStatus, .getProfile, .getWalletBallence, .getCards, .getRideHistory, .getRideDetail, .upcomingRides, .getWalletHistory, .coponHistory, .getSupportInfo, .getFavoriteLocations, .getTermsAndPrivacyURl, .getEstimates, .getTaxiServices, .getAllDrivers, .getChat:
            return .get
        case .deleteCard:
            return .delete
        default:
            return .post
        }
    }
    // MARK: - HTTPHeaders
    internal var headers: HTTPHeaders {
        let header:HTTPHeaders =
            [
                "X-Requested-With": "XMLHttpRequest",
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer \(UserSession.shared.user?.token ?? "")"
            ]
        switch self {
        default:
            return header
        }
    }
    
}


//eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImQ1NzNlYjBiYjI2OGE1NzljMmVjODJjMjRlZmE5YjU4MmI1MjIyOTQ1MTI4MDJlYmFmMjcyYmI4N2EwMjQ1MDg4ZGM0N2U4ZGMxMWYzNGMzIn0.eyJhdWQiOiIxMiIsImp0aSI6ImQ1NzNlYjBiYjI2OGE1NzljMmVjODJjMjRlZmE5YjU4MmI1MjIyOTQ1MTI4MDJlYmFmMjcyYmI4N2EwMjQ1MDg4ZGM0N2U4ZGMxMWYzNGMzIiwiaWF0IjoxNjUxMTI4NTgxLCJuYmYiOjE2NTExMjg1ODEsImV4cCI6MTY1MjQyNDU4MCwic3ViIjoiMzY2Iiwic2NvcGVzIjpbXX0.dfc2BCyE8xKtbmZmNScvgt-RlwNgrXxitIlACU0q9c6r6talRomiGYZDxICGjPdPKwxqKgrJDxe1QKJT6yxvBt-CmpVRg-chJPOOSr7iixIlZrxjQK7ZEhVC4cfTuBUjvJH3ZBGVGkmwWrtbPEiNns2o10WSMPdwT2f92LKEo3iNdi7b3lSQ5vsbXu_WYWfmV0sKXJGKUHZuP4Cn51HaoGN7Ml8Z5ssoHrij09i6XC3VxnZvxXiQlI6nvGdPxe8xkB29ItJnxb-zHtIH1_aQwpYqrAwWS5rj-mMfymVhUWcTRpXH96U5z0Pr1aAdt6Lr04YhWbI9Un-XOCMzOOMQLr2eqsrS6KC8sL9Pkx9Hjkh1ROE6fqScX6gmkA7B08bnZYd_flbEs_3r8OAGGr4jtMJKBJJYX76M7HEf2fOZoxNBaaCRXGQDNPz_K4L2dTkix_BNbUUkOlLG4p-Zebu7Qe9CZPSTZzUiyfpWWj6-RinY96AVxwAfxInmgXr4AtOIbTLBxjQBlQWaBUOzQQ-iRNmQa1ktd2taNg1fOR8Ibah3lLg29IzkPlRK05gEKFX5H9BgCJVtnyt5NK0T5LZhjqVHGVix9UTEJthnSGtvukl9yzIfeGWxoe1a9RDciJ7HVj7Bt_6Mk5Fqz3Zv91YywbCcAnU2K_PmNcAb_BmcW1g
