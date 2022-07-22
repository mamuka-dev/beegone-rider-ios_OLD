//
//  FilteredSheetManager.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/1/3.
//

import Foundation
import UIKit
import FittedSheets

class FilteredSheetManager {
    
    static let shared: FilteredSheetManager = FilteredSheetManager()
    
//    let sheetController = SheetViewController? = nil
    private init() {}
    
    func show(parent: UIViewController, viewToShow: UIViewController, inlineMode: Bool = false, percent: Float = 0.3, dismissOnOverlayTap: Bool = true, dismissOnPull: Bool = true) {
        
        let options = SheetOptions(
            
            useFullScreenMode: !inlineMode,
            useInlineMode: inlineMode
        )
        
        let sheetController = SheetViewController(controller: viewToShow, sizes: [.percent(percent), .fixed(600)], options: options)
        sheetController.allowGestureThroughOverlay = true
        sheetController.dismissOnOverlayTap = dismissOnOverlayTap
        sheetController.dismissOnPull = dismissOnPull
        
        sheetController.attemptDismiss(animated: true)
        
        if inlineMode {
            sheetController.overlayColor = UIColor.clear
            sheetController.animateIn(to: parent.view, in: parent)
        } else {
            parent.present(sheetController, animated: false, completion: nil)
        }
    }
    
    func showThe(parent: UIViewController, inlineMode: Bool) {
        
        if inlineMode {
            sheetController.overlayColor = UIColor.clear
            sheetController.animateIn(to: parent.view, in: parent)
        } else {
            parent.present(sheetController, animated: false, completion: nil)
        }
    }
    
    func showPayOnline(parent: UIViewController, inlineMode: Bool) {
        
        if inlineMode {
            sheetPayOnlineController.overlayColor = UIColor.clear
            sheetPayOnlineController.animateIn(to: parent.view, in: parent)
        } else {
            parent.present(sheetPayOnlineController, animated: false, completion: nil)
        }
    }
    
}
