//
//  SettingsCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/28.
//

import UIKit

class SettingsCell: TableCell {
    
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblSos: UILabel!
    @IBOutlet weak var lblHomeAddress: UILabel!
    @IBOutlet weak var lblWorkAddress: UILabel!
    @IBOutlet weak var vwMain: UIView!

    var cellData: SettingsCellData {get {return data as! SettingsCellData}}
    
    
    override func setupUI() {
        super.setupUI()
        
        let language = UserDefaults.standard.getSelectedLanguage()
        lblLanguage.text = language.name
        
        lblSos.text = R.string.localizable.sosNumberNotAvailable()
        if let sosNum = UserDefaults.standard.getSOS() {
            lblSos.text = sosNum
        }
        
        lblHomeAddress.text = cellData.viewModel.homeAddress?.address ?? "N/A"
        lblWorkAddress.text = cellData.viewModel.workAddress?.address ?? "N/A"
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.layer.cornerRadius = 12
    }
    
    @IBAction func btnWorkTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "work")
    }
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "home")
    }
    
    @IBAction func btnSosTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "sos")
    }
    
    @IBAction func btnLogoutTapped(_ sender: Any) {
        
        AlertView.show(title: R.string.localizable.areYouSureWantToLogout(), btnYesTitle: R.string.localizable.yeS(), btnNoTitle: R.string.localizable.nO()) { btnYesTapped in
            
            if btnYesTapped {
                
                self.cellData.viewModel.logOut { msg, success in
                    if success {
                        let redirect = RedirectHelper(window: nil)
                        redirect.logout()
                        redirect.determineRoutes()
                    } else {
                        if let msg = msg {
                            Utility.showLoaf(message: msg, state: .error)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func btnTermsTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "terms")
    }
    @IBAction func btnPrivacyTapped(_ sender: Any) {
        delegate?.cellWasTapped(cell: self, tag: "privacy")
    }
    
    @IBAction func btnLanguageTapped(_ sender: Any) {
        
        var config = SingleValuePickerConfiguration(title: "Select Language", imageName: "", description: nil, values: [], units: nil, selectedValueIndex: 0, selectedUnitIndex: 0, allowMultipleSelection: false)
        
        config.values = [Language.english.name, Language.spanish.name]
        SingleValuePickerView.show(config: config, delegate: self, tag: nil, parent: parentController)
    }
    
    @IBAction func btnShareTapped(_ sender: Any) {
        CommunicationService.share(subject: R.string.localizable.downloadBestTaxiAppFromHere(), text: "", image: nil, url: URL(string: APP_STORELINK)) { success in
        }
    }
}

extension SettingsCell: SingleValuePickerProtocol {
   
    func userSelected(valueIndex: Int, unitIndex: Int?, tag: String?) {
        
        if valueIndex == 0 {
            UserDefaults.standard.setSelectedLanguage(code: .english)
            Bundle.set(language: .english)
        } else {
            UserDefaults.standard.setSelectedLanguage(code: .spanish)
            Bundle.set(language: .spanish)
        }
        
        AlertView.show(title: R.string.localizable.kindlyRestartTheAppToApplyChangesForLocalization(), btnYesTitle: R.string.localizable.okey(), btnNoTitle: "", showOneButtonOnly: true) { success in
            self.setupUI()
        }
    }
    
    func userMultipleSelected(valuesIndexes: Array<Int>, unitIndexes: Array<Int>?, tag: String?) {
    }
}

class SettingsCellData: TableCellData {
    
    var viewModel: SettingsVM {get {return model as! SettingsVM}}
    init() {
        super.init(nibId: "SettingsCell")
    }
}
