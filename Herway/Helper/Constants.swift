//
//  Constants.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/4/22.
//

import Foundation
import UIKit
import Stripe
import GoogleMaps

let IMAGE_BASE_URL = "https://meemcolart.com/storage/"

var APP_STORELINK = "https://apps.apple.com/us/app/uber-request-a-ride/id368677368"
var CURRENCY: String = "SEK"
var SOMETHING_WENT_WRONG = "Something went wrong to get services!"
var SOMETHING_WENT_WRONG_TEXT = R.string.localizable.somethingWentWrong()


class Constants {

    struct Static {
        static let userAgent: String = "iOS"
        static var notificationToken: String = ""
    }
    
    static var deviceId: String {
        get {
            let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
            return deviceId
        }
    }
    
    static func setupConstData(data: [RequiredURlsResponseData]) {
        
        let terms = data.first(where: { d in
            d.key == "page_terms"
        })
        if let text = terms?.value {
            UserDefaults.standard.setTerms(text: text)
        }
        
        let privacy = data.first(where: { d in
            d.key == "page_privacy"
        })
        if let text = privacy?.value {
            UserDefaults.standard.setPrivacyPolicy(text: text)
        }
        
        let stripeKey = data.first(where: { d in
            d.key == "stripe_publishable_key"
        })
        if let text = stripeKey?.value {
            UserDefaults.standard.setStripeKey(text: text)
            STPAPIClient.shared().publishableKey = text
        }
        
        let currency = data.first(where: { d in
            d.key == "currency"
        })
        if let text = currency?.value {
            UserDefaults.standard.setCurrency(text: text)
        }
        
        let mapKey = data.first(where: { d in
            d.key == "map_key"
        })
        if let text = mapKey?.value {
            UserDefaults.standard.setMapKey(text: text)
            GMSServices.provideAPIKey(text)
        }
        
        let showOTP = data.first(where: { d in
            d.key == "verification"
        })
        if let text = showOTP?.value {
            if text == "1" {
                UserDefaults.standard.setShowOtpScreen(status: true)
            } else {
                UserDefaults.standard.setShowOtpScreen(status: false)
            }
        }
        
    }
    
    static func setupConsVariables() {
        
        if let stipeKey = UserDefaults.standard.getStripeKey() {
            STPAPIClient.shared().publishableKey = stipeKey
        }
        
        if let mapKey = UserDefaults.standard.getMapKey() {
            GMSServices.provideAPIKey(mapKey)
        }
    }
    
}



