//
//  CommunicationService.swift
//  MyRidePay
//
//  Created by Faizan Ali  on 2021/4/29.
//

import Foundation
import UIKit
import MessageUI

class CommunicationService: NSObject, MFMailComposeViewControllerDelegate {
    
    static let shared = CommunicationService()
    
    
    class func share(subject: String, text: String, image: UIImage? = nil,  url: URL? = nil, _ onCompletion: @escaping (Bool)->Void) {
        
        
        var items = [Any]()
        if image != nil { items.append(image!)}
        items.append(text)
        if url != nil { items.append(url!)}
        
        let activity: UIActivityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activity.completionWithItemsHandler =  { (anActivity, sucess, items, error) in
            onCompletion(true)
            activity.completionWithItemsHandler = nil
        }
        
        activity.setValue(subject, forKey: "Subject")
        
        
        let viewController = UIApplication.topViewController
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            activity.popoverPresentationController?.sourceView = viewController!.view
            activity.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            activity.popoverPresentationController?.sourceRect = viewController!.view.bounds
        }
        
        
        viewController?.present(activity, animated: true, completion: {
            onCompletion(false)
        })
    }
    
    func sendEmail(parent: UIViewController, subject: String? = nil , message: String? = nil){
        if !MFMailComposeViewController.canSendMail() {
            Utility.showLoaf(message: "Email app is not available.", state: .error)
            return
        }
        
        let vc = MFMailComposeViewController()
        vc.setSubject(subject ?? "MyRidePay App")
        vc.setMessageBody(message ?? "", isHTML: true)
        vc.mailComposeDelegate = CommunicationService.shared
        parent.present(vc, animated: true, completion: nil)

    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
        
        controller.dismiss(animated: true, completion: nil)
    }
    
}
