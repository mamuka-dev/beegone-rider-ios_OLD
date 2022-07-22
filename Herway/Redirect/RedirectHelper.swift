

import UIKit

enum Stoyboard : String {
    case Main
    case Auth
    case Intro
}

final class RedirectHelper {
    //
    private var window : UIWindow!
    
    init(window: UIWindow?) {
        if window != nil {
            self.window = window
        }else {
            guard let temp : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            self.window = temp
        }
        
    }
    
    func determineRoutes (){
        
//        logout()
        // User session
//        checkUserSession()
        let transition = CATransition()
        transition.type = .reveal
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: self.window.bounds.height))
        myView.backgroundColor = .white
        window.addSubview(myView)
        
        self.checkUserSession(transition: transition)
        
    }
    
    func checkUserSession(transition :CATransition){
        if let userData = UserDefaults.standard.getUserSession() {
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(LoginModelResponseData.self, from: userData)

                UserSession.shared.user = user
                
                setRootToHome(transition: transition)
            }catch let error {
                print(error)
                setRootToAuth(transition: transition)
            }
        }else {
//            UserSession.shared.user = LoginModelResponseData(id: 1, token: "", name: "Test", email: "test@gmail.com", photo: nil, userType: nil)
//            self.setRootToMain(transition: transition)
            setRootToAuth(transition: transition)
        }
    }

    func logout(){
        UserDefaults.standard.removeUserSession()
        UserSession.shared.user = nil
    }
    
    func setRootToAuth(transition :CATransition) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let loginNav =  storyboard.instantiateViewController(withIdentifier: "AuthNav") as! UINavigationController
        window.set(rootViewController: loginNav, withTransition: transition)
        window.makeKeyAndVisible()
    }
    
    func setRootToHome(transition :CATransition) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeNav =  storyboard.instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
        window.set(rootViewController: homeNav, withTransition: transition)
        window.makeKeyAndVisible()
    }
    
    
}

extension UIWindow {

    static var topWindow: UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindow.Level.normal
        window.makeKeyAndVisible()

        return window
    }

    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
        let previousViewController = rootViewController

        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }

        rootViewController = newRootViewController

        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }

        /// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
        /// In iOS 13 we don't want to remove the transition view as it'll create a blank screen
        /// TODO: fix leak on iOS 13
        if #available(iOS 13.0, *) {} else {
            if let transitionViewClass = NSClassFromString("UITransitionView") {
                for subview in subviews where subview.isKind(of: transitionViewClass) {
                    subview.removeFromSuperview()
                }
            }
        }

        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}
