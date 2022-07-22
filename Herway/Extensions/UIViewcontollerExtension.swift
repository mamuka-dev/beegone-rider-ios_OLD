 
import UIKit

extension UIViewController{
    //MARK:- Navigation transparent
    func transparentNavigation(tintColor: UIColor? = nil) {
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        if tintColor != nil {
            bar.tintColor = tintColor!
        }
        
        
        
    }
    
    func addNavigationGesture(parent: UIGestureRecognizerDelegate) {
        navigationController?.interactivePopGestureRecognizer?.delegate = parent
    }
    
    // UIGestureRecognizerDelegate
    @nonobjc func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navVc = navigationController {
          return navVc.viewControllers.count > 1
        }
        return false
    }
    
    func addNavBarImage() {
        
        let navController = navigationController!
        
        let image = UIImage(named: "watya_small_logo")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width / 2 - 20
        let bannerHeight = navController.navigationBar.frame.size.height / 2 - 20
        
        let bannerX = bannerWidth
        let bannerY = bannerHeight
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
}

extension UIViewController {
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.view.layer.cornerRadius = radius
        self.view.layer.maskedCorners = [CACornerMask]
        self.view.layer.masksToBounds = true
    }
}


extension UIViewController {
    func hideNavigationBar(animated: Bool){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    func showNavigationBar(animated: Bool) {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func alertMessage(title: String, msg: String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

 
 class DynamicHeightCollectionView: UICollectionView {
     override func layoutSubviews() {
         super.layoutSubviews()
         if bounds.size != intrinsicContentSize {
             self.invalidateIntrinsicContentSize()
         }
     }
     override var intrinsicContentSize: CGSize {
         return collectionViewLayout.collectionViewContentSize
     }
 }
