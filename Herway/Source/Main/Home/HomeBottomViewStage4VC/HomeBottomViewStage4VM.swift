//
//  HomeBottomViewStage4VM.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import Foundation
import UIKit
import AVFoundation

class HomeBottomViewStage4VM: TableViewModel {
    
    let currentState = UserDefaults.standard.getHomeState()
    
    var estimatedPrice: EstimatedPriceResponse? = nil
    var request: RideDetailResponseData? = nil
    var popupState: PopupState = .none
    var scheduleDate: String? = nil
    var servicesResponse: TaxiServicesResponse? = nil

    
    init(request: RideDetailResponseData?, estimatedPrice: EstimatedPriceResponse?, servicesResponse: TaxiServicesResponse? = nil) {
       
        self.request = request
        self.estimatedPrice = estimatedPrice
        self.servicesResponse = servicesResponse
        super.init()
        
        prepareData()
    }
    
    
    
    
    override func prepareData() {
        super.prepareData()
        
        let section = TableSectionData(model: self)
        
//        let shouldShowEstimatedPrice = UserDefaults.standard.showEstimatedPrice()
//        if shouldShowEstimatedPrice {
//            section.addCell(cellData: HomeEstimatedPriceCellData())
//            tableData.append(section)
//            delegate?.onUnderlyingDataChanged()
//            return
//        }
//        
        if self.popupState == .estimatedPrice {
            section.addCell(cellData: HomeEstimatedPriceCellData(theData: estimatedPrice))
        } else if  self.popupState == .schedulePicker {
            section.addCell(nibId: "HomeScheduleCell")
        } else if  self.popupState == .promo {
            section.addCell(cellData: HomeBottomViewStage3CellData())
        } else if  self.popupState == .serviceDetail {
            if let data = self.servicesResponse {
                section.addCell(cellData: HomeServiceDetailCellData(theData: data))
            }
            
        }
        
        
        
        if let request = self.request {
            
            if currentState == .acceptedRide {
                section.addCell(cellData: HomeBottomViewStage4HeaderCellData(currentRequest: request))
                section.addCell(cellData: HomeBottomViewStage4PromoCellData(currentRequest: request))
                section.addCell(cellData: HomeBottomViewStage4BottomCellData(currentRequest: request))
            } else if currentState == .rideInProgress {
                section.addCell(cellData: HomeBottomViewStage4HeaderCellData(currentRequest: request))
                section.addCell(cellData: HomeBottomViewStage4BottomCellData(currentRequest: request))
            } else if currentState == .showInvoice {
                section.addCell(cellData: HomeBookingInvoiceCellData(currentRequest: request))
            } else if currentState == .rating {
                section.addCell(cellData: HomeBottomViewStage4RatingCellData(currentRequest: request))
            }
        }
        

        
//        section.addCell(cellData: HomeBottomViewStage4HeaderCellData())
//        section.addCell(cellData: HomeBottomViewStage4PromoCellData())
//        section.addCell(cellData: HomeBottomViewStage4BottomCellData())
        
        
        tableData.append(section)
        delegate?.onUnderlyingDataChanged()
    }
    

    
}
