//
//  SideMenuItem.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/25.
//

import Foundation
import UIKit


enum SideMenuItem: String, CaseIterable {
    
    case home
    case wallet
    case cards
    case history
    case ongoing
    case couponHistory
    case support
    case settings
    case profile
    
    
    var title: String{
        
        switch self {
        case .home:
            return R.string.localizable.home()
        case .wallet:
            return R.string.localizable.wallet()
        case .cards:
            return R.string.localizable.manageCards()
        case .history:
            return R.string.localizable.ridesHistory()
        case .ongoing:
            return R.string.localizable.scheduleRides()
        case .couponHistory:
            return R.string.localizable.walletCouponHistory()
        case .support:
            return R.string.localizable.support()
        case .settings:
            return R.string.localizable.settings()
        case .profile:
            return R.string.localizable.profile()
        
        }
    }
    
    var img: UIImage?{
        
        switch self {
        case .home:
            return R.image.btnHome()
        case .wallet:
            return R.image.btnWallet()
        case .cards:
            return R.image.iconCards()
        case .history:
            return R.image.btnHistory()
        case .ongoing:
            return R.image.btnOngoing()
        case .couponHistory:
            return R.image.btnHistory()
        case .support:
            return R.image.btnSupport()
        case .settings:
            return R.image.btnSetting()
        case .profile:
            return R.image.btnSetting()
        }
    }
    
    var selectedImg: UIImage?{
        
        switch self {
        case .home:
            return R.image.btnHome()
        case .wallet:
            return R.image.btnWallet()
        case .cards:
            return R.image.iconCards()
        case .history:
            return R.image.btnHistory()
        case .ongoing:
            return R.image.btnOngoing()
        case .couponHistory:
            return R.image.btnHistory()
        case .support:
            return R.image.btnSupport()
        case .settings:
            return R.image.btnSetting()
        case .profile:
            return R.image.btnSetting()
        }
    }
}
