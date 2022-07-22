//
//  Signup+Extension.swift
//  OffSide
//
//  Created by Murteza on 10/11/2020.
//

import Foundation

import UIKit

class RadioButtonController: NSObject {
    var buttonsArray: [UIButton]! {
        didSet {
            for b in buttonsArray {
                b.setBackgroundImage(UIImage(named: "uncheck"), for: .normal)
                b.setBackgroundImage(UIImage(named: "check"), for: .selected)
            
            }
        }
    }
    var selectedButton: UIButton?
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }

    func buttonArrayUpdated(buttonSelected: UIButton) {
        for b in buttonsArray {
            if b == buttonSelected {
                selectedButton = b
                b.isSelected = true
            } else {
                b.isSelected = false
            }
        }
    }
}
