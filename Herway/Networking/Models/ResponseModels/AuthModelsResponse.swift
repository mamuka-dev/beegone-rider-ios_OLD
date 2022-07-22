//
//  AuthModelsResponse.swift
//  OffSide
//
//  Created by Faizan Ali  on 2020/11/23.
//

import Foundation

struct LoginModelResponse: Codable, CodableInit {
    let status: Int?
    let message: String?
    let data: LoginModelResponseData?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "response"
    }
}

struct LoginModelResponseData: Codable, CodableInit {
    var id: Int?
    var token, name, firstName, lastName, email: String?
    var photo: String?
    var wallet: String?
    var userType: Int?
    var homeAddress: FavoriteLocationData?
    var workAddress: FavoriteLocationData?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case token = "access_token"
        case name = "name"
        case email = "email"
        case photo = "photo"
        case userType = "user_role"
        case wallet
        case firstName
        case lastName
        case homeAddress
        case workAddress
    }
}

struct verificationResponse:Codable, CodableInit {
    let message:String?
    let request_id: Int?
    let current_provider: Int?
}

struct createInvoiceResponse:Codable, CodableInit {
    let status: Int?
    let message: String?
}

struct normalResponse:Codable, CodableInit {
    let status: Int?
    let message: String?
}

struct normalResponseWithMsg:Codable, CodableInit {
    let message: String?
}

struct promoCodeResponse:Codable, CodableInit {
    let amount: Double?
    let message: String?
}

// MARK: - Welcome
struct ForgetPassResponse: Codable, CodableInit {
    let message: String?
    let provider: ForgetPassResponseData?
    
    enum CodingKeys: String, CodingKey {
        case message
        case provider = "user"
        
    }
}

// MARK: - Provider
struct ForgetPassResponseData: Codable, CodableInit {
        let id: Int?
        let firstName, lastName, paymentMode, email: String?
        let mobile, picture, deviceToken, deviceID: String?
        let deviceType, loginBy: String?
        let walletBalance: Int?
        let rating: String?
        let otp: Int?
        let updatedAt: String?

        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case paymentMode = "payment_mode"
            case email, mobile, picture
            case deviceToken = "device_token"
            case deviceID = "device_id"
            case deviceType = "device_type"
            case loginBy = "login_by"
            case walletBalance = "wallet_balance"
            case rating, otp
            case updatedAt = "updated_at"
        }
}


// MARK: - LocationResponse
struct CheckForEmailResponse: Codable, CodableInit {
    let error: Bool?
    let message: String?
    let user: CheckForEmailResponseData?
}

// MARK: - User
struct CheckForEmailResponseData: Codable, CodableInit {
    let email: String?
}


// MARK: - Welcome
struct RegisterResponse: Codable, CodableInit {
    let email, firstName, lastName, mobile: String?
    let updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case mobile
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

// MARK: - Welcome
struct ProfileResponse: Codable, CodableInit {
    let id: Int?
    var firstName, lastName, paymentMode, email: String?
    let mobile: String?
    let picture: String?
    let deviceToken, deviceID, deviceType, loginBy: String?
    let walletBalance: Int?
    let rating: String?
    let otp: Int?
    let updatedAt, currency, sos: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case paymentMode = "payment_mode"
        case email, mobile, picture
        case deviceToken = "device_token"
        case deviceID = "device_id"
        case deviceType = "device_type"
        case loginBy = "login_by"
        case walletBalance = "wallet_balance"
        case rating, otp
        case updatedAt = "updated_at"
        case currency, sos
    }
}


// MARK: - Welcome
struct FavoriteLocationResponse: Codable, CodableInit {
    let home, work, others, recent: [FavoriteLocationData]?
}

// MARK: - Home
struct FavoriteLocationData: Codable, CodableInit {
    let id, userID: Int?
    let address: String?
    let latitude, longitude: Double?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case address, latitude, longitude, type
    }
}


struct CreditCardDetail: Codable, CodableInit {
    let id, userID: Int?
    let lastFour, cardID, token, brand: String?
    let type: String?
    let isDefault: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case lastFour = "last_four"
        case cardID = "card_id"
        case token, brand, type
        case isDefault = "is_default"
    }
}


// MARK: - LocationResponseElement
struct RideHistoryResponse: Codable, CodableInit {
    let id: Int?
    let bookingID: String?
    let userID, providerID, currentProviderID, serviceTypeID: Int?
    let otp, returntrip: Int?
    let status: String?
    let paymentMode: String?
    let paid: Int?
    let distance, amount: Double?
    let specialNote: String?
    let sAddress: String?
    let sLatitude, sLongitude: Double?
    let dAddress: String?
    let dLatitude, dLongitude: Double?
    let assignedAt: String?
    let scheduleAt: String?
    let startedAt, finishedAt: String?
    let userRated, providerRated, useWallet, surge: Int?
    let routeKey: String?
    let createdAt, updatedAt: String?
    let isTrack: String?
    let travelTime: String?
    let trackDistance, trackLatitude, trackLongitude: Int?
    let staticMap: String?
    let payment: RideHistoryPayment?
    let serviceType: RideHistoryServiceType?
    let user: RideHistoryUser?
    let provider: RideHistoryProvider?
    let rating: RideHistoryRating?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case userID = "user_id"
        case providerID = "provider_id"
        case currentProviderID = "current_provider_id"
        case serviceTypeID = "service_type_id"
        case otp, returntrip, status
        case paymentMode = "payment_mode"
        case paid, distance, amount, specialNote
        case sAddress = "s_address"
        case sLatitude = "s_latitude"
        case sLongitude = "s_longitude"
        case dAddress = "d_address"
        case dLatitude = "d_latitude"
        case dLongitude = "d_longitude"
        case assignedAt = "assigned_at"
        case scheduleAt = "schedule_at"
        case startedAt = "started_at"
        case finishedAt = "finished_at"
        case userRated = "user_rated"
        case providerRated = "provider_rated"
        case useWallet = "use_wallet"
        case surge
        case routeKey = "route_key"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isTrack = "is_track"
        case travelTime = "travel_time"
        case trackDistance = "track_distance"
        case trackLatitude = "track_latitude"
        case trackLongitude = "track_longitude"
        case staticMap = "static_map"
        case payment
        case serviceType = "service_type"
        case user
        case provider
        case rating
    }
}

// MARK: - Payment
struct RideHistoryPayment: Codable, CodableInit {
    let id, requestID: Int?
    let fixed, distance: Double?
    let tPrice: Double?
    let commision: Double?
    let discount: Double?
    let tax: Double?
    let wallet, surge: Double?
    let total, payable, providerCommission: Double?
    let providerCommissionPaid: String?
    let providerPay: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case requestID = "request_id"
        case fixed, distance
        case tPrice = "t_price"
        case commision, discount, tax, wallet, surge, total, payable
        case providerCommission = "provider_commission"
        case providerCommissionPaid = "provider_commission_paid"
        case providerPay = "provider_pay"
    }
}

struct RideHistoryServiceType: Codable, CodableInit {
    let id: Int?
    let type, name: String?
    let provider_name: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case name
        case provider_name
        case image
    }
}

struct RideHistoryUser: Codable, CodableInit {
    let id: Int?
    let firstName, lastName: String?
    let updatedAt: String?
    let picture: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case updatedAt = "updated_at"
        case picture = "picture"
    }
}

struct RideHistoryProvider: Codable, CodableInit {
    let id: Int?
    let firstName, lastName: String?
    let updatedAt: String?
    let picture: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case updatedAt = "updated_at"
        case picture = "avatar"
        case rating
    }
}

struct RideHistoryRating: Codable, CodableInit {
    let id: Int?
    let userRating, providerRating: Int?
    let userComments: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userRating = "user_rating"
        case providerRating = "provider_rating"
        case userComments = "user_comment"
    }
}


// MARK: - WelcomeElement
struct WalletHistoryResponse: Codable, CodableInit {
    let id, userID, amount: Int?
    let status, via, type, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case amount, status, via, type
        case createdAt = "created_at"
    }
}


struct SupportResponse: Codable, CodableInit {
    let contactNumber, contactEmail: String?

    enum CodingKeys: String, CodingKey {
        case contactNumber = "contact_number"
        case contactEmail = "contact_email"
    }
}


// MARK: - Welcome
struct RequiredURlsResponse: Codable, CodableInit {
    let data: [RequiredURlsResponseData]?
}

// MARK: - Datum
struct RequiredURlsResponseData: Codable, CodableInit {
    let key: String?
    let value: String?
}


// MARK: - Welcome
struct RideRequestResponse: Codable, CodableInit {
    let message: String?
    let requestID, currentProvider: Int?

    enum CodingKeys: String, CodingKey {
        case message
        case requestID = "request_id"
        case currentProvider = "current_provider"
    }
}


// MARK: - Welcome
struct RideDetailResponse: Codable, CodableInit {
    let data: [RideDetailResponseData]?
}

// MARK: - Datum
struct RideDetailResponseDataOne: Codable, CodableInit {
    let id: Int?
    let bookingID: String?
    let userID, providerID, currentProviderID, serviceTypeID: Double?
    let otp, returntrip: Int?
    let status, cancelledBy: String?
    let paymentMode: String?
    let paid, distance, amount: Double?
    let travel_time: String?
    let specialNote, sAddress: String?
    let sLatitude, sLongitude: Double?
    let dAddress: String?
    let dLatitude, dLongitude: Double?
    let assignedAt: String?
    let userRated, providerRated, useWallet, surge: Double?
    let routeKey: String?
    let createdAt, updatedAt, isTrack: String?
    let trackDistance, trackLatitude, trackLongitude: Double?
    let user: RideUserResponse?
    let serviceType: RideServiceType?
//    let provider: RideProviderResponse?
//    let providerService: RideProviderServiceResponse?
//    let payment: RideHistoryPayment?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case userID = "user_id"
        case providerID = "provider_id"
        case currentProviderID = "current_provider_id"
        case serviceTypeID = "service_type_id"
        case otp, returntrip, status
        case cancelledBy = "cancelled_by"
        case paymentMode = "payment_mode"
        case travel_time
        case paid, distance, amount
        case specialNote
        case sAddress = "s_address"
        case sLatitude = "s_latitude"
        case sLongitude = "s_longitude"
        case dAddress = "d_address"
        case dLatitude = "d_latitude"
        case dLongitude = "d_longitude"
        case assignedAt = "assigned_at"
        case userRated = "user_rated"
        case providerRated = "provider_rated"
        case useWallet = "use_wallet"
        case surge
        case routeKey = "route_key"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isTrack = "is_track"
        case trackDistance = "track_distance"
        case trackLatitude = "track_latitude"
        case trackLongitude = "track_longitude"
        case user
        case serviceType = "service_type"
//        case provider
//        case providerService = "provider_service"
//        case payment = "payment"
    }
}

// MARK: - Datum
struct RideDetailResponseData: Codable, CodableInit {
    let id: Int?
    let bookingID: String?
    let userID, providerID, serviceTypeID: Double?
    let otp: Int?
    let status: String?
    let paymentMode: String?
    let distance: Double?
    let travel_time: String?
    let sAddress: String?
//    let sLatitude, sLongitude: Double?
    let dAddress: String?
    let dLatitude, dLongitude: Double?
//    let assignedAt: String?
//    let userRated, providerRated, useWallet, surge: Double?
//    let routeKey: String?
//    let createdAt, updatedAt, isTrack: String?
//    let trackDistance, trackLatitude, trackLongitude: Double?
    let user: RideUserResponse?
    let serviceType: RideServiceType?
    let provider: RideProviderResponse?
    let providerService: RideProviderServiceResponse?
    let payment: RideHistoryPayment?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case userID = "user_id"
        case providerID = "provider_id"
        case otp = "otp"
//        case currentProviderID = "current_provider_id"
        case serviceTypeID = "service_type_id"
        case status
//        case cancelledBy = "cancelled_by"
        case paymentMode = "payment_mode"
        case travel_time
        case distance
//        case specialNote
        case sAddress = "s_address"
//        case sLatitude = "s_latitude"
//        case sLongitude = "s_longitude"
        case dAddress = "d_address"
        case dLatitude = "d_latitude"
        case dLongitude = "d_longitude"
//        case assignedAt = "assigned_at"
//        case userRated = "user_rated"
//        case providerRated = "provider_rated"
//        case useWallet = "use_wallet"
//        case surge
//        case routeKey = "route_key"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case isTrack = "is_track"
//        case trackDistance = "track_distance"
//        case trackLatitude = "track_latitude"
//        case trackLongitude = "track_longitude"
        case user
        case serviceType = "service_type"
        case provider
        case providerService = "provider_service"
        case payment = "payment"
    }
}



struct RideProviderServiceResponse: Codable, CodableInit {
    let id: Int?
    let service_number: String?
    let service_model: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case service_number
        case service_model
    }
}

// MARK: - ServiceType
struct RideServiceType: Codable, CodableInit {
    let id: Int?
//    let type, name, providerName: String?
    let image: String
//    let mapIcon: String?
//    let capacity: String?
//    let fixed: Double?
//    let price: Double?
//    let applyAfter1: Double?
//    let applyAfter2: Double?
//    let applyAfter3: Double?
//    let after1_Price, after2_Price: Double?
//    let after3_Price, after1_Minute, after2_Minute, after3_Minute: Double?
//    let phourfrom, phourto, pextra: String?
//    let minute: Double?
//    let distance: Double?
//    let calculator: String?
//    let status: Int?

    enum CodingKeys: String, CodingKey {
         case id
//         case type, name
//        case providerName = "provider_name"
        case image
//        case mapIcon = "map_icon"
//        case fixed
//        case applyAfter1 = "apply_after_1"
//        case applyAfter2 = "apply_after_2"
//        case applyAfter3 = "apply_after_3"
//        case after1_Price = "after_1_price"
//        case after2_Price = "after_2_price"
//        case after3_Price = "after_3_price"
//        case after1_Minute = "after_1_minute"
//        case after2_Minute = "after_2_minute"
//        case after3_Minute = "after_3_minute"
//        case phourfrom, phourto, pextra
//        case minute, distance, calculator
//        case serviceTypeDescription = "description"
//        case status
    }
}

// MARK: - User
struct RideUserResponse: Codable, CodableInit {
    let id: Int?
    let firstName, lastName, paymentMode, email: String?
    let mobile, picture, deviceToken, deviceID: String?
    let deviceType, loginBy: String?
    let stripeCustID: String?
    let walletBalance: Int?
    let rating: String?
    let otp: Int?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case paymentMode = "payment_mode"
        case email, mobile, picture
        case deviceToken = "device_token"
        case deviceID = "device_id"
        case deviceType = "device_type"
        case loginBy = "login_by"
        case stripeCustID = "stripe_cust_id"
        case walletBalance = "wallet_balance"
        case rating, otp
        case updatedAt = "updated_at"
    }
}


// MARK: - Welcome
struct RideProviderResponse: Codable, CodableInit {
    let id: Int?
    let firstName, lastName, email, mobile: String?
    let avatar, rating: String?
    let fleet: Double?
    let latitude, longitude: Double?
    let otp: Int?
//    let stripeCustID, createdAt, updatedAt, loginBy: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, mobile, avatar, rating, fleet, latitude, longitude, otp
//        case stripeCustID = "stripe_cust_id"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case loginBy = "login_by"
    }
}


// MARK: - WelcomeElement
struct CouponHistoryResponse: Codable, CodableInit {
    let id, userID, promocodeID: Int?
    let status, createdAt: String?
    let promocode: CouponHistoryResponseData?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case promocodeID = "promocode_id"
        case status
        case createdAt = "created_at"
        case promocode
    }
}

// MARK: - Promocode
struct CouponHistoryResponseData: Codable, CodableInit {
    let id: Int?
    let promoCode: String?
    let discount: Int?
    let discountType, expiration: String?
    let maxCount: Int?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id
        case promoCode = "promo_code"
        case discount
        case discountType = "discount_type"
        case expiration
        case maxCount = "max_count"
        case status
    }
}

// MARK: - WelcomeElement
struct ScheduleDataResponse: Codable, CodableInit {
    let id: Int?
    let bookingID: String?
    let userID, providerID, currentProviderID, serviceTypeID: Int?
    let otp, returntrip: Int?
    let status, cancelledBy: String?
    let paymentMode: String?
    let paid: Int?
    let distance, amount: Double?
    let specialNote, sAddress: String?
    let sLatitude, sLongitude: Double?
    let dAddress: String?
    let dLatitude, dLongitude: Double?
    let assignedAt, scheduleAt: String?
    let userRated, providerRated, useWallet, surge: Int?
    let routeKey: String?
    let createdAt, updatedAt, isTrack: String?
    let trackDistance, trackLatitude, trackLongitude: Int?
    let staticMap: String?
    let serviceType: ScheduleDataServiceType?
    let provider: ScheduleDataProvider?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case userID = "user_id"
        case providerID = "provider_id"
        case currentProviderID = "current_provider_id"
        case serviceTypeID = "service_type_id"
        case otp, returntrip, status
        case cancelledBy = "cancelled_by"
        case paymentMode = "payment_mode"
        case paid, distance, amount
        case specialNote
        case sAddress = "s_address"
        case sLatitude = "s_latitude"
        case sLongitude = "s_longitude"
        case dAddress = "d_address"
        case dLatitude = "d_latitude"
        case dLongitude = "d_longitude"
        case assignedAt = "assigned_at"
        case scheduleAt = "schedule_at"
        case userRated = "user_rated"
        case providerRated = "provider_rated"
        case useWallet = "use_wallet"
        case surge
        case routeKey = "route_key"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isTrack = "is_track"
        case trackDistance = "track_distance"
        case trackLatitude = "track_latitude"
        case trackLongitude = "track_longitude"
        case staticMap = "static_map"
        case serviceType = "service_type"
        case provider
    }
}

// MARK: - Provider
struct ScheduleDataProvider: Codable, CodableInit {
    let id: Int?
    let firstName, lastName, email, mobile: String?
    let wallet, avatar, rating, status: String?
    let fleet: Int?
    let latitude, longitude: Double?
    let otp: Int?
    let stripeCustID, createdAt, updatedAt, loginBy: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, mobile, wallet, avatar, rating, status, fleet, latitude, longitude, otp
        case stripeCustID = "stripe_cust_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case loginBy = "login_by"
    }
}

// MARK: - ServiceType
struct ScheduleDataServiceType: Codable, CodableInit {
    let id: Int?
    let type, name, providerName: String?
    let image, mapIcon: String?
    let capacity: String?
    let fixed: Int?
    let price: Double?
    let applyAfter1: Int?
    let applyAfter2: Double?
    let applyAfter3: Int?
    let after1_Price, after2_Price: Double?
    let after3_Price, after1_Minute, after2_Minute, after3_Minute: Int?
    let phourfrom, phourto, pextra: String?
    let minute: Double?
    let distance: Int?
    let calculator, serviceTypeDescription: String?
    let status: Int?

    enum CodingKeys: String, CodingKey {
        case id, type, name
        case providerName = "provider_name"
        case image
        case mapIcon = "map_icon"
        case capacity, fixed, price
        case applyAfter1 = "apply_after_1"
        case applyAfter2 = "apply_after_2"
        case applyAfter3 = "apply_after_3"
        case after1_Price = "after_1_price"
        case after2_Price = "after_2_price"
        case after3_Price = "after_3_price"
        case after1_Minute = "after_1_minute"
        case after2_Minute = "after_2_minute"
        case after3_Minute = "after_3_minute"
        case phourfrom, phourto, pextra, minute, distance, calculator
        case serviceTypeDescription = "description"
        case status
    }
}



// MARK: - Welcome
// MARK: - Welcome
struct EstimatedPriceResponse: Codable, CodableInit {
    let estimatedFare, distance: Double?
    let time: String?
//    let surge: Int?
//    let surgeValue: String?
//    let isextraprice, extraprice: Int?
    let roundOff: Double?
//    let walletBalance: Int?
    let total: Double?
    let eta_total: Double?
    

    enum CodingKeys: String, CodingKey {
        case estimatedFare = "estimated_fare"
        case distance
        case time
        case eta_total
//        case surgeValue = "surge_value"
//        case isextraprice, extraprice
        case roundOff = "round_off"
//        case etaTotal = "eta_total"
//        case walletBalance = "wallet_balance"
        case total
    }
}

//struct EstimatedPriceResponse: Codable, CodableInit {
//    let estimatedFare: Double?
//    let distance: Int?
//    let time: String?
//    let surge: Int?
//    let surgeValue: String?
//    let isextraprice, extraprice: Int?
//    let roundOff, etaTotal: Double?
//    let walletBalance: Int?
//    let total: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case estimatedFare = "estimated_fare"
//        case distance, time, surge
//        case surgeValue = "surge_value"
//        case isextraprice, extraprice
//        case roundOff = "round_off"
//        case etaTotal = "eta_total"
//        case walletBalance = "wallet_balance"
//        case total
//    }
//}


// MARK: - WelcomeElement
struct TaxiServicesResponse: Codable, CodableInit {
    let id: Int?
    let type, name: String?
    let image: String?
    let capacity: String?
    let price: Double?
    let calculator: String?
    let description: String?
    let fixed: Double?
    let eta_total: Double?

    enum CodingKeys: String, CodingKey {
        case id, type, name
        case image
        case capacity, price
        case calculator
        case description
        case fixed
        case eta_total
    }
}



struct NearDriversResponse: Codable, CodableInit {
    let id: Int?
    let latitude: Double?
    let longitude: Double?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, latitude, longitude, avatar
    }
}

struct UserSendChatResponse: Codable, CodableInit {
    let error: Bool?
}

struct UserChatResponse: Codable, CodableInit {
    let error: Bool?
    let chat: [UserChatDataResponse]?
    
    enum CodingKeys: String, CodingKey {
        case error, chat
    }
}

struct UserChatDataResponse: Codable, CodableInit {
    let type: String?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case type, message
    }
}



