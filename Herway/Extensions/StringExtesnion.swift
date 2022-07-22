 
import UIKit

extension String {
    var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    var isValidPassword: Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    //
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    mutating func addString(str: String) {
        self = self + str
    }
}

//extension String {
//    func strikeThrough(size: CGFloat, color: UIColor) -> NSAttributedString {
//        let regularAttribute = [
//            NSAttributedString.Key.font: UIFont(font: .avenirNextDemiBold, size: size)!,
//            NSAttributedString.Key.foregroundColor: color
//        ]
//        let attributeString =  NSMutableAttributedString(string: " \(self) ")
//        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
//        attributeString.addAttributes(regularAttribute, range: NSMakeRange(0, attributeString.length))
//        return attributeString
//    }
//}


extension NSAttributedString {

    /// Returns a new instance of NSAttributedString with same contents and attributes with strike through added.
     /// - Parameter style: value for style you wish to assign to the text.
     /// - Returns: a new instance of NSAttributedString with given strike through.
     func withStrikeThrough(_ style: Int = 1) -> NSAttributedString {
         let attributedString = NSMutableAttributedString(attributedString: self)
         attributedString.addAttribute(.strikethroughStyle,
                                       value: style,
                                       range: NSRange(location: 0, length: string.count))
         return NSAttributedString(attributedString: attributedString)
     }
}
extension String {
  
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let attributedString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString
        } catch {
            return NSAttributedString()
        }
    }
    
    func customHTMLAttributedString(withFont font: UIFont?, textColor: UIColor) -> NSAttributedString? {
        guard let font = font else {
            return self.htmlToAttributedString
        }
        let hexCode = textColor.hexCodeString
        let css = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(hexCode);}</style>"
        let modifiedString = css + self
        return modifiedString.htmlToAttributedString
    }
  
}

extension UITextView {
    
    var htmlText: String? {
        set(value) {
            let newValue = value ?? ""
            self.attributedText = newValue.customHTMLAttributedString(withFont: self.font, textColor: self.textColor ?? .black)
        }
        get {
            return self.attributedText.string
        }
    }
    
}

extension UIColor {
    
    var hexCodeString: String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format:"#%06x", rgb)
    }
  
}
