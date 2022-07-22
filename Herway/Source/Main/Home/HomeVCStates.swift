//
//  HomeVCExtension.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/5/28.
//

import Foundation
import CoreLocation
import GoogleMaps
import GooglePlacesSearchController

var sheetController = SheetViewController(controller: HomeBottomViewStage1VC.instantiateHome())
var sheetPayOnlineController = SheetViewController(controller: HomeBottomViewStage1VC.instantiateHome())

import FittedSheets
import UserNotifications

//MARK: Setup States.
extension HomeVC {
    
    
    func setUpState1(){
        
        self.useWalletAmount = false
        self.selectedScheduleDate = nil
        self.selectedScheduleTime = nil
        self.isPickupState = false
        self.updateServiceType(for: VehicleType.transportation.rawValue)
        btnSideMenuImg.image =  R.image.btnSideMenu()
        btnSideMenuImg.tintColor = .tint1
        vwDestination.isHidden = true
        sheetController.attemptDismiss(animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        let vc = HomeBottomViewStage1VC.instantiateHome()
        vc.parentHome = self
        
        let options = SheetOptions(
            useFullScreenMode: false,
            useInlineMode: true
        )
        sheetController = SheetViewController(controller: vc, sizes: [.percent(0.4), .fixed(600)], options: options)
        sheetController.allowGestureThroughOverlay = true
        sheetController.dismissOnOverlayTap = false
        sheetController.dismissOnPull = false
        
        FilteredSheetManager.shared.showThe(parent: self, inlineMode: true)
        }
    }
    
    func setUpState2(){
        
        let geocoder = GMSGeocoder()
        let position = CLLocationCoordinate2D(latitude: currentLat, longitude: currentLng)
        geocoder.reverseGeocodeCoordinate(position) { response, error in
            
            if error != nil {
                            print("reverse geodcode fail: \(error!.localizedDescription)")
                        } else {
                            if let places = response?.results() {
                                if let place = places.first {


                                    if let lines = place.lines {
                                        if lines.count > 0 && !self.isPickupState {
                                            self.lblPickup.text = lines[0]
                                        }
                                        print("GEOCODE: Formatted Address: \(lines)")
                                    }

                                } else {
                                    print("GEOCODE: nil first in places")
                                }
                            } else {
                                print("GEOCODE: nil in places")
                            }
                        }
        }
        
        if self.destinationLat == nil {
            self.lblDestination.text = R.string.localizable.enterDropOffLocation()
            self.lblDestination.textColor = .secondaryColor
            self.destinationLat = nil
        }
        
        if self.shouldShowHomeAddress {
            if let data = UserSession.shared.user?.homeAddress {
                if let lat = data.latitude {
                    self.destinationLat = lat
                }
                if let long = data.longitude {
                    self.destinationLng = long
                }
                if let address = data.address {
                    self.lblDestination.text = address
                    self.lblDestination.textColor = .primaryColor
                }
            }
        } else if self.shouldShowWorkAddress {
            if let data = UserSession.shared.user?.workAddress {
                if let lat = data.latitude {
                    self.destinationLat = lat
                }
                if let long = data.longitude {
                    self.destinationLng = long
                }
                if let address = data.address {
                    self.lblDestination.text = address
                    self.lblDestination.textColor = .primaryColor
                }
            }
        }
        
        btnSideMenuImg.image =  R.image.btnBack1()
        btnSideMenuImg.tintColor = .primaryColor
        sheetController.attemptDismiss(animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            self.vwDestination.isHidden = false
            if self.selectedService == nil {
                self.getRideServices { msg, success in
                }
                return
            }
            
            
            let options = SheetOptions(
                useFullScreenMode: false,
                useInlineMode: true
            )
            let height = CGFloat(450 + self.getSafeAreaBottomheight())
            
            
            if self.destinationLat == nil || self.destinationLng == nil || self.lblPickup.text == R.string.localizable.enterYourPickupLocation() {
                
                let vc = HomeBottomViewStage1VC.instantiateHome()
                vc.parentHome = self
                sheetController = SheetViewController(controller: vc, sizes: [.fixed(height)], options: options)
            } else {
                
                let vc = HomeBottomViewStage2VC.instantiateHome()
                vc.initialize(taxiServices: self.taxiServices, selectedService: self.selectedService!, isWalletSelected: self.useWalletAmount)
                vc.parentHome = self
                sheetController = SheetViewController(controller: vc, sizes: [.fixed(height)], options: options)
                self.setupMaps()
            }
            
            
            
            
            sheetController.allowGestureThroughOverlay = true
            sheetController.dismissOnOverlayTap = false
            sheetController.dismissOnPull = false
            
            FilteredSheetManager.shared.showThe(parent: self, inlineMode: true)
        }
    }
    
    func setUpFindingRide(){
        
        btnSideMenuImg.image =  R.image.btnSideMenu()
        btnSideMenuImg.tintColor = .tint1
        sheetController.attemptDismiss(animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.vwDestination.isHidden = true
            self.vwFindingRide.isHidden = false
            self.loaderStoped = false
            self.rotateView(targetView: self.vwLoader)
        }
        
    }
    
    
    
    func setUpState3(){
        
        btnSideMenuImg.image =  R.image.btnBack1()
        btnSideMenuImg.tintColor = .primaryColor
        sheetController.attemptDismiss(animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.vwDestination.isHidden = false
            let vc = HomeBottomViewStage3VC.instantiateHome()
            vc.parentHome = self
            
            let options = SheetOptions(
                useFullScreenMode: false,
                useInlineMode: true
            )
            sheetController = SheetViewController(controller: vc, sizes: [.percent(0.4), .fixed(600)], options: options)
            sheetController.allowGestureThroughOverlay = true
            sheetController.dismissOnOverlayTap = false
            sheetController.dismissOnPull = false
            
            FilteredSheetManager.shared.showThe(parent: self, inlineMode: true)
        }
    }
    
    func setUpState4(){
        
        guard let request = self.currentRequest else { return }
        
        btnSideMenuImg.image =  R.image.btnSideMenu()
        btnSideMenuImg.tintColor = .tint1
        sheetController.attemptDismiss(animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.vwDestination.isHidden = true
            let vc = HomeBottomViewStage4VC.instantiateHome()
            vc.initialize(request: request, estimatedPrice: self.estimatedPrice)
            vc.parentHome = self
            
            let options = SheetOptions(
                useFullScreenMode: false,
                useInlineMode: true
            )
            let height = self.getPickerHeight()
            sheetController = SheetViewController(controller: vc, sizes: [.fixed(height)], options: options)
            sheetController.allowGestureThroughOverlay = true
            sheetController.dismissOnOverlayTap = false
            sheetController.dismissOnPull = false
            
            FilteredSheetManager.shared.showThe(parent: self, inlineMode: true)
        }
    }
    
    func setUpPopupState(){
        
        if self.showPopupState == .none { return }
        sheetController.attemptDismiss(animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let vc = HomeBottomViewStage4VC.instantiateHome()
            vc.initialize(popUpState: self.showPopupState, estimatedPrice: self.estimatedPrice, servicesResponse: self.selectedService)
            vc.parentHome = self
            
            let options = SheetOptions(
                useFullScreenMode: false,
                useInlineMode: true
            )
            
            var height: CGFloat = 350
            if self.showPopupState == .schedulePicker || self.showPopupState == .promo {
                height = 250
            } else if self.showPopupState == .serviceDetail {
                height = 450
            }
            sheetController = SheetViewController(controller: vc, sizes: [.fixed(height)], options: options)
            sheetController.allowGestureThroughOverlay = true
            sheetController.dismissOnOverlayTap = false
            sheetController.dismissOnPull = false
            
            FilteredSheetManager.shared.showThe(parent: self, inlineMode: true)
        }
    }
    
    func getSafeAreaBottomheight() -> Int {
        let window = UIApplication.shared.windows.first
        let bottomPadding = window?.safeAreaInsets.bottom
        return Int(bottomPadding ?? 0)
    }
    
    func getPickerHeight() -> CGFloat {
        
        let screenHeight = Int(UIScreen.main.bounds.height)
        
        if currentState == .acceptedRide {
            return CGFloat(350 + getSafeAreaBottomheight())
        } else if currentState == .rideInProgress {
            return CGFloat(330 + getSafeAreaBottomheight())
        } else if currentState == .showInvoice {
            return CGFloat((screenHeight - 200) + getSafeAreaBottomheight())
        } else if currentState == .rating {
            return CGFloat(350 + getSafeAreaBottomheight())
        }
        return 0
    }
    
    
    
    func showPayOnlineView() {
        
        sheetPayOnlineController.attemptDismiss(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        let vc = PayOnlineVC.instantiateHome()
        vc.parentHome = self
        
        let options = SheetOptions(
            useFullScreenMode: false,
            useInlineMode: true
        )
            sheetPayOnlineController = SheetViewController(controller: vc, sizes: [.percent(0.3), .fixed(300)], options: options)
            sheetPayOnlineController.allowGestureThroughOverlay = true
            sheetPayOnlineController.dismissOnOverlayTap = false
            sheetPayOnlineController.dismissOnPull = false
        
        FilteredSheetManager.shared.showPayOnline(parent: self, inlineMode: true)
        }
    }
    
    func hidePayOnlineView() {
        sheetPayOnlineController.attemptDismiss(animated: true)
        
    }
    
    func showWalletCard() {
        
        self.getAllCards { msg, success in
            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            } else {
                if self.defaultCard == nil {
                    self.lblCard.text = R.string.localizable.setAddDefaultCard()
                    self.view.bringSubviewToFront(self.vwAddAmount)
                    self.vwAddAmount.isHidden = false
                } else {
                    self.view.bringSubviewToFront(self.vwAddAmount)
                    self.lblCard.text = "XXXX - XXXX -XXXX - \(self.defaultCard?.lastFour ?? R.string.localizable.fourTwo())"
                    self.vwAddAmount.isHidden = false
                }
            }
        }
    }
    
    
    func gotoHome() {
        
        let camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: self.currentLat, longitude: self.currentLng), zoom: 16)
        self.googleMapView.animate(to: camera)
    }
}



