//
//  SettingsVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/28.
//

import FlagPhoneNumber
import UIKit
import WebKit
import GooglePlacesSearchController

class SettingsVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var txtPhone: FPNTextField!
    @IBOutlet weak var vwSOS: UIView!
    @IBOutlet weak var theWebView: WKWebView!
    @IBOutlet weak var theTableView: UITableView!

    var viewModel: SettingsVM {get {return model as! SettingsVM}}
    override var tableView: UITableView { return theTableView }
    var placesSearchController: GooglePlacesSearchController!
    var isFromHome: Bool = true
    var showWebView: Bool = false
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    
    var thePhoneNo: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = SettingsVM()
        self.theWebView.isHidden = true
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.settingsCell)
    }
    
    override func setupUI() {
        super.setupUI()
        
        vwSOS.isHidden = true
        txtPhone.delegate = self
        txtPhone.displayMode = .list
        txtPhone.set(phoneNumber: self.thePhoneNo)
        txtPhone.setFlag(countryCode: FPNCountryCode.PK)
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            txtPhone.setFlag(countryCode: FPNCountryCode(rawValue: countryCode) ?? .PK)
        }
        listController.setup(repository: txtPhone.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.txtPhone.setFlag(countryCode: country.code)
        }
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        if self.showWebView == true {
            self.showWebView = false
            self.theWebView.isHidden = true
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSOSTapped(_ sender: Any) {
        
        print(thePhoneNo)
        UserDefaults.standard.setSOS(text: self.thePhoneNo)
        self.vwSOS.isHidden = true
        self.viewModel.prepareData()
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        super.cellWasTapped(cell: cell, tag: tag)
        
        if tag == "sos" {
            
            self.vwSOS.isHidden = false
            
        } else if tag == "privacy" {
            
            if let url = viewModel.getPrivacyUrl() {
                self.showWebView = true
                self.theWebView.isHidden = false
                self.theWebView.loadHTMLString(url, baseURL: nil)
            }
        
        } else if tag == "terms" {
            
            if let url = viewModel.getTermsUrl() {
                self.showWebView = true
                self.theWebView.isHidden = false
                self.theWebView.loadHTMLString(url, baseURL: nil)
            }
        } else if tag == "home" {
            
            isFromHome = true
            placesSearchController = GooglePlacesSearchController(delegate: self,
                            apiKey: "AIzaSyDgxUkkfvb-L-bQyr5_WFbj18w2swdn1QY",
                            placeType: .all,
                            radius: 500
            )
            self.present(placesSearchController, animated: true, completion: nil)
        } else if tag == "work" {
            
            isFromHome = false
            placesSearchController = GooglePlacesSearchController(delegate: self,
                            apiKey: "AIzaSyDgxUkkfvb-L-bQyr5_WFbj18w2swdn1QY",
                            placeType: .all,
                            radius: 500
            )
            self.present(placesSearchController, animated: true, completion: nil)
        }
        
    }
    
    

}

extension SettingsVC: FPNTextFieldDelegate{
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
        self.thePhoneNo = "\(textField.selectedCountry?.phoneCode ?? "")\(textField.text ?? "")"
        
        
        if isValid {
            self.thePhoneNo = textField.getFormattedPhoneNumber(format: .E164) ?? ""
        }
    }
    
    func fpnDisplayCountryList() {
        
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = R.string.localizable.countries()
           self.present(navigationViewController, animated: true, completion: nil)
            
    }
}


//MARK: GetPlaces Delegate.
extension SettingsVC: GooglePlacesAutocompleteViewControllerDelegate {
    
    func viewController(didAutocompleteWith place: PlaceDetails) {
        print(place.description)
        
        guard let lat = place.coordinate?.latitude, let long = place.coordinate?.longitude else { return }
    
            let address = place.name ?? ""
//            let lat = place.coordinate?.latitude ?? 33.6973
//            let long = place.coordinate?.longitude ?? 73.1515
            
            self.viewModel.updateFavoriteLocations(address: address, type: isFromHome ? "home" : "work", latitude: String(lat), longitude: String(long)) { msg, success in
                
                if success {
                    if let msg = msg {
                        Utility.showLoaf(message: msg, state: .success)
                    }
                } else {
                    if let msg = msg {
                        Utility.showLoaf(message: R.string.localizable.locationAlreadyExists(), state: .error)
                    }
                }
            }
        placesSearchController.isActive = false
    }
}
