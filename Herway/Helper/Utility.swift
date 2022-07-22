//
//  Utility.swift
//  Alazba
//
//  Created by Myansh Passi on 17/11/20.
//

import Foundation
import UIKit
import Loaf

 class Utility {
    public typealias EmptyCompletion = () -> Void
    //MARK:-Alerts
    static func alertMessage(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: nil
            ))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    class func showAlertWithTryAgain(title: String, message: String = "Something wrong", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {_ in
                completion?()
            }))
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: UIAlertAction.Style.default,
                handler: nil
            ))
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(
                alert,
                animated: true,
                completion: nil
            )
        }
    }
    class func showAlertWithOkAndCancel(title: String, message: String = "", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                completion?()
            }))
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: UIAlertAction.Style.default,
                handler: nil
            ))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    class func showAlertWithCustomButton(buttonTitle: String, title: String, message: String = "", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
                completion?()
            }))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
     
     class func getCurrentTimeTitle(onCompletion: ((String) -> Void)) {
         
         let hour = Calendar.current.component(.hour, from: Date())

         switch hour {
         case 6..<12 : onCompletion(R.string.localizable.goodMorning())
         case 12..<17 : onCompletion(R.string.localizable.goodAfternoon())
         case 17..<22 : onCompletion(R.string.localizable.goodEvening())
         default: onCompletion(R.string.localizable.goodNight())
         }
     }
     
     // let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate()) Swift 2 legacy
     
     
    class func showAlertWithCustomButtons(title: String, message: String = "", firstbuttonTitle: String = R.string.localizable.oK(), secondbuttonTitle: String = R.string.localizable.cancel(), firstCompletion: EmptyCompletion? = nil, secondCompletion: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: firstbuttonTitle, style: .default, handler: {_ in
                firstCompletion?()
            }))
            alert.addAction(UIAlertAction(
                title: secondbuttonTitle,
                style: UIAlertAction.Style.default,
                handler: secondCompletion
            ))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    class func showLoaf(message: String, state: Loaf.State,location: Loaf.Location = .top) {
        DispatchQueue.main.async {
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            guard let presenter = presentVC else {
                Utility.alertMessage(title: "", message: message)
                return
            }
            switch state {
            case .success:
                Loaf(message, state: .success,location: location, sender: presenter).show()
            case .warning:
                Loaf(message, state: .warning,location: location, sender: presenter).show()
            case .error:
                Loaf(message, state: .error,location: location, sender: presenter).show()
            default:
                return
            }
        }
    }
    
   class func getTheDateFromString(dateString: String, formate: DateFormat) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate.rawValue
        //according to date format your date string
        guard let theDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        return theDate
    }
    
    class func getDate(from dateString: String, fromFormate: DateFormat = .fullDate, toFormate: DateFormat = .monthDay, showToday: Bool = false) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormate.rawValue // "YYYY-MM-dd HH:mm:ss" //Your date format
        //according to date format your date string
        guard let theDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        dateFormatter.dateFormat = toFormate.rawValue// "MMMM dd EEEE"
        if showToday {
            
            if Calendar.current.isDateInToday(theDate) {
                return R.string.localizable.today()
            } else if Calendar.current.isDateInYesterday(theDate) {
                return R.string.localizable.yesterday()
            } else if Calendar.current.isDateInTomorrow(theDate) {
                return R.string.localizable.tomorrow()
            }

        }
        return dateFormatter.string(from: theDate)
    }
    
    class func getTime(from dateString: String, fromFormat: DateFormat = .fullDate, toFormate: DateFormat = .onlyTime) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat.rawValue  //Your date format
        //according to date format your date string
        guard let theDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        dateFormatter.dateFormat = toFormate.rawValue// "HH:mm"
        return dateFormatter.string(from: theDate)
    }
    
    
    class func getTimeAgoStr(from dateString: String, fromFormat: DateFormat = .fullDate) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat.rawValue  //Your date format
        //according to date format your date string
        guard let theDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        let str = theDate.timeAgoDisplay()
        return str
    }
     
     class func dialNumber(number : String) {
         
         PhoneNumber(extractFrom: number)?.makeACall()

//        let num: String = number.trimmingCharacters(in: .whitespaces)
//         
//      if let url = URL(string: "tel://\(num)"),
//        UIApplication.shared.canOpenURL(url) {
//           if #available(iOS 10, *) {
//             UIApplication.shared.open(url, options: [:], completionHandler:nil)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        } else {
//                 // add error message here
//        }
     }
 }


// MARK: DataDetector

class DataDetector {

    private class func _find(all type: NSTextCheckingResult.CheckingType,
                             in string: String, iterationClosure: (String) -> Bool) {
        guard let detector = try? NSDataDetector(types: type.rawValue) else { return }
        let range = NSRange(string.startIndex ..< string.endIndex, in: string)
        let matches = detector.matches(in: string, options: [], range: range)
        loop: for match in matches {
            for i in 0 ..< match.numberOfRanges {
                let nsrange = match.range(at: i)
                let startIndex = string.index(string.startIndex, offsetBy: nsrange.lowerBound)
                let endIndex = string.index(string.startIndex, offsetBy: nsrange.upperBound)
                let range = startIndex..<endIndex
                guard iterationClosure(String(string[range])) else { break loop }
            }
        }
    }

    class func find(all type: NSTextCheckingResult.CheckingType, in string: String) -> [String] {
        var results = [String]()
        _find(all: type, in: string) {
            results.append($0)
            return true
        }
        return results
    }

    class func first(type: NSTextCheckingResult.CheckingType, in string: String) -> String? {
        var result: String?
        _find(all: type, in: string) {
            result = $0
            return false
        }
        return result
    }
}

// MARK: PhoneNumber

struct PhoneNumber {
    private(set) var number: String
    init?(extractFrom string: String) {
        guard let phoneNumber = PhoneNumber.first(in: string) else { return nil }
        self = phoneNumber
    }

    private init (string: String) { self.number = string }

    func makeACall() {
        guard let url = URL(string: "tel://\(number.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    static func extractAll(from string: String) -> [PhoneNumber] {
        DataDetector.find(all: .phoneNumber, in: string)
            .compactMap {  PhoneNumber(string: $0) }
    }

    static func first(in string: String) -> PhoneNumber? {
        guard let phoneNumberString = DataDetector.first(type: .phoneNumber, in: string) else { return nil }
        return PhoneNumber(string: phoneNumberString)
    }
}

extension PhoneNumber: CustomStringConvertible { var description: String { number } }

// MARK: String extension

extension String {

    // MARK: Get remove all characters exept numbers

    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }

    var detectedPhoneNumbers: [PhoneNumber] { PhoneNumber.extractAll(from: self) }
    var detectedFirstPhoneNumber: PhoneNumber? { PhoneNumber.first(in: self) }
}
