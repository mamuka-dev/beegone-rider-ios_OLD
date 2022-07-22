//
//  SettingsVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/28.
//

import Foundation
import UIKit


class SettingsVM: TableViewModel {
    
    var homeAddress: FavoriteLocationData? = nil
    var workAddress: FavoriteLocationData? = nil
    var allUrls: [RequiredURlsResponseData] = [RequiredURlsResponseData]()
    
    var sosNumber: String? = nil
    override init() {
        super.init()
        fetchData()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: SettingsCellData())
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func getPrivacyUrl() -> String? {
        
        let url = self.allUrls.first(where: { d in
            d.key == "page_privacy"
        })
        
        return url?.value
    }
    
    func getTermsUrl() -> String? {
        
        let url = self.allUrls.first(where: { d in
            d.key == "page_terms"
        })
        
        return url?.value
    }
    
    func fetchData() {

        self.getAllUrls { msg, success in

            self.prepareData()
            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
        }
            self.getFavoriteLocations { msg, success in
                self.prepareData()
            }
//        }
    }
    
    func logOut(block: @escaping (String?, Bool)-> Void){
        
        guard let id = UserSession.shared.user?.id else {
            let redirect = RedirectHelper(window: nil)
            redirect.logout()
            redirect.determineRoutes()
            return
        }

        ActivityIndicator.shared.showLoadingIndicator()
        Routes.logout(id: String(id)).send(verificationResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if let msg = response.message {
                    Utility.showLoaf(message: msg, state: .success)
                }
                block(nil, true)
            }
        }
    }
    
    func getAllUrls(block: @escaping (String?, Bool)-> Void){
        
        Routes.getTermsAndPrivacyURl.send(RequiredURlsResponse.self) { (result) in

            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if let data = response.data {
                    self.allUrls = data
                    Constants.setupConstData(data: data)
                    block(nil, true)
                    return
                }
                
                block(nil, false)
            }
        }
    }
    
    
    func getFavoriteLocations(block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.getFavoriteLocations.send(FavoriteLocationResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                if let home = response.home {
                    if home.count > 0 {
                        self.homeAddress = home.last
                    }
                }
                if let work = response.work {
                    if work.count > 0 {
                        self.workAddress = work.last
                    }
                }
                
                block(nil, true)
            }
        }
    }
    
    func updateFavoriteLocations(address: String, type: String, latitude: String, longitude: String, block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.updateFavoriteLocations(type: type, latitude: latitude, longitude: longitude, address: address).send(normalResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                block(response.message, true)
                self.fetchData()
            }
        }
    }
    
}


