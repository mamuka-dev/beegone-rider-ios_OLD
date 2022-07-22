//
//  AlertView.swift
//  Moody
//
//  Created by Faizan Ali on 15/06/2020.
//  Copyright © 2020 com.pyntail. All rights reserved.
//

import UIKit

class AlertView: UIView {

    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var onClose: ((Bool)->Void)? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    static func show(title: String, btnYesTitle: String, btnNoTitle: String, showOneButtonOnly: Bool = false, onClose: @escaping (Bool)->Void){
        
        let av : AlertView = AlertView.fromNib()
        av.lblTitle.text = title
        av.btnYes.setTitle(btnYesTitle, for: .normal)
        av.btnNo.setTitle(btnNoTitle, for: .normal)
        av.btnNo.isHidden = showOneButtonOnly
        av.onClose = onClose
        av.setUpUI()
        
        av.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        UIApplication.shared.keyWindow?.addSubview(av)
        
        av.vwMain.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            av.vwMain.transform = CGAffineTransform.identity
        }) { (completion) in
            
        }
    }
    
    func setUpUI(){
        setTheme()
    }
    
    func setTheme(){
        
        self.backgroundColor = .primaryColor.withAlphaComponent(0.70)
    }
    
    @IBAction func btnOkeyTapped(_ sender: Any) {
        closeView()
        onClose?(true)
    }
    
    @IBAction func btnNoTapped(_ sender: Any) {
        closeView()
        onClose?(false)
    }
    
    func closeView() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { finished in
            self.removeFromSuperview()
        })
    }
    
}
