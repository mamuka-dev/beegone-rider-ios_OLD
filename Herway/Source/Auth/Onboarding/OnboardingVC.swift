//
//  OnboardingVC.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/22.
//

import UIKit
import WebKit

class OnboardingVC: BaseViewController {

    @IBOutlet weak var theWebView: WKWebView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    var showWebView: Bool = false
    var allUrls: [RequiredURlsResponseData] = [RequiredURlsResponseData]()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    
    override func setupUI() {
        setupTheme()
        fetchData()
        self.btnBack.isHidden = !showWebView
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        btnLogIn.layer.cornerRadius = 4
        btnSignUp.layer.cornerRadius = 4
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        
        self.showWebView = false
        self.theWebView.isHidden = true
        self.btnBack.isHidden = !showWebView
    }
    
    @IBAction func btnLogInTapped(_ sender: Any) {
        
        let vc = LogInVC.instantiateAuth()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        
        let vc = RegisterVerifyPhoneVC.instantiateAuth()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnPrivacyTapped(_ sender: Any) {
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
    
    @IBAction func btnTermsTapped(_ sender: Any) {
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
    
    func fetchData() {

        self.getAllUrls { msg, success in

            if !success {
                if let msg = msg {
                    Utility.showLoaf(message: msg, state: .error)
                }
            }
        }
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
