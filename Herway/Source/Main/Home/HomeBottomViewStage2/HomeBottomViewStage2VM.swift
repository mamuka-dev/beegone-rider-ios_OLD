//
//  HomeBottomViewStage2VM.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import Foundation
import UIKit

class HomeBottomViewStage2VM: TableViewModel {
    
    var selectedType: VehicleType = .transportation
    var taxiServices: [TaxiServicesResponse]
    var selectedService: TaxiServicesResponse
    var isWalletSelected: Bool
    
    init(taxiServices: [TaxiServicesResponse], selectedService: TaxiServicesResponse, isWalletSelected: Bool) {
        self.taxiServices = taxiServices
        self.selectedService = selectedService
        self.isWalletSelected = isWalletSelected
        super.init()
        prepareData()
    }
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
        section.addCell(cellData: HomeVehicleViewStage2HeaderCellData(taxiServices: taxiServices, selectedService: selectedService))
        
        taxiServices.forEach { s in
            
            var isSelected = self.selectedService.id == s.id
            if self.selectedService.type == s.type {
                section.addCell(cellData: HomeVehicleViewStage2CellData(service: s, isSelected: isSelected))
            }
            
        }
        
        section.addCell(cellData: HomeBottomViewStage2CellData())
        
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    
    
    func typeChanged(type: VehicleType) {
        self.selectedType = type
        
    }
    
}

