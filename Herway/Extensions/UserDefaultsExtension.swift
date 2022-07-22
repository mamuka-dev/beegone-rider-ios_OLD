//

import Foundation

enum UserSessionEnum : String {
    case userSessionData
    case deviceToken
    case userProfile
}



extension UserDefaults{
    //MARK: Save User Data
    func setUserSession(value: Data){
        set(value, forKey: UserSessionEnum.userSessionData.rawValue)
    }
    
    //MARK: Retrieve User Data
    func getUserSession() -> Data?{
        return UserDefaults.standard.value(forKey: UserSessionEnum.userSessionData.rawValue) as? Data
    }
    
    func removeUserSession(){
        self.removeObject(forKey: UserSessionEnum.userSessionData.rawValue)
    }
    
    
    func setUserType(type: UserTypeEnum){
        set(type.rawValue, forKey: "USER_TYPE")
    }
    
    func getUserType() -> UserTypeEnum{
        if let value = UserDefaults.standard.value(forKey: "USER_TYPE") as? String {
            return UserTypeEnum(rawValue: value) ?? .normalUser
        }
        return UserTypeEnum.normalUser
    }
    
    func setHomeState(state: HomeState){
        set(state.rawValue, forKey: "HOME_STATE")
    }
    
    func getHomeState() -> HomeState{
        if let value = UserDefaults.standard.value(forKey: "HOME_STATE") as? String {
            return HomeState(rawValue: value) ?? .initial
        }
        return HomeState.initial
    }
    
    func setRideRequestId(ID: String){
        set(ID, forKey: "RIDE_REQ_ID")
    }
    
    func getRideRequestId() -> String {
        if let value = UserDefaults.standard.value(forKey: "RIDE_REQ_ID") as? String {
            return value
        }
        return ""
    }
    
    func setShowEstimatedPrice(status: Bool){
        
        set(status == true ? 1 : 0, forKey: "SHOW_ESTIMATED_PRICE")
    }
    
    func showEstimatedPrice() -> Bool {
        if let value = UserDefaults.standard.value(forKey: "SHOW_ESTIMATED_PRICE") as? Int {
            return value == 1 ? true : false
        }
        return false
    }
    

    //MARK:- Device token
    func saveDeviceToken(token:String){
        set(token, forKey: UserSessionEnum.deviceToken.rawValue)
    }
    
    func getDeviceToken()-> String?{
        return UserDefaults.standard.value(forKey: UserSessionEnum.deviceToken.rawValue) as? String
    }
    
    func removeDeviceToken(){
        self.removeObject(forKey: UserSessionEnum.deviceToken.rawValue)
    }
    
    func saveDefaultCardId(cardId:String){
        set(cardId, forKey: "userDefaultCardId")
    }
    
    func getDefaultCardId()-> String?{
        return UserDefaults.standard.value(forKey: "userDefaultCardId") as? String
    }
    
    func setPrivacyPolicy(text:String){
        set(text, forKey: "userPrivacyPolicy")
    }
    
    func getPrivacyPolicy()-> String?{
        return UserDefaults.standard.value(forKey: "userPrivacyPolicy") as? String
    }
    
    func setTerms(text:String){
        set(text, forKey: "userTermsAndCond")
    }
    
    func getTerms()-> String?{
        return UserDefaults.standard.value(forKey: "userTermsAndCond") as? String
    }
    
    func setStripeKey(text:String){
        set(text, forKey: "stripe_publishable_key")
    }
    
    func getStripeKey()-> String?{
        return UserDefaults.standard.value(forKey: "stripe_publishable_key") as? String
    }
    
    func setCurrency(text:String){
        set(text, forKey: "currency")
    }
    
    func getCurrency()-> String?{
        return UserDefaults.standard.value(forKey: "currency") as? String
    }
    
    func setMapKey(text:String){
        set(text, forKey: "map_key")
    }
    
    func getMapKey()-> String?{
        return UserDefaults.standard.value(forKey: "map_key") as? String
    }
    
    func setSOS(text:String){
        set(text, forKey: "SOS_Mobile_NUm")
    }
    
    func getSOS()-> String?{
        return UserDefaults.standard.value(forKey: "SOS_Mobile_NUm") as? String
    }
    
    func setShowOtpScreen(status: Bool){
        
        set(status == true ? 1 : 0, forKey: "showOtpScreen")
    }
    
    func showOtpScreen() -> Bool {
        if let value = UserDefaults.standard.value(forKey: "showOtpScreen") as? Int {
            return value == 1 ? true : false
        }
        return false
    }
    
    func setSelectedLanguage(code: Language){
        set(code.rawValue, forKey: "SELECTED_LANGUAGE")
    }
    
    func getSelectedLanguage()-> Language{
        if let value = UserDefaults.standard.value(forKey: "SELECTED_LANGUAGE") as? String {
            return Language(rawValue: value) ?? .english
        } else {
            return .english
        }
    }
    
}

extension UserDefaults{
    func isNotificationTaped() -> Bool {
        return UserDefaults.standard.value(forKey: "isNotificationTaped") as? Bool ?? false
    }
    
    func saveIsNotificationTaped(status:Bool){
        set(status, forKey: "isNotificationTaped")
    }
}


enum UserTypeEnum: String {
    case guest
    case normalUser
}
