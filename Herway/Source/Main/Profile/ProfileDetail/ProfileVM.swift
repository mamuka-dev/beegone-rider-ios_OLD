//
//  ProfileVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/25.
//

import Foundation
import UIKit

class ProfileVM: TableViewModel {
    
    var homeAddress: FavoriteLocationData? = nil
    var workAddress: FavoriteLocationData? = nil
    var profileData: ProfileResponse? = nil
    
    override init() {
        super.init()
        fetchData()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        if let data = self.profileData {
            section.addCell(cellData: ProfileMainCellData(profileData: data))
        }
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func fetchData() {
        
        self.getProfileData { msg, success in
            
            self.getFavoriteLocations { msg, success in
                self.prepareData()
            }
            self.prepareData()
            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
        }
    }
    
    
    func getProfileData(block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.getProfile.send(ProfileResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                self.profileData = response
                UserSession.shared.user?.name = "\(self.profileData?.firstName ?? "") \(self.profileData?.lastName ?? "")"
                UserSession.shared.user?.email = self.profileData?.email
                UserSession.shared.user?.photo = self.profileData?.picture
                
                block(nil, true)
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
                        self.homeAddress = home[0]
                    }
                }
                if let work = response.work {
                    if work.count > 0 {
                        self.workAddress = work[0]
                    }
                }
                
                block(nil, true)
            }
        }
    }
    
}

