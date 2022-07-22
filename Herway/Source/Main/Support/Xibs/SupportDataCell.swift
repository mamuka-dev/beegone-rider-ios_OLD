//
//  SupportDataCell.swift
//  Herway
//
//  Created by Faizan Ali  on 2021/12/28.
//

import UIKit
import MessageUI

class SupportDataCell: TableCell, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var vwMain2: UIView!

    var cellData: SupportDataCellData {get {return data as! SupportDataCellData}}
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupTheme() {
        super.setupTheme()
        
        vwMain.layer.cornerRadius = 12
        vwMain2.layer.cornerRadius = 12
    }
    
    
    @IBAction func btnSupportTapped(_ sender: Any) {
        
        
    }
    
    @IBAction func btnWhatsAppTapped(_ sender: Any) {
        self.navigateToWhatsApp()
    }
    
    @IBAction func btnEmailTapped(_ sender: Any) {
        let recipientEmail = cellData.supportResponse?.contactEmail ?? "N/A"
        let subject = R.string.localizable.support()
        let body = R.string.localizable.iNeedSupport()
        
        // Show default mail composer
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            
            parentController.present(mail, animated: true)
        
        // Show third party email composer if default Mail app is not present
        } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    @IBAction func btnPhoneTapped(_ sender: Any) {
        let number = cellData.supportResponse?.contactNumber ?? ""
        Utility.dialNumber(number: number)
    }
    
    func navigateToWhatsApp() {
        
        
        let phone = cellData.supportResponse?.contactNumber ?? ""
        
        let number = phone.onlyDigits() // PhoneNumber.first(in: phone)?.number ?? "4670 765 56 55"
        
//        let countryCode = "46" //Country code
//        let mobileNumber = "70 765 56 55" //Mobile number
        let urlString = "https://api.whatsapp.com/send?phone=\(number)"

        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let URL = NSURL(string: urlStringEncoded!)

        if UIApplication.shared.canOpenURL(URL! as URL) {
            debugPrint("opening Whatsapp")
            UIApplication.shared.open(URL! as URL, options: [:]) { status in
                debugPrint("Opened WhatsApp Chat")
            }
        } else {
            debugPrint("Can't open")
        }
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

class SupportDataCellData: TableCellData {
    
    var supportResponse: SupportResponse?
    init(supportResponse: SupportResponse?) {
        self.supportResponse = supportResponse
        super.init(nibId: "SupportDataCell")
    }
}
