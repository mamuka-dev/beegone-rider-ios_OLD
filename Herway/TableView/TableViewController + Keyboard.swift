//
//  TableViewController + Keyboard.swift
//  FaizanTech
//
//  Created by Faizan Ali  on 2020/7/11.
//  Copyright © 2020 com.Faizan.Technology. All rights reserved.
//

import Foundation
import UIKit

extension TableViewController {
    
    /// For view that have input object like TextField should call this method on viewWillAppear(:) method
    public func observeKeyboardEvents(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // Keyboard will show and hide methods.
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc open func keyboardWillShow(_ notification: Foundation.Notification){}
    @objc open func keyboardWillHide(_ notification: Foundation.Notification){}
    
    @objc private func adjustForKeyboard(notification: Notification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardValue.cgRectValue.size.height
        
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView!.contentInset.bottom = .zero
        } else {
            var bottom = keyboardHeight
            if #available(iOS 11.0, *) {
                bottom = bottom - view.safeAreaInsets.bottom
            }
            self.tableView!.contentInset.bottom = bottom
                //= UIEdgeInsets(top: (tableView?.layer.frame.origin.y)!, left: 0, bottom: bottom, right: 0)
        }
    }
}
