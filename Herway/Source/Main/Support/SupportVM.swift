//
//  SupportVM.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/28.
//

import Foundation
import UIKit

class SupportVM: TableViewModel {
    
    var supportResponse: SupportResponse? = nil
    
    override init() {
        super.init()
        fetchData()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: SupportDataCellData(supportResponse: self.supportResponse))
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    func fetchData() {
        
        self.getSupportEmail { msg, success in
            
            self.prepareData()
            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
        }
    }
    
    
    func getSupportEmail(block: @escaping (String?, Bool)-> Void){
        
        ActivityIndicator.shared.showLoadingIndicator()
        Routes.getSupportInfo.send(SupportResponse.self) { (result) in
            
            ActivityIndicator.shared.hideLoadingIndicator()
            switch result {
            case .failure(let error):
                block(error.localizedDescription, false)
                print(error.localizedDescription)
            case .success(let response):
                
                self.supportResponse = response
                block(nil, true)
            }
        }
    }
    
}



