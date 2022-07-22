//
//  ActivityIndicator.swift
//  OffSide
//
//  Created by Faizan Ali  on 2020/11/24.
//

import Foundation
import UIKit

class ActivityIndicator: NSObject {
    fileprivate static let overlayView: UIView = UIView()
    fileprivate static let activityIndicator =  UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    fileprivate static  let indicatorView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    fileprivate static  let activityView = UIActivityIndicatorView(style: .whiteLarge)
    class var shared : ActivityIndicator{
        struct Static {
            static let instance = ActivityIndicator()
        }
        return Static.instance
    }
    fileprivate override init() {
        super.init()
        ActivityIndicator.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    func showLoadingIndicator() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        guard let window : UIWindow = (UIApplication.shared.keyWindow) else { return }
        ActivityIndicator.indicatorView.backgroundColor  = UIColor.black.withAlphaComponent(0.8)
        ActivityIndicator.activityView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        ActivityIndicator.activityView.color = .tint1
        ActivityIndicator.activityView.startAnimating()
        ActivityIndicator.indicatorView.layer.cornerRadius = 5
        ActivityIndicator.overlayView.addSubview(ActivityIndicator.activityIndicator)
        ActivityIndicator.overlayView.frame = window.frame
        ActivityIndicator.indicatorView.center = window.center
        ActivityIndicator.activityIndicator.center = window.center
        ActivityIndicator.activityView.center = ActivityIndicator.indicatorView.center
        window.addSubview(ActivityIndicator.overlayView)
        window.addSubview(ActivityIndicator.indicatorView)
        window.addSubview(ActivityIndicator.activityView)
        window.bringSubviewToFront(ActivityIndicator.indicatorView)
        window.bringSubviewToFront(ActivityIndicator.overlayView)
        window.bringSubviewToFront(ActivityIndicator.activityView)
    }
    func hideLoadingIndicator() {
        UIApplication.shared.endIgnoringInteractionEvents()
        ActivityIndicator.activityView.stopAnimating()
        ActivityIndicator.activityView.removeFromSuperview()
        ActivityIndicator.overlayView.removeFromSuperview()
        ActivityIndicator.activityIndicator.removeFromSuperview()
        ActivityIndicator.indicatorView.removeFromSuperview()
    }
}
