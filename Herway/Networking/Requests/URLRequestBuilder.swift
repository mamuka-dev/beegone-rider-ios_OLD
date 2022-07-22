 
 
 import Foundation
 import Alamofire
 
 enum AppURL:String {
    case privacyPolicyURL = ""
     case baseURL1 = "https://meemcolart.com/"
     case baseURL2 = "https://meemcolart.com/public/cabuser/public/"
     case token = "theToken"
     
     var getValue: String {
         
         if self == .token {
             return "Bearer \(UserSession.shared.user?.token ?? "")"
         }
         return ""
     }
 }
 
 protocol URLRequestBuilder: URLRequestConvertible, APIRequestHandler {
    
    var mainURL: URL { get }
    var requestURL: URL { get }
    // MARK: - Path
    var path: String { get }
    
    // MARK: - Parameters
    var parameters: Parameters? { get }
    
    var headers: HTTPHeaders { get }
    
    // MARK: - Methods
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
     
     var theRouteType: Routes { get }
 }
 
 
 extension URLRequestBuilder {
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var mainURL: URL  {
        
        switch theRouteType {
        case .login, .register, .sendBookingRide, .cancelRide, .getProfile, .editProfile, .resetPassword, .forgetPassword, .changePassword, .logout, .addMoneyToRiderWallet, .chargeCardForWallet, .getWalletBallence, .getCards, .addCardToRiderAccount, .changeDefaultCard, .deleteCard, .getRideHistory, .getRideDetail, .upcomingRides, .cancelScheduleRide, .getWalletHistory, .coponHistory, .getSupportInfo, .getFavoriteLocations, .updateFavoriteLocations, .checkRideStatus, .rateJob, .getEstimates, .getTaxiServices, .getAllDrivers, .payBycard, .applyPromoCode, .calculateTrip:
            return URL(string: "https://meemcolart.com/")!
        default:
            return URL(string: "https://meemcolart.com/public/cabuser/public/")!
        }
    }
    
    var requestURL: URL {
        return mainURL.appendingPathComponent(path)
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach { (header) in 
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        
        return request
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
 }
