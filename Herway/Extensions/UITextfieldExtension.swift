 
 
 import UIKit
 
 extension UITextField {
    
    var validatedText: String? {
        if let text = self.text, !text.isEmpty {
            return self.text!.trimmingCharacters(in: .whitespaces)
        }
        return nil
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
 }
 extension UITextField {

     //MARK:- Set Image on the right of text fields

   func setupRightImage(imageName:String){
     let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
     imageView.image = UIImage(named: imageName)
     let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
     imageContainerView.addSubview(imageView)
     rightView = imageContainerView
     rightViewMode = .always
     self.tintColor = .lightGray
 }

  //MARK:- Set Image on left of text fields

     func setupLeftImage(imageName:String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
      }

   }
