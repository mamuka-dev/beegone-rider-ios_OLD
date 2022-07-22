//
//  EditProfileVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/26.
//

import Foundation
import UIKit

class EditProfileVM: TableViewModel {
    
    var imageProfile: UIImage? = nil
    var profileData: ProfileResponse? = nil
    
    override init() {
        super.init()
        prepareData()
    }
    
    func updateImage(img: UIImage) {
        self.imageProfile = img
    }
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: EditProfileCellData())
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func updateData(block: @escaping ()-> Void) {
        
        self.EditProfileData { msg, success in

            if !success {
                
                Utility.showLoaf(message: R.string.localizable.somethingWentWrong(), state: .error)
            } else {
                Utility.showLoaf(message: "Profile successfully edited.", state: .success)
            }
            block()
        }
    }
    
    func EditProfileData(block: @escaping (String?, Bool)-> Void){
        
        guard let data = self.profileData else { return }
        
        var uploadData: UploadData? = nil
        if let img = imageProfile {
            uploadData = UploadData(data: img.pngData()!, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "png", name: "picture")
        }
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.editProfile(first_name: data.firstName ?? "", last_name: data.lastName ?? "", email: data.email ?? "", mobile: data.mobile ?? "").send(normalResponse.self, data: uploadData, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch results {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(_):
                
                block(nil, true)
            }
        }
    }
    
}

