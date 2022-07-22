//
//  HomeBottomViewStage2VC.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/12.
//

import UIKit

class HomeBottomViewStage2VC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: HomeBottomViewStage2VM {get {return model as! HomeBottomViewStage2VM}}
    override var tableView: UITableView { return theTableView }
    var parentHome: HomeVC!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func initialize(taxiServices: [TaxiServicesResponse], selectedService: TaxiServicesResponse, isWalletSelected: Bool) {
        model = HomeBottomViewStage2VM(taxiServices: taxiServices, selectedService: selectedService, isWalletSelected: isWalletSelected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func registerXibs() {
        super.registerXibs()
        
        theTableView.register(R.nib.homeBottomViewStage2Cell)
        theTableView.register(R.nib.homeVehicleViewStage2HeaderCell)
        theTableView.register(R.nib.homeVehicleViewStage2Cell)
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupTheme() {
        super.setupTheme()
    }


    override func cellWasTapped(cell: TableCell, tag: String) {
        
        
        if let cellData = cell.data as? HomeBottomViewStage2CellData {
            
            if tag == "walletSelected" {
                self.parentHome.useWalletAmount = viewModel.isWalletSelected
            } else if tag == "showSchedulePopUp" {
                self.parentHome.showSchedulePopUp()
            } else if tag == "promo" {
                
//                UserDefaults.standard.setHomeState(state: .promo)
                parentHome.showPromoCodeView()
            } else if tag == "book" {
                self.bookTaxi()
            }
            
            
        } else if let cellData = cell.data as? HomeVehicleViewStage2CellData {
            
            if tag == "showTheDetailOfService" {
                self.parentHome.showServiceDetailView()
            } else if tag == "showEstimatedPrice" {
                self.parentHome.showEstimatedPrice()
            } else  if tag == "showSchedulePopUp" {
                self.parentHome.showSchedulePopUp()
            } else if let id = cellData.service.id {
                self.parentHome.updateService(for: id)
            }
            if let s = self.parentHome.selectedService {
                self.viewModel.selectedService = s
            }
            
            self.viewModel.prepareData()
            
        } else if let cellData = cell.data as? HomeVehicleViewStage2HeaderCellData {
            
            let type = cellData.selectedType.rawValue
            self.parentHome.updateServiceType(for: type)
           
            if let s = self.parentHome.selectedService {
                self.viewModel.selectedService = s
            }
//            if let s = self.parentHome.selectedService?.type {
//                if let type = VehicleType(rawValue: s) {
//                    self.viewModel.selectedType = type
//                }
//            }
            self.viewModel.prepareData()
            
        } else if tag == "showSchedulePopUp" {
            self.parentHome.showSchedulePopUp()
        } else if tag == "showEstimatedPrice" {
            self.parentHome.showEstimatedPrice()
        } else if tag == "promo" {
            UserDefaults.standard.setHomeState(state: .promo)
            parentHome.setupStates()
        } else if tag == "book" {
            self.bookTaxi()
        }
    }
    
    func bookTaxi() {
        if self.parentHome.destinationLat == nil || self.parentHome.destinationLng == nil {
            Utility.showLoaf(message: R.string.localizable.kindlySelectDestination(), state: .error)
            return

        } else if self.parentHome.lblPickup.text == R.string.localizable.enterYourPickupLocation() {
            Utility.showLoaf(message: R.string.localizable.kindlySelectPickupLocation(), state: .error)
            return
        }
        
        UserDefaults.standard.setHomeState(state: .findingRide)
        self.parentHome.setupStates()
        parentHome.bookTaxi { msg, success in
            
            if success {
                print("Nice...")
            } else if let msg = msg {
                UserDefaults.standard.setHomeState(state: .search)
                self.parentHome.setupStates()
                Utility.showLoaf(message: msg, state: .error)
            }
        }
    }

}






