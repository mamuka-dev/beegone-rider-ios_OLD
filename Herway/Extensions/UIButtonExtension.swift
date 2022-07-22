 
import UIKit

extension UIButton {
    //MARK:- Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}

//extension PMSuperButton {
//    override open var isEnabled: Bool {
//        didSet {
//            DispatchQueue.main.async {
//                if self.tag == 100 {
//                    if self.isEnabled == false {
//                        self.backgroundColor = .Light_Gray
//                    }else {
//                        self.backgroundColor = .Dark_blue
//                    }
//                    return
//                }else {
//                    if self.isEnabled {
//                        self.alpha = 1.0
//                    }
//                    else {
//                        self.alpha = 0.6
//                    }
//                }
//                
//            }
//        }
//    }
//}
