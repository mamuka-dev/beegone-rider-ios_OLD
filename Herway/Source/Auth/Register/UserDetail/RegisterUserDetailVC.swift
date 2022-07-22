//
//  RegisterUserDetailVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/23.
//

import UIKit
import WebKit

class RegisterUserDetailVC: TableViewController, Storyboarded {
    
    @IBOutlet weak var theWebView: WKWebView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var theTableView: UITableView!

    var showWebView: Bool = false
    var allUrls: [RequiredURlsResponseData] = [RequiredURlsResponseData]()
    
    var viewModel: RegisterUserDetailVM {get {return model as! RegisterUserDetailVM}}
    override var tableView: UITableView { return theTableView }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func theInitialise(phone: String) {
        model = RegisterUserDetailVM(phone: phone)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func registerXibs() {
        super.registerXibs()

        theTableView.register(R.nib.registerUserDetailCell)
    }
    
    override func setupUI() {
        super.setupUI()
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        if showWebView {
            self.showWebView = false
            self.theWebView.isHidden = true
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func cellWasTapped(cell: TableCell, tag: String) {
        
        if tag == "terms" {
            self.btnTermsTapped()
        } else if tag == "privacy" {
            self.btnPrivacyTapped()
        }
    }
    
    func btnPrivacyTapped() {
        if let url = self.getPrivacyUrl() {
            self.showWebView = true
            self.theWebView.isHidden = false
            self.theWebView.loadHTMLString(url, baseURL: nil)
            self.btnBack.isHidden = !showWebView
        } else if let url = UserDefaults.standard.getPrivacyPolicy() {
            self.showWebView = true
            self.theWebView.isHidden = false
            self.theWebView.loadHTMLString(url, baseURL: nil)
            self.btnBack.isHidden = !showWebView
        }
    }
    
    func btnTermsTapped() {
        if let url = self.getTermsUrl() {
            self.showWebView = true
            self.theWebView.isHidden = false
            self.theWebView.loadHTMLString(url, baseURL: nil)
            self.btnBack.isHidden = !showWebView
        } else if let url = UserDefaults.standard.getTerms() {
            self.showWebView = true
            self.theWebView.isHidden = false
            self.theWebView.loadHTMLString(url, baseURL: nil)
            self.btnBack.isHidden = !showWebView
        }
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
}


