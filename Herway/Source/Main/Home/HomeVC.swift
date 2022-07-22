//
//  HomeVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/25.
//

import Foundation
import GoogleMaps
import Alamofire
import CoreLocation
import GooglePlacesSearchController


class HomeVC: BaseViewController, Storyboarded {
    
    //MARK: OutLets
    @IBOutlet weak var vwTarget: UIView!
    @IBOutlet weak var vwSubFindingView: UIView!
    @IBOutlet weak var vwFindingRide: UIView!
    @IBOutlet weak var btnSideMenuImg: UIImageView!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblPickup: UILabel!
    @IBOutlet weak var vwDestination: UIView!
    @IBOutlet weak var btnSideMenu: UIButton!
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var vwSOS: UIView!
    @IBOutlet weak var vwLoader: UIView!
    
    @IBOutlet weak var vwAddAmount: UIView!
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var lblCard: UILabel!
    
    //MARK: Varibles
    var destinationLat: Double? = nil
    var destinationLng: Double? = 73.1515
    var currentLat = 33.65624351
    var currentLng = 73.19600067
    
    var placesSearchController: GooglePlacesSearchController!
    var locationManager: CLLocationManager!
    let sourceMarker = GMSMarker()
    var defaultCard: CreditCardDetail? = nil
    var promoCode: String? = nil
    
    var currentRequest: RideDetailResponseData? = nil
    var estimatedPrice: EstimatedPriceResponse? = nil
    var profileData: ProfileResponse? = nil
    var currentState: HomeState = .initial
    var shouldShowHomeAddress: Bool = false
    var shouldShowWorkAddress: Bool = false
    var showPopupState: PopupState = .none
    var isFromDestination: Bool = true
    var isPickupState: Bool = false
    var selectedScheduleDate: String? = nil
    var selectedScheduleTime: String? = nil
    var useWalletAmount: Bool = false
    var nearbyDriversMarker1 = GMSMarker()
    var nearbyDriversMarker2 = GMSMarker()
    var nearbyDriversMarker3 = GMSMarker()
    var nearbyDriversMarker4 = GMSMarker()
    var nearbyDriversMarker5 = GMSMarker()
    var nearbyDriversMarker6 = GMSMarker()
    
    var nearDrivers: [NearDriversResponse] = [NearDriversResponse]()
    var taxiServices: [TaxiServicesResponse] = [TaxiServicesResponse]()
    var selectedService: TaxiServicesResponse? = nil
    
    var timerDispatchSourceTimer : DispatchSourceTimer?
    weak var timer: Timer?
    
    //MARK: LifeCycle
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.destinationLat = nil
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stopTimer()
        startTimer()
        
        
//        Bundle.setLanguage(lang: "es")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    //MARK: Initiailation
    override func setupUI() {
        
        
        
        self.vwTarget.layer.cornerRadius = 17
        self.vwAddAmount.isHidden = true
        self.vwAddAmount.backgroundColor = .primaryColor.withAlphaComponent(0.50)
        
        vwSOS.isHidden = true
        getConstData { msg, success in
        }
        getProfileData()
        UserDefaults.standard.setHomeState(state: .initial)
        vwSubFindingView.layer.cornerRadius = 8
        self.setupLocation()
        self.googleMapView.clear()
        setupMaps()
        self.googleMapView.isMyLocationEnabled = true
        if destinationLat != nil && destinationLng != nil {
            let camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: destinationLat!, longitude: destinationLng!), zoom: 16)
            self.googleMapView.animate(to: camera)
        }
        
        self.setupStates()
        self.getFavoriteLocations()
        self.getRideServices { msg, success in
        }
        vwDestination.cornerRadius = 12
    }
    
    
    //MARK: functions
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            self?.checkForRideRequest()
            self?.calculateTrip()
            let state = UserDefaults.standard.getHomeState()
            if state == .initial || state == .search {
                self?.getNearbyDrivers()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timerDispatchSourceTimer?.cancel()
    }
    
    func setupStates()  {
        currentState = UserDefaults.standard.getHomeState()
        
        vwSOS.isHidden = true
        
        if showPopupState != .none {
            self.setUpPopupState()
            self.stopLoader()
            vwFindingRide.isHidden = true
            return
        }
        
        if currentState == .initial {
            self.googleMapView.clear()
            setUpState1()
            self.stopLoader()
            vwFindingRide.isHidden = true
        }
//        else if currentState == .initialSearch {
//            vwFindingRide.isHidden = true
//            setUpState2()
//            
//        }
        else if currentState == .search {
            self.stopLoader()
            vwFindingRide.isHidden = true
            if self.taxiServices.count == 0 {
                self.getRideServices { msg, success in
                    self.setUpState2()
                }
            }
            setUpState2()
        } else if currentState == .findingRide {
            self.stopLoader()
            vwFindingRide.isHidden = true
            setUpFindingRide()
        } else if currentState == .promo {
            self.stopLoader()
            vwFindingRide.isHidden = true
            setUpState3()
        } else if currentState == .acceptedRide {
            self.stopLoader()
            vwFindingRide.isHidden = true
            setUpState4()
        } else if currentState == .rideInProgress {
            self.stopLoader()
            vwSOS.isHidden = false
            vwFindingRide.isHidden = true
            setUpState4()
        } else if currentState == .showInvoice {
            self.stopLoader()
            vwFindingRide.isHidden = true
            setUpState4()
        } else if currentState == .rating {
            self.stopLoader()
            vwFindingRide.isHidden = true
            setUpState4()
        }
    }
    
    
    var loaderStoped = true
    public func stopLoader(){
//        Run.onMain {
         self.loaderStoped = true
//        }
    }
     
    func rotateView(targetView: UIView, duration: Double = 1.0) {
         UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
             targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
         }) { finished in
             if !self.loaderStoped{
                 self.rotateView(targetView: targetView, duration: duration)
             }
         }
     }
    
    //MARK: Actions
    @IBAction func btnTargetTapped(_ sender: Any) {
        self.gotoHome()
    }
    
    @IBAction func btnChangeCardTapped(_ sender: Any) {
        let vc = ManageCardsVC.instantiateHome()
        self.navigationController?.pushViewController(vc, animated: true)
        self.vwAddAmount.isHidden = true
    }
    
    @IBAction func btnCardViewCloseTapped(_ sender: Any) {
        self.vwAddAmount.isHidden = true
    }
    
    @IBAction func btnPayOnline(_ sender: Any) {
        if let cardId = UserDefaults.standard.getDefaultCardId() {
            self.payByCard(cardId: cardId) { msg, success in
                if !success {
                    if let msg = msg {
                        Utility.showLoaf(message: msg, state: .error)
                    }
                }
                self.vwAddAmount.isHidden = true
                self.hidePayOnlineView()
            }
        } else {
            Utility.showLoaf(message: R.string.localizable.thereAreNoDefaultCardAvailable(), state: .error)
        }
    }
    
    @IBAction func btnSOSTapped(_ sender: Any) {
        
        if let number = UserDefaults.standard.getSOS() {
            if number != "" {
                Utility.dialNumber(number: number)
            } else {
                Utility.showLoaf(message: R.string.localizable.kindlyAddSOSNumberFirstFromSettings(), state: .error)
            }
        } else {
            Utility.showLoaf(message: R.string.localizable.kindlyAddSOSNumberFirstFromSettings(), state: .error)
        }
    }
    
    @IBAction func btnCancelRideTapped(_ sender: Any) {
        self.cancelTheRide()
    }
    
    @IBAction func btnDestinationTapped(_ sender: Any) {
        
        isFromDestination = true
        placesSearchController = GooglePlacesSearchController(delegate: self,
                        apiKey: "AIzaSyDgxUkkfvb-L-bQyr5_WFbj18w2swdn1QY",
                        placeType: .all,
                        coordinate: CLLocationCoordinate2D(latitude: currentLat, longitude: currentLng),
                        radius: 500
        )
        self.present(placesSearchController, animated: true, completion: nil)
    }
    
    @IBAction func btnPickupTapped(_ sender: Any) {
        
        isFromDestination = false
        placesSearchController = GooglePlacesSearchController(delegate: self,
                        apiKey: "AIzaSyDgxUkkfvb-L-bQyr5_WFbj18w2swdn1QY",
                        placeType: .all,
                        coordinate: CLLocationCoordinate2D(latitude: currentLat, longitude: currentLng),
                        radius: 500
        )
        self.present(placesSearchController, animated: true, completion: nil)
    }
    
    @IBAction func btnSideMenuTapped(_ sender: Any) {
        
        if showPopupState != .none {
            self.showPopupState = .none
            self.setupStates()
            return
        }
        
        if currentState == .search {
            UserDefaults.standard.setHomeState(state: .initial)
            self.setupStates()
            return
        } else if currentState == .promo {
            UserDefaults.standard.setHomeState(state: .initial)
            self.setupStates()
            return
        }
        
        SideMenuVC.show(parent: self, currentItem: .home) { item in
            if item == .history {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = RideHistoryVC.instantiateHome()
                    self.navigationController?.pushViewController(vc, animated: true)
                 }
                
            } else if item == .settings {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = SettingsVC.instantiateHome()
                    self.navigationController?.pushViewController(vc, animated: true)
                 }
                
            } else if item == .support {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = SupportVC.instantiateHome()
                    self.navigationController?.pushViewController(vc, animated: true)
                 }
                
            } else if item == .profile {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = ProfileVC.instantiateHome()
                    self.navigationController?.pushViewController(vc, animated: true)
                 }
                
            } else if item == .wallet {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = WalletVC.instantiateHome()
                    self.navigationController?.pushViewController(vc, animated: true)
                 }
                
            } else if item == .ongoing {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = ScheduledRidesVC.instantiateHome()
                    self.navigationController?.pushViewController(vc, animated: true)
                 }
                
            } else if item == .couponHistory {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = WalletAndCouponVC.instantiateHome()
                    self.navigationController?.pushViewController(vc, animated: true)
                 }
            } else if item == .cards {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = ManageCardsVC.instantiateHome()
                    self.navigationController?.pushViewController(vc, animated: true)
                 }
            }
        }
    }
}


enum HomeState: String {
    case initial
    case initialSearch
    case search
    case findingRide
    case promo
    case acceptedRide
    case rideInProgress
    case showInvoice
    case rating
}

enum PopupState: String {
    case estimatedPrice
    case schedulePicker
    case promo
    case serviceDetail
    case none
}







